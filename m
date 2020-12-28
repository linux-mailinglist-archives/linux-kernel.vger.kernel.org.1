Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623892E345E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 06:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgL1FmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 00:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgL1FmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 00:42:14 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A7DC061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 21:41:34 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c12so5739791pfo.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 21:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdC1UTvK3n3P54mNUc/2MJ7F1GE6qXAssfNlwctQq5A=;
        b=VgitC5bh7LY0I34mSYBnKJCn+g46m7lfhWc+52EAtE4Jtpn1zF5sEmiOiHFhniymQu
         75MVFKMKs2DbndOSgVA22lLlgtsoO+s8idjhSQU0xCV0oAzbeoMRXt68n0RAtd9hFkFV
         TKkOVCLHYeXHo3OJaDiiHCJpKpos4gOwZSSh4g0eeAdNHb2wU7CBUTdJfv38wDQqlWo4
         b5gpSyPsRZ4xY+KUA4FLZryRruATzIIMSVW6aWoFBnS/G/Bws41pXp3vetiEl78tNJiD
         +5GyYwHlJPG5buRTpVXncrX6sgDfBBj6k77xNvtNdNfDdAIIFMI8uhol7rByABB7Irvp
         7FIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdC1UTvK3n3P54mNUc/2MJ7F1GE6qXAssfNlwctQq5A=;
        b=M2c9jeJ8dF0KRdif8cZKW+CeAYCcKQ/v0EPMtHNZvAFaMEN2iZjLq6g4P8bkTKalhg
         Ybrgz4In5Q89T9T5XgcUQUBl43EQvsi10Ik+hE5//QBhjqi8rRHQlSg6QbfM1tZ5gYnz
         lMch2yItbbZdrFVVLNpoA5ma52H4Lf2WuxWdbj+wIu9KyZqD11fFGj6ymX4aC4VcGD/0
         4epU8zUrEP3/zyMuAoO892eCGTZ3p5+Iym6HaKIh3Hh6BUy5QpDmM+lAylD8feE6YkeS
         XgE6xUu4/ZdnERErTkKpUvmR+HSNXN78TlRmUkllhJVNuvrCdlP8aX/rxk+n7MMBSlhO
         vVbw==
X-Gm-Message-State: AOAM532euKJ/dkLRBsU6ITqJ/YHrezxtk/NiL4+VzQOUfAFnfcIv3BKA
        NVMqBMXp4F7thVJKXPL575+RiHru7IPtQljv1xPr7A==
X-Google-Smtp-Source: ABdhPJwXVa9em2MWeoou1jv+F1kF93xbWKqRqnIRiQYiWDC7Q/2z2DBySCmNGhGBDwiw46Gn2gDqglDyT7Aw6y+4gWs=
X-Received: by 2002:a63:480f:: with SMTP id v15mr28753074pga.341.1609134093727;
 Sun, 27 Dec 2020 21:41:33 -0800 (PST)
MIME-Version: 1.0
References: <20201227181310.3235210-1-shakeelb@google.com>
In-Reply-To: <20201227181310.3235210-1-shakeelb@google.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Mon, 28 Dec 2020 13:40:54 +0800
Message-ID: <CAMZfGtWqDLJkP1zk_W16F+ssiW5NujRF-LFoV2GJ-+gXvBswMQ@mail.gmail.com>
Subject: Re: [External] [PATCH 1/2] mm: memcg: fix memcg file_dirty numa stat
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Cgroups <cgroups@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 2:13 AM Shakeel Butt <shakeelb@google.com> wrote:
>
> The kernel updates the per-node NR_FILE_DIRTY stats on page migration
> but not the memcg numa stats. That was not an issue until recently the
> commit 5f9a4f4a7096 ("mm: memcontrol: add the missing numa_stat interface
> for cgroup v2") exposed numa stats for the memcg. So fixing the
> file_dirty per-memcg numa stat.
>
> Fixes: 5f9a4f4a7096 ("mm: memcontrol: add the missing numa_stat interface for cgroup v2")

Thanks for catching this problem.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/migrate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index ee5e612b4cd8..613794f6a433 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -500,9 +500,9 @@ int migrate_page_move_mapping(struct address_space *mapping,
>                         __inc_lruvec_state(new_lruvec, NR_SHMEM);
>                 }
>                 if (dirty && mapping_can_writeback(mapping)) {
> -                       __dec_node_state(oldzone->zone_pgdat, NR_FILE_DIRTY);
> +                       __dec_lruvec_state(old_lruvec, NR_FILE_DIRTY);
>                         __dec_zone_state(oldzone, NR_ZONE_WRITE_PENDING);
> -                       __inc_node_state(newzone->zone_pgdat, NR_FILE_DIRTY);
> +                       __inc_lruvec_state(new_lruvec, NR_FILE_DIRTY);
>                         __inc_zone_state(newzone, NR_ZONE_WRITE_PENDING);
>                 }
>         }
> --
> 2.29.2.729.g45daf8777d-goog
>


--
Yours,
Muchun
