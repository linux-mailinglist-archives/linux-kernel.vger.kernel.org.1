Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166D52867F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 21:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgJGTCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 15:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgJGTCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 15:02:07 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED414C0613D2;
        Wed,  7 Oct 2020 12:02:06 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d1so2912928qtr.6;
        Wed, 07 Oct 2020 12:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FEl01U0O4q1Wh5acZAMNLtX3OV2kFE+fvUvj0p58OWc=;
        b=ZOIJ8j4wn7/ZIbygqbn+zPxpWp96Dd/JFoJSsXP+0Jc+OVM2nt1NzPMxGMD6Srqo5e
         IK2Op88lBz8ucs9cmugYfAK2ldHi9qWlPQ9yigtHwSS5SKAW8HzQB+zL3lB37+e2e9OH
         F5CadzRUkD4OH/AhX/QGorxuNCTSj7SiTexiFlYz6fFctrc7Ka9wEyM5N2eJ3pcsiE3c
         8ERdSgFHXYj2MQkzz7n0rhrhjS/NT/lZNsol15cQZhfOmk1yYMnBhZ/EEMTEvbK2iqI6
         tZvdJEReO8m6jTalTHRsOkfw1vKp89Ra/OfPR/8PyaU94p6zv3ZSUuntXYBlTycbNxzy
         fN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FEl01U0O4q1Wh5acZAMNLtX3OV2kFE+fvUvj0p58OWc=;
        b=nnWGV4ww+xaLATeAT/UyejcT7NtsyrImA/qvnKd7T1cscWzwR50wFmMFlHSJ4PF66v
         ajcXIvcLBwf9ekkRvN13kQTq3EJrU8yorR1Vk1h97wDOVPlkdhXmoARlaqF8rHAcnB+w
         4kVShWYG4mzViQq/Qcph52ixQmSX95C5Ph1w27kPK2Aj06cq6ck+Fzanx7lWBBk/SyVU
         BilVoOQMtF5Jt1OKikEhPehlphgB/UlWLI9zohNbyyqmu5SqW/k9KSMvWAdC9jNEh3Kz
         lPnUIGQVQPLCesyH074wh7hEJ80DKoCLdO9IXoiW2zQ3arKjgiDD+ZVCs7+Zzzw81KDv
         XDSA==
X-Gm-Message-State: AOAM531rUtxotSkZ8QZaIAubnmrcJryhbLdtrRhGFgyCKT+5YKbv+bBL
        MhtQe7jIx9Vn0YanvbYzzoA=
X-Google-Smtp-Source: ABdhPJw43qZa0AFvk3gQx2GGHVG0qqHBOJmpcOK+e0O9FK8qvssu7uMLossAnkrEWn2VWiaE1T9Z7w==
X-Received: by 2002:ac8:760f:: with SMTP id t15mr4917593qtq.35.1602097326163;
        Wed, 07 Oct 2020 12:02:06 -0700 (PDT)
Received: from ubuntu.localdomain (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.googlemail.com with ESMTPSA id j16sm2087078qkg.26.2020.10.07.12.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 12:02:05 -0700 (PDT)
From:   Vivek Unune <npcomplete13@gmail.com>
Cc:     Vivek Unune <npcomplete13@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] ARM: dts: BCM5301X: Linksys EA9500 add port 5 and port 7
Date:   Wed,  7 Oct 2020 15:01:51 -0400
Message-Id: <cd64e0ccae3e5785c80ad4d73af533a40fc15876.1601655904.git.npcomplete13@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1601655904.git.npcomplete13@gmail.com>
References: <cover.1601655904.git.npcomplete13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add port 5 and port 7 which are connected to gmac0 & 1 respectively
DSA driver will use port 5 as cpu port and this works as well.

Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
---
 .../boot/dts/bcm47094-linksys-panamera.dts    | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
index f8443d9f86b7..b36ed0ead733 100644
--- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
+++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
@@ -161,6 +161,28 @@ port@4 {
 			label = "wan";
 		};
 
+		port@5 {
+			reg = <5>;
+			ethernet = <&gmac0>;
+			label = "cpu";
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+
+		port@7 {
+			reg = <7>;
+			ethernet = <&gmac1>;
+			label = "cpu";
+
+			fixed-link {
+				speed = <1000>;
+				full-duplex;
+			};
+		};
+
 		port@8 {
 			reg = <8>;
 			ethernet = <&gmac2>;
-- 
2.25.1

