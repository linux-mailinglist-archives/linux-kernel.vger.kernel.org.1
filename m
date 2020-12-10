Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D0C2D61B8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388977AbgLJQZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:25:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:34720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389377AbgLJQFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:05:40 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     heikki.krogerus@linux.intel.com, linux@roeck-us.net
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/5] USB: typec: tcpm: Add a 30ms room for tPSSourceOn in PR_SWAP
Date:   Thu, 10 Dec 2020 17:05:20 +0100
Message-Id: <20201210160521.3417426-5-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201210160521.3417426-1-gregkh@linuxfoundation.org>
References: <20201210160521.3417426-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kyle Tso <kyletso@google.com>

TCPM state machine needs 20-25ms to enter the ErrorRecovery state after
tPSSourceOn timer timeouts. Change the timer from max 480ms to 450ms to
ensure that the timer complies with the Spec. In order to keep the
flexibility for other usecases using tPSSourceOn, add another timer only
for PR_SWAP.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Badhri Jagan Sridharan <badhri@google.com>
Signed-off-by: Kyle Tso <kyletso@google.com>
Signed-off-by: Will McVicker <willmcvicker@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 2 +-
 include/linux/usb/pd.h        | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index d51c45961893..5ed78194a1bd 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3728,7 +3728,7 @@ static void run_state_machine(struct tcpm_port *port)
 			tcpm_set_state(port, ERROR_RECOVERY, 0);
 			break;
 		}
-		tcpm_set_state(port, ERROR_RECOVERY, PD_T_PS_SOURCE_ON);
+		tcpm_set_state(port, ERROR_RECOVERY, PD_T_PS_SOURCE_ON_PRS);
 		break;
 	case PR_SWAP_SRC_SNK_SINK_ON:
 		/* Set the vbus disconnect threshold for implicit contract */
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index 63a66dd5d832..bb9a782e1411 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -466,6 +466,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
 #define PD_T_DRP_SRC		30
 #define PD_T_PS_SOURCE_OFF	920
 #define PD_T_PS_SOURCE_ON	480
+#define PD_T_PS_SOURCE_ON_PRS	450	/* 390 - 480ms */
 #define PD_T_PS_HARD_RESET	30
 #define PD_T_SRC_RECOVER	760
 #define PD_T_SRC_RECOVER_MAX	1000
-- 
2.29.2

