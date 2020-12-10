Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195042D61CB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391694AbgLJQFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:05:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:33716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389598AbgLJQFY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:05:24 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     heikki.krogerus@linux.intel.com, linux@roeck-us.net
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        pumahsu <pumahsu@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Kyle Tso <kyletso@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/5] USB: typec: tcpm: Hard Reset after not receiving a Request
Date:   Thu, 10 Dec 2020 17:05:18 +0100
Message-Id: <20201210160521.3417426-3-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210160521.3417426-1-gregkh@linuxfoundation.org>
References: <20201210160521.3417426-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: pumahsu <pumahsu@google.com>

PD 3.0 spec 8.3.3.2.3, A Get_Source_Cap message is sent
to a UUT that is in the PE_SRC_Ready state. After sending
a Source_Capabilities message, the UUT should then expect
a Request message in response. When one is not received,
the UUT should timeout to PE_SRC_Hard_Reset.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Badhri Jagan Sridharan <badhri@google.com>
Signed-off-by: pumahsu <pumahsu@google.com>
Signed-off-by: Kyle Tso <kyletso@google.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 0ceeab50ed64..0efda59bb104 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2218,6 +2218,7 @@ static int tcpm_pd_send_control(struct tcpm_port *port,
 static bool tcpm_send_queued_message(struct tcpm_port *port)
 {
 	enum pd_msg_request queued_message;
+	int ret;
 
 	do {
 		queued_message = port->queued_message;
@@ -2237,7 +2238,16 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
 			tcpm_pd_send_sink_caps(port);
 			break;
 		case PD_MSG_DATA_SOURCE_CAP:
-			tcpm_pd_send_source_caps(port);
+			ret = tcpm_pd_send_source_caps(port);
+			if (ret < 0) {
+				tcpm_log(port,
+					 "Unable to send src caps, ret=%d",
+					 ret);
+				tcpm_set_state(port, SOFT_RESET_SEND, 0);
+			} else if (port->pwr_role == TYPEC_SOURCE) {
+				tcpm_set_state(port, HARD_RESET_SEND,
+					       PD_T_SENDER_RESPONSE);
+			}
 			break;
 		default:
 			break;
-- 
2.29.2

