Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA5023009CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 18:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbhAVR3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 12:29:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:40664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729684AbhAVQyz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 11:54:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEFBB23A9A;
        Fri, 22 Jan 2021 16:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611334445;
        bh=1kHUFnn6d5oIdozQtcSfSNQIxbyCatyKwsZYd3W7wqo=;
        h=Date:From:To:Cc:Subject:From;
        b=E86RXwzM4s4Cdso/07rwG+9R5lQJNMZQQT9stGce92CJpvCR9HomOf2bEFLW0iB0v
         USM0M2p1D35JHLE3qEfp5Gfpj5x+hcIivX13Js/iTMiOiBIOgi3TNI3cZH9vY4sPxs
         jQ0zUBAcZPL0NYiDIbk+awuJIf6nPq5/Jv5O8/SeSKAs7oDhJpemxiCu74SeB9uFWL
         mmszOM5nSpuUO7rIhmnK+w3TuwrXenGIwV3fcXvADBxeUFJjDl68K4IbSpNeOwgUH1
         aqh5LUfr7kEr9I7QVsa/gOCSVpwXIZiJTPxmUndCwyFOJNtuys5c+sVPbEtFOgbwpb
         LH0G6b+oy2NkA==
Date:   Fri, 22 Jan 2021 18:53:59 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Levi Yun <ppbuk5246@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mm/memblock: typo fix in a comment
Message-ID: <20210122165359.GC6332@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 9791581c049c10929e97098374dd1716a81fefcc:

  Merge tag 'for-5.11-rc4-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2021-01-20 14:15:33 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2021-01-22

for you to fetch changes up to 17cbe03872be8878e2f84047424350d036915df1:

  mm/memblock: Fix typo in comment of memblock_phys_alloc_try_nid() (2021-01-21 10:29:37 +0200)

----------------------------------------------------------------
mm/memblock: fix typo in comment of memblock_phys_alloc_try_nid()

----------------------------------------------------------------
Levi Yun (1):
      mm/memblock: Fix typo in comment of memblock_phys_alloc_try_nid()

 mm/memblock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Sincerely yours,
Mike.
