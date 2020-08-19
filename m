Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFC4249984
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 11:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgHSJjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 05:39:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:42988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbgHSJjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 05:39:21 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 207BC206FA;
        Wed, 19 Aug 2020 09:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597829960;
        bh=d7CAHzMkhCKaeq8rlFlp7wg1NwDvh0hOZ9bhTr6TmcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=andgOrj8J+vk/dN/u7ftpicQ7SuTdBbxr8Dz570YEX8B2ucDaeepqAOkhR+FPKwZc
         7oKlfkPA336PxiDdtlbX9uQDvAQOZcUNke3zeu/DY0tjW7Dc+ni7J8yuJpeOn4oeoE
         kKmscL88f0OyhC1vmHfEl/jmhSCto+Lywio/XPRk=
Date:   Wed, 19 Aug 2020 12:39:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jinbum Park <jinb.park7@gmail.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Fix missing function declaration
Message-ID: <20200819093917.GS7555@unreal>
References: <20200819080026.918134-1-leon@kernel.org>
 <65caa520-c7de-2703-f528-b2b1714ade65@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65caa520-c7de-2703-f528-b2b1714ade65@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 02:16:39PM +0530, Anshuman Khandual wrote:
>
>
> On 08/19/2020 01:30 PM, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > The compilation with CONFIG_DEBUG_RODATA_TEST set produces the following
> > warning due to the missing include.
> >
> >  mm/rodata_test.c:15:6: warning: no previous prototype for 'rodata_test' [-Wmissing-prototypes]
> >     15 | void rodata_test(void)
> >       |      ^~~~~~~~~~~
> >
> > Fixes: 2959a5f726f6 ("mm: add arch-independent testcases for RODATA")
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>
> This build failure appears only with W=1 and gets fixed with this.

It is our default compilation level for Mellanox RDMA submissions.

>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

Thanks

>
> > ---
> >  mm/rodata_test.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/mm/rodata_test.c b/mm/rodata_test.c
> > index 2a99df7beeb3..2613371945b7 100644
> > --- a/mm/rodata_test.c
> > +++ b/mm/rodata_test.c
> > @@ -7,6 +7,7 @@
> >   */
> >  #define pr_fmt(fmt) "rodata_test: " fmt
> >
> > +#include <linux/rodata_test.h>
> >  #include <linux/uaccess.h>
> >  #include <asm/sections.h>
> >
> > --
> > 2.26.2
> >
> >
> >
