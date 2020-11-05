Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 136072A83D1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbgKEQpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:45:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:48524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731557AbgKEQps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:45:48 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE3AD221F8;
        Thu,  5 Nov 2020 16:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604594748;
        bh=L9E+SLp8M2OPpGG3Mrt+tsx/eY4XdpZAfQDzblg/rc4=;
        h=From:To:Cc:Subject:Date:From;
        b=tsYzGh+6msoJKtXLQdqo9azmnLMGVqirKlWpinUa/4Qu2a9Jgu3S92VXhU+6dr1lX
         AHaAFa23Ix9g0KXDAKaTSuQe+VDcnl3L52K9UqcZ6NRzEDzQzu5CvVtdSH+gNaxdFW
         QPHXPKEeWpWhTh2zHwn4oKbHVn071tFSCQWE4YgA=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator fixes for v5.10-rc2
Date:   Thu, 05 Nov 2020 16:45:25 +0000
Message-Id: <20201105164547.AE3AD221F8@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-fix-v5.10-rc2

for you to fetch changes up to cf1ad559a20d1930aa7b47a52f54e1f8718de301:

  regulator: defer probe when trying to get voltage from unresolved supply (2020-11-03 13:19:01 +0000)

----------------------------------------------------------------
regulator: Fixes for v5.10

An addition to MAINTAINERS plus a fix for a nasty bootstrapping problem
which caused problems when we need to read the voltage of a regulator
that is not yet available during initialization, we were not correctly
distinguishing between this case and the case where a regulator is put
into a bypass mode.

----------------------------------------------------------------
Mark Brown (1):
      Merge tag 'v5.10-rc1' into regulator-5.10

Michał Mirosław (1):
      regulator: defer probe when trying to get voltage from unresolved supply

Robert Marko (1):
      MAINTAINERS: Add entry for Qualcomm IPQ4019 VQMMC regulator

 MAINTAINERS              | 8 ++++++++
 drivers/regulator/core.c | 2 ++
 2 files changed, 10 insertions(+)
