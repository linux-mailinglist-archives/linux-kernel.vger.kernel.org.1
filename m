Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1032ACB81
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 04:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbgKJDJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 22:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgKJDJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 22:09:37 -0500
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F333EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 19:09:36 -0800 (PST)
Received: by mail-vk1-xa42.google.com with SMTP id v5so1186661vkn.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 19:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pZgRoZ+grb92ReTPi7dMzerQ5xu8KZMINDDLao9Et84=;
        b=X1YhCkfLkBAdLES81GYvQ2P/eG9WAuzpSw2BTpSlbQPS89ByHWI60wyHh/DLjBZrJ4
         cR1vmSHM+8kFQlBKLDUBOj2Lk6rwnA8Q0twgbnl7l8At0eaLgsoTbm8JwWVnwMVSr0zv
         2PR383yye9ztHE1DkHiwlr1L0saSmGbAeVCAS2x6xWigteMNBaZtbp2EInx4SQj3WHxq
         NuaOnuxzbwrcs2u/7ZH1kvOEKsXfAznNu/6oOUnxK5iUeoJTWpU0BFxgCkNc9J+RiOn7
         /cIRo+XRT4aNbqjwq8kHKJk/vjxk0pR/FYkJ+h4p1grm7yhuvE+QIlVL+yX3y+1xJ9Wx
         Kjag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pZgRoZ+grb92ReTPi7dMzerQ5xu8KZMINDDLao9Et84=;
        b=cV8DTpJ0BrMu4WKtS1VgOP9WFD8VlZmfieJF4WBBcSAoM1xRc7LfvDY+FpXoMV5Zbi
         YRuD44NK9rTDPre8dXzgVC+SIam2UFnkqIFW9ijRblcZliXV2oJBge5t7SXzZAsgQrnF
         kg/lXXkym+WYXavHUMPcmoblQMklQ3Cp33fci5s69AGL2NCYDG8zf+E/2oFHq9chbMCe
         KSCBp0O4d3ZgvZ26lQk62sBVGTpF4MpgHlLE6mI9f3f/deWfaI/brjNKjFhTBo+9ZyJd
         wZuiEABb4DBkKnYFxHQsUmeIoWo4ZpIWMiG7LRHOSY2kNFgz6CeVI0mJ8YhOcTxzNfah
         eVGQ==
X-Gm-Message-State: AOAM530WF2Sz1Qw+U1F55PiEtgb1ANmbtIrxSR3Wae0iDiDkwlkDHmy/
        407rvEdiK2m5afCLSzJsTEyJHGR3pes9tvOczlzNbR05OQYTKQ==
X-Google-Smtp-Source: ABdhPJwFDr8TJq/toHUkOnKi1ykAKJGxGTdhqxOky0WSpSGoJWGqFX6KCucvlvhorC6Ygt/8D6/Y92JNPg50jhRUwHA=
X-Received: by 2002:a1f:c843:: with SMTP id y64mr9127731vkf.23.1604977776227;
 Mon, 09 Nov 2020 19:09:36 -0800 (PST)
MIME-Version: 1.0
References: <1604661895-5495-1-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1604661895-5495-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 10 Nov 2020 08:39:24 +0530
Message-ID: <CAFqt6zZU76NOF6uD_c1vRPmEHwOzLp9wEWAmSX2ficpQb0zf6g@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: add static for function __add_to_page_cache_locked
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 4:55 PM Alex Shi <alex.shi@linux.alibaba.com> wrote:
>
> Otherwise it cause gcc warning:
>           ^~~~~~~~~~~~~~~
> ../mm/filemap.c:830:14: warning: no previous prototype for
> =E2=80=98__add_to_page_cache_locked=E2=80=99 [-Wmissing-prototypes]
>  noinline int __add_to_page_cache_locked(struct page *page,
>               ^~~~~~~~~~~~~~~~~~~~~~~~~~

Is CONFIG_DEBUG_INFO_BTF enabled in your .config ?

>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/filemap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/filemap.c b/mm/filemap.c
> index d90614f501da..249cf489f5df 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -827,7 +827,7 @@ int replace_page_cache_page(struct page *old, struct =
page *new, gfp_t gfp_mask)
>  }
>  EXPORT_SYMBOL_GPL(replace_page_cache_page);
>
> -noinline int __add_to_page_cache_locked(struct page *page,
> +static noinline int __add_to_page_cache_locked(struct page *page,
>                                         struct address_space *mapping,
>                                         pgoff_t offset, gfp_t gfp,
>                                         void **shadowp)
> --
> 1.8.3.1
>
>
