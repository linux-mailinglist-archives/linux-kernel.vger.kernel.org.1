Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD7528B3DC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388064AbgJLLfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387617AbgJLLfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:35:17 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77939C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 04:35:17 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id n61so15515894ota.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 04:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EA5iIZaa576r8N8INA70o0knVE+kycavkUZdn7XX02M=;
        b=V0ejSBtgDyIKCCK5zxdwEMp109dR1GM6gtxLEiO+yI88qpjz2rS0oSNojGd90nBlpW
         pOUmxPrh29xPNjFFZvHdBT11F9JdrMp6VWGm1axcm3rcBNhYaMYi/gYju32s6V3ZIQc8
         dEaib9ocaF7pC0yXUGLr4YvZYAxZUByAeTVBb/76WZmDGa8quY8E8BvJAKDcCE0UZrD+
         djJ5EJfQVnc8/qi5zJ2ZStUaWjfoQ9xGO69RCGbdA9hsV16704i6BcUuNRZ5tjXELHDw
         sVdIuwBA+dXJBm7FXKeEJ+CRjdDJHmT52c5nZ0Cv2EJkS4YgVLgU13VGkO2mxCjHdykg
         90MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EA5iIZaa576r8N8INA70o0knVE+kycavkUZdn7XX02M=;
        b=L3rZnsCCKeGwqmWGFLA8GU0a9y+M/3p25KEIcbvqK2ab6VTkzWcodpSa9aS1jFwiBt
         v9VIfh83HQ8XVsjXGzOnx1HdipAIn4AXCq7e1SDkA/rmH7zdM8AFz11PtByR4xd1aNwl
         D9SZy4mUz4NRbFHuHrQMAyxHNMYRZjhiCITvGh8H/RNovihoinjGbcDXjQ3g/WTEuooT
         2ysWfLeRe4sPKHeev0FzzcAT/o3nvYRp2ykNDtM28aUPC6/LKkVpctkpIw7cO4nfN+pc
         PixUFyK8dUtXvJytH3L/cmvEPLqqL767Afyl2xvXLjZiP6VvzKJwlq6YsaPgwKHxQZDj
         DJWg==
X-Gm-Message-State: AOAM532iQlgNO58w+YLN1d94cprt141S6yfsRK0pZsLrZSEvvzKyE9p0
        e0c5hawL91TbmNtbbWAeLOQr2h2bY3nwLcHJGm/sXA==
X-Google-Smtp-Source: ABdhPJy5mDiiD/dr946HUCLfUPqDWNi7xK/hxPTfQLsh2DEQDwvP0zLsmu3Lz2nPeso0Y6N+GSMQCvUlIv81b75mtJ8=
X-Received: by 2002:a9d:1909:: with SMTP id j9mr19227168ota.283.1602502516828;
 Mon, 12 Oct 2020 04:35:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201012092603.630703-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20201012092603.630703-1-volodymyr_babchuk@epam.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 12 Oct 2020 13:35:06 +0200
Message-ID: <CAHUa44EAR=5Syz9vz4pCNm8ytqd3rhj=PDE8trAvOiAdhs_T8A@mail.gmail.com>
Subject: Re: [PATCH] optee: remove address tag in check_mem_type()
To:     Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc:     "tee-dev@lists.linaro.org" <tee-dev@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 11:26 AM Volodymyr Babchuk
<Volodymyr_Babchuk@epam.com> wrote:
>
> Before passing 'start' to find_vma() we need to remove
> tags from it to get sane results.
>
> Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
> ---
>  drivers/tee/optee/call.c | 2 ++
>  1 file changed, 2 insertions(+)

Would you mind giving a bit more background to this? For example in
which contexts this function does or doesn't work as expected? Do you
have any special use cases that don't work, etc? This is not a new
regression, it's rather a problem we've always had, right?

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index a5afbe6dee68..61420395137b 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -562,6 +562,8 @@ static int check_mem_type(unsigned long start, size_t num_pages)
>         struct mm_struct *mm = current->mm;
>         int rc;
>
> +       start = untagged_addr(start);
> +
>         down_read(&mm->mmap_sem);
>         rc = __check_mem_type(find_vma(mm, start),
>                               start + num_pages * PAGE_SIZE);
> --
> 2.27.0
