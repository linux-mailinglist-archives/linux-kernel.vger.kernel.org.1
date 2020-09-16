Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9100426CD4F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726684AbgIPU5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726490AbgIPQwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600275123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MTHeqxpIT8EXX6m2+ZlNqDXIIS9Amzc0XcLnbyVZ7dQ=;
        b=eY9JxkJCZ6EsNhA51N3RTxGIogGQKDKv5ygCL0WVat9O25xc+XWVE8Jt7LXWQU5ptakq+z
        fzQ6Ndk3NGpzbaU5iJkZcplJt5LFdSJgjpdi0Zsx5qUaWV9rHZnEZ2rpB1LKNtcH21yoKR
        dZOyy09lCHlUHLmkoUsz+nWTxkDEfQg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-A2Al3dyQOPSaDwUYumpPXA-1; Wed, 16 Sep 2020 10:36:59 -0400
X-MC-Unique: A2Al3dyQOPSaDwUYumpPXA-1
Received: by mail-pg1-f199.google.com with SMTP id 78so3963072pgf.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 07:36:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MTHeqxpIT8EXX6m2+ZlNqDXIIS9Amzc0XcLnbyVZ7dQ=;
        b=NlMkSXI4VjvCqXXM9dq8Pn2ot6qV8s2kYR7TW8zVMb2ee/a00eqWaSxwiTgifonmhn
         fX3nhVYmeILH30EVwGJztiAGZE9DXJ6B/3oFAejKwHg4b/ycVRwtRLOqBlBJQLie07Ia
         mPf0kJLQzr8VRM2e168UStEJk8PYpvcpcQvfdmWQV5aE1izRGeu635ulNdtbG+tUlC4v
         wJaqCQulWFnn29NE/ySLa6/edEhSboW/gqEZ1Wa+zSXgfDcEYhQ+UvQDWi0iHB67raLf
         xcDWTTvSwVMYCdu8uiFGUDFdVId/T7BrDHCMdSXIH6Q4yr4iUCVP2KsqG0qwobcteSUg
         5iiA==
X-Gm-Message-State: AOAM531EfIue8xy7cCiDhSlOUUjD3yhfY2sI4dokyTW+pvXgxZpRRfgD
        2FSOvXrGABbHGqaLmRZreXmz8NMhxqJktm2GG6BHc8/ZKrCN81fQsn22ahrBakdpDV8pv1elot4
        pDxVrUTSsylqGZBs87uesJfv0
X-Received: by 2002:a63:4746:: with SMTP id w6mr18998069pgk.412.1600267018014;
        Wed, 16 Sep 2020 07:36:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJydrD4AmJjitwyeWDobFc34EF1rDeWZ1E+AnBFNtqYiQ3U/wMM8WIEa3qQKrM57pGjzqu0/mQ==
X-Received: by 2002:a63:4746:: with SMTP id w6mr18998053pgk.412.1600267017786;
        Wed, 16 Sep 2020 07:36:57 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b29sm15071706pgb.71.2020.09.16.07.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 07:36:57 -0700 (PDT)
Date:   Wed, 16 Sep 2020 22:36:48 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] erofs: remove unneeded parameter
Message-ID: <20200916143648.GA23921@xiangao.remote.csb>
References: <20200916140604.3799-1-chao@kernel.org>
 <20200916143304.GA23176@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916143304.GA23176@xiangao.remote.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 10:33:04PM +0800, Gao Xiang wrote:
> Hi Chao,
> 
> On Wed, Sep 16, 2020 at 10:06:04PM +0800, Chao Yu wrote:
> > From: Chao Yu <yuchao0@huawei.com>
> > 
> > In below call path, no page will be cached into @pagepool list
> > or grabbed from @pagepool list:
> > - z_erofs_readpage
> >  - z_erofs_do_read_page
> >   - preload_compressed_pages
> >   - erofs_allocpage
> > 
> > Let's get rid of this unneeded parameter.
> 
> That would be unneeded after .readahead() is introduced recently
> (so add_to_page_cache_lru() is also moved to mm code), so I agree
> with you on it.

(cont.)

... also it'd be better to add such historical reason to the commit
message... since it was of some use before...

Thanks,
Gao Xiang

