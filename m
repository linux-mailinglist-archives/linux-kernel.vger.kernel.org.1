Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4F42ED071
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 14:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbhAGNO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 08:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbhAGNOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 08:14:55 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618FAC0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 05:14:15 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id s26so14391195lfc.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 05:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AHvJg6QqvjaPj1mSyp28+dbtlR3Tg5dXZi0aPRPJJqU=;
        b=JZ8/jgDc57h9ZcGl7zXTJDYsvO8gluNBV3+ERlzg3hFc26OkuZk0Vf+ooO0iDoU4Ab
         0YYzuVa8fSUUvRgh3eTIT/OcRvIVs0tb5XRsVlvu05dtmdCYldjHU+NLBU5UMjWnjHuq
         Z0yICaEy0dslu/wMb+JFpvZZHvDFOwX+KfOQHuyE2seHe2mrf4rbDvSMz3dq5uaQysUF
         9OuPsgyPtAGV6c45ssT+zIqnQM9fK7huaiNXLN7uVUVpfzeC12tC7k67zvb9OWRRUhbC
         1mcR/Cmeqp6SnnslTP1f+pNx7kT5Fh7gBct2y5Ma8GVmadg+0F5vjSr/KNQ/RdzkKJNM
         tN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AHvJg6QqvjaPj1mSyp28+dbtlR3Tg5dXZi0aPRPJJqU=;
        b=bHbt07inPb07SKzJZKUC41J6i4eyDBEoeiGG5lCALoZzk6GPSQGflhgsZqsbRjVjP+
         PxZ136Rgq8x0FNhFeLuWbaPmkWlz13SWLZfl11FMpMRQrRjaHbDMU5mASdGyOCA2/PN5
         O4zRsqjIBFP9iiaNhBahEevDbi4mwNIniECWa+nPp0KM6hQE25bA5TNgVl/CgaJulFpu
         /grNT9qm6zqFrWtq8qHhCNhn2Mrb2tKYNrYRIvUmuhcWKCTyny2IPYnpdj9QH/Fh0Bx6
         voH9df26RiAqri6i6/eo1kmdWNvszAjbdt3ZisA4OcnGVeSa6g8IjrJJhGx+5DkSU8nY
         xsHQ==
X-Gm-Message-State: AOAM53320XUy6oadrz5+LWhax8B8ZxokRAw8codEpiIOfuyjjyqFTePh
        ya7ur1VL6QY1Rezgpvt7zaM=
X-Google-Smtp-Source: ABdhPJypDX4qQRQnRCFCBmkkU3c/mja1O9HyE71esy2cCfWxv297MbiYRHwNWYIGdPP3hdDc6hn7Mw==
X-Received: by 2002:a05:651c:cb:: with SMTP id 11mr3934754ljr.509.1610025253853;
        Thu, 07 Jan 2021 05:14:13 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id f15sm1152747lfc.10.2021.01.07.05.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 05:14:13 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Thu, 7 Jan 2021 14:14:11 +0100
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc.c: Fix potential memory leak
Message-ID: <20210107131411.GA2053@pc638.lan>
References: <20210107123541.39206-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107123541.39206-1-linmiaohe@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In VM_MAP_PUT_PAGES case, we should put pages and free array in vfree. But
> we missed to set area->nr_pages in vmap(). So we would failed to put pages
> in __vunmap() because area->nr_pages = 0.
> 
> Fixes: b944afc9d64d ("mm: add a VM_MAP_PUT_PAGES flag for vmap")
> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/vmalloc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6507a579ff88..8ab83fbecadd 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2421,8 +2421,10 @@ void *vmap(struct page **pages, unsigned int count,
>  		return NULL;
>  	}
>  
> -	if (flags & VM_MAP_PUT_PAGES)
> +	if (flags & VM_MAP_PUT_PAGES) {
>  		area->pages = pages;
> +		area->nr_pages = count;
> +	}
>  	return area->addr;
>  }
>  EXPORT_SYMBOL(vmap);
> -- 
> 2.19.1
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Vlad Rezki
