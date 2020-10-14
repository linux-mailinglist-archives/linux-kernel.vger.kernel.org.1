Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD728E745
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 21:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390646AbgJNT2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 15:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389668AbgJNT2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 15:28:19 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ABBC061755;
        Wed, 14 Oct 2020 12:28:18 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id m9so142060qth.7;
        Wed, 14 Oct 2020 12:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dTSVWFM2/LTxQv7NidykDGUVu39NOUpLGs/ssfQGR2o=;
        b=FnmcRvSbgftAvRvHHib/Zk21pZeUQnQvzL3RsLz1EWEJw5qifaWJDZe27scDVl+aj/
         wBhQhqK4mQP2vMt01+xStlnRCwPxu8Ud+oDIeXAljQRsB/WuAMcN0GUC3c8f/NZ4Oh4T
         r/v4cpn44UFWoO0xODp+ektZPonyDuqoAM6GIzqGyCo2NDKopn6OZITXc2xBTuqMdQXr
         IQHzymdQICw6kRAt926M1mYAa4knCIInY94CW2IG9c6XQfCcXOAlGgC+n16PKSxsZNEw
         wSDeelozQwV7nkPf0IQPOi2iam/lLD7hf88s//IloU66+JaKPDRehIwVPjp/Mr6Fut7u
         GWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dTSVWFM2/LTxQv7NidykDGUVu39NOUpLGs/ssfQGR2o=;
        b=QttB8CoR5hRMOGxSWyGl2wA0v/e8CoSUOVECV8Q6QGOzu2aOxPMl2vJ6CNDwq7K1Yc
         U3TqvZPqac3VxZ1n/+6YHG9IXN5Vo5Go8dIGNIzOCnL2QDi/vozvIzlMvvAZiJBIwflO
         dVXG+LJU78aXuXwcoV5YDGIU3Lw5z92pa9cPYeh7MHCxjcwirM1qZGlF2pAaXmTTerAz
         hq8xA1PD0N50gQDu9JdmM0rIfJA0gtamPwX14oH6a+fiLufczJMLHpBtQCubk9l6WJge
         pjhjiKoNLslxqPZ89bSr/PRKFLrMn4E4DBOqo+3SzdC3HuJJnOP0VT5EGXzaQnkjC7N/
         DQaQ==
X-Gm-Message-State: AOAM533zLcxbNI62qMWs13maBv/9ElPLEDm2e5KFbSma8HR2siRt8kiB
        yrWzhbqo3LikmhEZMwW+cx4=
X-Google-Smtp-Source: ABdhPJzHDKLW+3I7+4RJLxNSa9wmuv9RwAslxZkZOtTWT+Yy4zzFEZhBWAGaZkIDJ2+9jD7wIi4Qdw==
X-Received: by 2002:ac8:5247:: with SMTP id y7mr689383qtn.205.1602703698179;
        Wed, 14 Oct 2020 12:28:18 -0700 (PDT)
Received: from ubuntu.localdomain (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.googlemail.com with ESMTPSA id g16sm265387qke.90.2020.10.14.12.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 12:28:17 -0700 (PDT)
From:   Vivek Unune <npcomplete13@gmail.com>
Cc:     florian.fainelli@broadcom.com,
        Vivek Unune <npcomplete13@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: BCM5301X: Linksys EA9500 add port 5 and port 7
Date:   Wed, 14 Oct 2020 15:27:27 -0400
Message-Id: <c51b1d53c9411a4321ddcb1dbcdb0a42945b23c4.1602701516.git.npcomplete13@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1602701516.git.npcomplete13@gmail.com>
References: <cover.1602701516.git.npcomplete13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ports 5 and 7 which are connected to gmac cores 1 & 2.
These will be disabled for now.

Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
---
 .../boot/dts/bcm47094-linksys-panamera.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
index 9fcd215177d7..0ff502d5aa0c 100644
--- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
+++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
@@ -242,6 +242,30 @@ port@4 {
 			label = "wan";
 		};
 
+		port@5 {
+			reg = <5>;
+			ethernet = <&gmac0>;
+			label = "cpu";
+			status = "disabled";
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
+			status = "disabled";
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

