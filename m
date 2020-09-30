Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8B727DE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 04:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgI3CnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 22:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbgI3CnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 22:43:01 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15443C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 19:42:59 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id b22so249569lfs.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 19:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FzMSyDG+4uOgzBHpqfZT/MbeTBRLHtt1WS9WK/I7PZQ=;
        b=xayrkaObU3Il4H+nuaMMdxgn7/aPj3l/vOTE98XE+9p44U4yqEX3ptVUiFWrUZjZaH
         SVn3ZlpvWfT0qV+yyqzrvjqp8t52q7zNJxXyOk5+z/BAfMsZMb7yQrbO0A8Ab8T24Wyw
         gsd0+7DSYyH3wDO0Ucx8SPrVNRvO4LQ0kn7f03Xj+9JsQ45ObPmgI8k4/KoFPObElwqa
         jl08z/WnBfJJsl/IAO3ENsKFFoDzljwKCPI/FrJsA0Cl2BPx7b8SWHyevU6sKW5gY8ZN
         mJmiYjRqrlSh3PNHrZfCe+nDOCy9EIrzy5+OG/lsifoeejM2dyFgBPM3nLUQl/5uZy01
         yRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FzMSyDG+4uOgzBHpqfZT/MbeTBRLHtt1WS9WK/I7PZQ=;
        b=kIMPQBGWsQwRFixl+2geRtjNm1p2VvGF8jASUxCMeQaqWDaEb1ca0Z/rus9MXGjjKJ
         2KoNO8ObioP0OIIGyDaoszj7xNuyO6Y/n4m221sGnseuaq/mamoxW1iwlvYzLdUNYAPJ
         XUoqzpsSkCLtgSzeiBVxCu53UPZl4mak1my2d2n6INqxpKIJtFDjYjqVXsNBMcD9JgXg
         loYRkJTn6ibEV1+HJN9aofyMECLDL4bJi1Na6Kz71kp+ffA5Kl3eRIs4CRjsc9W3jCs2
         0XHeGd/Fx6P4mDg29qP3cJvYlp9RbzA7aKZ7MQUvnyYofcoODyq7EDZOf6zNjoU3gxK+
         FWxg==
X-Gm-Message-State: AOAM530APKHKGMFLJ/WXFPVV4wAYOnNcbVNXUCQ11RlBw9x2Ex//U+5m
        T5/9iu2MxX14MeFc99XIe9zinxGC87/C+OqOTVQl0+HjaIfUoEht
X-Google-Smtp-Source: ABdhPJwSX5vMWCiJ89BIqCV30L9yZv296SgzIKsfSRd2CaRZj71yTXsgfifUdIfaiXvgOXTVCF0DGGPG0c2Gi8pwfJE=
X-Received: by 2002:a19:cc4d:: with SMTP id c74mr94470lfg.188.1601433777411;
 Tue, 29 Sep 2020 19:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200930020659.139283-1-wangkefeng.wang@huawei.com>
In-Reply-To: <20200930020659.139283-1-wangkefeng.wang@huawei.com>
From:   Chunxin Zang <zangchunxin@bytedance.com>
Date:   Wed, 30 Sep 2020 10:42:46 +0800
Message-ID: <CAKRVAeMWhetOCnt5vcC9ov3aG38gSrUrH2NVUXPiDyd49dnmww@mail.gmail.com>
Subject: Re: [External] [PATCH -next] mm/vmscan: Drop duplicated code in drop_slab_node
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 10:07 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> The following patches fix same issue and both add fatal
> signal check in drop_slab_node, kill a duplicated check.
>
>   "mm/vmscan: add a fatal signals check in drop_slab_node"
>   "mm/vmscan: fix infinite loop in drop_slab_node"
>
> Cc: Chunxin Zang <zangchunxin@bytedance.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  mm/vmscan.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index eae57d092931..980155e257bf 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -699,9 +699,6 @@ void drop_slab_node(int nid)
>         do {
>                 struct mem_cgroup *memcg = NULL;
>
> -               if (fatal_signal_pending(current))
> -                       return;
> -
>                 if (fatal_signal_pending(current))
>                         return;
>
> --
> 2.26.2
>

Yes,  there are the same patch.  Because the 'add a fatal signals
check in drop_slab_node' description is more accurate.
The mail list  please see  https://lkml.org/lkml/2020/9/15/20

Andrew, can you update it ,  thanks so much.

Best wishes
Chunxin Zang
