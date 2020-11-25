Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6669C2C4468
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbgKYPtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730318AbgKYPtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:49:46 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51A6C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:49:46 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id y78so1434842vsy.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NuolX140BHWDSfAnkAazVtuOkVaQx44vD4ygTSsH7i0=;
        b=rDhffU8agGCkAeyEzGOkE+j6cV0a1uoxirn6kM7BJm5UTghhnCpPPmC5ZcgkRQCU4/
         ZrU+CSewAUPDIQI9wIDd+dZ+PYYK7Y7XqRFNNLI45GFBIWpejw2JQyysvQRB+OM2UVBg
         PIZe2C5VtJKmtFgGbXJizuw3zRmsSUPi9Go36xiqD3gZv3JmzxaHoeMfb7AUzUgCYHWM
         VxnFrZlP/9xAaOenxTittyfcWHh6gRIEvjbiymOcLLTVfBTJBJIf0cvUQp3Cip6IKhA4
         N80sUDm/AngysoETFD0JET7QZBlgMeo21FqFtClS7CZYcWOdKWg53XZXja2tD/AeV749
         4rYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NuolX140BHWDSfAnkAazVtuOkVaQx44vD4ygTSsH7i0=;
        b=pVKauC4kSGTKkejV/J+pFECjbCAhkRE3c5tjBDOgnYgI16aVTmugCl32RBHjMvZ3cI
         yHjMrLICMxMXSnRCaGQNpM7Fvjoh/R4Pcv18j3GWTpFKd2xc60qygduPo9hg5QfBXY9z
         +V82/PmI43/LSiGsZ1rIUAYpo/MkG8H30lvMYBRC0JMifNLRZO++qBEEfaVeUc5oHZ/u
         fEoBR9xyAd2cEZ4i73Fvv6VZKHgtd2Wrb1hxXcN7Zs0j7Uxzf6075bx33MJGTkbDWdM0
         6Uogtj6vJbkVQ52/X161NL8Ogk/Ph9QpRkYYJr1qIBFncvdzE64LPrWYMOqR5CSv5rxx
         2Bcg==
X-Gm-Message-State: AOAM5306qu0IwcovNdIhSVp1xywd4gA4zwBX+rfxe1GGPob2Wxuf5eQF
        SGR4zFqRlEja3v9uZHojFIbc8A2GqRqp8Mzh83Zip+ZGTNE=
X-Google-Smtp-Source: ABdhPJxZxRKOyaplIjBChIXrROxyvIkuHzgd6WsxFKaCKTd92HH//+2oU9GUNStdVCCIGEkeK0GTjeZoKR8p1QMq8EI=
X-Received: by 2002:a05:6102:30a4:: with SMTP id y4mr2493751vsd.59.1606319385866;
 Wed, 25 Nov 2020 07:49:45 -0800 (PST)
MIME-Version: 1.0
References: <1606318341-29521-1-git-send-email-charante@codeaurora.org>
In-Reply-To: <1606318341-29521-1-git-send-email-charante@codeaurora.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 25 Nov 2020 21:19:34 +0530
Message-ID: <CAFqt6zY5uoU8E9fhHQ2wU7V5C5b9WtNXXMGCEbmaEYQ3pWgvPQ@mail.gmail.com>
Subject: Re: [PATCH] mm: cma: improve pr_debug log in cma_release()
To:     Charan Teja Reddy <charante@codeaurora.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 9:02 PM Charan Teja Reddy
<charante@codeaurora.org> wrote:
>
> It is required to print 'count' of pages, along with the pages, passed
> to cma_release to debug the cases of mismatched count value passed
> between cma_alloc() and cma_release() from a code path.
>
> As an example, consider the below scenario:
> 1) CMA pool size is 4MB and
> 2) User doing the erroneous step of allocating 2 pages but freeing 1
> page in a loop from this CMA pool.
> The step 2 causes cma_alloc() to return NULL at one point of time
> because of -ENOMEM condition.
>
> And the current pr_debug logs is not giving the info about these types
> of allocation patterns because of count value not being printed in
> cma_release().
>
> We are printing the count value in the trace logs, just extend the same
> to pr_debug logs too.
>
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>

Reviewed-by: Souptick Joarder <jrdr.linux@gmail.com>

> ---
>  mm/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/cma.c b/mm/cma.c
> index 7f415d7..07c904b 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -512,7 +512,7 @@ bool cma_release(struct cma *cma, const struct page *pages, unsigned int count)
>         if (!cma || !pages)
>                 return false;
>
> -       pr_debug("%s(page %p)\n", __func__, (void *)pages);
> +       pr_debug("%s(page %p, count %zu)\n", __func__, (void *)pages, count);
>
>         pfn = page_to_pfn(pages);
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member of the Code Aurora Forum, hosted by The Linux Foundation
>
>
