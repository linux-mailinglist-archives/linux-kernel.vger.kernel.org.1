Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7D127B813
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 01:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgI1X2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 19:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgI1X2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 19:28:43 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D910C0613BB
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 15:51:09 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 16so2653878qkf.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 15:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zk6QeUcgtam/NrYdrxcTVrrfoEM22yAdB2MDn+QseZc=;
        b=T1rlAS1y7bUNEdJ+nZMfUdxNk5/54+ZHcKNUbTcPpn2OhR4AIs+LInzPhVoZISJQ8P
         NeFKBpqS7p1LjpTgplZ85ly7sBcPoSJkoxkD/fKJgmFJbMld2HSBpsqjD1RzDw6MpuUc
         6rKpqK8/JNLpCUctsqwoyA3impUNNQrceSBXdYVaAinFdfn4ziwFI7egHcxuX42Pu+XE
         AWSq+4d31HkJ64EkwLfrNZB0l2If1y9dyQqmwnVVQg2oPoe22Etx5aaI0JPckjnwu8fm
         bX3KpCsDrHtqelCtrZMXs+Xm0dy0dkxggkL+b5VJ2+GYXG6wUiMYwkA4PlSE3ihR6qn1
         OUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zk6QeUcgtam/NrYdrxcTVrrfoEM22yAdB2MDn+QseZc=;
        b=Ap2NAude9uvTLD8/8oeEz2OsahJXPqEEwdmn2Kuowy0t+yZuJKE8jxueBACAhLkWOk
         LqVJF7OX2DG3sIaqVvuQSRxXbHzBoJr2qlyioosL0SE5mUa23hE5gMG8Xm+3+2zigY80
         Wclygbq0/QXy2ebEOAUZhvgcp9sATE+i0Ww4M7kKykxOgSxTIBcA+IwgoV/GaT8JFlha
         Ay5QwYST3Oa4SJGoQNGtyu7rnSn+7HhkGVWVo91XLWH4rX0XqZrO+C93mhWxUkdHISzf
         qPZxTMJGC3QhzxmmmflSsN7gxA865rsF3Q7fJ4Oz0FtSNtI+RBM/HXzPsq35Jhm3TdOM
         2hrQ==
X-Gm-Message-State: AOAM530rUsgpOAzSLdtIFnGqxHvNkrNgP/Su8DGBr4UxIo7lcKEjpVBe
        hT8DdmB3VIboPBB95sznCBrS4g==
X-Google-Smtp-Source: ABdhPJya02yfbEyO9CXfLe2ET4P9ghh8QUvYaMGrtYJ7Boaulx3pzHUbx+YRCR8CBn3K01acS/8+7g==
X-Received: by 2002:a37:9c86:: with SMTP id f128mr1796171qke.30.1601333468459;
        Mon, 28 Sep 2020 15:51:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id f24sm2404196qka.5.2020.09.28.15.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 15:51:07 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kN1z9-002aKX-1d; Mon, 28 Sep 2020 19:51:07 -0300
Date:   Mon, 28 Sep 2020 19:51:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Leon Romanovsky <leonro@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200928225107.GT9916@ziepe.ca>
References: <20200927062337.GE2280698@unreal>
 <CAHk-=winqSOFsdn1ntYL13s2UuhpQQ9+GRvjWth3sA5APY4Wwg@mail.gmail.com>
 <CAHk-=wj61s30pt8POVtKYVamYTh6h=7-_ser2Hx9sEjqeACkDA@mail.gmail.com>
 <20200928124937.GN9916@ziepe.ca>
 <CAHk-=wj6aTsqq6BAUci-NYJ3b-EkDwVgz_NvW_kW8KBqGocouQ@mail.gmail.com>
 <20200928172256.GB59869@xz-x1>
 <CAHk-=wi=iCnYCARbPGjkVJu9eyYeZ13N64tZYLdOB8CP5Q_PLw@mail.gmail.com>
 <20200928183928.GR9916@ziepe.ca>
 <CAHk-=wgu+6Cx_=U1Vh4Fzm97JA1k76fS905uEAVK-2eJ_1KukQ@mail.gmail.com>
 <CAHk-=wiWr+gO0Ro4LvnJBMs90OiePNyrE3E+pJvc9PzdBShdmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiWr+gO0Ro4LvnJBMs90OiePNyrE3E+pJvc9PzdBShdmw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 12:50:03PM -0700, Linus Torvalds wrote:

> But the more I look at this code, the more I go "ok, I want somebody
> to actually test this with the rdma case".

I suspect it will be OK as our immediate test suite that touches this
will be using malloc memory.

It seems some mmap trick will be needed to get higher map counts?

> So I'll attach my suggested patch, but I won't actually commit it. I'd
> really like to have this tested, possibly _together_ with the sequence
> count addition..

Ok, we will do this once the holidays are over. If Peter doesn't take
it I can look at the seqcount too.

Thanks,
Jason
