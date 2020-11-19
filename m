Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4FE2B99EB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgKSRpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:45:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:47640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728284AbgKSRpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:45:30 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5A5921D7A;
        Thu, 19 Nov 2020 17:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605807930;
        bh=iq75PEK8x+3RVdblmo8FP1m1ICW+OINA4AFdYz6+Xec=;
        h=From:To:Cc:Subject:Date:From;
        b=yr3D6ARjVVn+ShQTbEV2UtS6MVWriJv5urv23y+Iq0Dj3MmiBcczyG+uLBD17bD9+
         +fzc4titUfuCDTrGkMfzH2lxF2+urTV86Bbu2D9thai3U96oN/kbU2E9GyhmQx6JTG
         KdFwfKJSumSP9DODBbSafH0mqQRauNqfmmV7Q+0c=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.10-rc4
Date:   Thu, 19 Nov 2020 17:45:08 +0000
Message-Id: <20201119174529.A5A5921D7A@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit cf1ad559a20d1930aa7b47a52f54e1f8718de301:

  regulator: defer probe when trying to get voltage from unresolved supply (2020-11-03 13:19:01 +0000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.10-rc4

for you to fetch changes up to 2ba546ebe0ce2af47833d8912ced9b4a579f13cb:

  regulator: ti-abb: Fix array out of bound read access on the first transition (2020-11-18 17:59:24 +0000)

----------------------------------------------------------------
regulator: Fixes for v5.10

Mostly core fixes here, one set from Michał Mirosław which cleans up
some issues introduced as part of the coupled regulators work, one
memory leak during probe and two due to regulators which have an input
supply name and regulator name which are identical, which is very
unusual.  There's also a fix for our handling of the similarly unusual
case where we can't determine if a regulator is enabled during boot.

----------------------------------------------------------------
Michał Mirosław (3):
      regulator: fix memory leak with repeated set_machine_constraints()
      regulator: avoid resolve_supply() infinite recursion
      regulator: workaround self-referent regulators

Nishanth Menon (1):
      regulator: ti-abb: Fix array out of bound read access on the first transition

Pi-Hsun Shih (1):
      regulator: core: don't disable regulator if is_enabled return error.

Sean Nyekjaer (1):
      regulator: pfuze100: limit pfuze-support-disable-sw to pfuze{100,200}

 drivers/regulator/core.c               | 43 ++++++++++++++++++++--------------
 drivers/regulator/pfuze100-regulator.c | 13 ++++++----
 drivers/regulator/ti-abb-regulator.c   | 12 +++++++++-
 3 files changed, 44 insertions(+), 24 deletions(-)
