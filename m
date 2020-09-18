Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77682701EF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgIRQRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbgIRQRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:17:30 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D73220795;
        Fri, 18 Sep 2020 16:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600445850;
        bh=vDSPwR6Bgtsv8lo5GFN8iaXaPRe2BXebWktgtOo/fdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AJyl8b9xSfvFZR6HGhRH7nsb/iGQhawLhTeyE87loXOdqeZDCPnlqAnzziOzh2HKO
         tEmmVbzqbqqa1hgzl39wro5uexKcys69WtEYsVMnjGqqYJo1e8RdOXQmdcb6+lB6BK
         ZkSODultj5cguRFUnMJryTY07P3jVkmWZE8SKw2A=
Date:   Fri, 18 Sep 2020 11:23:05 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] percpu fix for v5.9-rc6
Message-ID: <20200918162305.GB25599@embeddedor>
References: <20200917204514.GA2880159@google.com>
 <CAHk-=whXpv0KJvpL153dhUaRgSjzT8H4dD85hRw-fAwXvXnKAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whXpv0KJvpL153dhUaRgSjzT8H4dD85hRw-fAwXvXnKAA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 06:05:13PM -0700, Linus Torvalds wrote:
> On Thu, Sep 17, 2020 at 1:45 PM Dennis Zhou <dennis@kernel.org> wrote:
> >
> >
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index f4709629e6de..1ed1a349eab8 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -1316,7 +1316,7 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
> >
> >         /* allocate chunk */
> >         alloc_size = sizeof(struct pcpu_chunk) +
> > -               BITS_TO_LONGS(region_size >> PAGE_SHIFT);
> > +               BITS_TO_LONGS(region_size >> PAGE_SHIFT) * sizeof(unsigned long);
> 
> Hmm.
> 
> Wouldn't this be cleaner as
> 
>         alloc_size =struct_size(chunk, populated,
>                  BITS_TO_LONGS(region_size >> PAGE_SHIFT) );

Yeah; the above is much better. Please, use that helper.

> and looking at this, I realize that I thought we enabled warnings for
> 'sizeof()' of flexible array structures to avoid these kinds of
> mistakes, but that must clearly have happened only in a dream of mine.

If you were to try to apply the sizeof() operator to the flexible-array member
alone: sizeof(chunk->populated); you would get a warning because such arrays
have incomplete type, see below:

mm/percpu.c: In function ‘pcpu_alloc_first_chunk’:
mm/percpu.c:1320:52: error: invalid application of ‘sizeof’ to incomplete type ‘long unsigned int[]’
 1320 |   BITS_TO_LONGS(region_size >> PAGE_SHIFT) * sizeof(chunk->populated);
      |                                                    ^

However, in this case, sizeof() is being applied to the object type, which doesn't
cause a warning, but still is an error-prone coding practice. For instance, this
is the bugfix[1], for a 4-year old bug introduced by the combination of weak code
and this commit[2]. This bug could have been prevented by either adopting better
coding practices or through the use[3] of the recent struct_size() helper.

So please, whenever you can use it, do so. :)

Thanks
--
Gustavo

[1] https://git.kernel.org/linus/cffaaf0c816238c45cd2d06913476c83eb50f682
[2] https://git.kernel.org/linus/57384592c43375d2c9a14d82aebbdc95fdda9e9d
[3] https://git.kernel.org/linus/553d66cb1e8667aadb57e3804775c5ce1724a49b


