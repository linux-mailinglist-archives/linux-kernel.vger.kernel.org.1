Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF012FEA34
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731266AbhAUMhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730980AbhAUMgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 07:36:52 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE20C061757
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:36:10 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a10so2342153ejg.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 04:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=48e+OLm0ER6iWCSKD8u4Ws9vRmX1gNHTsb3YXOXSYS8=;
        b=copFDABFS89Vhx33PEDHJHERGoFy2Vuqtucq5WJKiGGcsc6yW/ffOxkjxFEXAPXdfe
         8+cgtzDqhgsG7JI1DRVhGIJA70TV+ge7RU3kREubDrzlqkYrF62abD+ZKO+fPzmIw8iA
         B1lzfhO1Ru5q9xfXx1tlyZwobE7K/Al2snjPrNxk7GOb2lBTzVUSqh2Anv3G0VfDYFPa
         U3g/vHoKT+eh4l7Pwl2ZnX5qximeGen1MD7I31R2DH9HhLEqAU3UfZ+nFSNeLpX/7FxK
         vb29cekjaXkEadfyLXrpZ7Vv4wiZoJt4KaYUzUy8XaDeqnYHwmJwantaL2ioWKXDlttt
         F76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=48e+OLm0ER6iWCSKD8u4Ws9vRmX1gNHTsb3YXOXSYS8=;
        b=iCuzdgoQ1MY2Qk4Kf3QeROgGG9ZNM68xOB3R6RXenVFa4f9+3GNc3n65IhdARfdxjQ
         wQF7Od5CfPGFgO1JVkm2HyeONzZJs8jSAhKr4j8iOqIoP5D2AZzQdR4/DQRtO95DBpbV
         ATeDzCh6KdGcWv4yvvGo/5FgwaTnrVeMcnGhzfvf1518CJNWdwsZbDKZ1vKEZSdFriRs
         8jOkHRgGfS8HP5uFz6aepAs4fTD+mGPayUyItLbmm3B0G9Y406Mj8XKVkyy9RNMSSr4U
         GGUG2uMyp6srLKWqUiBmVzVqY2itCu87NNnkCC2tV1MDWJAT4aRZPRL/lqmRXw72mUan
         bv1g==
X-Gm-Message-State: AOAM530ayTnVWXVpaL8UZ508JZMaaaPqHCF0VTydhnxA+OvmNiuXN0Wd
        a+Tell+rNuI5qlnUV+1dx4zvI7Ke+tPzG5dY
X-Google-Smtp-Source: ABdhPJxA0ioWQq2rM25QOBXr65kL+/AQPugIlhse28klBj9oVCJOq84+cEEgbISNMspGQBBBX+HkfA==
X-Received: by 2002:a17:906:94d2:: with SMTP id d18mr9045527ejy.94.1611232569099;
        Thu, 21 Jan 2021 04:36:09 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id z25sm2180530ejd.23.2021.01.21.04.36.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jan 2021 04:36:08 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Kalyani Akula <kalyani.akula@xilinx.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/3] arm64: dts: zynqmp: Enable and Wire DP
Date:   Thu, 21 Jan 2021 13:36:04 +0100
Message-Id: <cover.1611232558.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am updating DT patches which were there part of DP v11 series sent by
Laurent in past [1]. Patches have been removed in v12 [2].
The series is rebased on the top of [3] which wired si5341 clock chip.

[1] http://lore.kernel.org/r/20200318153728.25843-1-laurent.pinchart@ideasonboard.com
[2] http://lore.kernel.org/r/20200718001347.25451-1-laurent.pinchart@ideasonboard.com
[3] http://lore.kernel.org/r/cover.1611224800.git.michal.simek@xilinx.com

Thanks,
Michal


Laurent Pinchart (2):
  arm64: dts: zynqmp: Add DPDMA node
  arm64: dts: zynqmp: Wire up the DisplayPort subsystem

Michal Simek (1):
  arm64: dts: zynqmp: Add DisplayPort subsystem

 .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi | 10 ++++++
 .../boot/dts/xilinx/zynqmp-zcu100-revC.dts    | 31 ++++++++++++++++++
 .../boot/dts/xilinx/zynqmp-zcu102-revA.dts    | 10 ++++++
 .../boot/dts/xilinx/zynqmp-zcu104-revA.dts    | 11 +++++++
 .../boot/dts/xilinx/zynqmp-zcu104-revC.dts    | 11 +++++++
 .../boot/dts/xilinx/zynqmp-zcu106-revA.dts    | 11 +++++++
 .../boot/dts/xilinx/zynqmp-zcu111-revA.dts    | 11 +++++++
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi        | 32 +++++++++++++++++++
 8 files changed, 127 insertions(+)

-- 
2.30.0

