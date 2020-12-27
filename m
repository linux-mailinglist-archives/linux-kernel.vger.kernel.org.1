Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE852E2F82
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 01:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgL0Aq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 19:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgL0Aq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 19:46:56 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38FCC0613C1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 16:46:15 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id r9so6341447otk.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 16:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=SCcDAq1vx1rq+khgfj2C8Z6X6qgNeLzbSQZknX3MThk=;
        b=sy/rykXo/FRQEq0/TxDVzPDMGqgFybPLTzbWbJNL/gqnd98GstGFv+ALhsFgRy+eNZ
         dw2LSeN91oKxnmfWVCuGmpBfLvYrospIBbmwcI1CgFU6dMwKuhEABRhgubsOFJiu+Fvq
         eN1iXuUyXoOrg7JJZ3ualv6xYvwj7vl5CjaiCbqrUrvAvF8Gw6WLMFyBiw818OiFbex4
         W91QV1M0kUfTcDf6vKhZJSAi6zwrQ5cpP0vd8GTq4HUvbB6E6AtCNv3kBN6aarnGlbXY
         /04w53yPA3slMfsLvTHRXctX6R0/6A2NqzCzqE5XZLNDm33Tt0VU6Tf023dUbCbwi2fh
         6YGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=SCcDAq1vx1rq+khgfj2C8Z6X6qgNeLzbSQZknX3MThk=;
        b=g50dmRCvMmZB0M6+Kpbu0lePzC52KtChgKaZX9TkBpPT4K+BKEgQnvytUNXEOxA6D/
         fcIzlVDVl4VLYnOH7kJooSp1mg9R/t4RFml0KUHuzL0QgxreoHYohFGaDdHScMa0khKv
         NNMQb7lV7FrEAhAwMsVZe6LljknyO5517VRKsyH+7EiEGSnViHXKDXZsXhG0fyqJuOvz
         vlur2Ip1jIgAz9//o/7bWqUR6PAivpskIpa6Jz6/rHdnOZCfAjopGJ86qPvXt/D7dIc1
         FciQOCY3MBVndXTOIMhoIn6SIcRRnMUuD7qJgZxKt6UndIzpzKccHluA3owBpnZfUR9s
         OVtg==
X-Gm-Message-State: AOAM5332HgxB3MZiUU/NHkyVNUfLNPle+SdzkxQLmdX776d8X4akEmcW
        qxmiD5bVOpFqvekopIbG8uXUjGTKstgygg==
X-Google-Smtp-Source: ABdhPJzwlNaCKWypZRgSBM2YuwBl7PIaMGbdjfU62eHRJZtGMdj6masRtaLILV4j6n4gjYdm1kEQlQ==
X-Received: by 2002:a05:6830:114e:: with SMTP id x14mr28821611otq.253.1609029974392;
        Sat, 26 Dec 2020 16:46:14 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t26sm8322868otm.17.2020.12.26.16.46.12
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 26 Dec 2020 16:46:13 -0800 (PST)
Date:   Sat, 26 Dec 2020 16:45:55 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries
 when prefaulting
In-Reply-To: <20201226224016.dxjmordcfj75xgte@box>
Message-ID: <alpine.LSU.2.11.2012261623140.1022@eggly.anvils>
References: <CAHk-=wgO2LsoKhX7MjSECo+Xrj1-Me7tzRfNcsdEZBRwJW1cQg@mail.gmail.com> <20201219124103.w6isern3ywc7xbur@box> <CAHk-=wifcVaxaTn_RbZ=idfYFazTPwm8t5cB1rY6xEBjbcfO5g@mail.gmail.com> <20201222100047.p5zdb4ghagncq2oe@box> <alpine.LSU.2.11.2012231905300.5723@eggly.anvils>
 <20201225113157.e7hmluffh56fszfc@box> <CAHk-=wiT50aEErZgZOrbFQ=GhFuM3MnBmHoSBSScN9rmXMnOKQ@mail.gmail.com> <20201226204335.dikqkrkezqet6oqf@box> <alpine.LSU.2.11.2012261246450.1629@eggly.anvils> <CAHk-=wjesveWEQZ4tqRssSSQvuxx46LqYfME+uxKfghxAe6U_w@mail.gmail.com>
 <20201226224016.dxjmordcfj75xgte@box>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Dec 2020, Kirill A. Shutemov wrote:
> 
> Here's the fixup I have so far. It doesn't blow up immediately, but please
> take a closer look. Who knows what stupid mistake I did this time. :/

It's been running fine on x86_64 for a couple of hours (but of course
my testing is deficient, in not detecting the case Linus spotted).

But I just thought I'd try it on i386 (hadn't tried previous versions)
and this has a new disappointment: crashes when booting, in the "check
if the page fault is solved" in do_fault_around().  I imagine a highmem
issue with kmap of the pte address, but I'm reporting now before looking
into it further (but verified that current linux.git i386 boots up fine).

Maybe easily fixed: but does suggest this needs exposure in linux-next.

Hugh
