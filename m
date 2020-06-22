Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29648203C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 18:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgFVQ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 12:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728185AbgFVQ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:27:21 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16043C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:27:21 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 9so20053844ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUQt+wIXHVUSOm3OqSTrOTjz+yLUhP4e6aO1d0qpuNk=;
        b=pxR59VldgupkQAkqc/a4MUaHT2ekxmVgXcm2e2zkbWexhzWuNRPC3ovhWnSWEX8Xuj
         iVs7a7AuZS0NGz5SPfi+Rw/FUFSBhlzk9BbHEMOTjJIWuXwhfaxjfWu981YlZtLUTTI+
         TqL/d1mHkpIJMEF8/NBLKRz9eJKYs71gEd3CgF/XnVHeT0Espsf8KiJkYeb6ILTenv1d
         rA2BuxpX7ljYgf81pghFJAPU2ulF0J+HeBjmvFtR43IZJiEnIW04HDqVPYLjBblVq9AX
         4MdrFniVZ1V6D5VwHTS0/xzS1N/xVGCQyMnTOYMEpTwc2rAPl6QvAtKkezuvo6vlAteC
         +B7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUQt+wIXHVUSOm3OqSTrOTjz+yLUhP4e6aO1d0qpuNk=;
        b=M8GB2J1zd9USZRqAgnV6tA43K8cx3U2u6Zp52pQzLi5dt5NSowEgNpZMfbHvLoyRvD
         +tf6O+PN4USoGyFiS+7jta7Mg9TsGaUnhyDp9aBPIdrYcz/XceNSZJQ+Zvu68SqZswCd
         3M7E+1RZrVzTCgBSDybojGwYR1RCDACApBdLkQ186KOEBHjEzdrzuHerD+SD0+n/0Ff6
         CLYcYBOa9hGvGdfVYpR3vcP3+t5k/2mK28N372ZYsQZlLqWuf7lH+fBmkXxHZsiVYcp2
         a+HF2rTsw32mwl+6gz9rzZ2m7mB7ULep8cduUJI+QTghZdmyhmegAKSfyTsyPi+4T+cp
         Ws4w==
X-Gm-Message-State: AOAM533v1uYR3HzS++bnk3ESXiEwmJm0vM7JoyOqK6dkOgeJ62gzWaS2
        KxZ1kYGGhV+fGUa/++rWO86AXdiGei7Al4Ew31g=
X-Google-Smtp-Source: ABdhPJwqhgUpYfxCY6qwT/+WVfdXybhQ0h6vrxKeoNAXjDDg+a0Y8QUr4TAASbB95XF9/b6DVf6vOUozb9QT6/2oSEg=
X-Received: by 2002:a2e:8682:: with SMTP id l2mr2099748lji.68.1592843239437;
 Mon, 22 Jun 2020 09:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <1592362839-4050-1-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1592362839-4050-1-git-send-email-jrdr.linux@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 22 Jun 2020 22:05:35 +0530
Message-ID: <CAFqt6zbQ-AJK_3NHmaOVXYUaD7ajvEvogMAOrse-99+vPi7xNw@mail.gmail.com>
Subject: Re: [PATCH v2] drivers/virt/fsl_hypervisor: Correcting error handling path
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, mchehab+samsung@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 8:22 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> First, when memory allocation for sg_list_unaligned failed, there
> is no point of calling put_pages() as we haven't pinned any pages.
>
> Second, if get_user_pages_fast() failed we should unpinned num_pinned
> pages, no point of checking till num_pages.
>
> This will address both.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: John Hubbard <jhubbard@nvidia.com>

Any suggestion, what is the right tree to take this patch forward ?

> ---
> v2:
>         Added review tag.
>
>  drivers/virt/fsl_hypervisor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
> index 1b0b11b..ea344d7 100644
> --- a/drivers/virt/fsl_hypervisor.c
> +++ b/drivers/virt/fsl_hypervisor.c
> @@ -157,7 +157,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>
>         unsigned int i;
>         long ret = 0;
> -       int num_pinned; /* return value from get_user_pages() */
> +       int num_pinned = 0; /* return value from get_user_pages() */
>         phys_addr_t remote_paddr; /* The next address in the remote buffer */
>         uint32_t count; /* The number of bytes left to copy */
>
> @@ -293,7 +293,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
>
>  exit:
>         if (pages) {
> -               for (i = 0; i < num_pages; i++)
> +               for (i = 0; i < num_pinned; i++)
>                         if (pages[i])
>                                 put_page(pages[i]);
>         }
> --
> 1.9.1
>
