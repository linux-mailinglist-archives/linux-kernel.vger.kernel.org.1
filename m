Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1F126CC96
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgIPUqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgIPRB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:01:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1940FC006938
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 07:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0sirvuqazzshCbZE24EWceX5REl9RxuudL9lwx7DoI8=; b=Ic68Vg7iyk7XWdoCFOawJ0CNKp
        ZBJRI2EhsHoaSgmtHmVarEKFFat/VArg8kjPcBj7hxHQkOTJv1WZXOkILeYWjd/Kxwc0Jo1rViaZh
        bEIui5SolkKPEmzfMjzkH+kuiF07ugy1sIDdWgl0oAUD0k9IwHsf0C9al2CcEUcNQQZIhD8BpZGx5
        Ukfphf342knAcSRXLw69kpJWU56h/tWDbgUJHCElCEgSvBgvqj4a8Ldazy1wYXioiv7ngoC/s2nd6
        WssGZgS1W7QHgSkn8WjEp49/qyK4vzXpqoLoO2sLFUoJzcdpsLzRCidJVZAySVJFp8oAZd95g04j6
        m0lW+mLA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIY3w-0002D6-OJ; Wed, 16 Sep 2020 14:05:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44BC33006D0;
        Wed, 16 Sep 2020 16:05:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 33BED2B9285F4; Wed, 16 Sep 2020 16:05:32 +0200 (CEST)
Date:   Wed, 16 Sep 2020 16:05:32 +0200
From:   peterz@infradead.org
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Wade Mealing <wmealing@redhat.com>
Subject: Re: [PATCHv2] perf: Fix race in perf_mmap_close function
Message-ID: <20200916140532.GA1362448@hirez.programming.kicks-ass.net>
References: <20200910104153.1672460-1-jolsa@kernel.org>
 <CAM9d7cjqq8+wcZWJ77oONKXu-FsaT_YvRxzaGbRT8PjLOw-AkQ@mail.gmail.com>
 <20200910144744.GA1663813@krava>
 <CAM9d7ciEAA_3Quo1-q7hU=Te+hBgJ2wYAjbDazXd7yS70HrhPA@mail.gmail.com>
 <20200911074931.GA1714160@krava>
 <CAM9d7cicyzZvkrXTvSrGrOE626==myvF2hnuUNiUoLXiOKHB+A@mail.gmail.com>
 <20200914205936.GD1714160@krava>
 <alpine.LRH.2.20.2009151734230.12057@Diego>
 <20200916115311.GE2301783@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916115311.GE2301783@krava>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 01:53:11PM +0200, Jiri Olsa wrote:
> There's a possible race in perf_mmap_close when checking ring buffer's
> mmap_count refcount value. The problem is that the mmap_count check is
> not atomic because we call atomic_dec and atomic_read separately.
> 
>   perf_mmap_close:
>   ...
>    atomic_dec(&rb->mmap_count);
>    ...
>    if (atomic_read(&rb->mmap_count))
>       goto out_put;
> 
>    <ring buffer detach>
>    free_uid
> 
> out_put:
>   ring_buffer_put(rb); /* could be last */
> 
> The race can happen when we have two (or more) events sharing same ring
> buffer and they go through atomic_dec and then they both see 0 as refcount
> value later in atomic_read. Then both will go on and execute code which
> is meant to be run just once.

The trival case should be protected by mmap_sem, we call vm_ops->close()
with mmap_sem held for writing IIRC. But yes, I think it's possible to
construct a failure here.
