Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82382E0C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 16:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgLVPIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 10:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgLVPIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 10:08:48 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FA8C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 07:08:08 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id f16so4437802uav.12
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 07:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vg4rXkTJ1RSjS9v+aXpVjxDf/4HIRC34j1tsJCwhiy0=;
        b=EEq/OnT3s6THYE1mfOGdHX0XzUpZjLU87XJ256AUL7ssWp2wb2sMsIaLH7B8+h8Wwd
         enqIS47nOCOHDhZX40eV9wnaBYjsWPLshftZBceKLyVTfTG4eVoILyo0N2Fh4+Ey6vO/
         ODn+vaVqXEBho4XxnQXXbXA+KiLBSu+lht3FqsFwpQJ/gd6txg+WdVPNtfcCQaCrhkyU
         Yz9vBgppwOVSoSGrIBuITgFlV/RT49VH8HkFZdqmY5MTVyR4aCC3KcImNdQcEOUzojYR
         ygE9A1+NGYEDLUPBX915EnpUuk9gER/h2ZLvWVvylmK1SeNeIEOxPSPhXH2SoAKk8zXa
         bsag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vg4rXkTJ1RSjS9v+aXpVjxDf/4HIRC34j1tsJCwhiy0=;
        b=hDlSswO/tr0aUaMqu9rsCXTK2+qGaUqqsItYLTEzhyk441AeBzwlKHNNP5CVFbFXGG
         ec/wcyNkdkCtSGSlniWe9WvNyQo78YEl6YG4Px2dvLmiGd96RzXDWrdLkHP10UUxVLUN
         7PoIG8QmckmQqbeGXPRBIc1VkTL8KeValAOHgb00vJO7WxwCXLNIYLP3u/tYs9fpjytG
         ULws8vjevKIOVG8zRsgSk75Q3+UWDtaZ2aWjzzqeWWXs9C/bgQc3+rcgTJ0dRivRHlxc
         sHrRMZoxnzq6lELt7WX8bkOEOCUnqMM6VB3XnX9XuQEX/cs9LRwyv29foZ22o8iR+5CC
         n/1g==
X-Gm-Message-State: AOAM5325V8Fbaf2y7lszayMg6fHwUPGwfAy1qbDoyoVuHOk91IWyvXQh
        u8iUcGuWcdhfG6M688mL7YH8VE0GEvWWiOjfpXU=
X-Google-Smtp-Source: ABdhPJz7xctMff6Y7t2PkT1UIdR/DFlB2RTAjl6gmUJvTWVB3c2qtLBZ7l29fXx5kKdM7Vs7cVMi+hNqyO3ISBvXGsY=
X-Received: by 2002:ab0:1c0a:: with SMTP id a10mr15591875uaj.89.1608649687685;
 Tue, 22 Dec 2020 07:08:07 -0800 (PST)
MIME-Version: 1.0
References: <20201222121904.50845-1-qianjun.kernel@gmail.com>
In-Reply-To: <20201222121904.50845-1-qianjun.kernel@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 22 Dec 2020 20:37:55 +0530
Message-ID: <CAFqt6zbVSnHoU54ZaOEcHAEvO96h0X6wQaNrjxqgGkgmD4Vqdw@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm:improve the performance during fork
To:     qianjun.kernel@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 5:49 PM <qianjun.kernel@gmail.com> wrote:
>
> From: jun qian <qianjun.kernel@gmail.com>
>
> In our project, Many business delays come from fork, so
> we started looking for the reason why fork is time-consuming.
> I used the ftrace with function_graph to trace the fork, found
> that the vm_normal_page will be called tens of thousands and
> the execution time of this vm_normal_page function is only a
> few nanoseconds. And the vm_normal_page is not a inline function.
> So I think if the function is inline style, it maybe reduce the
> call time overhead.
>
> I did the following experiment:
>
> I have wrote the c test code, pls ignore the memory leak :)
> Before fork, I will malloc 4G bytes, then acculate the fork
> time.
>
> int main()
> {
>         char *p;
>         unsigned long long i=0;
>         float time_use=0;
>         struct timeval start;
>         struct timeval end;
>
>         for(i=0; i<LEN; i++) {
>                 p = (char *)malloc(4096);
>                 if (p == NULL) {
>                         printf("malloc failed!\n");
>                         return 0;
>                 }
>                 p[0] = 0x55;
>         }
>         gettimeofday(&start,NULL);
>         fork();
>         gettimeofday(&end,NULL);
>
>         time_use=(end.tv_sec * 1000000 + end.tv_usec) -
>                 (start.tv_sec * 1000000 + start.tv_usec);
>         printf("time_use is %.10f us\n",time_use);
>
>         return 0;
> }
>
> We need to compare the changes in the size of vmlinux, the time of
> fork in inline and non-inline cases, and the vm_normal_page will be
> called in many function. So we also need to compare this function's
> size. For examples, the do_wp_page will call vm_normal_page, so I
> also calculated it's size.
>
>                   inline           non-inline       diff
> vmlinux size      9709248 bytes    9709824 bytes    -576 bytes
> fork time         23475ns          24638ns          -4.7%

Do you have time diff for both parent and child process ?

> do_wp_page size   972              743              +229
>
> According to the above test data, I think inline vm_normal_page can
> reduce fork execution time.
>
> Signed-off-by: jun qian <qianjun.kernel@gmail.com>
> ---
>  mm/memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 7d608765932b..a689bb5d3842 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -591,7 +591,7 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>   * PFNMAP mappings in order to support COWable mappings.
>   *
>   */
> -struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> +inline struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
>                             pte_t pte)
>  {
>         unsigned long pfn = pte_pfn(pte);
> --
> 2.18.2
>
>
