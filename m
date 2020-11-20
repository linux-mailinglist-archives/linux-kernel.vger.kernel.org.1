Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32C72B9FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 02:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgKTB1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 20:27:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30195 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726580AbgKTB1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 20:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605835636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DLIVQHvx6BWBfd7HmGxTRnB/+14KaYzo8H+szC2YlPI=;
        b=NV29aVEFQ0NDGgSVCR8PH9QV8S2SHf+xrST9WD11wNAawkgefZQRigEoZyQPEUaYZ/E0sN
        0utQJd+RAOKuRxgGnBY6Xd5Adg5peaUWzjJ+wb5xVYlYrlT5ERswnaIvimqph3SHTTsb5B
        sEof+fq2F0h1FIdlLTlWHI0UVbQAmkg=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-zHTgypmDMNms5cAJhTKOxA-1; Thu, 19 Nov 2020 20:27:14 -0500
X-MC-Unique: zHTgypmDMNms5cAJhTKOxA-1
Received: by mail-ua1-f70.google.com with SMTP id 93so2459750uav.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 17:27:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DLIVQHvx6BWBfd7HmGxTRnB/+14KaYzo8H+szC2YlPI=;
        b=YaDTUMhaSiA1YJxtqTvvp/rqIGKHGkQc/eMlHpUEFTE3FoesmTfUMujdndIzkWrSbs
         T3loph9BdY8YH6jxmFS1fO0fyG+AZqY+h66/22Np6cGGsBXXXaq52jowdlJY4KFrBAKK
         D00n//tRWIy+dEH3/JgvO0ImEHxNU3PArwtprOOVYnxC7DvwxVc3DqVSjjyU7og7BaN4
         etWu3XNTPTNkLbqz1dESFAF/0CjwJ33eaCFwnU2KHEa0o66ZwFmzdPwCotnMOXgQHl3K
         zBHDg/KzjqKtj11nlqraxqRzDaw4VhwZofsJKE8D4BfjQxrm8yfPGyd5ecZCpSe4OTTc
         2F7A==
X-Gm-Message-State: AOAM532ShA2gOTYleDa0eR3LFxhmks31feOlL0ASQo87Q+dJvbzxP7ua
        6qPBjTO+dbJGxR8yZ3X8NHvaiFdv0mbgAU3hf5PJIhl6D9byQg71otd2TR9NNTnyaQvRT5jYPAJ
        RQ5vQ115dazay7Xo3V56T3ulhLhOu6oZmMPozExYQ
X-Received: by 2002:a67:ead4:: with SMTP id s20mr9956263vso.23.1605835633570;
        Thu, 19 Nov 2020 17:27:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAOprCn+MSLwpUL1KRNzUeNpOM1FggL7enU/sNOGdCf/2dwEQ+lfxQplsQG9tT32TFdvR6vVegizOMc4DLrrs=
X-Received: by 2002:a67:ead4:: with SMTP id s20mr9956250vso.23.1605835633366;
 Thu, 19 Nov 2020 17:27:13 -0800 (PST)
MIME-Version: 1.0
References: <20200821020345.3358-1-thunder.leizhen@huawei.com>
 <b4643e74-aad9-385f-01f2-f8e48ba4dbef@suse.de> <ad100923-e479-faf0-f749-ac8e4cf87899@huawei.com>
 <8aa638b7-6cfd-bf3d-8015-fbe59f28f31f@suse.de> <c2f8cf50-d9f7-df19-40eb-0543e6208c0d@huawei.com>
In-Reply-To: <c2f8cf50-d9f7-df19-40eb-0543e6208c0d@huawei.com>
From:   John Dorminy <jdorminy@redhat.com>
Date:   Thu, 19 Nov 2020 20:27:02 -0500
Message-ID: <CAMeeMh_iBFpmSjgm8aC1WO-=iQPU5rQ2-Z6oe0L8nt5ke=+XQw@mail.gmail.com>
Subject: Re: [PATCH 1/1] block: move the PAGE_SECTORS definition into <linux/blkdev.h>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        dm-devel <dm-devel@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-bcache <linux-bcache@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings;

There are a lot of uses of PAGE_SIZE/SECTOR_SIZE scattered around, and
it seems like a medium improvement to be able to refer to it as
PAGE_SECTORS everywhere instead of just inside dm, bcache, and
null_blk. Did this change progress forward somewhere?

Thanks!

John Dorminy


On Mon, Sep 7, 2020 at 3:40 AM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
> Hi, Jens Axboe, Alasdair Kergon, Mike Snitzer:
>   What's your opinion?
>
>
> On 2020/8/21 15:05, Coly Li wrote:
> > On 2020/8/21 14:48, Leizhen (ThunderTown) wrote:
> >>
> >>
> >> On 8/21/2020 12:11 PM, Coly Li wrote:
> >>> On 2020/8/21 10:03, Zhen Lei wrote:
> >>>> There are too many PAGE_SECTORS definitions, and all of them are the
> >>>> same. It looks a bit of a mess. So why not move it into <linux/blkdev.h>,
> >>>> to achieve a basic and unique definition.
> >>>>
> >>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >>>
> >>>
> >>> A lazy question about page size > 4KB: currently in bcache code the
> >>> sector size is assumed to be 512 sectors, if kernel page > 4KB, it is
> >>> possible that PAGE_SECTORS in bcache will be a number > 8 ?
> >>
> >> Sorry, I don't fully understand your question. I known that the sector size
> >> can be 512 or 4K, and the PAGE_SIZE can be 4K or 64K. So even if sector size
> >> is 4K, isn't it greater than 8 for 64K pages?
> >>
> >> I'm not sure if the question you're asking is the one Matthew Wilcox has
> >> answered before:
> >> https://www.spinics.net/lists/raid/msg64345.html
> >
> > Thank you for the above information. Currently bcache code assumes
> > sector size is always 512 bytes, you may see how many "<< 9" or ">> 9"
> > are used. Therefore I doubt whether current code may stably work on e.g.
> > 4Kn SSDs (this is only doubt because I don't have such SSD).
> >
> > Anyway your patch is fine to me. This change to bcache doesn't make
> > thins worse or better, maybe it can be helpful to trigger my above
> > suspicious early if people do have this kind of problem on 4Kn sector SSDs.
> >
> > For the bcache part of this patch, you may add,
> > Acked-by: Coly Li <colyli@suse.de>
> >
> > Thanks.
> >
> > Coly Li
> >
> >>>> ---
> >>>>  drivers/block/brd.c           | 1 -
> >>>>  drivers/block/null_blk_main.c | 1 -
> >>>>  drivers/md/bcache/util.h      | 2 --
> >>>>  include/linux/blkdev.h        | 5 +++--
> >>>>  include/linux/device-mapper.h | 1 -
> >>>>  5 files changed, 3 insertions(+), 7 deletions(-)
> >>>>
> >>>
> >>> [snipped]
> >>>
> >>>> diff --git a/drivers/md/bcache/util.h b/drivers/md/bcache/util.h
> >>>> index c029f7443190805..55196e0f37c32c6 100644
> >>>> --- a/drivers/md/bcache/util.h
> >>>> +++ b/drivers/md/bcache/util.h
> >>>> @@ -15,8 +15,6 @@
> >>>>
> >>>>  #include "closure.h"
> >>>>
> >>>> -#define PAGE_SECTORS              (PAGE_SIZE / 512)
> >>>> -
> >>>>  struct closure;
> >>>>
> >>>>  #ifdef CONFIG_BCACHE_DEBUG
> >>>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> >>>> index bb5636cc17b91a7..b068dfc5f2ef0ab 100644
> >>>> --- a/include/linux/blkdev.h
> >>>> +++ b/include/linux/blkdev.h
> >>>> @@ -949,11 +949,12 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
> >>>>   * multiple of 512 bytes. Hence these two constants.
> >>>>   */
> >>>>  #ifndef SECTOR_SHIFT
> >>>> -#define SECTOR_SHIFT 9
> >>>> +#define SECTOR_SHIFT              9
> >>>>  #endif
> >>>>  #ifndef SECTOR_SIZE
> >>>> -#define SECTOR_SIZE (1 << SECTOR_SHIFT)
> >>>> +#define SECTOR_SIZE               (1 << SECTOR_SHIFT)
> >>>>  #endif
> >>>> +#define PAGE_SECTORS              (PAGE_SIZE / SECTOR_SIZE)
> >>>>
> >>>>  /*
> >>>>   * blk_rq_pos()                   : the current sector
> >>> [snipped]
> >>>
> >>>
> >>
> >
> >
> > .
> >
>

