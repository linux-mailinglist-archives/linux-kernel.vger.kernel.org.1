Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6972D79A4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392580AbgLKPlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391412AbgLKPlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:41:25 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DFEC061794
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 07:40:44 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id q16so9770370edv.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 07:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EYEhmqgMBelT+r3UvsYmm6GV5gehaW4irkf5MJK5PqY=;
        b=eSC7wuVh8qa+mVWnfXaO9dQlrHtO3/aEXpRaX3SHQLSsMEZITngILaZpEc6gFEZ+tU
         Rf/Q6ujYBZFLFj5m89//f32/kztfEBHJQzk1KPL0byYiBa0pdbKpu+IMzwa+FA4tSL2O
         qVwCXmHnIWJoy0ZlFoQUpZTxQ9yxLg+gCMVd+zNbuKsdKFAwXjyEitI1ngkNBp/OVq8x
         gzKpZMyhMdx4E9fk86amdU9GOS0cyxyM65ZXxElY9eZRgMcKFMBp3GN8NyUTpmXF48mk
         fAzWzh/vI1wXEqtEjzNbxFuQwi0wmFEWFouKG5ARMzSRyDdD9QfBVkI8Pjv+Tp2W/bjI
         YAEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EYEhmqgMBelT+r3UvsYmm6GV5gehaW4irkf5MJK5PqY=;
        b=QhDjTSIVENq1m11+vxpOEDKfVUNNzS0MsZqLCKIGQf7Vom+5jw4v74XGymt+1QTCDs
         5a6fhX8fVZ6PWqCOEIvrFH3PoDnwiu1PSqU1AOo5DwJzHe232N90wtjftzz5j5r6wFMR
         OyZBoacLTyn8H9ypg95sFGH1UHtBnl9lNG81NlGTnaDWnB6KuoQNnlZjgNu0RmHmnIeM
         wmtMXk8zO+VUoofsRX9+XL7s5hYPxP0GPwc0JMsAMO5nMAEPBIAV3Stj+J4UlM/klMkr
         0uh4NEOsFEjhtKaJNYuB6b1NKy2ApgZMi2TAhmWWqKA8D7TEr99CbXRLKWlSFl0hEGQJ
         fjqg==
X-Gm-Message-State: AOAM531tdEy7xCrlGoL6bqg2GgikpcVUCaJK52m4SQQsc/GGxQtgFOXH
        D4K8mSw4KwKWozDEHIH8Dv7F4g==
X-Google-Smtp-Source: ABdhPJxHE2IdtUNCOx0bPjb2SxLmU5wnNVe/UoEiscHoKgu4ucw9owJA6iDcNGBT7y3Qyq1Ng9g1MA==
X-Received: by 2002:aa7:cac2:: with SMTP id l2mr12401004edt.141.1607701243402;
        Fri, 11 Dec 2020 07:40:43 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:ee7a])
        by smtp.gmail.com with ESMTPSA id k21sm7032894ejv.80.2020.12.11.07.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 07:40:42 -0800 (PST)
Date:   Fri, 11 Dec 2020 16:38:36 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 2/2] block: no-copy bvec for direct IO
Message-ID: <20201211153836.GA291478@cmpxchg.org>
References: <cover.1607477897.git.asml.silence@gmail.com>
 <51905c4fcb222e14a1d5cb676364c1b4f177f582.1607477897.git.asml.silence@gmail.com>
 <20201209084005.GC21968@infradead.org>
 <20201211140622.GA286014@cmpxchg.org>
 <2404b68a-1569-ce25-c9c4-00d7e42f9e06@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2404b68a-1569-ce25-c9c4-00d7e42f9e06@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 02:20:11PM +0000, Pavel Begunkov wrote:
> On 11/12/2020 14:06, Johannes Weiner wrote:
> > On Wed, Dec 09, 2020 at 08:40:05AM +0000, Christoph Hellwig wrote:
> >>> +	/*
> >>> +	 * In practice groups of pages tend to be accessed/reclaimed/refaulted
> >>> +	 * together. To not go over bvec for those who didn't set BIO_WORKINGSET
> >>> +	 * approximate it by looking at the first page and inducing it to the
> >>> +	 * whole bio
> >>> +	 */
> >>> +	if (unlikely(PageWorkingset(iter->bvec->bv_page)))
> >>> +		bio_set_flag(bio, BIO_WORKINGSET);
> >>
> >> IIRC the feedback was that we do not need to deal with BIO_WORKINGSET
> >> at all for direct I/O.
> > 
> > Yes, this hunk is incorrect. We must not use this flag for direct IO.
> > It's only for paging IO, when you bring in the data at page->mapping +
> > page->index. Otherwise you tell the pressure accounting code that you
> > are paging in a thrashing page, when really you're just reading new
> > data into a page frame that happens to be hot.
> > 
> > (As per the other thread, bio_add_page() currently makes that same
> > mistake for direct IO. I'm fixing that.)
> 
> I have that stuff fixed, it just didn't go into the RFC. That's basically
> removing replacing add_page() with its version without BIO_WORKINGSET
> in bio_iov_iter_get_pages() and all __bio_iov_*_{add,get}_pages() +
> fix up ./fs/direct-io.c. Should cover all direct cases if I didn't miss
> some.

Ah, that's fantastic! Thanks for clarifying.
