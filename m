Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519AD2920D0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 03:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgJSBAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 21:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbgJSBAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 21:00:35 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3C6C061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 18:00:34 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y14so4987547pfp.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 18:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=yjVes5Gnoubgx9zs7z3JikV3JDkeiY/LjVzP2aH5ZLg=;
        b=hX/WYBc+YeiZHUAI8VeY6swjibC2eoRabcM2nLxPSqbnsFlIjwiYaFBSsiVdId2bCh
         f56H6nlXLVgzrgdSJXfIkQcWkrRSWpmR4HJVpTS5WNY0Ucr6mXuBvb+r19pyD48HfUT5
         Ae9KJ6L8ZOhPzMMHYcT36Yo8kkB0/MQUAsT/6C4isXe8vWXGtvUpYCByOQxSuzusrdyQ
         yUE8AxZy67Y6Je8y7M+VTmFavCCFcXlmZg7CIp4kkHV5JwQ3lCGd+pq9708XM9HvhqYZ
         6YuGi4EbqWU0q9g/VVHE050Bb8dqSGqrOi2boOGiWTdJmHfor1j/F/r8GFbbqdrnRxsE
         tqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=yjVes5Gnoubgx9zs7z3JikV3JDkeiY/LjVzP2aH5ZLg=;
        b=qn4KmlPNu/h8WKrKNk7945gDVhQk4weLLDS8gyPYtl6lk7FDsUNqcfYnqnQaOO90kr
         llW6XY6esNWZu16tVloYFgWKRBWbNrBEl/nn5UQtmMHB/5MQRyzS7sgeub46xTLsCmI+
         pw65lZ+DP46ZiOS0EUwuJazK2UKs27JZLutvtVz+x4QwSMiKLRg35p6PEI+wlYU1gs3G
         7VQCGebcv58set5i/3rXQMhcYRWw5k555Ri/MMwQ5nMWHuKHEHbe42fXVCSfHjJX7dO9
         qGqXIOLH3tPn5N5Z5oA9/lJpdOXMHny++fNkascb+gsZp30P2tXO7o+J85X6P1sWM5Sh
         AARA==
X-Gm-Message-State: AOAM533A0s/FvZCN1RR1YtRef58lC1yEZEj1XvfuV9L7opLCTD8SX283
        jZWibcDrj1wvnEDlSKw7x8PM14JA3mU=
X-Google-Smtp-Source: ABdhPJyPuRDYPexTM8Mbg+gVcilL2JH2Ve9X3wEcKvHJaBMSx1RRD4EpdfE8VDA9ERdrTh1TIVE93g==
X-Received: by 2002:a62:92c8:0:b029:152:1703:2da9 with SMTP id o191-20020a6292c80000b029015217032da9mr14175193pfd.60.1603069234068;
        Sun, 18 Oct 2020 18:00:34 -0700 (PDT)
Received: from localhost ([1.129.224.104])
        by smtp.gmail.com with ESMTPSA id z10sm9979587pff.218.2020.10.18.18.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 18:00:33 -0700 (PDT)
Date:   Mon, 19 Oct 2020 11:00:28 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2] page_alloc: Fix freeing non-compound pages
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        =?iso-8859-1?q?Peter=0A?= Zijlstra <peterz@infradead.org>
References: <20200926213919.26642-1-willy@infradead.org>
        <20200928180307.7573f3b6128b5e3007dfc9f0@linux-foundation.org>
        <20200929011719.GD30994@casper.infradead.org>
        <20200928214656.be4a0f29961589c074e518fa@linux-foundation.org>
In-Reply-To: <20200928214656.be4a0f29961589c074e518fa@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <1603066445.g384du2cm9.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Andrew Morton's message of September 29, 2020 2:46 pm:
> On Tue, 29 Sep 2020 02:17:19 +0100 Matthew Wilcox <willy@infradead.org> w=
rote:
>=20
>> On Mon, Sep 28, 2020 at 06:03:07PM -0700, Andrew Morton wrote:
>> > On Sat, 26 Sep 2020 22:39:19 +0100 "Matthew Wilcox (Oracle)" <willy@in=
fradead.org> wrote:
>> >=20
>> > > Here is a very rare race which leaks memory:

Great catch! [sorry, a bit behind with emails]

>> >=20
>> > Not worth a cc:stable?
>>=20
>> Yes, it probably should have been.
>=20
> Have you a feeling for how often this occurs?
>=20
>>  I just assume the stablebot will
>> pick up anything that has a Fixes: tag.
>=20
> We asked them not to do that for mm/ patches.  Crazy stuff was getting
> backported.
>=20
>> > >
>> > > --- a/mm/page_alloc.c
>> > > +++ b/mm/page_alloc.c
>> > > @@ -4947,6 +4947,9 @@ void __free_pages(struct page *page, unsigned =
int order)
>> > >  {
>> > >  	if (put_page_testzero(page))
>> > >  		free_the_page(page, order);
>> > > +	else if (!PageHead(page))
>> > > +		while (order-- > 0)
>> > > +			free_the_page(page + (1 << order), order);
>> >=20
>> > Well that's weird and scary looking.  `page' has non-zero refcount yet
>> > we go and free random followon pages.  Methinks it merits an
>> > explanatory comment?
>>=20
>> Well, poot.  I lost that comment in the shuffling of patches.  In a
>> different tree, I have:
>>=20
>> @@ -4943,10 +4943,19 @@ static inline void free_the_page(struct page *pa=
ge, unsi
>> gned int order)
>>                 __free_pages_ok(page, order);
>>  }
>> =20
>> +/*
>> + * If we free a non-compound allocation, another thread may have a
>=20
> "non-compound, higher-order", I suggest?
>=20
>> + * speculative reference to the first page.  It has no way of knowing
>> + * about the rest of the allocation, so we have to free all but the
>> + * first page here.
>> + */
>>  void __free_pages(struct page *page, unsigned int order)
>>  {
>>         if (put_page_testzero(page))
>>                 free_the_page(page, order);
>> +       else if (!PageHead(page))
>> +               while (order-- > 0)
>> +                       free_the_page(page + (1 << order), order);
>>  }
>>  EXPORT_SYMBOL(__free_pages);
>> =20
>>=20
>> Although I'm now thinking of making that comment into kernel-doc and
>> turning it into advice to the caller rather than an internal note to
>> other mm developers.
>=20
> hm.  But what action could the caller take?  The explanatory comment
> seems OK to me.

The version of this without the comment got merged. I didn't mind the
comment...

Thanks,
Nick
