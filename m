Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5102EE7CB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbhAGVp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:45:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60911 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728029AbhAGVpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610055838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j1WBhlktToi1vWvZaR5+DgjHLfs7iNt/Cu4S6xB04DU=;
        b=MN/r8FHnxXBVWg1LKB+Hs3f/1kspdleS3gsBMqBrO1SzZcXaytALsLnVKRl05JfAqGDj3z
        10Bg9oCAzBaB5zweVtejwcC5B78fMvtXyLnqLKsB4sNr6o9sy80r4mXGG9rHaG58lkbIXc
        MDKcHIQlndEIAi9oakRh0uzhvu0uyIU=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-zBAY7AnhPjWU1pF3kat-Eg-1; Thu, 07 Jan 2021 16:43:56 -0500
X-MC-Unique: zBAY7AnhPjWU1pF3kat-Eg-1
Received: by mail-pg1-f197.google.com with SMTP id l2so5770259pgi.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 13:43:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=j1WBhlktToi1vWvZaR5+DgjHLfs7iNt/Cu4S6xB04DU=;
        b=beo6XXEkTTdJOf0WOtuABgK7S23VDj1Zsa3qtKBpF4tA1BvLictrHYlOANJZrBAuJE
         XW9QgLA6VoIXtf4tSZHjJgkpWeDmQqTc0lxQ7j04fzVXPW1kVxeKLhlb17091tPdZstx
         5Ivn88Jgqti+tatAhHmXs81VN+bX9xI6GEsT6A6trARxr0CuaWgj0QKb6RnWbNSqwM8I
         8oYgYMn/yOwXBqw1+rOFtzHdRbdyKDQ8+dj12AmTh9aSpU7/cSro9pJqZapPDVXKEz58
         5aQAFg322iuQSdgfYFneQIF3Rb5tkrnfNwCJC8oAtppoilHeb7BZyxm49LxRBmhg4MPE
         Ou6A==
X-Gm-Message-State: AOAM533XfmR8RJOF02MBIWq0VOesE8qxY5LMeBI6u2aC7utH4/1shleA
        MpPQkQu1DnC9StX9zk5Kb8aQxOisQreb/ExV2KHh7FiMdk2H3g2pzNEkts0fbWVm9NTgfIApV3I
        pqlmhSp3kUjCdQc4OY9CB1h3V+0kbsDLEwJ71yKTWHc2qXg/0JuLiZhBLuro4guuj/HczLp4=
X-Received: by 2002:a63:fe13:: with SMTP id p19mr3763101pgh.119.1610055835456;
        Thu, 07 Jan 2021 13:43:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5tmk+1kJ7p3tl2fEpGQCVYC3T+sDFUsmhkAMNVSAuIoaB2DY+I7y+Fpp26Kgj3/iCVDzOgg==
X-Received: by 2002:a63:fe13:: with SMTP id p19mr3763072pgh.119.1610055835113;
        Thu, 07 Jan 2021 13:43:55 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 11sm6959307pgz.22.2021.01.07.13.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 13:43:54 -0800 (PST)
Subject: Re: [PATCH] RDMA/ocrdma: fix use after free in
 ocrdma_dealloc_ucontext_pd()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        dledford@redhat.com, leon@kernel.org, maxg@mellanox.com,
        galpress@amazon.com, michaelgur@nvidia.com, monis@mellanox.com,
        gustavoars@kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201230024653.1516495-1-trix@redhat.com>
 <20210107204102.GA933840@nvidia.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <00c76f8e-4e46-2ab5-772b-ad5db59f8490@redhat.com>
Date:   Thu, 7 Jan 2021 13:43:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210107204102.GA933840@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/7/21 12:41 PM, Jason Gunthorpe wrote:
> On Tue, Dec 29, 2020 at 06:46:53PM -0800, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> In ocrdma_dealloc_ucontext_pd() uctx->cntxt_pd is assigned to
>> the variable pd and then after uctx->cntxt_pd is freed, the
>> variable pd is passed to function _ocrdma_dealloc_pd() which
>> dereferences pd directly or through its call to
>> ocrdma_mbx_dealloc_pd().
>>
>> Reorder the free using the variable pd.
>>
>> Fixes: 21a428a019c9 ("RDMA: Handle PD allocations by IB/core")
>> Signed-off-by: Tom Rix <trix@redhat.com>
>>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> Applied to for-rc
>
> Is anyone testing ocrdma? Just doing the pyverbs rdma tests with kasn
> turned on would have instantly caught this, and the change is nearly a
> year old.
>
> Is ocrdma obsolete enough we can delete the driver?

I am not an authority on ocrdma, i am fixing treewide, the problems clang static analysis flags.

Tom

>
> Thanks,
> Jason
>

