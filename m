Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166002ED534
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 18:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbhAGRLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 12:11:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbhAGRLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 12:11:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11778233FD;
        Thu,  7 Jan 2021 17:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610039442;
        bh=2XmiB4F3aLGhBSppvywTKpPwlB1NGZnvQCx+5bvoY/k=;
        h=From:To:Cc:Subject:Date:From;
        b=WNyON4AR+4h+TpUXVfuDRiWiOldOV5BSe8exK39N+7lIEEDfU1yzddrTVwDA0VgmN
         MoEsW9nfbkMc4NYMA7b+1hBJ4kGr7mztCJht94i3PYuh3NZqiXuGj+tPdp7Ra0N0Pc
         L0fyo9llaGdGGn9g8tAwa1yXiPISJXleOO9PI/IUl23pq7uh2tXrmQwQWBRsE15oZG
         wVp7JiJy+5gwY6m+86Un8N2CMiHOuRHVANTE268URLamegbhYqUt5Bk51oQq2TuzID
         QzAvVpvdHS+xo66PKvb5iwgHpW/HHS9lHj28MLbgn8QaGY+1ggVKbpgy2lbOdyY2kt
         OGdFz5wThF/Ag==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.11-rc2
Date:   Thu, 07 Jan 2021 17:09:55 +0000
Message-Id: <20210107171041.11778233FD@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:

  Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.11-rc2

for you to fetch changes up to 36836f5b377b5a75c16f5bdc5c0f97f9f51212e1:

  Merge qcom driver fix into regulator-5.11 (2021-01-04 16:23:20 +0000)

----------------------------------------------------------------
regulator: Fixes for v5.11

A few minor driver specific fixes, mostly DT bindings document bits,
plus a new device ID.

----------------------------------------------------------------
Arnd Bergmann (1):
      regulator: qcom-rpmh: add QCOM_COMMAND_DB dependency

Dmitry Baryshkov (2):
      dt-bindings: regulator: qcom,rpmh-regulator: add pm8009 revision
      regulator: qcom-rpmh-regulator: correct hfsmps515 definition

Guido Günther (1):
      regulator: bd718x7: Add enable times

Mark Brown (3):
      regulator: pf8x00: Use specific compatible strings for devices
      Merge tag 'v5.11-rc1' into regulator-5.11
      Merge qcom driver fix into regulator-5.11

 .../bindings/regulator/nxp,pf8x00-regulator.yaml   |  6 ++-
 .../bindings/regulator/qcom,rpmh-regulator.txt     |  1 +
 drivers/regulator/Kconfig                          |  1 +
 drivers/regulator/bd718x7-regulator.c              | 57 ++++++++++++++++++++++
 drivers/regulator/pf8x00-regulator.c               |  8 ++-
 drivers/regulator/qcom-rpmh-regulator.c            |  2 +-
 6 files changed, 70 insertions(+), 5 deletions(-)
