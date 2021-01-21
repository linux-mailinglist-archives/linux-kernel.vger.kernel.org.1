Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5D72FE7B3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729568AbhAUKd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728948AbhAUK3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:29:10 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F8CC06179B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:19 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id l9so1874424ejx.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 02:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EnsVlbJaN5WOsGHVrv0u0vrcQJ2xhSe8sflE2lsbuCA=;
        b=fGWyO4Fe5SVuIauLgVfVOiCp9Aiaj8VhvLOZ3SA7RVagKA05wEpsO9ijjwUUZMPfFc
         Mf4a3jWi+4RwT/WGm/LoMfK7hsJxSpAjHM81Pw8+R2/Nkr+ErWUj0GVE7Wy8u7MlcF3y
         0b03gwM6wXzKO9jUo6J3ghhh5dyvZ7n8GNJZf4AkpPjOthAK4L7JHBrEwNglSDjn8m0z
         4k9qATOwIv7KBXSN3L4MQhyGlCxiGeZKTYLE31EmL7HOLjdG8gem69DwTj/WVPdJDDFy
         YSXLW5VV/wXtLKbWzCD3ksY8klz35hcMWgP17HmcyzkLS9B31X//7IL5WfFqhv36vqrG
         4FzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EnsVlbJaN5WOsGHVrv0u0vrcQJ2xhSe8sflE2lsbuCA=;
        b=FEX8fsIQ6VXL5dkQ1W+V4XF8isoNAwFrgUaHNFwo2D50849VlmCzQ7zzGsH76LMN1D
         cPljBRsl+FgzcyisnQ/G/bh2KjO2IeoTHHc2/P+X5zE60oOt0gU7fzv4xeXt09OBUyIt
         dQXKtXVAHOds8k+ZiNHE1NyTvNmBELs+Ow+DANk1bj9kK/uZd4AS/HiTSR0aAcT26rR3
         PzppoCy58vvBYBBWCAqmO5ULirTJtXquNAC93lJFM51hWT3VPUsVWrAbb1yqRb/fU7n1
         HzFBrXG3O3JtGH5TvexoPFXwF2csrwbSwSOgRFm5Ex61skIgpEXALxer29k+DVUDMxZm
         kPTw==
X-Gm-Message-State: AOAM5304zkxtg1iSDMkWUD/gFT/BtRqrJnHKKP6vsGPZo1BiJMDO3tV6
        x4ce70cKrhGCHVe8P3j1E6juqMW4kYdS1eEJ
X-Google-Smtp-Source: ABdhPJzR9hS+nzxO4X48KcFTDTD3OQ1RsI2df6sBw76mw1yWQa4Sthh5h7tLHFStiK5iYckXZJvN9Q==
X-Received: by 2002:a17:906:a384:: with SMTP id k4mr5895531ejz.194.1611224837684;
        Thu, 21 Jan 2021 02:27:17 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id n15sm2037347ejg.5.2021.01.21.02.27.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 02:27:17 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 07/12] arm64: dts: zynqmp: Add missing mio-bank properties to sdhcis
Date:   Thu, 21 Jan 2021 11:26:55 +0100
Message-Id: <dbdfcc1b25af8b28fc658a37ce18902978cb410d.1611224800.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611224800.git.michal.simek@xilinx.com>
References: <cover.1611224800.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing xlnx,mio-bank property to sdhci nodes. Also add properties with
0 value to have it listed in case that files are copied to different
projects where default case doesn't need to be handled in the same way.
That's why explicitly list them too.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

Based on dt binding fix:
https://lore.kernel.org/r/5fa17dfe4b42abefd84b4cbb7b8bcd4d31398f40.1606914986.git.michal.simek@xilinx.com
---
 arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 2 ++
 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 1 +
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 1 +
 5 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
index 68ecd0f7b2f2..71ebcaadb7c8 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
@@ -233,11 +233,13 @@ &sdhci0 {
 	status = "okay";
 	no-1-8-v;
 	disable-wp;
+	xlnx,mio-bank = <0>;
 };
 
 &sdhci1 {
 	status = "okay";
 	bus-width = <0x4>;
+	xlnx,mio-bank = <0>;
 	non-removable;
 	disable-wp;
 	cap-power-off-card;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index d92698ffbf8c..9abd10f6785a 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -694,6 +694,7 @@ &sata {
 &sdhci1 {
 	status = "okay";
 	no-1-8-v;
+	xlnx,mio-bank = <1>;
 };
 
 &uart0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index 5e2be9abc175..8ede619fea52 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -203,6 +203,7 @@ &sata {
 &sdhci1 {
 	status = "okay";
 	no-1-8-v;
+	xlnx,mio-bank = <1>;
 	disable-wp;
 };
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index 4ec6715abab7..d60a30787022 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -689,6 +689,7 @@ &sata {
 &sdhci1 {
 	status = "okay";
 	no-1-8-v;
+	xlnx,mio-bank = <1>;
 };
 
 &uart0 {
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index 2969c4b71384..758de05c4a4b 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -572,6 +572,7 @@ &sata {
 &sdhci1 {
 	status = "okay";
 	no-1-8-v;
+	xlnx,mio-bank = <1>;
 };
 
 &uart0 {
-- 
2.30.0

