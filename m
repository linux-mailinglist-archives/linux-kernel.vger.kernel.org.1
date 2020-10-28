Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B24029DAB6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 00:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390618AbgJ1X2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 19:28:45 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20041 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbgJ1X2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 19:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603927686; x=1635463686;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cbfVGaWnMu+8pgVF8g9CD+iaCR7rsYJqW/fz2SXidbQ=;
  b=Mn3sDuQScwyjtmKbPlOHBmyouzgGVJ/WTyDwEMUbuL+t7S2HzKilMZnw
   38SJStGReIgseYw7ql37FVKYNsXALHzpOrFCaADlMIVkXEX5R0LvZVCen
   AktJRXgxnnkw8Xl9yLy6tjl5LVGy6rgp8eJF2W+YZs2J0U78aFWkBvfWM
   ARVsTQ0iu0p5ZQPdXrVQEpQYOghm1/nbL78twEfKp2eJLglyjtwMCq9ys
   a2OJp0mi1DJzEThG+PMmtYU77wYYpM72wOHarGF9hcwYaaOAlKm7GiS2/
   zhJ/h7h9oqt9SDrMcKgEHdTRq3JkS/bs6Mv5Jwig16H+fm/SQsfn+R8xa
   w==;
IronPort-SDR: KJ6wjcLoiXERxdvDeXajzUeWMliQmDTCJdxvDFN09bjQJemXkNYaYOZv36YbSk5T22a9/oNjsL
 cQnhWblP4pPA6RdKYbdLz2pagF1yeF3D3H6si/AVvxhntGyw2H7dXJT0xmvrlnKrf9ulKaPtXY
 kKs4Mng9VmFgBlmKVBdqRjIKRIQXl+GENWPMfOPqsQLJ5hKoA7Bt9NSdMCU0Vr1l72j+jtYW1M
 sWGukp1Vn/g5etmuqcGz744gbgIgBHu7ZHHjyBpOxiczbyhqRWDQ9T41k22B4mOJXXGGk9gSxZ
 10E=
X-IronPort-AV: E=Sophos;i="5.77,428,1596470400"; 
   d="scan'208";a="155611417"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2020 07:28:06 +0800
IronPort-SDR: VzlkUCNeuiucAlbc+gyL0aodpnzYM5fLzwxytRyoGYduZ3X3C+oLdxxmocaNnVJ5czRBuUOy/v
 ljlJSKGVnwhwiSWB2F2rmSUcYBmywtTkd+ugr5nakFcxV6ZTUPEPzJnwNFOSlFMV89eTvYlvH5
 iD7FyGvf1IiT/hgfg/ct+k3kuq0HwuzB53xYl2KBV9BIjIY5mmr7446OFdBPYYDWnlPEdUfw8s
 90dcxZTP4znap9l5Tu8SyIw3K6/DrAP0IbTkws+YM/ag8QIkgHGOoSuSuagzg2inf8vXSyVK2j
 IGBNmppPuORVzBxevAfHma72
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2020 16:14:22 -0700
IronPort-SDR: buavO+3n128wXApNGIFfrqEjjKBm1I1PnymmXX6X25/PUwDn5yG4TfLzSC3aE2blO728jSGeng
 ZYeuijWei4Rk96OnUtunZLZLpZ8I8ZF8kBAwFll7TWFGOFYd+USFDHf28rNgHOg1kK6CBbOvEg
 2ne1I12LnBypDbBQB2RIMi+VZJRwgjVqnm/MHzx9HfJMpfW9eN7HbjCtMB8+TA8F7C6Ab31MPf
 ygcujc57MY7V/gNCT4VLsSKPv0htxzY3Vi3usUONWUKMZJTk01Q2pOZ1r1bYLYPudWSqa4oxUc
 U2k=
WDCIronportException: Internal
Received: from myd002180.ad.shared (HELO jedi-01.hgst.com) ([10.86.60.107])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Oct 2020 16:28:07 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        padmarao.begari@microchip.com,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Cyril.Jean@microchip.com
Subject: [RFC PATCH 0/3] Add Microchip PolarFire Soc Support 
Date:   Wed, 28 Oct 2020 16:27:56 -0700
Message-Id: <20201028232759.1928479-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds minimal support for Microchip Polar Fire Soc Icicle kit.
It is rebased on v5.10-rc1 and depends on clock support. 
Only MMC and ethernet drivers are enabled via this series.
The idea here is to add the foundational patches so that other drivers
can be added to on top of this.

This series has been tested on Qemu and Polar Fire Soc Icicle kit.
The following qemu series is necessary to test it on Qemu.

The series can also be found at the following github repo.

I noticed the latest version of mmc driver[2] hangs on the board with
the latest clock driver. That's why, I have tested with the old clock
driver available in the above github repo.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg08582.html
[2] https://www.spinics.net/lists/devicetree/msg383626.html

Atish Patra (3):
RISC-V: Add Microchip PolarFire SoC kconfig option
RISC-V: Initial DTS for Microchip ICICLE board
RISC-V: Enable Microchip PolarFire ICICLE SoC

arch/riscv/Kconfig.socs                       |   7 +
arch/riscv/boot/dts/Makefile                  |   1 +
arch/riscv/boot/dts/microchip/Makefile        |   2 +
.../microchip/microchip-icicle-kit-a000.dts   | 313 ++++++++++++++++++
arch/riscv/configs/defconfig                  |   4 +
5 files changed, 327 insertions(+)
create mode 100644 arch/riscv/boot/dts/microchip/Makefile
create mode 100644 arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts

--
2.25.1

