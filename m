Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 417D627B956
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 03:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgI2B0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 21:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgI2B0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 21:26:11 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9467CC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 18:26:11 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id n13so4493487edo.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 18:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9+IiWJjSCsa3H211qi8G/I3o2LKKqrVZtYC6QtTBudg=;
        b=v+cmjGckHAAscgdJCKKcOpkZt5W7kj9wtG0S0i5i8CU6FJQsAKRy0mG7lHaKs9P1Rm
         FNf09YyuhrUkfXx4LCs0rdVCfFh3rbzyi+htTSkyDUaG/YkwS8GYQKtWsV1awNRb1W0s
         t//fBVM6GB2s48wH54hOLPGXPZ4cT3IIdMkWlARF50xs3TltKeawp1Ayud3KM/hxDUX5
         tU86Mqd0N9i21fvekjDYLCyGHQEWMrbyk+RIjUQNURCFlJFqz+QcWU4IYXnECq82TNis
         rXh05Iqs0TZGI2cm2EqJzQy8SyOTzs5asGQkpXRoUCQntEk2L9nPPkYQ2RttFm2HJV7b
         Bk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9+IiWJjSCsa3H211qi8G/I3o2LKKqrVZtYC6QtTBudg=;
        b=eFz6HZryglE5Cmaw0e1FYNL3xoCq5QCD8NkIaM+x2X7brh+EQSewTbknmWt3WwqjLx
         PV3muhx91jZYX7zt+gVe7IA5TaSAuxzxk3gKBQUPRCZIJbWyIG8AcxNeW739NsDXEoVf
         8J8YV8rG6EsF/2cZ71mWplmgYlalg3dt+XU3vwSf2IOgbrkzsqt1IbeDKtV8T2ea0ttw
         TX2s6JNtBpomkIhIBAH/3cYNXYXOLDH1sMYmSpjkqQa8lC1F0iSxpB+AURGwqmI0lg1q
         xgKzaqEDyyGdhOMBOPT8BvVew8ANTNm1OSh4twhANz+NOSr3hZcXqUc8N4seLSAPjYu5
         1Z6w==
X-Gm-Message-State: AOAM532ciaPRVTMS5kNDxNsssjwHGEah/qC3x31ezCOVwrSUkbCVjVYa
        Hc7ZBGWs+TC1VJWPEMH96pRGMBmass107CEctcbZDw==
X-Google-Smtp-Source: ABdhPJyukjgfeJlTRPeGdPIi9Phg1aw79cup8F0sTHp1XtOitP/5r3JajS/c5S9Voy8qaoMMFVj4pyr1k2fKkYLBhkg=
X-Received: by 2002:a05:6402:3192:: with SMTP id di18mr783128edb.116.1601342768237;
 Mon, 28 Sep 2020 18:26:08 -0700 (PDT)
MIME-Version: 1.0
References: <d1b31586-426a-e0b1-803e-3eff30196c05@web.de> <20200926121402.GA7467@kadam>
 <20200926221720.GK9916@ziepe.ca> <20200928175237.6b3024fe6ad96d70c75d5de1@linux-foundation.org>
In-Reply-To: <20200928175237.6b3024fe6ad96d70c75d5de1@linux-foundation.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 28 Sep 2020 18:25:57 -0700
Message-ID: <CAPcyv4gnUrpGrrk=zq8_OTU6+448AMue+w93vB2dQM-uauR7RQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm/hmm/test: use after free in dmirror_allocate_chunk()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 5:52 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Sat, 26 Sep 2020 19:17:20 -0300 Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> > On Sat, Sep 26, 2020 at 03:14:02PM +0300, Dan Carpenter wrote:
> > > The error handling code does this:
> > >
> > > err_free:
> > >     kfree(devmem);
> > >         ^^^^^^^^^^^^^
> > > err_release:
> > >     release_mem_region(devmem->pagemap.range.start, range_len(&devmem->pagemap.range));
> > >                            ^^^^^^^^
> > > The problem is that when we use "devmem->pagemap.range.start" the
> > > "devmem" pointer is either NULL or freed.
> > >
> > > Neither the allocation nor the call to request_free_mem_region() has to
> > > be done under the lock so I moved those to the start of the function.
> > >
> > > Fixes: 1f9c4bb986d9 ("mm/memremap_pages: convert to 'struct range'")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
> > > ---
> > > v2: The first version introduced a locking bug
> > > v3: Markus Elfring pointed out that the Fixes tag was wrong.  This bug
> > > was in the original commit and then fixed and then re-introduced.  I was
> > > quite bothered by how this bug lasted so long in the source code, but
> > > now we know.  As soon as it is introduced we fixed it.
> > >
> > > One problem with the kernel QC process is that I think everyone marks
> > > the bug as "old/dealt with" so it was only because I was added a new
> > > check for resource leaks that it was found when it was re-introduced.
> > >
> > >  lib/test_hmm.c | 44 ++++++++++++++++++++++----------------------
> > >  1 file changed, 22 insertions(+), 22 deletions(-)
> >
> > Hi Andrew,
> >
> > I don't have have any hmm related patches this cycle, can you take
> > this into your tree?
> >
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>
> Thanks.
>
> It's actually a fix against Dan Williams' -mm patch "mm/memremap_pages:
> convert to 'struct range'"

Yes, sorry, for the fix:

Acked-by: Dan Williams <dan.j.williams@intel.com>
