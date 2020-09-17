Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE79026D11A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 04:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgIQC2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 22:28:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25147 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726007AbgIQC2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 22:28:08 -0400
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 22:28:07 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600309686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N4dsBjdtcU4ASBhl61wjASbXtJpfQbVEgyM+D/rYJHU=;
        b=HwCqXXbQkIVkM1xiSclr84fCXTIxGtOvKn+Y3+Xe8M0YNKMKOg9WO1dioFh84BUlgeIkBW
        gd/RI590OLT1WDYeIwyeWn37W+oimJd007Wnra5UGhRxBo09uVgwLeTHPG13+j9tudbH5D
        ZQxblwlNaB169o6iLIQwQZ5GtdeZuW0=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-Hc1AC3oMMdGZvk79EGCzTA-1; Wed, 16 Sep 2020 22:21:22 -0400
X-MC-Unique: Hc1AC3oMMdGZvk79EGCzTA-1
Received: by mail-pg1-f200.google.com with SMTP id r4so484194pgl.20
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 19:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N4dsBjdtcU4ASBhl61wjASbXtJpfQbVEgyM+D/rYJHU=;
        b=WuJpm84GuF1lkXmUEMlpy9jjToi0im4CCdXq2XUp7JMWM/cRxejB7a7tIQNu2B0blY
         Ny1T/Rf0MoVjJ7/F5xhVUEdN2nSYLK9n7II/1LtnVfYVs30AGhDrh9Sa5AC49DKJiLr0
         mPCBVHOAivouYLDT/t19gPG/wfR7O92aoiLKKWCi4q6guMtdQ7S0Lwvd/RLyuZ5dFEYD
         No4xSr/SzKsZEWVtfKfn9NC0SjrihvA2sudaVdrULDcIbAtE6+49+/reMGn5zUXL27Tu
         vmSQDMzY0AQzCQtZ9ZRQW7UpnEjGwHhP/qFIlol8jcNyp7ZoTo5dogN4S5PFnO/0Q38Q
         D8eg==
X-Gm-Message-State: AOAM533bXg5sg5Ye9HVHATaHPPaZtW6LZK1/o3pvA70qSqKRHBM31BeU
        MolkdOWj3/4INihEZGES7hGzyzm5SnCSuTXSRsxVOWBTXdcCsr+WbklNyYVWrZef3yQmPaclITD
        IPVCIp/yup/pGZV3aGC7yGOFm
X-Received: by 2002:aa7:9a90:0:b029:142:2501:39e7 with SMTP id w16-20020aa79a900000b0290142250139e7mr9108786pfi.54.1600309281153;
        Wed, 16 Sep 2020 19:21:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyeaJVz11MtazIIwXq4sTHziPNu0GZHEoeqcQaC+iA9ZRm+rBmogCojJtJL/NsMAtaxH6rGbA==
X-Received: by 2002:aa7:9a90:0:b029:142:2501:39e7 with SMTP id w16-20020aa79a900000b0290142250139e7mr9108776pfi.54.1600309280942;
        Wed, 16 Sep 2020 19:21:20 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id i17sm18191887pfa.2.2020.09.16.19.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 19:21:20 -0700 (PDT)
Date:   Thu, 17 Sep 2020 10:21:10 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        chao@kernel.org
Subject: Re: [PATCH v2] erofs: remove unneeded parameter
Message-ID: <20200917022110.GA18734@xiangao.remote.csb>
References: <20200917011821.22767-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917011821.22767-1-yuchao0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 17, 2020 at 09:18:21AM +0800, Chao Yu wrote:
> After commit 0615090c5044 ("erofs: convert compressed files from
> readpages to readahead"), add_to_page_cache_lru() was moved to mm
> code, so that in below call path, no page will be cached into
> @pagepool list or grabbed from @pagepool list:
> - z_erofs_readpage
>  - z_erofs_do_read_page
>   - preload_compressed_pages
>   - erofs_allocpage
> 
> Let's get rid of this unneeded @pagepool parameter.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@redhat.com>

Will apply it later :)

Thanks,
Gao Xiang

