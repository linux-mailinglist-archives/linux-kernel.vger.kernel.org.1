Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A982F1870
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387882AbhAKOjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbhAKOjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:39:47 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7049DC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:39:07 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id m23so18116470ioy.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7Ff3/GSz0mDP53UZ3T0QGRCfO7riuClvIlABMtVajPk=;
        b=inW1dDnetuqja+9mHz3m2TD0WEbZabWqOxG698JoybfYr524YxgBstuIE+/Db6X0xo
         g/m8/lxB43q0Zmd9iYr17sqVH99pkqEtQ4Vs1KAuwDb1xhCmvOxn4To85Bv5HMp96ui3
         oeyj37C2/mVSrqCNDOud8PM9HWMK1Oq3020sGSA+i31XpQoq/4S+R/4UXnNFQ8B9HvZy
         5LhTeE3AJsigE37XN6sMDBw4qKke1WtFG20EiCp9XGcGkjQVvM0/OKzAN91u9qUJif6k
         ETm39Lwzlc/QdlAB2yEvzkFsuLpakkAhb10Q5lLwZrxXE7y8IU2eMZBgRsj++8AeJ339
         a7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7Ff3/GSz0mDP53UZ3T0QGRCfO7riuClvIlABMtVajPk=;
        b=WnIQUUjhlF3rUW5XRRM68X5nqiUG60TVJsyOWWO9Rw7HnYjDCh2PiHTdJ2Pe2sR4KB
         JNjF/zyC/vW2bVIgL3LezPXq9fDRZp0Xam3fWXnAYpEb36W3fpBc4z5gq7DJfwoXgQbD
         Vzh32sSikz0oGyQLQuowRJxtGXAf1TsgSx5PKB1glhOKVFrgu7zuxxuqPmUdu3C7MpFC
         8sgdqiZ3YD8eezIDw/NOCPZgI57M7DQXJWRpQsg3eiHZUtXIOjIMfu/J8HsLJPmGsTIJ
         KSSgwGqDicTfxWHdcBll/QVBP1z+Rh8NbME8mhQ3Ubf+7YivXde6dfWTOAoFUIp+P8Xm
         Y3eQ==
X-Gm-Message-State: AOAM531sijHQX4WxJSZx8HvyYonxMKT4wY5MJRICMjq/12t/M/Q6dxc5
        VlxkvGdNsbM8UcZg+DzXi1bz6Q==
X-Google-Smtp-Source: ABdhPJxf15ocI9P3XR4J51G1f7eg48SV9hJ5+LCEM96Gu0bdOr/8qyQbWCmzfLMkw+O+2XQ8RhWuBw==
X-Received: by 2002:a05:6602:59e:: with SMTP id v30mr14472695iox.37.1610375946838;
        Mon, 11 Jan 2021 06:39:06 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id y5sm15175749ilj.35.2021.01.11.06.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:39:06 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kyyLZ-005WNx-O1; Mon, 11 Jan 2021 10:39:05 -0400
Date:   Mon, 11 Jan 2021 10:39:05 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
Message-ID: <20210111143905.GJ504133@ziepe.ca>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
 <20210107202525.GD504133@ziepe.ca>
 <X/eA/f1r5GXvcRWH@redhat.com>
 <20210108133649.GE504133@ziepe.ca>
 <X/iPtCktcQHwuK5T@redhat.com>
 <20210109034958.6928-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109034958.6928-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 09, 2021 at 11:49:58AM +0800, Hillf Danton wrote:
> On Fri, 8 Jan 2021 14:19:45 -0400 Jason Gunthorpe wrote:
> > 
> > What I was trying to explain below, is I think we agreed that a page
> > under active FOLL_LONGTERM pin *can not* be write protected.
> > 
> > Establishing the FOLL_LONGTERM pin (for read or write) must *always*
> > break the write protection and the VM *cannot* later establish a new
> > write protection on that page while the pin is active.
> > 
> > Indeed, it is complete nonsense to try and write protect a page that
> > has active DMA write activity! Changing the CPU page protection bits
> > will not stop any DMA! Doing so will inevitably become a security
> > problem with an attack similar to what you described.
> > 
> > So this is what was done during fork() - fork will no longer write
> > protect pages under FOLL_LONGTERM to make them COWable, instead it
> > will copy them at fork time.
> 
> Is it, in a step forward, unlikely for DMA write activity to happen
> during page copy at fork?

I'm not sure it matters, it is not that much different than CPU write
activity concurrent to fork(). fork() will capture some point in time
- if the application cares that this data is coherent during fork()
then it has to deliberately cause coherence somehow.

DMA just has fewer options for the application to create the coherency
because of data tearing during the page copy.

Jason
