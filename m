Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6403729187D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 19:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbgJRRM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 13:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbgJRRM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 13:12:58 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 846662063A;
        Sun, 18 Oct 2020 17:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603041177;
        bh=AK5r/ov6o6zQcLRexpXc2iVbUCioiMkupD2/Q12PoW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zt2298czrECJkDZ2/Wuix5AIbJrytMvzOur+1UZPhjCdKLz6GddyMkZALX6I1E7sf
         uz77+PrVaWfV8vZDourIf5Guvct32FU85StXZqQ/CHTNYSl/z3cDmM+dpb+DHxWFqG
         TtUa+j9iJNSeAxbhYINycc4GnKPn+4guWRNxq+SU=
Date:   Sun, 18 Oct 2020 20:12:52 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib/test_free_pages: Add basic progress indicators
Message-ID: <20201018171252.GA392079@kernel.org>
References: <20201018140445.20972-1-geert@linux-m68k.org>
 <20201018142508.GJ20115@casper.infradead.org>
 <CAMuHMdVcTx0wVTSh-YaJxXqCMpCxGRe3QH36O5i+McinfdRwDg@mail.gmail.com>
 <20201018150146.GK20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201018150146.GK20115@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 04:01:46PM +0100, Matthew Wilcox wrote:
> On Sun, Oct 18, 2020 at 04:39:27PM +0200, Geert Uytterhoeven wrote:
> > Hi Matthew,
> > 
> > On Sun, Oct 18, 2020 at 4:25 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > On Sun, Oct 18, 2020 at 04:04:45PM +0200, Geert Uytterhoeven wrote:
> > > > The test module to check that free_pages() does not leak memory does not
> > > > provide any feedback whatsoever its state or progress, but may take some
> > > > time on slow machines.  Add the printing of messages upon starting each
> > > > phase of the test, and upon completion.
> > >
> > > It's not supposed to take a long time.  Can you crank down that 1000 *
> > 
> > It took 1m11s on ARAnyM, running on an i7-8700K.
> > Real hardware may even take longer.
> 
> 71 seconds is clearly too long.  0.7 seconds would be fine, so 10 * 1000
> would be appropriate, but then that's only 320MB which might not be
> enough to notice on a modern machine.
> 
> > > 1000 to something more appropriate?
> > 
> > What would be a suitable value? You do want to see it "leak gigabytes
> > of memory and probably OOM your system" if something's wrong,
> > so decreasing the value a lot may not be a good idea?
> > 
> > Regardless, if it OOMs, I think you do want to see this happens
> > while running this test.
> 
> How about scaling with the amount of memory on the machine?
> 
> This might cause problems on machines with terabytes of memory.
> Maybe we should cap it at a terabyte?

On ARAnyM wih 782 MBytes of RAM running on i7-8650U it takes ~1.75
seconds.
Still, I think adding some verbosity to the test wouldn't hurt ;-)

> diff --git a/lib/test_free_pages.c b/lib/test_free_pages.c
> index 074e76bd76b2..aa18fa52290a 100644
> --- a/lib/test_free_pages.c
> +++ b/lib/test_free_pages.c
> @@ -9,11 +9,11 @@
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  
> -static void test_free_pages(gfp_t gfp)
> +static void test_free_pages(gfp_t gfp, unsigned long totalram)
>  {
> -	unsigned int i;
> +	unsigned long i, max = totalram / 8;
>  
> -	for (i = 0; i < 1000 * 1000; i++) {
> +	for (i = 0; i < max; i++) {
>  		unsigned long addr = __get_free_pages(gfp, 3);
>  		struct page *page = virt_to_page(addr);
>  
> @@ -26,8 +26,11 @@ static void test_free_pages(gfp_t gfp)
>  
>  static int m_in(void)
>  {
> -	test_free_pages(GFP_KERNEL);
> -	test_free_pages(GFP_KERNEL | __GFP_COMP);
> +	struct sysinfo si;
> +
> +	si_meminfo(&si);
> +	test_free_pages(GFP_KERNEL, si.totalram);
> +	test_free_pages(GFP_KERNEL | __GFP_COMP, si.totalram);
>  
>  	return 0;
>  }

-- 
Sincerely yours,
Mike.
