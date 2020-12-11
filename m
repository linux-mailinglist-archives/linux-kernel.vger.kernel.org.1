Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA7C2D7777
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 15:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391777AbgLKOJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 09:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390916AbgLKOJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 09:09:37 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E11C061793
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:08:56 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id a16so12506882ejj.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aF3Mh+MA2q+ZpkL8xg5nd4+KjM1FTv7S2GkjkszOwBM=;
        b=i6YXb/kx1K+ZBNheDvASX0oKCecbflSu+fyZ2fjKhwHBwFR4vTEmwXKgPT0qc764hc
         qewaFUeRaEtQMg4y/IoQVBFWvYZgkKHgyPd0hX4njbbbc7ZIqLfu5zOpaeWkQf9WL/YY
         gK4YXTSVzLt6ykV4YXpOlzQE2kLyT/GEE8ZicFgOtOByVhSdmNRn25qGctI7sVs67bMM
         g71vZ5z1eKErNtAJkJsFWO6CAtctbdgFlqO3i2yYIu2B89QgS0bwMVUcc7u83MGSWI/p
         irIp0IQm6+JQBAc2JE7Gcyj+oiIYQTctJxugvD6aHDhN70KKyCr4Vg/HLjfLLlUIbrcR
         cO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aF3Mh+MA2q+ZpkL8xg5nd4+KjM1FTv7S2GkjkszOwBM=;
        b=I6j8YmnW2gpJzR1mHxbSNdYYR3VY0jheBp2RsihpEoCwBTeX+fI9Cw1rBcE0VuuNdV
         x4rK8aVnF/F8+cz2ODZzuKtyLsxikEJKj+rE3v8CKz76tYTRBNqiY/L3SIxfvYhP23tT
         muwjjnPuG1bDYSbhNogBfDgrVQKufDPNA+JxhcdUN6WgBan2XlPWRPcIq8OKSH50GUyI
         /su8FaTtJZEGABSjI9rry2W+iUiQ3CsBrwEkaIFBd8f3sYdYBlYwpeO59cOxWX6K7lKx
         OLLOSR15j3GNMZ1dIjZp7EOaK2p9sYfV36JXxhXSLvp9iIAXENC0CKyXluBWL6J2bsbB
         TQ6A==
X-Gm-Message-State: AOAM5334j5C7U6oGW5Ttu9YawX1l0RjwsySygd0z9qVAH5KxchXH54kH
        jFYjK7SjrBPwfUDY7FQ9mOe5iQ==
X-Google-Smtp-Source: ABdhPJyMudGT3oM0ZWZIivI28u4XfQD8nzeth0kSRM1OzeZjoSv9S67hiN2S0oEkgM7dAVinTklXtQ==
X-Received: by 2002:a17:906:a244:: with SMTP id bi4mr11127201ejb.59.1607695735452;
        Fri, 11 Dec 2020 06:08:55 -0800 (PST)
Received: from localhost ([2620:10d:c093:400::5:ee7a])
        by smtp.gmail.com with ESMTPSA id rs27sm7106637ejb.21.2020.12.11.06.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 06:08:38 -0800 (PST)
Date:   Fri, 11 Dec 2020 15:06:22 +0100
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH 2/2] block: no-copy bvec for direct IO
Message-ID: <20201211140622.GA286014@cmpxchg.org>
References: <cover.1607477897.git.asml.silence@gmail.com>
 <51905c4fcb222e14a1d5cb676364c1b4f177f582.1607477897.git.asml.silence@gmail.com>
 <20201209084005.GC21968@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209084005.GC21968@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 08:40:05AM +0000, Christoph Hellwig wrote:
> > +	/*
> > +	 * In practice groups of pages tend to be accessed/reclaimed/refaulted
> > +	 * together. To not go over bvec for those who didn't set BIO_WORKINGSET
> > +	 * approximate it by looking at the first page and inducing it to the
> > +	 * whole bio
> > +	 */
> > +	if (unlikely(PageWorkingset(iter->bvec->bv_page)))
> > +		bio_set_flag(bio, BIO_WORKINGSET);
> 
> IIRC the feedback was that we do not need to deal with BIO_WORKINGSET
> at all for direct I/O.

Yes, this hunk is incorrect. We must not use this flag for direct IO.
It's only for paging IO, when you bring in the data at page->mapping +
page->index. Otherwise you tell the pressure accounting code that you
are paging in a thrashing page, when really you're just reading new
data into a page frame that happens to be hot.

(As per the other thread, bio_add_page() currently makes that same
mistake for direct IO. I'm fixing that.)
