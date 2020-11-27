Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587632C69B1
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731631AbgK0QmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:42:06 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:48964 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731577AbgK0QmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:42:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 436F3FB04;
        Fri, 27 Nov 2020 17:42:02 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Fz0S_8lZJE8h; Fri, 27 Nov 2020 17:42:01 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 5DC004068F; Fri, 27 Nov 2020 17:42:00 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] arm64: defconfig: Enable Librem 5 hardware
Date:   Fri, 27 Nov 2020 17:41:59 +0100
Message-Id: <cover.1606495281.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables components found on Purism's Librem 5
that are available in mainline.

- changes from v1
  - As per review comments from Krzysztof Kozlowski
    https://lore.kernel.org/linux-arm-kernel/CAJKOXPdEwiSTg+cMes_wes5oz2F1qEexsus6iHenuLs9SAXk6g@mail.gmail.com/
    - Squash config changes into a single commit
  - Add touch controller

Patches are on top of Shawn's imx/defconfig

Guido Günther (1):
  arm64: defconfig: Enable more Librem 5 hardware

 arch/arm64/configs/defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.29.2

