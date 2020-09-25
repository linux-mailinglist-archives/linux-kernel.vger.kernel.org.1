Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F7E2791FA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 22:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgIYUVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 16:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbgIYUTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 16:19:32 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2D8523888;
        Fri, 25 Sep 2020 20:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601065028;
        bh=tcpcPd6V5OwTfWaugeSxXS/06OAYDOShWpD8cPhO4n0=;
        h=From:To:Cc:Subject:Date:From;
        b=aY0B4Yrn8Q/EEKrcOl9OWaOkKVp56vTA59OJqhABI2osoBmklQn2JhqZlkH7fcis4
         kiBH1aVKR8L6RfM783id2ZpUXXUbL0b3yOEPbKL9L+RwIC2OTaAAvmHG7U4eGwI1F9
         pPGDxqEdMn3QHPQSxKRZxsLyJAh6ro5jVTdss+ZY=
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regmap fixes for v5.9-rc6
Date:   Fri, 25 Sep 2020 21:16:00 +0100
Message-Id: <20200925201707.A2D8523888@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d012a7190fc1fd72ed48911e77ca97ba4521bccd:

  Linux 5.9-rc2 (2020-08-23 14:08:43 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-fix-v5.9-rc6

for you to fetch changes up to 05669b63170771d554854c0e465b76dc98fc7c84:

  regmap: fix page selection for noinc writes (2020-09-21 20:58:02 +0100)

----------------------------------------------------------------
regmap: Fixes for v5.9

Two issues here - one is a fix for use after free issues in the case
where a regmap overrides its name using something dynamically generated,
the other is that we weren't handling access checks non-incrementing I/O
on registers within paged register regions correctly resulting in
spurious errors.  Both of these are quite rare but serious if they
occur.

----------------------------------------------------------------
Charles Keepax (2):
      regmap: debugfs: Fix handling of name string for debugfs init delays
      regmap: debugfs: Add back in erroneously removed initialisation of ret

Dmitry Baryshkov (2):
      regmap: fix page selection for noinc reads
      regmap: fix page selection for noinc writes

 drivers/base/regmap/internal.h       |  6 +--
 drivers/base/regmap/regcache.c       |  2 +-
 drivers/base/regmap/regmap-debugfs.c |  7 ++--
 drivers/base/regmap/regmap.c         | 75 +++++++++++++++++++++++-------------
 4 files changed, 56 insertions(+), 34 deletions(-)
