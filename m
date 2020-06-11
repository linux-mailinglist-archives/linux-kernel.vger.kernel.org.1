Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418941F707B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 00:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgFKWmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Jun 2020 18:42:37 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:47890 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgFKWmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 18:42:36 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 87B558066C;
        Fri, 12 Jun 2020 10:42:33 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1591915353;
        bh=z18FyZO4tD8hq+U3C4EzL4PHx+K02wDYo+U3VUvRdeE=;
        h=From:To:Cc:Subject:Date;
        b=mltCE6afHRqjGu92ZKl4G4QS9zOuutjmGmnPbXOV+4uZp7Mub3IXKH5m+O5jm9v9Z
         fNUwwjz+6jwUiXlWIwTb9zPt+/4jCR+S44UpKgwldU0CG6sf3JHjp8foBhqn5eZ8F3
         YY4UzzkTth4urENA263dDzjaPqnbWDAr3d/YqxOk1i2OPCTPPXf2kob0aZ5GWHjVw/
         iGh0gcooGj2jTmFSTPHKJE/tLlqdgbVYoR3rPYzzrgQbnxNu0+qBys4bC1LA/X2NDW
         aZuU1TqaTJZJMidyq+Reh+lqFUwvIITQR1dMvv99eDGbk3Mn52Pmko5PtIaXSwIK77
         +CJ+KQJg741ag==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ee2b3590000>; Fri, 12 Jun 2020 10:42:33 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id A069B13ED45;
        Fri, 12 Jun 2020 10:42:32 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 403A7280083; Fri, 12 Jun 2020 10:42:33 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@c-s.fr
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v3 0/2] powerpc: CMDLINE config cleanup
Date:   Fri, 12 Jun 2020 10:42:18 +1200
Message-Id: <20200611224220.25066-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans up the config options related to the boot command line=
.

Chris Packham (2):
  powerpc: Remove inaccessible CMDLINE default
  powerpc: configs: remove CMDLINE_BOOL

 arch/powerpc/Kconfig                           | 6 +-----
 arch/powerpc/configs/44x/akebono_defconfig     | 2 --
 arch/powerpc/configs/44x/arches_defconfig      | 2 --
 arch/powerpc/configs/44x/bamboo_defconfig      | 2 --
 arch/powerpc/configs/44x/bluestone_defconfig   | 2 --
 arch/powerpc/configs/44x/canyonlands_defconfig | 2 --
 arch/powerpc/configs/44x/currituck_defconfig   | 2 --
 arch/powerpc/configs/44x/eiger_defconfig       | 2 --
 arch/powerpc/configs/44x/fsp2_defconfig        | 1 -
 arch/powerpc/configs/44x/icon_defconfig        | 2 --
 arch/powerpc/configs/44x/iss476-smp_defconfig  | 1 -
 arch/powerpc/configs/44x/katmai_defconfig      | 2 --
 arch/powerpc/configs/44x/rainier_defconfig     | 2 --
 arch/powerpc/configs/44x/redwood_defconfig     | 2 --
 arch/powerpc/configs/44x/sam440ep_defconfig    | 2 --
 arch/powerpc/configs/44x/sequoia_defconfig     | 2 --
 arch/powerpc/configs/44x/taishan_defconfig     | 2 --
 arch/powerpc/configs/44x/warp_defconfig        | 1 -
 arch/powerpc/configs/holly_defconfig           | 1 -
 arch/powerpc/configs/mvme5100_defconfig        | 3 +--
 arch/powerpc/configs/ps3_defconfig             | 2 --
 arch/powerpc/configs/skiroot_defconfig         | 1 -
 arch/powerpc/configs/storcenter_defconfig      | 1 -
 23 files changed, 2 insertions(+), 43 deletions(-)

--=20
2.27.0

