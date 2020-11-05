Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB072A7F4A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 13:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbgKEM6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 07:58:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730672AbgKEM6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 07:58:34 -0500
Received: from kernel.org (unknown [87.71.3.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC65D206D4;
        Thu,  5 Nov 2020 12:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604581113;
        bh=nw01jgr1oxcT/BSQ8RNy3JuylP0TudEfSI4BCkeILvI=;
        h=Date:From:To:Cc:Subject:From;
        b=OA8aa1eLmcnucKXWejEdzLr0u2RYFCRGF2pEITcOXpR4qASlfJ31DuR1Kp4QBisYY
         O6anCnfdO2PyiThTCABqzUkpiyUIwmVPg+X1jBV56XqwosAFCdQV1qdyGekj+6ESw8
         PJy56caePKRwwEsGOMN7JNOUms2bwgMe0TgXRcpw=
Date:   Thu, 5 Nov 2020 14:58:27 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Fix highmem initialization on arm and xtensa
Message-ID: <20201105125827.GA301837@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 4ef8451b332662d004df269d4cdeb7d9f31419b5:

  Merge tag 'perf-tools-for-v5.10-2020-11-03' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux (2020-11-03 13:28:50 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/rppt/memblock.git tags/fixes-2020-11-05

for you to fetch changes up to b9bc36704cca500e2b41be4c5bf615c1d7ddc3ce:

  ARM, xtensa: highmem: avoid clobbering non-page aligned memory reservations (2020-11-04 10:42:57 +0200)

----------------------------------------------------------------
Fix highmem initialization on arm and xtensa

Recent refactoring of memblock iterators has broken initialization of
highmem on arm and xtensa because it changed the way beginning and end of
memory regions are rounded to PFNs. This fix restores the original
behaviour.

----------------------------------------------------------------
Ard Biesheuvel (1):
      ARM, xtensa: highmem: avoid clobbering non-page aligned memory reservations

 arch/arm/mm/init.c    | 4 ++--
 arch/xtensa/mm/init.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--
Sincerely yours,
Mike.
