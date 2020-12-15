Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92ED2DAB69
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 11:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgLOKun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 05:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbgLOKtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 05:49:41 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89981C0617B0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 02:49:00 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CwFP65SKkz9sTg; Tue, 15 Dec 2020 21:48:58 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <e796c5fcb5898de827c803cf1ab8ba1d7a5d4b76.1606231483.git.christophe.leroy@csgroup.eu>
References: <e796c5fcb5898de827c803cf1ab8ba1d7a5d4b76.1606231483.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/6] powerpc/8xx: DEBUG_PAGEALLOC doesn't require an ITLB miss exception handler
Message-Id: <160802920955.504444.6903217720200398229.b4-ty@ellerman.id.au>
Date:   Tue, 15 Dec 2020 21:48:58 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 15:24:54 +0000 (UTC), Christophe Leroy wrote:
> Since commit e611939fc8ec ("powerpc/mm: Ensure change_page_attr()
> doesn't invalidate pinned TLBs"), pinned TLBs are not anymore
> invalidated by __kernel_map_pages() when CONFIG_DEBUG_PAGEALLOC is
> selected.
> 
> Remove the dependency on CONFIG_DEBUG_PAGEALLOC.

Applied to powerpc/next.

[1/6] powerpc/8xx: DEBUG_PAGEALLOC doesn't require an ITLB miss exception handler
      https://git.kernel.org/powerpc/c/613df979da6c032cbe6fa273fb8ca21af022157e
[2/6] powerpc/8xx: Always pin kernel text TLB
      https://git.kernel.org/powerpc/c/bccc58986a2f98e3af349c85c5f49aac7fb19ef2
[3/6] powerpc/8xx: Simplify INVALIDATE_ADJACENT_PAGES_CPU15
      https://git.kernel.org/powerpc/c/576e02bbf1062b9118d5bbb96a40ed3b6b359f22
[4/6] powerpc/8xx: Use SPRN_SPRG_SCRATCH2 in ITLB miss exception
      https://git.kernel.org/powerpc/c/a314ea5abf6dbaf35f14c9bd1d93105260fb9336
[5/6] powerpc/8xx: Use SPRN_SPRG_SCRATCH2 in DTLB miss exception
      https://git.kernel.org/powerpc/c/89eecd938cab80f0da18abbd2ed997a521f83f01
[6/6] powerpc/ppc-opcode: Add PPC_RAW_MFSPR()
      https://git.kernel.org/powerpc/c/70b588a068668dd7a92ed19cf0373ba92847957c

cheers
