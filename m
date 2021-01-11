Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B3B2F1E81
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390672AbhAKTE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390620AbhAKTE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:04:27 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D457C061795
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:03:47 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id m12so1096300lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kPTtQzuom5Awb0GxiDKd05xSwBAc8AF72bAoBes2ggE=;
        b=H2kU5UYMYcLQgzHllGugRqyIESmcF7I3idrXTq24h4uCLEVVDpGBmLxGmD8+GhSnGF
         m3sQWed5AyIGadPjSXqHFAF5DYRLez2ICQqJFYKb2qGv5VvYWGCJMpJiiR9pFThDDPpR
         3/cFpiZY2VRv3AnOfbFvv16B9MBZPaZxXw1C0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPTtQzuom5Awb0GxiDKd05xSwBAc8AF72bAoBes2ggE=;
        b=NY4kHHjKv64B+Ssp5JxpkoPRzUFMgVDeelZc95U5UKtZDiBCVug4mA3NS4RuI579Ys
         U1jk8OQ3zbOPuPxDmHVzp1k4GXgDqFhPd13wKX6oTcViiNvOjLJ4A8Vj5NVFSRfa+NuZ
         7N6ew+IXP8XbSbXw9RMjkUFcg3IHmGlHn53u9DXlRH/9U3JQOBU9KdpDaPGixuyeyZnz
         3Catx7Db9AlFlnbzrVXvGtNYxzcG203ZjuRkSb9ldg6t2QK45Ecen3F2yUBEPzmFG2rq
         YPZHYgDzOlQKB1k1PCuFKKmvN21qJkc3BD6BGY5o2OkY/2AJWBtQ+fhL5FZTi8s4ubH0
         UddQ==
X-Gm-Message-State: AOAM533nM++7L0Dneo4L7fYbPCdP9iNMCqXIUpbCDc1Hc1f1g2VEd1+s
        Fo/rHC80SLoCZLm8Yp0zNQ6E1XEpLYXLug==
X-Google-Smtp-Source: ABdhPJyEg03Tzlq7WyZcKA8CGogYF5pi/iZol5YJybSraJ+bbf+hARb8RqQs/4apQHBzbGghQH17og==
X-Received: by 2002:a19:7109:: with SMTP id m9mr397302lfc.351.1610391825037;
        Mon, 11 Jan 2021 11:03:45 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id a10sm81593lfs.18.2021.01.11.11.03.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 11:03:44 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id f11so66087ljm.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:03:43 -0800 (PST)
X-Received: by 2002:a2e:8995:: with SMTP id c21mr368315lji.251.1610391823175;
 Mon, 11 Jan 2021 11:03:43 -0800 (PST)
MIME-Version: 1.0
References: <20210111130048.499958175@linuxfoundation.org> <20210111130053.764396270@linuxfoundation.org>
 <alpine.LSU.2.11.2101110947280.1731@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2101110947280.1731@eggly.anvils>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jan 2021 11:03:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=whj+ixuJ7+_h42CRssvsuzHaMsYf-2LjYBaM4dRax7cyQ@mail.gmail.com>
Message-ID: <CAHk-=whj+ixuJ7+_h42CRssvsuzHaMsYf-2LjYBaM4dRax7cyQ@mail.gmail.com>
Subject: Re: [PATCH 5.10 109/145] mm: make wait_on_page_writeback() wait for
 multiple pending writebacks
To:     Hugh Dickins <hughd@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        syzbot <syzbot+2fc0712f8f8b8b8fa0ef@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 9:55 AM Hugh Dickins <hughd@google.com> wrote:
>
> I think it's too early to push this one through to stable:
> Linus mentioned on Friday that Michael Larabel of Phoronix
> has observed a performance regression from this commit.

That turned out to be a red herring. Yes, Michael saw a performance
regression on some machines, but the change to go back to the old
model (where the repeat was basically at wakeup time rather than in
the waiter) didn't actually make any difference.

And the issue only showed on a couple of machines, and only with
certain configurations (ie apparently switching to the performance
governor made it go away).

So it seems to have been some modal behavior about random timing
(possibly just interaction with cpufreq) rather than a real
regression.

I think the real issue is simply that some loads are very sensitive to
the exact writeback timing patterns. And I think we're making things
worse by having some of the patterns be very non-deterministic indeed.

For example, long before we actually take the page lock and then wait
for (and set) the page writeback bit, look at how we first use the
Xarray tags to turn the "page dirty" tag into "page needs writeback"
tag, and then look up an array of such writeback pages: all without
any real locking at all (apart from the xas lock itself for the
tagging op).

Making things even less deterministic, the code that doesn't do
writeback - but just _wait_ for writeback - doesn't actually serialize
with the page lock at all. It _just_ does that
"wait_for_page_writeback()", which is ambiguous when there are
consecutive writebacks happening. That's actually the case that I
think Michael would have seen - because he obviously never saw the
(very very rare) BUG_ON.

The BUG_ON() in page writeback itself is serialized by the page lock
and so there aren't really many possibilities for that to get
contention or other odd behavior (the wakeup race being the one very
very unlikely notable one). In contrast, the "wait for writeback"
isn't serialized by anything else, so that one is literally "if was at
writeback at some point, wait for it to no longer be", and then the
aggressive wakeup was good for that case, while it caused problems for
the writeback case.

Anyway, the numbers are all ambiguous, the one-liner fix is not
horrible, and the take-away from all of this is likely mostly: it
would be good to have some more clarity about the whole writeback and
wait-for-writeback thing.

In many ways it would be really line to have a sequence count rather
than just a single bit. But obviously that does not work for 'struct
page'.

Anyway, don't hold up this "get rid of BUG_ON() in writeback" patch for this.

              Linus
