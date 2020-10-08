Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEC1286E9B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 08:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgJHGRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 02:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbgJHGQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:16:38 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7B3C0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 23:16:28 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id r128so3170930qkc.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 23:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0afO4rLOQPn7gMI304N6qXvrtGMWMCYRRtjs+1Xakek=;
        b=uTtb7+ofg2OG2cMxwvSTM2ldRGL9kdaDpJYxmAGOxlU+yr3Pf6MYmh72p3yN1ZAsZX
         efWu1MU32eMvtPiiJncf7TWqHAsFyz9sVVk1tK/Jn3evALFgUaRvRTYo8vQuhjXjHnzz
         SfWLx1OmApfzw3IecLiCLTq1fBw6yQd9mdE/9QxOCaUxm/2BNej6YvCmmRF6lKwYwqAs
         ls6P5dVR7LD3cCOzYYHO2EVlY8F80qCr85fLvtYibkuQnHsns8ugy0J3vfdB/Zoapaik
         z9++1Y3n+yOfk6SONNEaV+M0Fm3xu2FyqMJoiG+Un/GFJWCO03WFSxx4BkSEVouFDpuF
         QJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0afO4rLOQPn7gMI304N6qXvrtGMWMCYRRtjs+1Xakek=;
        b=nNHBdAufXfU2yO018sFKD8Q01LZnZkX5BaPeH4v2Zn1RAysaY6waMQaWuFVouBLt7+
         Ox3Chj8BF+ZcXaHIBvhWV45pRWYOTxcLz6ApimXK1sr36PkKMtfx8dyrG9EKNfRMJSih
         CKjJhXo4Aqez6QShJYWLadglLEkwp1hBdAryMLnLvSvmaT63LZvbZLL/znxbwCfwJ49P
         ZlpyLrQRCUgnWlUOsGF9UIwgSm3TdNwY/i1Y/AVWXW92FcAC5/0pIQJny5ysdoE58sy4
         za0fGVlk1bjl6e3b+lIgwvS3Q/7wPCCLfbi4avQ5deHYtBeAt3jSSQv7LgDFN3KQHxWj
         MRDQ==
X-Gm-Message-State: AOAM532/MW47U2d3LGu6HPcGsuosSBhRN5fwwbBJdUqlu4XI0f1DyD8y
        Q/oyR75ztKMmVBzKuheuCuPU7Sdv29o=
X-Google-Smtp-Source: ABdhPJw7WhaRaqeR0L0lv1rj1FaUtUibazC8dkI2MQFvFXuAhurO32cj3J0XQeNK5domXhl9EEiQoRnQ7lY=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:1:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a0c:b39a:: with SMTP id t26mr6518189qve.19.1602137787303;
 Wed, 07 Oct 2020 23:16:27 -0700 (PDT)
Date:   Wed,  7 Oct 2020 23:15:53 -0700
In-Reply-To: <20201008061556.1402293-1-badhri@google.com>
Message-Id: <20201008061556.1402293-13-badhri@google.com>
Mime-Version: 1.0
References: <20201008061556.1402293-1-badhri@google.com>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
Subject: [PATCH v10 12/15] usb: typec: tcpm: Parse frs type-c current from
 device tree
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
        Badhri Jagan Sridharan <badhri@google.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Amelie Delaunay <amelie.delaunay@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New source's current capability is now defined as string based
device tree property through new-source-frs-typec-current.
Refactor tcpm code to parse new-source-frs-typec-current and
infer local port's new source current capability during frs.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
v9 is the first version of this patch in this series to rebase
TCPM code to read new source frs current from
new-source-frs-typec-current. No changes since v9.
---
 drivers/usb/typec/tcpm/tcpm.c | 41 +++++++++++++++++++----------------
 include/linux/usb/typec.h     | 12 ++++++++++
 2 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 02b7f623f584..d5a3e2b3bea2 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -180,16 +180,11 @@ enum adev_actions {
 	ADEV_ATTENTION,
 };
 
-/*
- * Initial current capability of the new source when vSafe5V is applied during PD3.0 Fast Role Swap.
- * Based on "Table 6-14 Fixed Supply PDO - Sink" of "USB Power Delivery Specification Revision 3.0,
- * Version 1.2"
- */
-enum frs_typec_current {
-	FRS_NOT_SUPPORTED,
-	FRS_DEFAULT_POWER,
-	FRS_5V_1P5A,
-	FRS_5V_3A,
+static const char * const typec_new_source_frs_current[] = {
+	[FRS_NOT_SUPPORTED]	= "not-supported",
+	[FRS_DEFAULT_POWER]	= "default",
+	[FRS_5V_1P5A]		= "1.5A",
+	[FRS_5V_3A]		= "3.0A",
 };
 
 /* Events from low level driver */
@@ -364,7 +359,7 @@ struct tcpm_port {
 	bool self_powered;
 
 	/* FRS */
-	enum frs_typec_current frs_current;
+	enum typec_new_source_frs_current new_source_frs_current;
 
 	/* Sink caps have been queried */
 	bool sink_cap_done;
@@ -1713,7 +1708,7 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 	unsigned int cnt = pd_header_cnt_le(msg->header);
 	unsigned int rev = pd_header_rev_le(msg->header);
 	unsigned int i;
-	enum frs_typec_current frs_current;
+	enum typec_new_source_frs_current partner_frs_current;
 	bool frs_enable;
 	int ret;
 
@@ -1786,12 +1781,13 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 		for (i = 0; i < cnt; i++)
 			port->sink_caps[i] = le32_to_cpu(msg->payload[i]);
 
-		frs_current = (port->sink_caps[0] & PDO_FIXED_FRS_CURR_MASK) >>
+		partner_frs_current = (port->sink_caps[0] & PDO_FIXED_FRS_CURR_MASK) >>
 			PDO_FIXED_FRS_CURR_SHIFT;
-		frs_enable = frs_current && (frs_current <= port->frs_current);
+		frs_enable = partner_frs_current && (partner_frs_current <=
+						     port->new_source_frs_current);
 		tcpm_log(port,
 			 "Port partner FRS capable partner_frs_current:%u port_frs_current:%u enable:%c",
-			 frs_current, port->frs_current, frs_enable ? 'y' : 'n');
+			 partner_frs_current, port->new_source_frs_current, frs_enable ? 'y' : 'n');
 		if (frs_enable) {
 			ret  = port->tcpc->enable_frs(port->tcpc, true);
 			tcpm_log(port, "Enable FRS %s, ret:%d\n", ret ? "fail" : "success", ret);
@@ -4746,7 +4742,8 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 {
 	const char *cap_str;
 	int ret;
-	u32 mw, frs_current;
+	u32 mw;
+	const char *new_source_frs_current;
 
 	if (!fwnode)
 		return -EINVAL;
@@ -4817,9 +4814,15 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 
 	/* FRS can only be supported byb DRP ports */
 	if (port->port_type == TYPEC_PORT_DRP) {
-		ret = fwnode_property_read_u32(fwnode, "frs-typec-current", &frs_current);
-		if (ret >= 0 && frs_current <= FRS_5V_3A)
-			port->frs_current = frs_current;
+		ret = fwnode_property_read_string(fwnode, "new-source-frs-typec-current",
+						  &new_source_frs_current);
+		if (!ret) {
+			ret = match_string(typec_new_source_frs_current,
+					   ARRAY_SIZE(typec_new_source_frs_current),
+					   new_source_frs_current);
+			if (ret >= 0)
+				port->new_source_frs_current = ret;
+		}
 	}
 
 	return 0;
diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
index 6be558045942..3198b89fa451 100644
--- a/include/linux/usb/typec.h
+++ b/include/linux/usb/typec.h
@@ -72,6 +72,18 @@ enum typec_orientation {
 	TYPEC_ORIENTATION_REVERSE,
 };
 
+/*
+ * Based on "Table 6-14 Fixed Supply PDO - Sink" of "USB Power Delivery Specification Revision 3.0,
+ * Version 1.2"
+ * Initial current capability of the new source when vSafe5V is applied.
+ */
+enum typec_new_source_frs_current {
+	FRS_NOT_SUPPORTED,
+	FRS_DEFAULT_POWER,
+	FRS_5V_1P5A,
+	FRS_5V_3A,
+};
+
 /*
  * struct enter_usb_data - Enter_USB Message details
  * @eudo: Enter_USB Data Object
-- 
2.28.0.806.g8561365e88-goog

