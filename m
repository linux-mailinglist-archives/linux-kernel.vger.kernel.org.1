Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C46C2739E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 06:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgIVEbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 00:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgIVEbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 00:31:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0446BC061755;
        Mon, 21 Sep 2020 21:31:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b79so1876850wmb.4;
        Mon, 21 Sep 2020 21:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dBMKv7Deo23fcUft/+4uee+gTmxJlYqKyjhLhZ254Pw=;
        b=GmwMiF1Zf2+D5MYRba2R6yoL9aCwzI3F2CsAWvP3HcNdxmcSFKTZbuagWvYmwth/Ao
         BJb5UXHtIT3PO5CQYq50qv0Kx9XmO9/WW8Dqb6Mk4pDrz7wtN/b/ZPWLcxgxzy67vXNM
         orcBmTBxbq1xLUQ1xxgAIBgDkQoIoVa/Ee3CjyXN4KiGq6fcVzbMgmj/Q1MxjzayEaNS
         m/xIUVsnrMW6tf6WRkNZXbbmMqUYUpyxXwxogy4rrJFKyRzyNHANoD4gq6ZQEwaPd6wy
         wxKr1X3E/n0M8oNlZ1u4jde8HaqvhxtZPxyE705O4/UdAMzROa7hWtjMQYSeqCF2QOWU
         3QBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dBMKv7Deo23fcUft/+4uee+gTmxJlYqKyjhLhZ254Pw=;
        b=ovME3uYCrQC/vFPCvFo1t1IumsRfk6b3D653preBAv2WNs5IaXbGrpdWnZZIwzyXuw
         /62/0wjcBY1ouskDh5GQ4N7vj3z1Ze1IvSAjC+YMHgxIqyi3W9ex7F1seXSsMJUCBuKP
         lm/I19VGvQeDMOmjfeBWXjZorJQy/mrGfIk34j+RRkKyyMnhDUqxr+UxWXw8KbYq1FYI
         ONGvCtBJaGc+5DKh3dWSNjK4xTaas1DvDvydXdlwUdYLeAvOPecY92TZuCJ6LhK/iwWC
         odsYCbQS34NFLFsS5CgapNQEjnsq5HYoQ0hJFzIVtP3neWRMCLxMut8YegQtDUD93xFa
         PfuA==
X-Gm-Message-State: AOAM533/1dLCl5XKxlyuLNKnLgDrFbca1D3lo/806FOZQWVlUCP41GyL
        0fgzNvleGTqcpXkoNFo1PRY=
X-Google-Smtp-Source: ABdhPJzV7ZUnMfimwcWMnYTdwhHgykJjvi8jtzf2pqAX5rKfT4DmD0vjgbz/diT+oYQPeD938jOFIg==
X-Received: by 2002:a05:600c:258:: with SMTP id 24mr2522749wmj.66.1600749103531;
        Mon, 21 Sep 2020 21:31:43 -0700 (PDT)
Received: from mamamia.internal (a89-183-78-237.net-htp.de. [89.183.78.237])
        by smtp.gmail.com with ESMTPSA id z127sm2585159wmc.2.2020.09.21.21.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 21:31:42 -0700 (PDT)
From:   Andre Heider <a.heider@gmail.com>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: dts: marvell: espressobin: Get rid of duplicate serial aliases
Date:   Tue, 22 Sep 2020 06:31:41 +0200
Message-Id: <20200922043141.1138665-1-a.heider@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921164830.499548-1-a.heider@gmail.com>
References: <20200921164830.499548-1-a.heider@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The included armada-37xx.dtsi already defines these two aliases.

Signed-off-by: Andre Heider <a.heider@gmail.com>
Reviewed-by: Pali Rohár <pali@kernel.org>
---
v3: really fix filename, sorry for the spam... too early, not enough coffee
v2: fix filename in commit message

This goes on top of Pali's patch:
"arm64: dts: marvell: espressobin: Add ethernet switch aliases"

The resulting .dtb files are the same.

 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index 0775c16e0ec8..3169a820558f 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -17,8 +17,6 @@ aliases {
 		ethernet1 = &switch0port1;
 		ethernet2 = &switch0port2;
 		ethernet3 = &switch0port3;
-		serial0 = &uart0;
-		serial1 = &uart1;
 	};
 
 	chosen {
-- 
2.28.0

