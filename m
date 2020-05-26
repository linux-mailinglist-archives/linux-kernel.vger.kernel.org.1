Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FCE1AD3BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 02:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728270AbgDQAqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 20:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726627AbgDQAqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 20:46:07 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55464C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 17:46:06 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id y185so165535vsy.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 17:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jgottula-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=98QNDXNNi1/b9nh1s56044uMzWepsdxzuM+zy1ZjRxU=;
        b=nFkxDEP5t02hVcrnliNnd9dc1y+GiLs22EKy+tLyO3fXH9tBa+cKxVG6bsGHJBqEUl
         cs2UXX2VTUu7edfBFqgeSbwbmg+sryNav/F9LImOfjwz9sruHXCb9abixx9cdvUZAqAb
         CdhCfHgyRm4asocPeYGS3RdX0j/kSN57fjamUpFinPwCVhasHt7uXH1JBgb1V+2RGel6
         1iztnj+WMRqGnL27F8Z7VlBQBK4UDqzbbQOvWbYpoKwpEQedyO6Jg3Bpn2wbhglY+Zbp
         Kh3FGd981CMRmk7rjc/JUHpdcgd/zoW1cwN3issixl0BtDdNGFZ3bkUqeh+by79V+RkS
         0ABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=98QNDXNNi1/b9nh1s56044uMzWepsdxzuM+zy1ZjRxU=;
        b=WQe4z1NDyhTghYdrfLRwbOuvUBO72LxLzne78xJS8yWnZPeOFJzLovWJOMLNAfKSqC
         mE34Wt1RUkRNaA09a9DNNOxjEe8t5x5mLCv36U9ReQSA/u3H3/UM5LrUBb5Vo7oiEnhG
         Fdbz33IM2RinHMLKPZBIx0EOjj+uqsjo+DUdhx+B9+xdxA+aPVpQqUf8IP7JmRWHmELs
         4EbqInqqDxoKoZJAzi+PWU0YsjZQtD/teJzNPB9y9yqkNsJya2G8o3bY0yieBFsSlO+e
         8e2U/Nz7AFIQmUNiZo9nbogjbg8cp8AQR4cvQuZmF+qN2o0qB2c9KEqhRDVKD5OnM9LU
         +xyg==
X-Gm-Message-State: AGi0PuZZaAcIU6kwyFcKF3zAINvOla4epZmTjcaEUGZYctJy0ptxPvYv
        FdrnR+7mI1c6+NQjJQ9kdGfii89ZLdxtu/T0WINZpA==
X-Google-Smtp-Source: APiQypJT/nzaZl1RZrciK4UlldYYOjXJrnUG6cC4F7AkHx8huVmh54MdmiFbcbxJAC44wxDaul2Ok4UZA5L7skkhW6k=
X-Received: by 2002:a67:7d10:: with SMTP id y16mr318990vsc.23.1587084365254;
 Thu, 16 Apr 2020 17:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAKuMfTUPzPjuNk+T_GQMCKoB9ssh2arr6xRiu6VODwwB0PMdZw@mail.gmail.com>
 <20200416214649.GA60148@google.com>
In-Reply-To: <20200416214649.GA60148@google.com>
From:   Justin Gottula <justin@jgottula.com>
Date:   Thu, 16 Apr 2020 17:45:31 -0700
Message-ID: <CAKuMfTVpaetB0qQ_hm8cSowtZN8HUKXdADWhKXC=4eKd1i5oSw@mail.gmail.com>
Subject: Re: [PATCH] zram: fix writeback_store returning zero in most situations
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 2:47 PM Minchan Kim <minchan@kernel.org> wrote:
> I couldn't remember why I wanted to do continue even though we knew
> the write was failure from the beginning.
>
> Couldn't we just bail out whenever we encounter the error?
> Sergey, Justin, what do you think?
>
> IMO, it would be more consistent with other error handling.

As far as being consistent with the rest of the error handling in the
loop, I think there's a reasonable distinction that can be drawn between
some of the error cases and others. With some, breaking out immediately is
obviously the correct action; but with others, it's not as clear-cut.

For the zram->wb_limit_enable && !zram->bd_wb_limit case, breaking out of
the loop and immediately returning makes complete sense: once we've hit
the writeback limit, there's nothing that could happen in future loop
iterations that could cause us to somehow _not_ be at the limit anymore.
So there's no reason to continue the loop.

Similarly, for the alloc_block_bdev(zram) failure case, breaking out of
the loop and immediately returning also makes complete sense: if we've
already run out of blocks on the backing device, then continuing to loop
isn't going to result in is somehow ending up with more backing device
blocks available. So there's no reason to continue the loop in that case
either.

With the zram_bvec_read and submit_bio_wait failure cases, though, it's
not nearly as clear that a failure on the current slot _automatically_
guarantees that all future slots would also have errors. For example, in
the zram_bvec_read failure case, it's entirely possible that the
decompression code in the currently-used compression backend might have
had a problem with the current buffer; but that doesn't necessarily seem
like a clear-cut indication that the same decompression error would
definitely happen on later iterations of the loop: in fact, many of the
later slots could very well be ZRAM_HUGE or ZRAM_SAME, and so they would
avoid that type of error entirely. And in the submit_bio_wait failure
case, it's also conceivable that the backing device may have had some sort
of write error with the current block and data buffer, but that the same
error might not happen again on future iterations of the loop when writing
a different buffer to potentially an entirely different block. (Especially
if the backing device happens to be using some kind of complicated driver,
like one of the weirder LVM/device-mapper backends or a network block
device.)

So, at least when it comes to "are these particular failure cases the kind
where it would certainly make no sense to continue with future loop
iterations because we would definitely have the same failures then too",
there's a reasonable argument that the zram_bvec_read and submit_bio_wait
error cases don't necessarily fit that logic and so potentially shouldn't
immediately break and return.

A couple of other considerations came to mind while thinking about this:

1. From the standpoint of the user, what should they reasonably be
expecting to happen when writing "huge"/"idle" to the writeback file? A
best-effort attempt at doing all possible block writebacks (of the
requested type) that can possibly be successfully accomplished? Or,
writeback of only as many blocks as can be done until a (possibly
transient or not-applicable-to-all-blocks) error pops up, and then
stopping at that point? I tend to think that the former makes a bit more
sense, but I don't know for sure if it's the definite Right Answer.

2. There is a bit of a predicament with the keep-going-even-if-an-error-
happened approach. There could be multiple submit_bio_wait failures (e.g.
due to a few blocks that couldn't be written-back due to transient write
errors on the backing device), each with their own error return value; but
we can only return one error code from writeback_store. So how do we even
communicate a multiple-errors-happened situation to the user properly? My
patch, as originally written, would give the user an errno corresponding
to the last submit_bio_wait failure to happen; but of course that leaves
out any other error codes that may have also come up on prior write
attempts that failed (and those failures could have been for different
reasons). And then also, it's entirely possible that submit_bio_wait may
return -EIO or -ENOSPC or -ENOMEM, which would be ambiguous with the other
meanings of those error codes from the writeback_store function itself
(-EIO for WB limit, -ENOSPC for no free blocks on backing device, -ENOMEM
if couldn't allocate the temporary page).

As for the main issue of whether or not to break out of the loop in the
event of a backing device write error, I think it probably makes more
sense not to break out. But it could probably be argued either way.
