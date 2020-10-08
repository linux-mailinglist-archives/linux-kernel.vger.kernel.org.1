Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C672873D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 14:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgJHMMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 08:12:54 -0400
Received: from m12-17.163.com ([220.181.12.17]:53922 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbgJHMMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 08:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=i5BRo
        cpGVyu81fjViP5klrSmYKy5Fq+kT8RQjN6SaV4=; b=lGl4OIspNxSTNX7uYBK6z
        Gu180i3CZUBLM8K30CE91woEGYYxcVGPGOqBhPOF3IMQN5DstmwVo+lreo8eLYXn
        nDECyS3PnpgaLtEuzGx5AqWUCU6dErtWOgWOHXXDNTB8ui3brvXhcwP5O+SUNS8U
        s4D11OgI480EMCVVBfs5LM=
Received: from localhost (unknown [101.228.30.83])
        by smtp13 (Coremail) with SMTP id EcCowAB3xDjuAX9f2iIbMg--.5269S2;
        Thu, 08 Oct 2020 20:11:26 +0800 (CST)
Date:   Thu, 8 Oct 2020 20:11:25 +0800
From:   Hui Su <sh_def@163.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc.c: check the addr first
Message-ID: <20201008121125.GA6644@rlk>
References: <20200927163337.GA5472@rlk>
 <20200928180434.GD458519@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200928180434.GD458519@iweiny-DESK2.sc.intel.com>
X-CM-TRANSID: EcCowAB3xDjuAX9f2iIbMg--.5269S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4xZFykWrWDGF18KF17Wrg_yoW8KFWUpF
        Z8ta1jyFy8tr1YvrZFqFW8Xas5tw4fGF15uF47Za4kCr1YgF18Ars8AryagFyrGrW8tF1I
        vFs8KFyS9ryYyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnYFAUUUUU=
X-Originating-IP: [101.228.30.83]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbBDgu3X1rbKigpTwAAsI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 11:04:34AM -0700, Ira Weiny wrote:
> On Mon, Sep 28, 2020 at 12:33:37AM +0800, Hui Su wrote:
> > As the comments said, if @addr is NULL, no operation
> > is performed, check the addr first in vfree() and
> > vfree_atomic() maybe a better choice.
> 
> I don't see how this change helps anything.  kmemleak_free() checks addr so no
> danger there.  Also kmemleak_free() contains a pr_debug() which some might find
> useful.
> 
> Ira
> 
Thanks for your explanations, Ira.

Firstly, as you have said, the kmemleak_free() only unregister a previously
registered object(which shouldn't be NULL), and kmemleak_free() alse check the
ptr whether is NULL, it does no danger here.

Secondly, as you said kmemleak_free() contains a pr_debug() which will be useful,
and i don't think so because this patch only filter out the NULL pointer case, which
may not be useful?(maybe not right?)

Thirdly, let's see kimage_file_prepare_segments() and kimage_file_post_load_cleanup()
in kernel/kexec_file.c.

kimage_file_prepare_segments() uses 'out' label in several places, when reading
files from kernel_fd or initrd_fd or memdup_user cmdline_buf.
The out label will run kimage_file_post_load_cleanup(), which will do vfree()
for ->kernel_buf and ->initrd_buf and ->cmdline_buf and so on...

Supposing the arch_kexec_kernel_image_probe() failed, and it goto out, then it
still vfree(->initrd_buf). In this case we can return faster if we check param
addr first in vfree().

In this case maybe we should use more Precise labels?

All above is my opinion, thanks.

> > 
> > Signed-off-by: Hui Su <sh_def@163.com>
> > ---
> >  mm/vmalloc.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index be4724b916b3..1cf50749a209 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -2305,10 +2305,11 @@ void vfree_atomic(const void *addr)
> >  {
> >  	BUG_ON(in_nmi());
> >  
> > -	kmemleak_free(addr);
> > -
> >  	if (!addr)
> >  		return;
> > +
> > +	kmemleak_free(addr);
> > +
> >  	__vfree_deferred(addr);
> >  }
> >  
> > @@ -2340,13 +2341,13 @@ void vfree(const void *addr)
> >  {
> >  	BUG_ON(in_nmi());
> >  
> > +	if (!addr)
> > +		return;
> > +
> >  	kmemleak_free(addr);
> >  
> >  	might_sleep_if(!in_interrupt());
> >  
> > -	if (!addr)
> > -		return;
> > -
> >  	__vfree(addr);
> >  }
> >  EXPORT_SYMBOL(vfree);
> > -- 
> > 2.25.1
> > 
> > 
> > 

