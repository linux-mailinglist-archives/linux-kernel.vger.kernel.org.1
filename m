Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE456303E65
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 14:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392598AbhAZNRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 08:17:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404246AbhAZMqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 07:46:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 37C7123104;
        Tue, 26 Jan 2021 12:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611665129;
        bh=jc3jk7zdFTpc4OCqxDpiaeq59UaQ0zVzd2okvWJnK0k=;
        h=From:To:Cc:Subject:Date:From;
        b=VwM0R70f5mCKBMPG6MizOTQGdQsSd5f9qbHbneivJMl0X/ywm332UB3s9WS1njMM3
         gTGsZY0ylXfqIjFAHRsIAgJoyFu6DqFqDLTz6iNa4cbFeLzlcogUeQRAeA+SWTCtGE
         JLhwdN6KDV5puZ4Y4KELWjd7zg0sRprD/EesK5RX4FWfKjQwJnzfqImARVAkNoGost
         AGitMGPsRAt5+BMIGH4vVbBBdjErSAVar0pgozGcjHRctHmJ6F+DA7W5Urnnomk0dX
         stGx2SaNCdgianuiQjf84Iic+RffQU5RSh86p2op5pmA2gfBVHUUbXDl50WkAdontI
         IqKOp0wBvbYbw==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.11-rc5
Date:   Tue, 26 Jan 2021 12:44:33 +0000
Message-Id: <20210126124529.37C7123104@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.11-rc5

for you to fetch changes up to 14a71d509ac809dcf56d7e3ca376b15d17bd0ddd:

  regulator: Fix lockdep warning resolving supplies (2021-01-22 14:03:07 +0000)

----------------------------------------------------------------
regulator: Fixes for v5.11

The main thing here is a change to make sure that we don't try to double
resolve the supply of a regulator if we have two probes going on
simultaneously, plus an incremental fix on top of that to resolve a
lockdep issue it introduced.

There's also a patch from Dmitry Osipenko adding stubs for some
functions to avoid build issues in consumers in some configurations.

----------------------------------------------------------------
David Collins (1):
      regulator: core: avoid regulator_resolve_supply() race condition

Dmitry Osipenko (1):
      regulator: consumer: Add missing stubs to regulator/consumer.h

Mark Brown (2):
      Merge v5.11-rc3
      regulator: Fix lockdep warning resolving supplies

 drivers/regulator/core.c           | 44 ++++++++++++++++++++++++++++----------
 include/linux/regulator/consumer.h | 30 ++++++++++++++++++++++++++
 2 files changed, 63 insertions(+), 11 deletions(-)
