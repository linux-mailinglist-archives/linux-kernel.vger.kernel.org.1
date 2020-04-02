Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0C619CC9E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 00:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389390AbgDBWAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 18:00:01 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:35154 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732995AbgDBWAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 18:00:01 -0400
Received: by mail-pf1-f201.google.com with SMTP id c82so4235887pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=fGO/LJweRfjzoNNtcouuC1p+t8sUj+ryEoR9Pw+Ties=;
        b=eDi5O9TD95uNcfdqgTHHcoe0MCFTiL6tlhYQIWG++N+2Zj2qEQC/H5KzLh0PgWJkBk
         RF41qd7YG9rUQX2ROBlG/9leP6lg5z2j7RZDkG3krpHgbWaRBv/ZMfbAls/wAQfoBj3k
         Ha6+ilY7qEQmBSUqRklWAGfjjx0wrzwSClCYRIPcgeO0ZUreXSooYrq6zQR7nYf+ATeX
         +wIOdYwZb5C7WhL9LKmv18LnNwqDW4KwUke32X7fJsci7bjcU+/yC3a2zRunZhBWRcgq
         3XJeg1MA8C6HIGgplGDiqcZ0yL6SU1GJ7cuR15IXX/2zk5ANKLysJD/HVUe3gC+LdXVH
         RFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=fGO/LJweRfjzoNNtcouuC1p+t8sUj+ryEoR9Pw+Ties=;
        b=qP9YIF54eztKwhUWE2KCX9nH0YrKiRR5imxDM4sEljet7TV0rHwBUQ2Sro3CiffXwM
         E6dlH2Jt1CdBRUjGAf6ArZjBS2TkgMCQS2glyOrVojf93IrGBuMhjbgaq/391gFute88
         m56Kj+T9sRV5TaoHZGt0+he5lcjZ0pToGAFqMiH3GIIZtPiBmexFSEYpz3Jac3UR2HmH
         HNRIEbMx4AfA04Ke+IeP5nwazKbleymWxStKRxRVmTtUHeQ6WMBYTZp4QalaxaAWOGxT
         uPSVD5wdqFZVQtNtEytpLt1ifiCgmHDScyW26wMJ1UXbICEH/oUyqbUHv2lbucA6ojwa
         +yGw==
X-Gm-Message-State: AGi0PuaQTNOyASYMWGEKUZ//mc2WUi93QaaJ8bZwaobY0058vEsX/nHw
        5Ez6zXNhy9VLiMHoIDov6MhCFsXNkjA=
X-Google-Smtp-Source: APiQypJxSRgREB0dWLpAT518fR5h5iCmDFtWTpeb1vl29TnRZsaiWSDp6ZRDRMhHplEfaenObLzqOasKQFg=
X-Received: by 2002:a17:90a:a4c7:: with SMTP id l7mr5927191pjw.114.1585864799199;
 Thu, 02 Apr 2020 14:59:59 -0700 (PDT)
Date:   Thu,  2 Apr 2020 14:59:47 -0700
Message-Id: <20200402215947.176577-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v1] usb: typec: tcpm: Ignore CC and vbus changes in PORT_RESET change
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After PORT_RESET, the port is set to the appropriate
default_state. Ignore processing CC changes here as this
could cause the port to be switched into sink states
by default.

echo source > /sys/class/typec/port0/port_type

Before:
[  154.528547] pending state change PORT_RESET -> PORT_RESET_WAIT_OFF @ 100 ms
[  154.528560] CC1: 0 -> 0, CC2: 3 -> 0 [state PORT_RESET, polarity 0, disconnected]
[  154.528564] state change PORT_RESET -> SNK_UNATTACHED

After:
[  151.068814] pending state change PORT_RESET -> PORT_RESET_WAIT_OFF @ 100 ms [rev3 NONE_AMS]
[  151.072440] CC1: 3 -> 0, CC2: 0 -> 0 [state PORT_RESET, polarity 0, disconnected]
[  151.172117] state change PORT_RESET -> PORT_RESET_WAIT_OFF [delayed 100 ms]
[  151.172136] pending state change PORT_RESET_WAIT_OFF -> SRC_UNATTACHED @ 870 ms [rev3 NONE_AMS]
[  152.060106] state change PORT_RESET_WAIT_OFF -> SRC_UNATTACHED [delayed 870 ms]
[  152.060118] Start toggling

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index de3576e6530ab2..82b19ebd7838e0 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -3794,6 +3794,14 @@ static void _tcpm_cc_change(struct tcpm_port *port, enum typec_cc_status cc1,
 		 */
 		break;
 
+	case PORT_RESET:
+	case PORT_RESET_WAIT_OFF:
+		/*
+		 * State set back to default mode once the timer completes.
+		 * Ignore CC changes here.
+		 */
+		break;
+
 	default:
 		if (tcpm_port_is_disconnected(port))
 			tcpm_set_state(port, unattached_state(port), 0);
@@ -3855,6 +3863,15 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *port)
 	case SRC_TRY_DEBOUNCE:
 		/* Do nothing, waiting for sink detection */
 		break;
+
+	case PORT_RESET:
+	case PORT_RESET_WAIT_OFF:
+		/*
+		 * State set back to default mode once the timer completes.
+		 * Ignore vbus changes here.
+		 */
+		break;
+
 	default:
 		break;
 	}
@@ -3908,10 +3925,19 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
 	case PORT_RESET_WAIT_OFF:
 		tcpm_set_state(port, tcpm_default_state(port), 0);
 		break;
+
 	case SRC_TRY_WAIT:
 	case SRC_TRY_DEBOUNCE:
 		/* Do nothing, waiting for sink detection */
 		break;
+
+	case PORT_RESET:
+		/*
+		 * State set back to default mode once the timer completes.
+		 * Ignore vbus changes here.
+		 */
+		break;
+
 	default:
 		if (port->pwr_role == TYPEC_SINK &&
 		    port->attached)
-- 
2.26.0.292.g33ef6b2f38-goog

