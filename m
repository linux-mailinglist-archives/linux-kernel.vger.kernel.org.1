Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EFF2C7E04
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 07:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgK3GEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 01:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgK3GEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 01:04:06 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D615C0613D3;
        Sun, 29 Nov 2020 22:03:26 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id hk16so715920pjb.4;
        Sun, 29 Nov 2020 22:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zhVPQbT+XsqYAAdzPNfOUxHPVoA7ByFSiGyznpbOHYo=;
        b=KqddcHl3nG9ICuWJI5DhumJWe0ZJ88hB6nEwLUN+dtqViY08r6a0vu16zc8qG+vR0n
         8279aVJZl22tp+TSIAnn6PNyWHSN1u4dgWZozDehwOSQK0sGl1PKY1EEfxYG/6ZkmXyq
         epXRr1a23/MvWPB4oli4SmPagrz6BAqGJG2rWIRo3+zDTK59gS49tNJJhxNH7lOACTec
         gENqMi9CoNqfiYx3fBfHQvggMyXQ6/XQYh/vuo16n33RniWvfMCQpkvIJCS3dJRCptfv
         UCbyj5DedjgoLaL0m9qsOp30fUQ5j6FioVqCbTXh7URQCqKmC1POMn9nJpY2d8cx2Gf5
         de1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zhVPQbT+XsqYAAdzPNfOUxHPVoA7ByFSiGyznpbOHYo=;
        b=nF43TUQBpvcuV3kgRqb/SjgO+leB9svfVHPnNRkLctTneWtiPivSBWIWKO/90ocIY7
         7PaIxnJoQF3L+nhrvn2Lslx2mG381/vPKJgpfMFBZQI58WNjF5B+Xlx67eWIkH86IU0m
         qEE221Ie6EtDf0eCmBKjZb/7UP0JVb3Tek7iL9ZT3T7oVgDTdWECNLz/XovVJvAF0KOh
         JsST1VFSM2e3kdfbrHB9U/OjVZpmp6FRFsc3ssMvA3KdI629JV0eqN69bfYjDW6xAJFO
         /yEGx1AahKMwDePtV+iGOMnGLCeNBE4WY+i7kTN63kcStM+zxfjdWJ+5sCrg7SVAXVq2
         BieA==
X-Gm-Message-State: AOAM530XZ+NbOS7O45Kb6MCPkHb15cJyybVfgaECV/m330t/0XTlXoEl
        rcP16A1nRoStB9hLsfDSCiBb31JEvBQCeA==
X-Google-Smtp-Source: ABdhPJzCZc1/oz48r0UAFMuCgh/kMY0v4ZvQ4ywv8DqkGU1WeB0wz/UvXP1kMHfB2QZFWxFbus8R9g==
X-Received: by 2002:a17:902:b116:b029:d8:f5d7:5fe5 with SMTP id q22-20020a170902b116b02900d8f5d75fe5mr17220389plr.48.1606716205705;
        Sun, 29 Nov 2020 22:03:25 -0800 (PST)
Received: from anyang-linuxfactory-or-kr ([106.250.177.234])
        by smtp.gmail.com with ESMTPSA id f123sm148057pfa.89.2020.11.29.22.03.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Nov 2020 22:03:24 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:03:20 +0900
From:   Dongjin Kim <tobetter@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: meson-sm1: fix typo in opp table
Message-ID: <20201130060320.GA30098@anyang-linuxfactory-or-kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The freqency 1512000000 should be 1500000000.

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---

Change in v2:
  - wrong fix in the previous patch.
    https://patchwork.kernel.org/project/linux-amlogic/patch/20201130054221.GA25448@anyang-linuxfactory-or-kr/ 

---
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 71317f5aada1..c309517abae3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -130,7 +130,7 @@
 			opp-microvolt = <790000>;
 		};
 
-		opp-1512000000 {
+		opp-1500000000 {
 			opp-hz = /bits/ 64 <1500000000>;
 			opp-microvolt = <800000>;
 		};
-- 
2.17.1

