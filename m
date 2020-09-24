Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3CC276A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgIXHGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgIXHGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:06:16 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FA6C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:06:16 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w11so2724847lfn.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mMFKn7petaqw14RFBic1L+pEOZugLfwojCWzUGGlGRk=;
        b=kH0LayK5JtiQ8tepUjGq57EtzET3XZ6P8Txuyf9x/cC+4xEgn59xevZUVDig78jBv3
         oeO56q22fL/g1Gwr7UAoFwGY+CTNPf/d6FXFi0AVfJWsRon9MNchf144xgPN88ZoBOEr
         6E5MMPJhzLAe/WVbdET9TGizCE864EdeoRwoWW/etbAJe07xxXtsi/HOxxf6A1ca/KSX
         FNWp23EV+SvkjwXezkwYpzd5soSAqVjIPHNl43t3x1pfUDXQTx+yoYvF7MmfwwfEtN/d
         5mpC39PLvwv+oSnmHSm07c61UhWmML33a2VmIzAbQg0jRG3d4cVYu4G73Sjxcj09QPXa
         sOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mMFKn7petaqw14RFBic1L+pEOZugLfwojCWzUGGlGRk=;
        b=TIwGGXHKpgFT4npXMfaxDx4y54hnLZ+XxrQr/vmo4nfcmVIni27Fzw3BM1JwoJNLVS
         xQD/CIAznSgpWNLuxE/r9omMStkpy+y/H58mr+ZGkNhTU/CO8vPLCDrVR1xTMf0rxoJN
         0yjwVBNbSpoPSQfarA1FMMLLEnX2dk4gu5PFQ7FdBSwsP2ZSZ6/xnY4Qz11YYhVMc6yo
         OWuuNWRm/fIUwWuDNEThvLH00M58HbgFUtDLzDDxYY/TA4lU0iPYRtUy3qxEfalSSu1P
         4EfHXI3UTq1IiBVyekX2JrpYETB71Aqwc5IpU29qQAI5+kopGgGhMatEgm3hwFr9avc1
         aZpQ==
X-Gm-Message-State: AOAM533aMYxaJXhkdiSA9C74c2LJrHGtAMbcqfJ6Qj5+vHqlkpqAuiiA
        r+EQE2oom8OPnvbySfZ7N1C5c4FdVGcr0qdkDJk5mg==
X-Google-Smtp-Source: ABdhPJyrP+YkIWkaEI+NWeFL5KWoU3afg5MKHhZoH/V0ZiG8R83YgqOxCDiXW2noqxL4i9nQMQQzDrmvX4NiTGlpmV4=
X-Received: by 2002:a19:2346:: with SMTP id j67mr1042414lfj.449.1600931174317;
 Thu, 24 Sep 2020 00:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200922203700.2879671-1-guro@fb.com> <20200922203700.2879671-5-guro@fb.com>
In-Reply-To: <20200922203700.2879671-5-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 24 Sep 2020 00:06:03 -0700
Message-ID: <CALvZod6v2oYk+xhAzM97-wPRdHmCv-C5zEctXzBk=wd0ZAKruw@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] mm: convert page kmemcg type to a page memcg flag
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

On Tue, Sep 22, 2020 at 1:37 PM Roman Gushchin <guro@fb.com> wrote:
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
> PageMemcgKmem() and SetPageMemcgKmem(). __ClearPageKmemcg()
> can be simple deleted because clear_page_mem_cgroup() already
> does the job.
>
> As a bonus, on !CONFIG_MEMCG build the PageMemcgKmem() check will
> be compiled out.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
