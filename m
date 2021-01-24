Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEDF301BC7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 13:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbhAXMQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 07:16:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:49098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726668AbhAXMQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 07:16:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5137AAC45;
        Sun, 24 Jan 2021 12:15:46 +0000 (UTC)
Date:   Sun, 24 Jan 2021 13:15:39 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] objtool/urgent for v5.11-rc5
Message-ID: <20210124121539.GD2493@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull three urgent objtool fixes resulting from recent toolchain
changes.

Thx.

---

The following changes since commit 7c53f6b671f4aba70ff15e1b05148b10d58c2837:

  Linux 5.11-rc3 (2021-01-10 14:34:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v5.11_rc5

for you to fetch changes up to 1d489151e9f9d1647110277ff77282fe4d96d09b:

  objtool: Don't fail on missing symbol table (2021-01-21 15:49:58 -0600)

----------------------------------------------------------------
 - Adjust objtool to handle a recent binutils change to not generate unused
 symbols anymore.

 - Revert the fail-the-build-on-fatal-errors objtool strategy for now due to the
 ever-increasing matrix of supported toolchains/plugins and them causing too
 many such fatal errors currently.

 - Do not add empty symbols to objdump's rbtree to accommodate clang removing
 section symbols.

----------------------------------------------------------------
Josh Poimboeuf (3):
      objtool: Don't add empty symbols to the rbtree
      objtool: Don't fail the kernel build on fatal errors
      objtool: Don't fail on missing symbol table

 tools/objtool/check.c | 14 +++++---------
 tools/objtool/elf.c   | 14 ++++++++++++--
 2 files changed, 17 insertions(+), 11 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
