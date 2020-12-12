Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F632D8730
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 16:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439218AbgLLPFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 10:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLLPFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 10:05:03 -0500
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46263C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 07:04:23 -0800 (PST)
Received: by mail-ua1-x943.google.com with SMTP id y25so375382uaq.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 07:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SIHzE5eZs0KEPIpA5NjA8gcyQH1GGVp3OBB3oHCA74I=;
        b=DdbKMEVoZM5chftjfT/Gg/v7/+prBBJwpUGNi0GoSQ0iGWDleq3JzUspdcNXMfmyNP
         nJa3dZEmhIlOzVlhvNVJ9JNvDKyO7dsFaoOQhSasJEYU9FBPJgBqEHZPCM8NZbl+DIve
         Lcc3DsGRnrXhC/9emS/r4BVPvml2czXEu3kdlitwLzcD6MK3FBH5ZpvDwejgEFmYLS2o
         YL4g1dd/aco/hAoQ6ieCe4jPuSVVK55pJo1CHuebA85UsC6CZz2ycF5vPajYYADHisuI
         VDxDsXHj8bAP+14YVKaVVeEXuR7wUj762LvLQNyFstx4GUWXpCcEE9pmD1QZqLdMjiNl
         14FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SIHzE5eZs0KEPIpA5NjA8gcyQH1GGVp3OBB3oHCA74I=;
        b=fQZ2EY0cFs82OCkpjE2IBoZPuhcULGeSIhtKdPi+seGrx5eKfeN5OUQ+U4qOHbTCmu
         iWFqgWSF8H/XOgW5XrCnS6cJt6SnDf0BPFQeb3ptB2c4U/4x1cj2+bvzVIzwBPa20L2u
         fhygaKsJMc7aa9ZZfai+z7bHifCRInkSl/SsJinzbnLwMSOZp97O8zlCQhEy0v9FTyoZ
         61OnrXIkvjomTSVf8Khf7FWVoWZD2kkBZGnyDozN9EUpBuls/BQG/R4wwMvY1EVIcZS5
         J881qdX2xcahbAFEOPv91oU0PPRpaXvl7yLw8N95W8MtkWZtPHPbcjh2WNP0tSMBQHeF
         WXOA==
X-Gm-Message-State: AOAM531HtsUdDAk6DtezwF36zXyHzSGVqylg8PCI/sdNtkRxHfu9cBy1
        L9g4n58mAvvO90wPHORQYjjGR8tTJUyQMuWmNFMG3l35By8=
X-Google-Smtp-Source: ABdhPJzjAFglavIb7bKPJX7qn/3frrTPgtwDxYblpSvg5JtOKVCA5lXvXlWAa7FDjUQv8L0aGabGeEFa4YHDTHT6D54=
X-Received: by 2002:ab0:127:: with SMTP id 36mr16109011uak.118.1607785461751;
 Sat, 12 Dec 2020 07:04:21 -0800 (PST)
MIME-Version: 1.0
References: <20201211150157.91399-1-ldufour@linux.ibm.com>
In-Reply-To: <20201211150157.91399-1-ldufour@linux.ibm.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 12 Dec 2020 20:34:10 +0530
Message-ID: <CAFqt6zbpWyaJmTGjXcHzdU8+Vow=Kawe6K=UGb4zW0sJJ0LKmg@mail.gmail.com>
Subject: Re: [PATCH] mm/memory_hotplug: quieting offline operation
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        nathanl@linux.ibm.com, cheloha@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 8:32 PM Laurent Dufour <ldufour@linux.ibm.com> wrote:
>
> On PowerPC, when dymically removing memory from a system we can see in the console a
> lot of messages like this:
> [  186.575389] Offlined Pages 4096

Is it specific to PowerPC ?

>
> This message is displayed on each LMB (256MB) removed, which means that we
> removing 1TB of memory, this message is displayed 4096 times.
>
> Moving it to DEBUG to not flood the console.
>
> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
> ---
>  mm/memory_hotplug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index b44d4c7ba73b..c47a53a16782 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1587,7 +1587,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
>
>         /* Mark all sections offline and remove free pages from the buddy. */
>         __offline_isolated_pages(start_pfn, end_pfn);
> -       pr_info("Offlined Pages %ld\n", nr_pages);
> +       pr_debug("Offlined Pages %ld\n", nr_pages);
>
>         /*
>          * The memory sections are marked offline, and the pageblock flags
> --
> 2.29.2
>
>
