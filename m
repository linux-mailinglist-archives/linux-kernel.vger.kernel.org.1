Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D9F241F5E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 19:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729205AbgHKRkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 13:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728862AbgHKRkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:40:04 -0400
Received: from gaia (unknown [95.146.230.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C391320782;
        Tue, 11 Aug 2020 17:40:02 +0000 (UTC)
Date:   Tue, 11 Aug 2020 18:40:00 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fix for 5.9-rc1
Message-ID: <20200811173957.GA11571@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the fix below. Thanks.

The following changes since commit eaecca9e7710281be7c31d892c9f447eafd7ddd9:

  arm64: Fix __cpu_logical_map undefined issue (2020-08-08 19:25:04 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 3df14264ad9930733a8166e5bd0eccc1727564bb:

  recordmcount: Fix build failure on non arm64 (2020-08-10 15:22:06 +0100)

----------------------------------------------------------------
Fix recordmcount build failure on non-arm64 (caused by an arm64 patch).

----------------------------------------------------------------
Christophe Leroy (1):
      recordmcount: Fix build failure on non arm64

 scripts/recordmcount.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
Catalin
