Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFE92791FE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgIYUVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:21:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728465AbgIYUTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:19:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E2962399C;
        Fri, 25 Sep 2020 20:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601065050;
        bh=giGCxILgKEq3oA0B0/iU+Y2hwrEg54j62yt7zpYmyTA=;
        h=From:To:Cc:Subject:Date:From;
        b=KaRd3sbf91UrziJnJ+Dp8Bq+EAWFMUhlLbZynA25sBqRvcJ4q04mMO0q29WC3QK/+
         rs4FBTtqF+YAqhvcBJdoIbbQSTX53grH5qZeKs119pEzSF3GuPeiJb2JkN/TbkEwEV
         TbKArVJuhROeWAHnhn+MmoguO3JebLrdpuotuGU0=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.9-rc6
Date:   Fri, 25 Sep 2020 21:16:21 +0100
Message-Id: <20200925201729.7E2962399C@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 59ae97a7a9e1499c2070e29841d1c4be4ae2994a:

  regulator: pwm: Fix machine constraints application (2020-09-02 19:13:29 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.9-rc6

for you to fetch changes up to fbb5a79d2fe7b01c6424fbbc04368373b1672d61:

  regulator: axp20x: fix LDO2/4 description (2020-09-23 17:06:27 +0100)

----------------------------------------------------------------
regulator: Fix for v5.9

A single fix for incorrect specification of some of the register fields
on axp20x devices which would break voltage setting on affected systems.

----------------------------------------------------------------
Icenowy Zheng (1):
      regulator: axp20x: fix LDO2/4 description

 drivers/regulator/axp20x-regulator.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)
