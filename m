Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E843F3045C7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392240AbhAZRyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:54:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390552AbhAZIre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:47:34 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F7A7C0617AA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 00:46:05 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d38so17090810ybe.15
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 00:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=rY9VRGFEnK07xJyRxhqYar0R4BXBdHwAeKiBVE3gLSc=;
        b=UnAA7x7sisgHljyIT3brf27r5NguPJN6tGOVTmiPo2N2K9j+Gu/JvzvKR+oBXsMm8v
         2IV3JGec/SjF2E1jp01MTDE6qwsitpCnUfMQDmwpwoxpxc5ozzMDQqPI7gxNUxF/ZK9E
         ex2NDQh/t613jm0YYS5r9kA7Ylj9HOF5ZXJAtJImG+OI3oMqQ0j45CKotJGFAH1E+wwv
         HGKvZ69ezcCeX+/DEoWEnHxnpl6eUgottFdSOcYNy9PTbQAOCj+4B43hYfYGLAsOEHQJ
         x+xbafEeLwoxmI/QC/iSIsV24te9zerIcaN4RlcboxBDlAGq30azKEPBCpucE8Q9kpc2
         HVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rY9VRGFEnK07xJyRxhqYar0R4BXBdHwAeKiBVE3gLSc=;
        b=plOjO8nBuVhQLf9dyj2X4DsPdbw4V01zEpbZ13O4vDiSyClvlX+2h3A7j6C+eOnSSN
         UCzzIK2QsCwYncwMrrdfpsu1M+LDP7pOuy/sBPue3h1waJqujjLSSuxGZ86cz13a3vKg
         WMViXB+xn05jTVCDKy54+ttbpauQOQNeeFKTDynr7PE1OHPp4fXrbjgKCb43enhDUtQp
         i74XUZRT9EgsRALJfF4ooUMbt8fMlO5xBysYv7AtatNWvBpVnKp54u9oRgoVAKH3Zj0A
         c+CtiO/gnt3HKsxeSdWyrydbcSKXwXG+Q+t5+KKDl3mdT6gEsLkwODxLDnLZ4OxvZXvU
         NkdQ==
X-Gm-Message-State: AOAM530CaOBffUReI/7mI4NfAlrkhbPGxc81+mnzSYiRqdaLnmZJrujF
        mb00JNb5aZFTsbeaB3qwWmQW4p6c/Y01
X-Google-Smtp-Source: ABdhPJx+fjPVUGXGXLaEb5V4RxpTQ3WPXK1uu3IzULxVwMe1ZP0gWXIf/o0pmkLFGK4n8elA+NfVJT/bgeaO
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:4430:c29c:1e76:3e65])
 (user=kyletso job=sendgmr) by 2002:a25:ac5d:: with SMTP id
 r29mr7223448ybd.446.1611650764837; Tue, 26 Jan 2021 00:46:04 -0800 (PST)
Date:   Tue, 26 Jan 2021 16:45:44 +0800
In-Reply-To: <20210126084544.682641-1-kyletso@google.com>
Message-Id: <20210126084544.682641-4-kyletso@google.com>
Mime-Version: 1.0
References: <20210126084544.682641-1-kyletso@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH 3/3] usb: typec: tcpm: Get Sink VDO from fwnode
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        hdegoede@redhat.com, badhri@google.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current design only allows TCPM to get the Sink VDO from TCPC configs.
Add an additional way from fwnode.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index c14cf7842520..7b797d14d9db 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5673,6 +5673,18 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 			port->new_source_frs_current = frs_current;
 	}
 
+	ret = fwnode_property_read_u32_array(fwnode, "sink-vdos", NULL, 0);
+	if (ret <= 0 && ret != -EINVAL) {
+		return -EINVAL;
+	} else if (ret > 0) {
+		port->nr_snk_vdo = min(ret, VDO_MAX_OBJECTS);
+		ret = fwnode_property_read_u32_array(fwnode, "sink-vdos",
+						     port->snk_vdo,
+						     port->nr_snk_vdo);
+		if (ret < 0)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.30.0.280.ga3ce27912f-goog

