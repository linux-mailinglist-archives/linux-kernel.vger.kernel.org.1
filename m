Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF332F9349
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jan 2021 16:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbhAQPLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 10:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729229AbhAQPKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 10:10:44 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6A7C061575;
        Sun, 17 Jan 2021 07:10:03 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id rv9so1327320ejb.13;
        Sun, 17 Jan 2021 07:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KBhfyHx7lA/AvYD4INjaneAr9EpjD/9Ht6JhcAPrRyk=;
        b=KxX36Q38Gtu12ZEaMG8pcwxFXvjTgiXjLKKgwa8hRkvNDUq69PKG1+R+wMBmO7cKVa
         eqkOZ3IEYIwSxuxSlq9afn1cKGqhuGyZX82BVSUvQAO3Rz17+zBV2nZVrCuq7EPFAktu
         mAr0XDmaqUW3DxZGZ0uojWlDL4Hik1vV8vKHBrkBhY6/XVdNl7Dgku4BHE/9zR0BUffZ
         NZamLGcT2mHtlxDx8Zo4I2fgIG7QOs0N6j0iRq/5ZjCoDdqh6z9GF8hY24k+YsZL2Xyc
         KFFXD0hta9Z6uc2gxO5B2wWQp7qNJYjTqHNQ0Dr9JK3PE7JrAwtQ3JgSlRbaLe78V3eO
         OXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KBhfyHx7lA/AvYD4INjaneAr9EpjD/9Ht6JhcAPrRyk=;
        b=qgbSoGL5rH2rz/lneYSfQzW0unKPq+b2xoX0VuIL9fnPnEfi3pz/wG+TjUuQzZilOC
         HipisFT01+z3zjt5WzBYfl3OUVWQwuWByzkleYtA0fCXQkvE9DNAXNEdn+ejbLIZfpwl
         usC4t6Ih/gg3Tzu11gDlBS/AIUYsIrFL5wVo4s7qZgr+Bqar9FaS79sAPIIJffvmMSNc
         dLJqq7D23txfNKDUEoQQIYhEzlld1pHkQX93sPPZPWNEIg6uK8g+wIs+eJxF2DBpKzDi
         M2p/Rx7yaodwo8RYLrkozBbwKOpv/chz8TPpXnoc1KAu0iepMAp87LXxFJbSghqZZ2+8
         AxPQ==
X-Gm-Message-State: AOAM530FLcNOzFkVSBsEXF5jyRsyjWcFiR1VGyVNjw1I22G+AD82eSIG
        uPZ7dROSq4JuheNmN+z9gpg=
X-Google-Smtp-Source: ABdhPJxPcUd5MNIIkD9OqaL4RoyXU009UiwezOm5YSI3C5+kDQS07JEjXDRYpJhYyvp+5Q4br98+AA==
X-Received: by 2002:a17:906:9342:: with SMTP id p2mr15049999ejw.300.1610896202360;
        Sun, 17 Jan 2021 07:10:02 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g3sm6295121eds.69.2021.01.17.07.10.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Jan 2021 07:10:01 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: rockchip: rename thermal subnodes for rk3368.dtsi
Date:   Sun, 17 Jan 2021 16:09:52 +0100
Message-Id: <20210117150953.16475-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210117150953.16475-1-jbx6244@gmail.com>
References: <20210117150953.16475-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:
/arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dt.yaml:
thermal-zones: 'cpu', 'gpu' do not match any of the regexes:
'^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'

Make the rk3368 thermal subnode names in line with the rest of
the Rockchip dts files. Add a label and rename them so that it ends
with "-thermal"

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/
thermal/thermal-zones.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index dad1a00e6..cd8274a35 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -400,7 +400,7 @@
 	};
 
 	thermal-zones {
-		cpu {
+		cpu_thermal: cpu-thermal {
 			polling-delay-passive = <100>; /* milliseconds */
 			polling-delay = <5000>; /* milliseconds */
 
@@ -444,7 +444,7 @@
 			};
 		};
 
-		gpu {
+		gpu_thermal: gpu-thermal {
 			polling-delay-passive = <100>; /* milliseconds */
 			polling-delay = <5000>; /* milliseconds */
 
-- 
2.11.0

