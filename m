Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECEFF289BBD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 00:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391180AbgJIWZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 18:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390153AbgJIWZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 18:25:12 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FF1C0613D5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 15:25:11 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cv1so5549281qvb.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 15:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8oWWXTJLgz6k0eoay/wZw+xNoGlz9otu+1gTZ3QYQTU=;
        b=JLw9cOIADbCSt30KyPOolp7D8T1ydtcphV5lvGpBdT0H+g77HDzGqjI0IhTwDtshej
         z8W9/A5rl7Fs73WAAOZCMBnYeiPIeODDdOK72bckk1yyjqKzGzJGpGNwVGUB0vRNaqG6
         ap064g18fjDLNTiIERClhqsAS5BC7X7bh6LtPx49QkjIsF0B7Xd4H4eYYxg/AdJF3NbQ
         6Q2Uw/NINPLSaXbo4JkZOxArbxVx5MKT8yoo5U7zqDz0bBWlEov3++WNlmduRS66dQKB
         STAnvBVe/E+zYOop/N5UjYdXTGAqyB9F1cQa/HvHMUIVc87d8UVxGlSEk0HwjL0aOg35
         Angg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8oWWXTJLgz6k0eoay/wZw+xNoGlz9otu+1gTZ3QYQTU=;
        b=QKgWyOofz21oOM8IzyFYEBgrEZfyK53B6l1Vrp/Pw9vZ90YI/S8bkMrJN/xvFKbyQb
         UOPOGII+oAWSW+7HVYmjLC5/A0hpNtb7/bP9A+h5N9aZV9/hGkh0M5l6LwIXwwpfAPpK
         JnPph4OJHw8m/2a0VPB9aD5y8UTy7fvLCYVUxaKJ+0+nhkZaR4FutCfPEPwPwo3BeTnO
         ubxSfKW3liRxdKrHZZkKR7wZZHtfZqxX9viUyLXg8NGom81yfWIQJ5PbD/LU6Wkclh37
         MpblVA1SCErL7YZkkBzUsOpzTvXKPbc8B83sy4g66hAsuEyx9uTG+Hg2VkQ6mwC8P4uW
         xdOQ==
X-Gm-Message-State: AOAM532350PttQkDF4kihP+gYOzEpl1FJQPSY8FNbbPENHnM39GwItCc
        OUmSnDWIQj83LysFzYTa8WgzkA==
X-Google-Smtp-Source: ABdhPJx4KrjLeEug0hrbNvxkGQnKMdvwXI9Ssl/PdIck48j/G9dQSZkfDxN9OyPFgyOzHX6NhQzoFg==
X-Received: by 2002:a0c:9a01:: with SMTP id p1mr14524630qvd.61.1602282310859;
        Fri, 09 Oct 2020 15:25:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id t3sm7141813qtq.24.2020.10.09.15.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 15:25:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kR0p3-002qLD-KY; Fri, 09 Oct 2020 19:25:09 -0300
Date:   Fri, 9 Oct 2020 19:25:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christian =?utf-8?B?S8O2bmln?= <ckoenig.leichtzumerken@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, chris@chris-wilson.co.uk,
        airlied@redhat.com, daniel@ffwll.ch, sumit.semwal@linaro.org,
        willy@infradead.org, jhubbard@nvidia.com,
        Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH 1/6] mm: mmap: fix fput in error path
Message-ID: <20201009222509.GC5177@ziepe.ca>
References: <20201009150342.1979-1-christian.koenig@amd.com>
 <20201009150420.450833e3830b9d39a2385dd9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201009150420.450833e3830b9d39a2385dd9@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 03:04:20PM -0700, Andrew Morton wrote:
> On Fri,  9 Oct 2020 17:03:37 +0200 "Christian König" <ckoenig.leichtzumerken@gmail.com> wrote:
> 
> > Patch "495c10cc1c0c CHROMIUM: dma-buf: restore args..."
> > adds a workaround for a bug in mmap_region.
> > 
> > As the comment states ->mmap() callback can change
> > vma->vm_file and so we might call fput() on the wrong file.
> > 
> > Revert the workaround and proper fix this in mmap_region.
> > 
> 
> Doesn't this patch series address the same thing as
> https://lkml.kernel.org/r/20200916090733.31427-1-linmiaohe@huawei.com?

Same basic issue, looks like both of these patches should be combined
to plug it fully.

Jason 
