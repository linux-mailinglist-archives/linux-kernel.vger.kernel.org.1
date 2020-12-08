Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F0D2D25ED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgLHIaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:30:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33192 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725927AbgLHIaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:30:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607416131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TjsxQ2FzOW8Vf+JUFyxyrHDPT5g94+5fVImUHems/bg=;
        b=ChoAllp3IenSpA3t2pK1BrF2q3L9Wkb8XtczRn4PQ0c3ek8cJSLXBTXLm64eq99hD2lHMu
        1aTT215YR2bFyQRdg58tIKTHYoKIwdQF4tc4CtQxOKQZXZkdG/at6Hw5lSpoxD7Y1qsMXo
        YMSYl1/mbHjsWSwhoRIhI9ezZFKphys=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-qE97xquSPL-ru67l_GVtUA-1; Tue, 08 Dec 2020 03:28:49 -0500
X-MC-Unique: qE97xquSPL-ru67l_GVtUA-1
Received: by mail-pf1-f198.google.com with SMTP id k17so7426402pfu.21
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 00:28:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TjsxQ2FzOW8Vf+JUFyxyrHDPT5g94+5fVImUHems/bg=;
        b=PNO21T0pZethJR6aeSkNtqOflv74Xxy7ppzq4RkCORvObg4TtTAvaFatGXRsJDk5xT
         Rg+mKY6sZ03ePtMohb4qrJ8n7TvijdOIMV6GXTuhY2UwTQAnSkyHyICj+2xckwP3uD8E
         JaW3WfBSimlmTjfuNQIbNv8q9wLjLt3dFsVfvs4mXe8uiHdYlzFQWPA9tlJ2I65iw0oV
         xbBGs2CWN5obkbNN82GIhGis+dMbl318YkG82luKaIyesXH9hX10s3he7hQbGa22tqYZ
         O25opGpza5fzMnB3u/t8pkBXYpfdA/GoZ29wPr4iPwWTrDVHSIQRjiuYzik4mFvol2B7
         zzvQ==
X-Gm-Message-State: AOAM532SAR3D44KTSUVIEClHKoMr5mjstK5nMB4SQStTh/9/rcIxDOm+
        dR5RdxaEpgS4x2S4lDakGMC+fogtV6Q6xq+k68iIfPOWEJmd5jUUzGLANlkCrwtE0gFiaRxJqYE
        1P/pybt+ymFpSrD9eSULlGf8o
X-Received: by 2002:aa7:9f0f:0:b029:19b:c68f:61cd with SMTP id g15-20020aa79f0f0000b029019bc68f61cdmr19311541pfr.45.1607416128451;
        Tue, 08 Dec 2020 00:28:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyfxiWJVep27zelwlm4PEke2fzHrgHBaLKKZuL5ZDqWxjwE42PCmN/0sqAxIvpULn5YbI4fZA==
X-Received: by 2002:aa7:9f0f:0:b029:19b:c68f:61cd with SMTP id g15-20020aa79f0f0000b029019bc68f61cdmr19311523pfr.45.1607416128200;
        Tue, 08 Dec 2020 00:28:48 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id f92sm2218853pjk.54.2020.12.08.00.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 00:28:47 -0800 (PST)
Date:   Tue, 8 Dec 2020 16:28:37 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2 1/3] erofs: get rid of magical Z_EROFS_MAPPING_STAGING
Message-ID: <20201208082837.GC3006985@xiangao.remote.csb>
References: <20201207012346.2713857-1-hsiangkao@redhat.com>
 <0fc43d3f-9c79-c7a1-6e41-b5b6932fe571@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0fc43d3f-9c79-c7a1-6e41-b5b6932fe571@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 04:15:59PM +0800, Chao Yu wrote:
> On 2020/12/7 9:23, Gao Xiang wrote:

...


> >   }
> > -static inline bool z_erofs_put_stagingpage(struct list_head *pagepool,
> > -					   struct page *page)
> > +static inline bool z_erofs_put_shortlivedpage(struct list_head *pagepool,
> > +					      struct page *page)
> >   {
> > -	if (!z_erofs_page_is_staging(page))
> > +	if (!z_erofs_is_shortlived_page(page))
> >   		return false;
> > -	/* staging pages should not be used by others at the same time */
> > -	if (page_ref_count(page) > 1)
> > +	/* short-lived pages should not be used by others at the same time */
> > +	if (page_ref_count(page) > 1) {
> 
> Does this be a possible case?

Add more words about this.... since EROFS uses rolling decompression (which means
the sliding window is limited (e.g. 64k, but some vendors adjust it to 12k for
example ) even though the uncompressed size is too large (e.g. 128k)), and by
using get_page(), vmap(), and z_erofs_put_shortlivedpage() to free such usage.
Since shortlivedpages won't share with other parallel thread, so it's safe to
just like this to decrease page count (it means how many shared get_page()
before) and recycle to pagepool (on the last reference for later use.)

Thanks,
Gao Xiang

