Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F3C25C397
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 16:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgICOyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 10:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729296AbgICOyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:54:45 -0400
Received: from kernel.org (unknown [77.127.89.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8D952072A;
        Thu,  3 Sep 2020 14:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599144884;
        bh=v33Xb9X9GvxmPN3+NOHcqHGJjgQqmZYSA04xdjzeNUQ=;
        h=Date:From:To:Cc:Subject:From;
        b=nsU7mWRmhR/Pfl4Z4+2/xdN0yMWkKeMDLx6U+5rYeeuL0CrLRaCprjNkhF8mHEYv9
         52vD0bWQeoz+j7GgbkZSg1U0OoMY5/Y2gnwvTMaaSgryB6zAjoYwm8Zd5Q/muX3eIe
         WmLBizF+TvgLJfs43bVRd6eCDeQdUL7H6JrMb1zU=
Date:   Thu, 3 Sep 2020 17:54:38 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Michal Simek <monstr@monstr.eu>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        kernel test robot <lkp@intel.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [GIT PULL] Fix min_low_pfn/max_low_pfn build errors on ia64 and
 microblaze
Message-ID: <20200903145438.GA1781636@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git tags/fixes-2020-09-03

for you to fetch changes up to 5f7b81c18366c38446f6eedab570b98dbdc07cff:

  ia64: fix min_low_pfn/max_low_pfn build errors (2020-09-01 19:34:11 +0300)

----------------------------------------------------------------
Fix min_low_pfn/max_low_pfn build errors on ia64 and microblaze

Some configurations of ia64 and microblaze use min_low_pfn and
max_low_pfn in pfn_valid(). This causes build failures for modules that
use pfn_valid().

The fix is to add EXPORT_SYMBOL() for these variables on ia64 and
microblaze.

----------------------------------------------------------------
Randy Dunlap (2):
      microblaze: fix min_low_pfn/max_low_pfn build errors
      ia64: fix min_low_pfn/max_low_pfn build errors

 arch/ia64/kernel/ia64_ksyms.c | 2 +-
 arch/microblaze/mm/init.c     | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

-- 
Sincerely yours,
Mike.
