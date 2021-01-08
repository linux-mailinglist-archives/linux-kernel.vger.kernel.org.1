Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0DD2EF787
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 19:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbhAHSiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 13:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbhAHSh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 13:37:59 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C380C061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 10:37:19 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id c22so8119097pgg.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 10:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NdEgLCv0WcsMLswh+8Qu2jUrNvErOztEJExOtEtsP1U=;
        b=eW2T0ERT3EcmrriRa+877oo1orT/BVz49StZkuNqKMQNcIaFxdh143+b8LlkF5XuMR
         kNyWgVr0UEOYZ/WbjZ8Sd+0e08XdNkwXsXhyT1mSfU9c1gRkBrx4ZN/USZMovfYf1buP
         Qw8/g23Fwa1FOnsYC98vZ9aeUeXNRx8cmRoWQn87zRawWjIoQxG/Akx85WYUsGFQn5qr
         ebIvlYHuae7YA0rNHMbT+4h73YkFIHHliv2o2YdmHzOb0LicWxghdz5fX/A0o3tPU2cP
         o6ud33sUCbRpoSyAGJT/tjASduh/4NrlrSEekmdXp3hDUpcCg/NBG+RMSQiyqdS3dQZZ
         bqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdEgLCv0WcsMLswh+8Qu2jUrNvErOztEJExOtEtsP1U=;
        b=pb3FraChTGoYqZes6jyBVPIwWrdfnJ2EbKqQuZXXFZspj3RelMT0uPdSp0D5GJc47+
         YNhAGbaPvgd5MbGt5ODr5Vr0jZy9D4aNjJKLhUbhcbQPYaXBBuDlANjmW9QSRQj6cDYV
         AY7LJjI6zxzt9cxY2SJ0hLYAfsy7zQtsZ6DQyn9iGoHstJVB6ObQqVwkScEKxU0N9Vx8
         wmLDflmkRthK1HpHR+jixeiwV06VBAD4N6eCrycQqz0c8Vo95WSt0G2Y4xi4YeA8rQX0
         fngYSKG3zWYFEcVlqgU7r+TkfgFqhyTRKshHZEGw9O+lhC6E2cxys6GnazMGDFPwnHgj
         dj2w==
X-Gm-Message-State: AOAM532BiIKFaSlhHdvA5GFQlf/860Ze2qJCt+O405I2CXPaikO9aajp
        6IXu5hmN7BNNWrAYTkZGH8clTOqFo2ZyYXhwU4eaOw==
X-Google-Smtp-Source: ABdhPJwEfe1QqhFk0jrAFEufd1jArwzUfZxR6UaVy99xbVOyreBChQZUpNRelxBssoGesrEYfF6ujhJVFLOrd+Ew/2I=
X-Received: by 2002:a63:4644:: with SMTP id v4mr8354904pgk.440.1610131038922;
 Fri, 08 Jan 2021 10:37:18 -0800 (PST)
MIME-Version: 1.0
References: <20210103171137.153834-1-lecopzer@gmail.com>
In-Reply-To: <20210103171137.153834-1-lecopzer@gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 8 Jan 2021 19:37:08 +0100
Message-ID: <CAAeHK+xaVvvMfd8LhPssYi+mjS-3OVsDaiNq2Li+J7JLF6k3Gg@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: kasan: support CONFIG_KASAN_VMALLOC
To:     Lecopzer Chen <lecopzer@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mediatek@lists.infradead.org, yj.chiang@mediatek.com,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 3, 2021 at 6:12 PM Lecopzer Chen <lecopzer@gmail.com> wrote:
>
> Linux supports KAsan for VMALLOC since commit 3c5c3cfb9ef4da9
> ("kasan: support backing vmalloc space with real shadow memory")
>
> Acroding to how x86 ported it [1], they early allocated p4d and pgd,
> but in arm64 I just simulate how KAsan supports MODULES_VADDR in arm64
> by not to populate the vmalloc area except for kimg address.
>
> Test environment:
>     4G and 8G Qemu virt,
>     39-bit VA + 4k PAGE_SIZE with 3-level page table,
>     test by lib/test_kasan.ko and lib/test_kasan_module.ko
>
> It also works in Kaslr with CONFIG_RANDOMIZE_MODULE_REGION_FULL,
> but not test for HW_TAG(I have no proper device), thus keep
> HW_TAG and KASAN_VMALLOC mutual exclusion until confirming
> the functionality.

Re this: it makes sense to introduce vmalloc support one step a time
and add SW_TAGS support before taking on HW_TAGS. SW_TAGS doesn't
require any special hardware. Working on SW_TAGS first will also allow
dealing with potential conflicts between vmalloc and tags without
having MTE in the picture as well. Just FYI, no need to include that
in this change.
