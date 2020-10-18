Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3854C2917F7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 17:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgJRPBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 11:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJRPBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 11:01:50 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D153C061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 08:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HbA1hL7/g1Rk5bMSA5yKY3g7LD7jvXAZvVxtLd5NnQI=; b=TCej97Be7WiiF8zCNVqDc25tKP
        gbze8GwCkRgCzmYGJUMIG1UbmpyUPCR9ShP/qVVMBAvatfD/MQF1ps1g1l9x6DHHEaYkgL4nmGFmL
        wYYbrlLNxSAYAYimFXA8k4/a29Zs9Vijn9qn1krtoqDh563cqyBXdz98lRnLTKcu82Gu48QGCdPha
        Wd1dP/68lhdsFBd1MdkQcHMwl9KOVYKe6GH3aiXDtbsK9zI1DhI+rNgCflT5CvX7EdW+gzZZxT/60
        p93KBH2Ol39QNTAM8F4rCz1LvoMkyiGKCWO7J7iWFi/2hpblAtgAmYOi028FT/AzjnV0oitfD4pNJ
        Gwvlqrzw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUABu-0005ZG-F5; Sun, 18 Oct 2020 15:01:46 +0000
Date:   Sun, 18 Oct 2020 16:01:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib/test_free_pages: Add basic progress indicators
Message-ID: <20201018150146.GK20115@casper.infradead.org>
References: <20201018140445.20972-1-geert@linux-m68k.org>
 <20201018142508.GJ20115@casper.infradead.org>
 <CAMuHMdVcTx0wVTSh-YaJxXqCMpCxGRe3QH36O5i+McinfdRwDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVcTx0wVTSh-YaJxXqCMpCxGRe3QH36O5i+McinfdRwDg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 04:39:27PM +0200, Geert Uytterhoeven wrote:
> Hi Matthew,
> 
> On Sun, Oct 18, 2020 at 4:25 PM Matthew Wilcox <willy@infradead.org> wrote:
> > On Sun, Oct 18, 2020 at 04:04:45PM +0200, Geert Uytterhoeven wrote:
> > > The test module to check that free_pages() does not leak memory does not
> > > provide any feedback whatsoever its state or progress, but may take some
> > > time on slow machines.  Add the printing of messages upon starting each
> > > phase of the test, and upon completion.
> >
> > It's not supposed to take a long time.  Can you crank down that 1000 *
> 
> It took 1m11s on ARAnyM, running on an i7-8700K.
> Real hardware may even take longer.

71 seconds is clearly too long.  0.7 seconds would be fine, so 10 * 1000
would be appropriate, but then that's only 320MB which might not be
enough to notice on a modern machine.

> > 1000 to something more appropriate?
> 
> What would be a suitable value? You do want to see it "leak gigabytes
> of memory and probably OOM your system" if something's wrong,
> so decreasing the value a lot may not be a good idea?
> 
> Regardless, if it OOMs, I think you do want to see this happens
> while running this test.

How about scaling with the amount of memory on the machine?

This might cause problems on machines with terabytes of memory.
Maybe we should cap it at a terabyte?

diff --git a/lib/test_free_pages.c b/lib/test_free_pages.c
index 074e76bd76b2..aa18fa52290a 100644
--- a/lib/test_free_pages.c
+++ b/lib/test_free_pages.c
@@ -9,11 +9,11 @@
 #include <linux/mm.h>
 #include <linux/module.h>
 
-static void test_free_pages(gfp_t gfp)
+static void test_free_pages(gfp_t gfp, unsigned long totalram)
 {
-	unsigned int i;
+	unsigned long i, max = totalram / 8;
 
-	for (i = 0; i < 1000 * 1000; i++) {
+	for (i = 0; i < max; i++) {
 		unsigned long addr = __get_free_pages(gfp, 3);
 		struct page *page = virt_to_page(addr);
 
@@ -26,8 +26,11 @@ static void test_free_pages(gfp_t gfp)
 
 static int m_in(void)
 {
-	test_free_pages(GFP_KERNEL);
-	test_free_pages(GFP_KERNEL | __GFP_COMP);
+	struct sysinfo si;
+
+	si_meminfo(&si);
+	test_free_pages(GFP_KERNEL, si.totalram);
+	test_free_pages(GFP_KERNEL | __GFP_COMP, si.totalram);
 
 	return 0;
 }
