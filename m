Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC92D29E4A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgJ2Hke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727721AbgJ2HYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:24:52 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE288C05BD22
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 23:31:52 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o25so1303844qtt.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 23:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=mtMGAzSIXhq9aXQBscSgtdribEudRLJd8ZDm7F7aN+Q=;
        b=MzDz/8lGegKD7cOyFrpzaM6DS87nvvbx5nC+Fu1+89L7xSDv67Prs/sKVZt5GCSseH
         NtoZBcYdnR+lrr01rf3YhjeOs1odtXOzobZqSqdojFLuba94QnPnOYxFRsq2qNaMmP7e
         3crBZMTfYUDkhn04AfNxUMfhXtiYdByypHs2uPKJ3wzO1NO9vgr8+zw15siaHE4XEoGo
         tTcKCWkNPO8Roev3aSjwapCDZ3VTN2jSbvKvttzgaOcSYufQSEM4DAOowNW3g7hFfdJm
         cvxC2nHc1bF1irZl83dmbzzi9mrGzuunXppIE6H8n1SUQYkBQM5zQcaKKLO5Sj1foV+2
         x02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mtMGAzSIXhq9aXQBscSgtdribEudRLJd8ZDm7F7aN+Q=;
        b=c7zmD91X8ms3KYyOh0Z2A4fbB9JmMEoVuVuTpjv3VCm/GHcxr1CkQ0oaIigIrFuwcn
         UqiX1B8UD5awY76kepyriLzu2lowWMwAHAMylV9VYGnZYSsWi13kJPW2OuKmn4KMIMPg
         B30r1Lfmag2LfJKX54qFSwoftl8+HcIIYQ+DI8wgz8dfWifVJhqwfZjrE3NDaJ/8TrIb
         xDow5WvmcVIiZ/QU6T8hYto1aXWi1gEyA2TrCe/iLlgx9kz5/xSDTkvgGT86e8yjs1BN
         wx6XwffGCpRXJvMG+FbqLua1FTvikR8CiWN2x3MoE5IuagLIT3yZBEHD1E395yB2SLRL
         liMw==
X-Gm-Message-State: AOAM530Fz+52JVRC0dygMy6frjAivNJnzR/j9+1wbLciBxwmyi/oAMG/
        zQTzdWyXiOijcoM4xxALmnTzP+uMeUI=
X-Google-Smtp-Source: ABdhPJzK8m+EfSDYe+BcMtQGqbsI1KxK0DzV6zOtcf9ICiFjzJN/9zR2s+8fA5Ek1aEOXA7qry1QhZV+TjE=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a05:6214:951:: with SMTP id
 dn17mr3023019qvb.9.1603953112037; Wed, 28 Oct 2020 23:31:52 -0700 (PDT)
Date:   Wed, 28 Oct 2020 23:31:32 -0700
In-Reply-To: <20201029063138.1429760-1-badhri@google.com>
Message-Id: <20201029063138.1429760-5-badhri@google.com>
Mime-Version: 1.0
References: <20201029063138.1429760-1-badhri@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v12 04/10] usb: typec: tcpm: frs sourcing vbus callback
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thierry Reding <treding@nvidia.com>,
        Prashant Malani <pmalani@chromium.org>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During FRS hardware autonomously starts to source vbus. Provide
callback to perform chip specific operations.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
Introduced in v9.

Changes since v10:
Added Reviewed-by: Heikki Krogerus

Changes since v11:
none
---
 drivers/usb/typec/tcpm/tcpm.c | 9 +++++++++
 include/linux/usb/tcpm.h      | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 561480b67bce..0123d2f14c96 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4091,7 +4091,16 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *port)
 	case SRC_TRY_DEBOUNCE:
 		/* Do nothing, waiting for sink detection */
 		break;
+	case FR_SWAP_SEND:
+	case FR_SWAP_SEND_TIMEOUT:
+	case FR_SWAP_SNK_SRC_TRANSITION_TO_OFF:
+	case FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED:
+		if (port->tcpc->frs_sourcing_vbus)
+			port->tcpc->frs_sourcing_vbus(port->tcpc);
+		break;
 	case FR_SWAP_SNK_SRC_NEW_SINK_READY:
+		if (port->tcpc->frs_sourcing_vbus)
+			port->tcpc->frs_sourcing_vbus(port->tcpc);
 		tcpm_set_state(port, FR_SWAP_SNK_SRC_SOURCE_VBUS_APPLIED, 0);
 		break;
 
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 09762d26fa0c..7303f518ba49 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -83,6 +83,9 @@ enum tcpm_transmit_type {
  *		Optional; Called to enable/disable PD 3.0 fast role swap.
  *		Enabling frs is accessory dependent as not all PD3.0
  *		accessories support fast role swap.
+ * @frs_sourcing_vbus:
+ *		Optional; Called to notify that vbus is now being sourced.
+ *		Low level drivers can perform chip specific operations, if any.
  */
 struct tcpc_dev {
 	struct fwnode_handle *fwnode;
@@ -109,6 +112,7 @@ struct tcpc_dev {
 			   const struct pd_message *msg);
 	int (*set_bist_data)(struct tcpc_dev *dev, bool on);
 	int (*enable_frs)(struct tcpc_dev *dev, bool enable);
+	void (*frs_sourcing_vbus)(struct tcpc_dev *dev);
 };
 
 struct tcpm_port;
-- 
2.29.1.341.ge80a0c044ae-goog

