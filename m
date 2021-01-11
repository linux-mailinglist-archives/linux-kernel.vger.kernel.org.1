Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991A72F21B1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbhAKVWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730374AbhAKVWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:22:06 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA79C061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:21:26 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ce23so416789ejb.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+AfvfCqsfaWkYAg6+USDuxUF1iByJwAHFmuzpuqID3o=;
        b=JNXA4eh+XvS7VbDRQow9rDSG63sK6s8viFtRvPQKLPQc5znp1NdUI+ZUf2P+tJOUmN
         msc82S/JFuJGrRoM96c06ABMd8qdGoW8j1IEzQwCVlvHzQ2imnfCuaccwTzaM35r4yoC
         5ctGnMEryb+INkdAhzu1jnFQyEdFzL61rGkEb8VgJhPqyb/vETkhRofHD5JvBPLdcmwG
         j2JTXkJXSUQe4tun8gWbG4BaJx0oaPce60HdcO4m20+mGHVYG4kNbNbYYspvtF5AVi+w
         Zf2O2+H+VDOqksZzd2mznPvSOVOObBMI1J3ePh8ZKuDRL33S3wmmaqGxZ8ADVTGHjlO/
         uJFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+AfvfCqsfaWkYAg6+USDuxUF1iByJwAHFmuzpuqID3o=;
        b=ShH/JzusuPgf8poglU1FFTu+dcZZrauwnrJRBDf/y9ZLOgMmp2iyvZhqIQX6aK2Oik
         yHP0FOy/3S18hYl5bhAYromEph5VxQYzRJ8eNzijMlFqYW8+zy6C7kiG/wCozlmQdb+n
         88Qcg3p9w5EaqjlYfq+ZDQ6Y+n5OVe28QmzFX4lgiI4Fwaa9x9Du8Nde33+QxmuoBI9o
         coGaIiny8M9DmpwWXymAdLBYnzOZxS6DV55ciFMKj3VxJX6VHMI/h8kbjW6UeCvfAQ9m
         mRa58kHIueD4RYtx98dC+awZ6KD9rN8PNt9T5uymEcXqp5h1KUDXV6HEA02IZd7o3bNj
         0K3A==
X-Gm-Message-State: AOAM533GvHnlOYckHYBnxp3e7bvx+jKR7yLcB7UdGbbyAysuIz39357+
        oyRNq80VwRhGwGkq5zHPZH/1p54hIvg9i9CaG9Y=
X-Google-Smtp-Source: ABdhPJyFOrpHE8t0ZJOiqnyBKrLl6Kg5x7EcGRv1wS/EVN/VXJyRmG8bui3pJBKEPi/eo+tz32T94OYlqAGygy6os8k=
X-Received: by 2002:a17:906:1a4e:: with SMTP id j14mr879710ejf.507.1610400084987;
 Mon, 11 Jan 2021 13:21:24 -0800 (PST)
MIME-Version: 1.0
References: <c617a0c6cb2a7e3bc78998ad7e2bceb22df157c2.1610398598.git.sudaraja@codeaurora.org>
In-Reply-To: <c617a0c6cb2a7e3bc78998ad7e2bceb22df157c2.1610398598.git.sudaraja@codeaurora.org>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 11 Jan 2021 13:21:12 -0800
Message-ID: <CAHbLzkoZpiY3qB-fuvg+HYb+SwOvY8qiHLfFG=aibgRyP5bpCQ@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: support equal reclaim for anon and file pages
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 12:59 PM Sudarshan Rajagopalan
<sudaraja@codeaurora.org> wrote:
>
> When performing memory reclaim support treating anonymous and
> file backed pages equally.
> Swapping anonymous pages out to memory can be efficient enough
> to justify treating anonymous and file backed pages equally.
>
> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> ---
>  mm/vmscan.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 257cba79a96d..ec7585e0d5f5 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -169,6 +169,8 @@ struct scan_control {
>   */
>  int vm_swappiness = 60;
>
> +bool balance_anon_file_reclaim = false;

I think the same effect could be achieved by adjusting swappiness. The
"swappiness" can go to 200 now.

Please check the document at Documentation/admin-guide/sysctl/vm.rst, it says:

This control is used to define the rough relative IO cost of swapping
and filesystem paging, as a value between 0 and 200. At 100, the VM
assumes equal IO cost and will thus apply memory pressure to the page
cache and swap-backed pages equally; lower values signify more
expensive swap IO, higher values indicates cheaper.

> +
>  static void set_task_reclaim_state(struct task_struct *task,
>                                    struct reclaim_state *rs)
>  {
> @@ -201,6 +203,13 @@ static DECLARE_RWSEM(shrinker_rwsem);
>  static DEFINE_IDR(shrinker_idr);
>  static int shrinker_nr_max;
>
> +static int __init cmdline_parse_balance_reclaim(char *p)
> +{
> +       balance_anon_file_reclaim = true;
> +       return 0;
> +}
> +early_param("balance_reclaim", cmdline_parse_balance_reclaim);
> +
>  static int prealloc_memcg_shrinker(struct shrinker *shrinker)
>  {
>         int id, ret = -ENOMEM;
> @@ -2291,9 +2300,11 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>
>         /*
>          * If there is enough inactive page cache, we do not reclaim
> -        * anything from the anonymous working right now.
> +        * anything from the anonymous working right now. But when balancing
> +        * anon and page cache files for reclaim, allow swapping of anon pages
> +        * even if there are a number of inactive file cache pages.
>          */
> -       if (sc->cache_trim_mode) {
> +       if (!balance_anon_file_reclaim && sc->cache_trim_mode) {
>                 scan_balance = SCAN_FILE;
>                 goto out;
>         }
> --
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
>
