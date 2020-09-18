Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE4A27037C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 19:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgIRRpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 13:45:38 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:55862 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgIRRph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 13:45:37 -0400
Date:   Fri, 18 Sep 2020 13:45:35 -0400
From:   Rich Felker <dalias@libc.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-sh list <linux-sh@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [GIT PULL] arch/sh important regression fixes 5.9
Message-ID: <20200918174528.GY3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.libc.org/linux-sh tags/sh-for-5.9-part2

for you to fetch changes up to b0cfc315ff38c423a5ce9ce159bd5baa4135e688:

  sh: fix syscall tracing (2020-09-13 21:22:55 -0400)

----------------------------------------------------------------
Fixes for build and function regression.

----------------------------------------------------------------
Rich Felker (2):
      sh: remove spurious circular inclusion from asm/smp.h
      sh: fix syscall tracing

 arch/sh/include/asm/smp.h     |  1 -
 arch/sh/kernel/entry-common.S |  1 -
 arch/sh/kernel/ptrace_32.c    | 15 +++++----------
 3 files changed, 5 insertions(+), 12 deletions(-)
