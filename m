Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17C2C283966
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgJEPSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgJEPSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:18:23 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7389EC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 08:18:23 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id z19so11374092lfr.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 08:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2qOcvP6yZYUR1v8WQaMRDniV7F3qJo7CKmCutWFPBtE=;
        b=XbVifhi5KVtDLxaTqfpq5MyIp82zE/09YCqj199zSX4K3E3rgtsPrGkLWj+Bs0o6yz
         db1hPZUCo5H5yqAv770q20hBXCJPYLPrV3QMsf7ht+fAzpfzKDUvc2xNGvqVSqoclp7y
         y3UkwgyjbTPKtqepRDlAW01V+Ke2cToZ5Q1HBTm42vPprRihBVKoy2b4M81lfPmHMs36
         ckVV81sMB+fXThXo97NGhu5XWZXpK51ekR0r5H/PeZawxg19IrTqrMsIpq6kjFyCE0nm
         qk+THTnhEuBhWF/upGBn2gSEx8gw1Rg0OpDgsAA6VlqKoVfJYFuJ3AxEQ4rnQSZj3GiO
         DToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2qOcvP6yZYUR1v8WQaMRDniV7F3qJo7CKmCutWFPBtE=;
        b=ZLQjisj1oKP3ZJ+c48w1T2FKqHrkonNjy3Xajkr5M+Fb80Rxv4Cu896DLGF2d0YM4o
         KRXV12Wk+YuJhV+nvCORklL8QCEHMx6bICIbFsJqL/jEWl+7wVfWV2fGbxgTzuW2ToJn
         2A6rfgBGnYXOufw50BlNuI6FBVQUTjvSAMuPH17lb/I5qu0hBYSbrHMhmZMGabZt2LE9
         UJiFfKxavDDfH4iWDGz7kzURS57tmonYP3yN7n7LLkTcctfPbbGHdrZdKCftp3nFPgx7
         Ye5QUlc87+GXRGjAlqCsxpDTSKFX7hzHt6NgxlkItvameJusQ1y6U0MdZUlM6pXPtYw9
         PXuw==
X-Gm-Message-State: AOAM533ZWonYeEwKZLRpOmK5K+4JfokRjq0tmISCDHioXxN2Okgx7h6A
        E6sA2yH0Sg3lyRH+zL9xgBCWRlqJ+vsyIntPDh5/AQ==
X-Google-Smtp-Source: ABdhPJxjpGsjngB1hmr5J6waZxkLGXegfaskQxGiD+jsJdfvIziNgRfxZfHW4Vy6mGw+s/EC6i14WRLpKxhQ/FGr1vk=
X-Received: by 2002:a19:4084:: with SMTP id n126mr639lfa.54.1601911101455;
 Mon, 05 Oct 2020 08:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20201002172559.4000748-1-guro@fb.com> <20201002172559.4000748-5-guro@fb.com>
In-Reply-To: <20201002172559.4000748-5-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 5 Oct 2020 08:18:10 -0700
Message-ID: <CALvZod7OQOF+6i=oWokXmTTc0OymsLEyKGkt+i2rEMT=HWfWKQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mm: convert page kmemcg type to a page memcg flag
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 2, 2020 at 10:26 AM Roman Gushchin <guro@fb.com> wrote:
>
> PageKmemcg flag is currently defined as a page type (like buddy,
> offline, table and guard). Semantically it means that the page
> was accounted as a kernel memory by the page allocator and has
> to be uncharged on the release.
>
> As a side effect of defining the flag as a page type, the accounted
> page can't be mapped to userspace (look at page_has_type() and
> comments above). In particular, this blocks the accounting of
> vmalloc-backed memory used by some bpf maps, because these maps
> do map the memory to userspace.
>
> One option is to fix it by complicating the access to page->mapcount,
> which provides some free bits for page->page_type.
>
> But it's way better to move this flag into page->memcg_data flags.
> Indeed, the flag makes no sense without enabled memory cgroups
> and memory cgroup pointer set in particular.
>
> This commit replaces PageKmemcg() and __SetPageKmemcg() with
> PageMemcgKmem() and an open-coded OR operation setting the memcg
> pointer with the MEMCG_DATA_KMEM bit. __ClearPageKmemcg() can be
> simple deleted, as the whole memcg_data is zeroed at once.
>
> As a bonus, on !CONFIG_MEMCG build the PageMemcgKmem() check will
> be compiled out.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
