Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6901424EBF8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 09:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgHWHST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 03:18:19 -0400
Received: from honk.sigxcpu.org ([24.134.29.49]:50526 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbgHWHSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 03:18:17 -0400
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 2F7E5FB04;
        Sun, 23 Aug 2020 09:18:13 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4D3AEECRzJdg; Sun, 23 Aug 2020 09:18:10 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id EF71C45869; Sun, 23 Aug 2020 09:18:08 +0200 (CEST)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Anson Huang <Anson.Huang@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Li Jun <jun.li@nxp.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Walle <michael@walle.cc>,
        Olof Johansson <olof@lixom.net>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] arm64: dts: imx8mq: Add NWL DSI host controller to Librem 5 Devkit
Date:   Sun, 23 Aug 2020 09:18:06 +0200
Message-Id: <cover.1598166983.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add the NWL host controller to the imx8mq and make use of it on
the Librem 5 Devkit enabling the built in MIPI DSI LCD panel.

I opted to add imx8mq internal ports and endpoints between nwl and lcdif to the
generic dtsi since those are SOC rather than board specific properties.

Changes from v3
- Rebase patch 3 and 4 against Shawn's imx/defconfig
  Patches 1 an 2 got already applies, thanks!

Changes from v2
- Add Tested-by from Martin Kepplinger, thanks!
  https://lore.kernel.org/linux-arm-kernel/cover.1597913263.git.agx@sigxcpu.org/T/#m067f2d659fcd1c0cb7792b22d0c4db06ed235815
  https://lore.kernel.org/linux-arm-kernel/cover.1597913263.git.agx@sigxcpu.org/T/#m9aff315ee38fd9bbcd3a896876726c14b2fb7048

Changes from v1
- Add Reviewed-by from Fabio Estevam, thanks!
  https://lore.kernel.org/linux-arm-kernel/CAOMZO5DUA5eS8apZPbte0EcSQ4Vwpg6YLK7D0YdjSUy+kdBu8Q@mail.gmail.com/
  https://lore.kernel.org/linux-arm-kernel/CAOMZO5ANrd2JCmHyxZ0Sv0WNcU9T-q3MbaeADxbOwf+31MQ4LQ@mail.gmail.com/#t
  https://lore.kernel.org/linux-arm-kernel/CAOMZO5Dg5NGpJ0SQkYny04Kv3ky0619J7YwT-0eE1dsK19o1-w@mail.gmail.com/
- As per review comment by Fabio Estevam
  Re-sync DRM related defconfig bits. I didn't resyc the whole defconfig since
  this is pretty much kernel version dependent.

Guido Günther (2):
  arm64: defconfig: re-sync DRM related defconfig bits
  arm64: defconfig: Enable imx8mq-librem5-devkit display stack

 arch/arm64/configs/defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.26.2

