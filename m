Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8810B2DE80B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbgLRRcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:32:54 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:49004 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbgLRRcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:32:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 931B0FB06;
        Fri, 18 Dec 2020 18:32:10 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1qf_Jj-yCOvO; Fri, 18 Dec 2020 18:32:09 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id DB46B43FDC; Fri, 18 Dec 2020 18:32:08 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Max Krummenacher <max.oss.09@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] arm64: defconfig: Enable some (hopefully) useful options
Date:   Fri, 18 Dec 2020 18:32:05 +0100
Message-Id: <cover.1608312654.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The aim of this series is make the arm64 'make defconfig' kernel more useful
for debugging and daily usage. I'm aware that expectations there diff widely so
I went for things I found in other defconigs as well.

It enables ftrace, more filesystems and more dm/md modules.

Since it's not board specific I have no idea which tree I would target so I
picked next-20201218.

Guido Günther (3):
  arm64: defconfig: Enable function tracer
  arm64: defconfig: Enable more filesystems
  arm64: defconfig: Enable more DM/MD targets as modules

 arch/arm64/configs/defconfig | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

-- 
2.29.2

