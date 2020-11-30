Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3A2D2C84CD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgK3NM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgK3NM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:12:26 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1465C061A54
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:11:17 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id v3so1851226plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yD+i4Z9WFCrSPRU/Cu5AH5Qr/+FQTQAlg3Q/0BU4c3I=;
        b=wa8JZ6sUoOGymC9NQTHdhS3RFxQgnL4Q31tcPLwetwCO/EVYtiZU9gl8F/MUUjan0s
         lCEeaR7mN6NtyzTxB6yNgfp5E5/N+3klgIP7o97EKtSlrlBKXW+q7jj+Q/l890wPmFr1
         yQTHLNRn0sftR/UVvEnAddUwJgSu7gkz9iJjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yD+i4Z9WFCrSPRU/Cu5AH5Qr/+FQTQAlg3Q/0BU4c3I=;
        b=Nc1vmJjw5oyRLy4OzMzNyGUEkHd2loNiKG20dDSaeTQLh2mpMRI/ibB2AK2PjaKgsp
         OuhcNJj02Ke+4bIDINpHptOii6IrHPr+lrygLkGyUmvnlawIwzeR3EhvzjKt07PJVwOW
         g7NFmC43NI4RnuAwVMeAxeDdH5NeEbjy0hArTZDSzkDgbOu+zllpi+9cGj/eW8Jym2ML
         lztR/8EajN1CaOasdEUMvFwV01PZmq5nPk28pGnAZdGBfh/K6D93rU6Lcm7wSdWa7YgF
         NscG/boXOR3i0Om+VCyXcbF/lMmazma6Wb4Qbto4/NtV1lpKOxI7FoMppCUCwsfeA77E
         D0mA==
X-Gm-Message-State: AOAM5305kDnE0Tu6ZhtBWJjVama+fhP1HcDZK09/AtT/PKlPKhW1Lxq5
        315X5OgOhoDLYBg/IxSC8vFRjDAhmiNQEg==
X-Google-Smtp-Source: ABdhPJxrFt/Ipfrzw4pKLeTjqBcuHqmyZX1kXZuagx430E+3Z1gm3vf299AADhwFvbVd37XzTyckWQ==
X-Received: by 2002:a17:90a:6a0e:: with SMTP id t14mr25795009pjj.95.1606741877257;
        Mon, 30 Nov 2020 05:11:17 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id a4sm41757578pjq.0.2020.11.30.05.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 05:11:16 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        w@1wt.eu, daniel@0x0f.com
Subject: [PATCH 8/9] ARM: mstar: Add smp ctrl registers to infinity2m dtsi
Date:   Mon, 30 Nov 2020 22:10:46 +0900
Message-Id: <20201130131047.2648960-9-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130131047.2648960-1-daniel@0x0f.com>
References: <20201130131047.2648960-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the smpctrl registers to the infinity2m dtsi so that the
second CPU can be enabled on chips in this family.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-infinity2m.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity2m.dtsi b/arch/arm/boot/dts/mstar-infinity2m.dtsi
index 02adb9fe9d3c..85e178368ba4 100644
--- a/arch/arm/boot/dts/mstar-infinity2m.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity2m.dtsi
@@ -13,3 +13,11 @@ cpu1: cpu@1 {
 		reg = <0x1>;
 	};
 };
+
+&riu {
+	smpctrl@204000 {
+		compatible = "mstar,smpctrl";
+		reg = <0x204000 0x200>;
+		status = "okay";
+	};
+};
-- 
2.29.2

