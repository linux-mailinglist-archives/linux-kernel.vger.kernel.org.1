Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51092CF898
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 02:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgLEB0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 20:26:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:53238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgLEB0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 20:26:03 -0500
Date:   Fri, 4 Dec 2020 17:25:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1607131522;
        bh=GjUSlecWxBxHbnsCJmgbVCyqlcg2RO9TS2Mad7tkdB0=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=yg33d0k0YWAbij4DhLtRIMLjs+i8EZqXOsyEVltAzBNjw5EGsvOlonYgvki8qVIyW
         U7xCaU51IaUJAZQIwOvq+3sCbzFC7rLANXrzEy6aF94x9+2OKhab8IDx/geiwlYie8
         t9Orxy/sIjWNmB07TegVDFCJSwNrdqzZ1dd7YdSY=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     "qiang.zhang@windriver.com" <qiang.zhang@windriver.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "qcai@redhat.com" <qcai@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <walter-zh.wu@mediatek.com>
Subject: Re: [PATCH] kasan: fix slab double free when cpu-hotplug
Message-Id: <20201204172521.ed9f77164ff9f9fc91f35ee0@linux-foundation.org>
In-Reply-To: <1607083295.22062.15.camel@mtksdccf07>
References: <20201204102206.20237-1-qiang.zhang@windriver.com>
        <1607083295.22062.15.camel@mtksdccf07>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 20:01:35 +0800 Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:

> > diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
> > index d98b516f372f..55783125a767 100644
> > --- a/mm/kasan/quarantine.c
> > +++ b/mm/kasan/quarantine.c
> > @@ -194,7 +194,6 @@ bool quarantine_put(struct kmem_cache *cache, void *object)
> >  
> >  	q = this_cpu_ptr(&cpu_quarantine);
> >  	if (q->offline) {
> > -		qlink_free(&meta->quarantine_link, cache);
> >  		local_irq_restore(flags);
> >  		return false;
> >  	}
> 
> Hi Qiang,
> 
> Thanks for fixing this.
> Due to that issue, my commit has been removed by Stephen from
> linux-next.
> 
> 
> Hi Stephen, Andrew,
> 
> Should I directly upload the v4 or Stephen can pick the commit which 
> has been removed back to the linux-next.

I took care of it.  Restored the original patch and added this one as a
-fix.
