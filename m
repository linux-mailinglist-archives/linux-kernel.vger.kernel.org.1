Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7375277038
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbgIXLrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgIXLrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:47:41 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B34BC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:47:41 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e17so3232716wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 04:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gen+1cfeiOVlze5PT7LGWC4Io/Jy9zJpWLjYnIvdBUo=;
        b=TqfH7ms/kwOFy3YTgEn6UqG4brHkQnjy8aBZKTbxHkbSxe6JG6g0MkBGQNhA+tdZvR
         Wc4gr8CVvLBkf87fYMzPxzVW/UgWr6VgBNCsZbtokIx8fjt8Kwqczd5qf1YvYamucjuQ
         NlDP42JVeL/9yurovMfouUcI0uZsKT1jrxk1HunQohITz+j9mwWPDqtzAqnHQxQSuctr
         0Na+JMknAlwuJsSpsZEnLUSHrVBSuPv674aqJdq20IKnA7rd7fMFdvLqmRfsBq2deV0m
         3kY2VwGlM6yZ+VeZoYDSeETpKInsKH9X+S7dgsDGIETRa0fgU+JKButY361X6OTV/S+0
         R6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gen+1cfeiOVlze5PT7LGWC4Io/Jy9zJpWLjYnIvdBUo=;
        b=Xt2qmM8lxB1iRUxn2Npe3vktDwVY98W1fNkUwjsst0OgRoaXhta8OnZMiR8nolp2pe
         6FP/1uIcSTXv+UDde3M/9JvdLBWxk5YfpeafA1DMz8eZFy5EvFMxZUBN23E7Zau1bw9Z
         yF33KbmrSXqj4RE2xGJqTs8K6gw8NSJOzWHss2bixnymSEDU90ZUKDD68W66eo7s6NiP
         NqdK8D9Gc1PiOK7kfeG5IvSuLFU93GZnCbLG+xbU158FF+bhKfVQOqxRwoOy034dUeuR
         fCYBU/xnFczoMn+LLwBrNR62n7rV5HOS++YIVABBmY1B184pDmMRksmmTs8bJPX88TEL
         SpkA==
X-Gm-Message-State: AOAM533kGYbxxvJUNAzjemVB5R4bz3eL4zCnEd97ZFwYofvazS0I/YLK
        2YxVDUmG+gSoVCT6aVMMG8G0OK9GIutbBWekNY6Zug==
X-Google-Smtp-Source: ABdhPJzlAB1LaKS3vVnOhteN+LKInSJ3iqRi3Bi3sbvOZu3M59dlgKL3UiNjzSfzCIOJabK/i1UMh2XSl+c0rvu4m3o=
X-Received: by 2002:a7b:c749:: with SMTP id w9mr4067938wmk.29.1600948059478;
 Thu, 24 Sep 2020 04:47:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200924040513.31051-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20200924040513.31051-1-walter-zh.wu@mediatek.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 24 Sep 2020 13:47:27 +0200
Message-ID: <CAG_fn=W2dcGKFKHpDXzNvbPUp3USYyWi2DEpEewboqYBodnSsQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] kasan: print timer and workqueue stack
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 6:05 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> The aux_stack[2] is reused to record the call_rcu() call stack,
> timer init call stack, and enqueuing work call stacks. So that
> we need to change the auxiliary stack title for common title,
> print them in KASAN report.
>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>
> Suggested-by: Marco Elver <elver@google.com>
> Acked-by: Marco Elver <elver@google.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Reviewed-by: Andrey Konovalov <andreyknvl@google.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Alexander Potapenko <glider@google.com>
> ---
>
> v2:
> - Thanks for Marco suggestion.
> - We modify aux stack title name in KASAN report
>   in order to print call_rcu()/timer/workqueue stack.
>
> ---
>  mm/kasan/report.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index 4f49fa6cd1aa..886809d0a8dd 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -183,12 +183,12 @@ static void describe_object(struct kmem_cache *cache, void *object,
>
>  #ifdef CONFIG_KASAN_GENERIC
>                 if (alloc_info->aux_stack[0]) {
> -                       pr_err("Last call_rcu():\n");
> +                       pr_err("Last potentially related work creation:\n");

This doesn't have to be a work creation (expect more callers of
kasan_record_aux_stack() in the future), so maybe change the wording
here to "Last potentially related auxiliary stack"?
