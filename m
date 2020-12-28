Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E912E348A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 07:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgL1Goo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 01:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgL1Goo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 01:44:44 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180FEC061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 22:44:04 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id k7so2030089ooa.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 22:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=o5wtPX61QoOqoZU2VTRJCE3ZyQ3KdZXG3FjCWYnhbEo=;
        b=MBH2w4ZV23RJuSVoaMPfo6ofBhwPb4jewXSeYQP1woVvN0xBSyjZWO4V96+cOKOtnL
         3jCjNCOgv3I+YECgRSpVULJVXQhGZt1uchfOt8BAsCMtx4C+2cBR+qkrCkamned2He46
         SERg4fDJusnUBrJhqRzLq8ROXsSy5J3dYE1Lsw33VAELTQKK/p2FE36yScc77AOXTzQb
         UfNXx60MJaNTev25LrjbWQPq5vj8uYXozn3xWo6THV0WcAAa5fYKiCU+eDYVV5mIs3d8
         chsppqTQkqI/DyVSrSPfw3Hv8Mw3rI6rw4gj7SbSKMSIGfcGEaoiZtFuCKpEKFkFC+A+
         i7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=o5wtPX61QoOqoZU2VTRJCE3ZyQ3KdZXG3FjCWYnhbEo=;
        b=OCFKcc+XZShpY7n0/mJRJuX8vmuE+WpAdysyEF6gIBxnagzLG54gDqhjwyGBwjR7AJ
         FMoeHhIIHzwTadJY5FmVXhOGhEZ7lRXFSfuhG4AqvSl8LTeEGB/GHXymULbnTFjd/m2Q
         RAm6NvsdSjfCaWYLEOs8CuAhk0f4lWdAFV8gbraJTkvpR3xtCxp6wnPiufNzDlqxAuaK
         5i9jXlUJOS2oLEJGyxRSffIXSNVddLVDIZFRB5QuisypIBv86in39MnIsgaSXdNYajPR
         bpm/+Djp4z5K/tip917nxra10LMmrlrKQpEvSRxYUeX5sDxnezqpx7DfXjnebX9qAweb
         ynxA==
X-Gm-Message-State: AOAM532eOD21HPWsm+hbbBznROTzeTg/c3bwuz/PLb4kSL7iZWlzcOo7
        5rvH1nxPY8CAFm4N0tqr5zxpWQ==
X-Google-Smtp-Source: ABdhPJxptFi0jlfOZ1KQ6ymnKZrDWvFuVR0GjxXiDxg91Uwd+ugMtO2uhXZ+YCY0rcz1P04NWG54nw==
X-Received: by 2002:a4a:cb84:: with SMTP id y4mr29970687ooq.70.1609137842984;
        Sun, 27 Dec 2020 22:44:02 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id l134sm8666271oig.25.2020.12.27.22.44.01
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 27 Dec 2020 22:44:02 -0800 (PST)
Date:   Sun, 27 Dec 2020 22:43:44 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
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
In-Reply-To: <CAHk-=wiVrd4R2EVGCGtmybt6+u9LoGgMdnf12zc=sYL=QbvRWQ@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2012272233170.24487@eggly.anvils>
References: <alpine.LSU.2.11.2012231905300.5723@eggly.anvils> <20201225113157.e7hmluffh56fszfc@box> <CAHk-=wiT50aEErZgZOrbFQ=GhFuM3MnBmHoSBSScN9rmXMnOKQ@mail.gmail.com> <20201226204335.dikqkrkezqet6oqf@box> <alpine.LSU.2.11.2012261246450.1629@eggly.anvils>
 <CAHk-=wjesveWEQZ4tqRssSSQvuxx46LqYfME+uxKfghxAe6U_w@mail.gmail.com> <20201226224016.dxjmordcfj75xgte@box> <alpine.LSU.2.11.2012261623140.1022@eggly.anvils> <alpine.LSU.2.11.2012261816520.1071@eggly.anvils> <CAHk-=wjHvipz5DqWUFP5zuPK-kWM4QD-eokf75V8NGNATnn+BQ@mail.gmail.com>
 <20201227234853.5mjyxcybucts3kbq@box> <CAHk-=wiVrd4R2EVGCGtmybt6+u9LoGgMdnf12zc=sYL=QbvRWQ@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Dec 2020, Linus Torvalds wrote:
> On Sun, Dec 27, 2020 at 3:48 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > I did what Hugh proposed and it got clear to my eyes. It gets somewhat
> > large, but take a look.
> 
> Ok, it's not that much bigger, and the end result is certainly much
> clearer wrt locking.
> 
> So that last version of yours with the fix for the uninitialized 'ret'
> variable looks good to me.
> 
> Of course, I've said that before, and have been wrong. So ...

And guess what... it's broken.

I folded it into testing rc1: segfault on cc1, systemd
"Journal file corrupted, rotating", seen on more than one machine.

I've backed it out, rc1 itself seems fine, I'll leave rc1 under
load overnight, then come back to the faultaround patch tomorrow;
won't glance at it tonight, but maybe Kirill will guess what's wrong.

Hugh
