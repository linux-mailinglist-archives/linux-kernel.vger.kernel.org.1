Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C011226ABD9
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgIOS2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgIOS2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:28:15 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EF2C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:28:11 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o8so6440032ejb.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a5yi80kDIlG+xC/7XTwq910FSClVkKBKeTr0UXgGZ+0=;
        b=YmFlarJ9oRwLXcNbELoAFxAwVoC7NgP9ryRrDh/LZni6oveziBc+ox9f2SBO4m3yhj
         rRix7hD9Fet8AhU43X2g1J0Ftj5ulQTGWBaRKouyE+6bHXH4FYTomTxPBTfCHFPaZ2Ay
         mG5YuoUyZPhlZ+BdHkfqaZAfyP+0YABaHxT5sXKGQwmNwnnicV5lYEkddRonVQgu5hFQ
         T8IxFBKA6ZboUzQA2jDZh0mIjxzjn39eRNBuYvDFfN17tZhFBJnFYVmyFXvtJ4UBBH3w
         EAXCLdb7G7ZW/09ZhRJhk77p8jC7ThQHtXs5TWBXcveuWZ+FPiCZ44de1sRQxktuFMWd
         Xq+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a5yi80kDIlG+xC/7XTwq910FSClVkKBKeTr0UXgGZ+0=;
        b=MXoPbLdNL28C5DhV0n1vPGQPUX7YJBWxgpM4QSQF02M9nCSjW632XhgOgRJHLoplND
         vrlNlfCgc9u8aaiMH7Qr/95ybSmXIhfvYm7UUW2JUcAm+UB4i8TXlQWLFvxOQT7jagd8
         HGRNYFAECpidQjF2E0hTxPPkaBd4T+zOEfRKHpSFnoe5QOVZuXJhD96agQxZSTWXFAUr
         08cWdeIcQIDqAe1+9E9vbwX6NnTMgpOV9TrNwzJ9vgHtJ8P75CTQQXjkTJ3Piv1Xo1Jf
         +jFRsbVpVJ/EILPnAo+F6P1pKrxIPWBHPzynzG7dDUEi2hQGliqWttZmxNAgsn3V/bU6
         J7GQ==
X-Gm-Message-State: AOAM532Er+feYlhL8S3odXfuai1BVb6b0Oz/AVellm98zQc9XT7B9eIU
        +Pl08K0cmddMD8fAByHars27sQmXrCKiuofi3aNOOA==
X-Google-Smtp-Source: ABdhPJyUBRBt8bBZ5p9/xJ79IzKoHzofLxRRFybaihfzMqJOzTXj2b8jfsVQ+4z5vuQFWZlehODpbQ+JO6019bDjGfs=
X-Received: by 2002:a17:906:7116:: with SMTP id x22mr22211371ejj.426.1600194489854;
 Tue, 15 Sep 2020 11:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <1600145748-26518-1-git-send-email-vijayb@linux.microsoft.com>
In-Reply-To: <1600145748-26518-1-git-send-email-vijayb@linux.microsoft.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 15 Sep 2020 14:27:34 -0400
Message-ID: <CA+CK2bDH-BGAWhCYLpsxwhS1+eHibqmjLiXAhyr0i94YJspYuA@mail.gmail.com>
Subject: Re: [v1] mm: khugepaged: avoid overriding min_free_kbytes set by user
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Allen Pais <apais@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 12:55 AM Vijay Balakrishna
<vijayb@linux.microsoft.com> wrote:
>
> set_recommended_min_free_kbytes need to honor min_free_kbytes set by the
> user.  Post start-of-day THP enable or memory hotplug operations can
> lose user specified min_free_kbytes, in particular when it is higher than
> calculated recommended value.
>
> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Cc: stable@vger.kernel.org
> ---
>  mm/khugepaged.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4f7107476a6f..b4b753ba411a 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2253,7 +2253,7 @@ static void set_recommended_min_free_kbytes(void)
>  {
>         struct zone *zone;
>         int nr_zones = 0;
> -       unsigned long recommended_min;
> +       int recommended_min;

Hi Vijay,

Please explain in log the type change. user_min_free_kbytes is  of
"int" type and is initialized to -1, so comparing to unsigned leads to
undesired effect.


>
>         for_each_populated_zone(zone) {
>                 /*
> @@ -2280,12 +2280,12 @@ static void set_recommended_min_free_kbytes(void)
>
>         /* don't ever allow to reserve more than 5% of the lowmem */
>         recommended_min = min(recommended_min,
> -                             (unsigned long) nr_free_buffer_pages() / 20);
> +                             (int) nr_free_buffer_pages() / 20);
>         recommended_min <<= (PAGE_SHIFT-10);
>
> -       if (recommended_min > min_free_kbytes) {
> +       if (recommended_min > user_min_free_kbytes) {

Took me a while to understand, but this change is correct. It is the
same logic that is done in init_per_zone_wmark_min().

Please join the two patches you have in one patch series.
Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>

Thank you,
Pasha
