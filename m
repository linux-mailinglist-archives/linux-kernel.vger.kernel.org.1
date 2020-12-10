Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4E02D61D1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391293AbgLJQ3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:29:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388492AbgLJQFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:05:33 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     heikki.krogerus@linux.intel.com, linux@roeck-us.net
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>,
        Kyle Tso <kyletso@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/5] USB: typec: tcpm: Prevent log overflow by removing old entries
Date:   Thu, 10 Dec 2020 17:05:17 +0100
Message-Id: <20201210160521.3417426-2-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210160521.3417426-1-gregkh@linuxfoundation.org>
References: <20201210160521.3417426-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Badhri Jagan Sridharan <badhri@google.com>

TCPM logs overflow once the logbuffer is full. Clear old entries and
allow logging the newer ones as the newer would be more relevant to the
issue being debugged.

Also, do not reset the logbuffer tail as end users might take back to
back bugreports which would result in an empty buffer.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Kyle Tso <kyletso@google.com>
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index cedc6cf82d61..0ceeab50ed64 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -470,12 +470,6 @@ static bool tcpm_port_is_disconnected(struct tcpm_port *port)
 
 #ifdef CONFIG_DEBUG_FS
 
-static bool tcpm_log_full(struct tcpm_port *port)
-{
-	return port->logbuffer_tail ==
-		(port->logbuffer_head + 1) % LOG_BUFFER_ENTRIES;
-}
-
 __printf(2, 0)
 static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
 {
@@ -495,11 +489,6 @@ static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
 
 	vsnprintf(tmpbuffer, sizeof(tmpbuffer), fmt, args);
 
-	if (tcpm_log_full(port)) {
-		port->logbuffer_head = max(port->logbuffer_head - 1, 0);
-		strcpy(tmpbuffer, "overflow");
-	}
-
 	if (port->logbuffer_head < 0 ||
 	    port->logbuffer_head >= LOG_BUFFER_ENTRIES) {
 		dev_warn(port->dev,
@@ -519,6 +508,9 @@ static void _tcpm_log(struct tcpm_port *port, const char *fmt, va_list args)
 		  (unsigned long)ts_nsec, rem_nsec / 1000,
 		  tmpbuffer);
 	port->logbuffer_head = (port->logbuffer_head + 1) % LOG_BUFFER_ENTRIES;
+	if (port->logbuffer_head == port->logbuffer_tail)
+		port->logbuffer_tail =
+			(port->logbuffer_tail + 1) % LOG_BUFFER_ENTRIES;
 
 abort:
 	mutex_unlock(&port->logbuffer_lock);
@@ -622,8 +614,6 @@ static int tcpm_debug_show(struct seq_file *s, void *v)
 		seq_printf(s, "%s\n", port->logbuffer[tail]);
 		tail = (tail + 1) % LOG_BUFFER_ENTRIES;
 	}
-	if (!seq_has_overflowed(s))
-		port->logbuffer_tail = tail;
 	mutex_unlock(&port->logbuffer_lock);
 
 	return 0;
-- 
2.29.2

