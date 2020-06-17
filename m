Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9771FC501
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 06:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgFQEQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 00:16:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgFQEQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 00:16:25 -0400
Received: from kernel.org (unknown [87.70.103.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1E78206D8;
        Wed, 17 Jun 2020 04:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592367385;
        bh=YSs3rS7jimINWeUYP1cnNHyH0AxuWxWgoOijCC6+TGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VyUAIohaqZorUXwTkRH2qBJCKLfdZvByHmqUzFZW7GdZb1lS4b+q8M1JrPeSpsERq
         kkY/b+DZfIuDP7TQMB0ubgyezfg8YBTEV5Wdvj6Kiuvzf5zUfTIiJmKvIp1vBs+SOC
         hVA54LY75gmPA9Nr3sNmUHwkfzx4I+RfAZut/9sY=
Date:   Wed, 17 Jun 2020 07:16:17 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] powerpc/8xx: use pmd_off() to access a PMD entry in
 pte_update()
Message-ID: <20200617041617.GA6571@kernel.org>
References: <20200615092229.23142-1-rppt@kernel.org>
 <20200616124304.bbe36933fcd48c5f467f4be9@linux-foundation.org>
 <87o8piegvt.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8piegvt.fsf@mpe.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 09:21:42AM +1000, Michael Ellerman wrote:
> Andrew Morton <akpm@linux-foundation.org> writes:
> > On Mon, 15 Jun 2020 12:22:29 +0300 Mike Rapoport <rppt@kernel.org> wrote:
> >
> >> From: Mike Rapoport <rppt@linux.ibm.com>
> >> 
> >> The pte_update() implementation for PPC_8xx unfolds page table from the PGD
> >> level to access a PMD entry. Since 8xx has only 2-level page table this can
> >> be simplified with pmd_off() shortcut.
> >> 
> >> Replace explicit unfolding with pmd_off() and drop defines of pgd_index()
> >> and pgd_offset() that are no longer needed.
> >> 
> >> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> >> ---
> >> 
> >> I think it's powerpc material, but I won't mind if Andrew picks it up :)
> >
> > Via the powerpc tree would be better, please.
> 
> I'll take it into next for v5.9, unless there's a reason it needs to go
> into v5.8.

I consider it a fixup for 5.8 merge window conflicts. Besides, mering it
now may avoid new conflicts in 5.9 ;-)

> cheers

-- 
Sincerely yours,
Mike.
