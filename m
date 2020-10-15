Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 805FB28FA21
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 22:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392283AbgJOUbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 16:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730851AbgJOUbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 16:31:14 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB83C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 13:31:14 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k1so6245394ilc.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 13:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KMEoBpSpf5ITv96lwr1E/oq/2FCY57jpAaduGuTPcdI=;
        b=c0u0Re/dOCSPaDfhhy9zAOz8zbYQs1/ORCwhrN5/0vmsDvcgn6i3yy6b7/rbmWY/cF
         69vGTKrvnq1NvAFGCeaa0mer8JhGOMG0/neIUwtuHP1DMlA+2X+u21nu6X2nmMJEocp9
         aJj1dFh7UogkZAScFWdWOPmz9En2d2rttEIAZ+5/Wl1umvnhp+BcQibIgQEVjJmaja6t
         jwnAGrfExUXeQf3xI4CpJVse2KZBsNEBajuW4GzWVtxXEBazAv3Y2s9RVIfmECugvMDR
         J9+MRKV1gZhCKz8e5Ue93ZuwzW5XSfyr3UJhpFy83w2lyHvTJe+A9gxI43dMmirBf69J
         /uqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KMEoBpSpf5ITv96lwr1E/oq/2FCY57jpAaduGuTPcdI=;
        b=T4xYeQXSiC53c7KrGpk0SvTJ8GbjbNuywEEY+KOMNhV5YD3ysA1c7CwXVyRJMx4Hsw
         mEUDunbzBKnKbVDfJOspLLIu4fdPGPoJgkxQsmixoywpHtZe59zNLeYH1XpPJxr4tBSe
         F50ovXW0wHdQf4RYTHKuuOfsPL2LyC8K+1v/FtmyZzBnaswZo6VEiudEWDaPnnx6ymaA
         DkK0pFxYFaJoRuR1LmLmo5wvIWDTBRZaZ/T1BYP4AdlU2DEXpotqw446ZV2uuB5mCzk8
         MzKPDOAXpZpCEzgkfBCZPSHBQAKfL1FuXGWEOIf4AI8V6iXcRmwx3YVluGMUdp9X74LA
         EBrw==
X-Gm-Message-State: AOAM532ESyjhNx9fr4yqNblUzTK8i6MyhGxB3B5OUxRQjhxT0e+lJavC
        Z0TwB34pYN6QeC48EnG4rr//mqJ39SHaklB/E6172zxH9TGvrA==
X-Google-Smtp-Source: ABdhPJw27itUGJwpE6ecTiJLPMcG+8G7avBYojcFJaZYKj3gfLThWSK9B2UYHnLOzIVMPQddockt9gKmy3btJT/dxrI=
X-Received: by 2002:a92:180b:: with SMTP id 11mr273536ily.89.1602793873755;
 Thu, 15 Oct 2020 13:31:13 -0700 (PDT)
MIME-Version: 1.0
References: <20201012125323.17509-1-david@redhat.com> <20201012125323.17509-12-david@redhat.com>
In-Reply-To: <20201012125323.17509-12-david@redhat.com>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Thu, 15 Oct 2020 22:31:02 +0200
Message-ID: <CAM9Jb+gS2dFO584KgHsx2Biw1ppCNqO8UB1om35Z1E8qaFUyPw@mail.gmail.com>
Subject: Re: [PATCH v1 11/29] virtio-mem: use "unsigned long" for nr_pages
 when fake onlining/offlining
To:     David Hildenbrand <david@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> No harm done, but let's be consistent.
>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/virtio/virtio_mem.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
> index cb2e8f254650..00d1cfca4713 100644
> --- a/drivers/virtio/virtio_mem.c
> +++ b/drivers/virtio/virtio_mem.c
> @@ -766,7 +766,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
>   * (via generic_online_page()) using PageDirty().
>   */
>  static void virtio_mem_set_fake_offline(unsigned long pfn,
> -                                       unsigned int nr_pages, bool onlined)
> +                                       unsigned long nr_pages, bool onlined)
>  {
>         for (; nr_pages--; pfn++) {
>                 struct page *page = pfn_to_page(pfn);
> @@ -785,7 +785,7 @@ static void virtio_mem_set_fake_offline(unsigned long pfn,
>   * (via generic_online_page()), clear PageDirty().
>   */
>  static void virtio_mem_clear_fake_offline(unsigned long pfn,
> -                                         unsigned int nr_pages, bool onlined)
> +                                         unsigned long nr_pages, bool onlined)
>  {
>         for (; nr_pages--; pfn++) {
>                 struct page *page = pfn_to_page(pfn);
> @@ -800,10 +800,10 @@ static void virtio_mem_clear_fake_offline(unsigned long pfn,
>   * Release a range of fake-offline pages to the buddy, effectively
>   * fake-onlining them.
>   */
> -static void virtio_mem_fake_online(unsigned long pfn, unsigned int nr_pages)
> +static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
>  {
>         const unsigned long max_nr_pages = MAX_ORDER_NR_PAGES;
> -       int i;
> +       unsigned long i;
>
>         /*
>          * We are always called at least with MAX_ORDER_NR_PAGES

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
