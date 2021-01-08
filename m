Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8D42EF816
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 20:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbhAHT0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 14:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728864AbhAHT0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:26:22 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B36C061381
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 11:25:41 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id l11so25637835lfg.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 11:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wbp5uQXvEJj9vCd3uDLsS0MjLHCz/E8hBRej1ogMfSY=;
        b=CnoSYFDonWZ+Dgr+tiFEJynbekbzhxxmwqhGZRLPn7gyBa+bQCxiZCgqtJNAqqH7V7
         TSFbUq82vxW5E7FhsuzaQeerMwZaOt0+C5QPZm1zSWCjM30scQoh2y1t/I0kXtd2Me5o
         PnboSZjV2P4J6KnmAMWXW033tv1LqjZapysIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wbp5uQXvEJj9vCd3uDLsS0MjLHCz/E8hBRej1ogMfSY=;
        b=dEqjKp11esznCczAvaaFUB4Z+FAsBhb24PQ1GIblcwF4Nv+SW0/MhrNuITzUZW7C2L
         KhI2iAI63dK4tItgQnvk/dYF02lqOrIY0oX6zmub8tAC4Ui83D47xS/X/HumyFFQeY2+
         Qd81ETLnT3y3WbKWb4S+2MpWgxa9nFHlPXmTRlrDR/lUc7wDr0IpUT1HNTeq6uYSz7IC
         gxdxNPZProy/x0BCDrXm19lZYTqa8lauMyBG4RfZy1wI+LuBL9gEngjQ3G5uO9qI7tzP
         qHqt2dA8cHjvIhZv/LNVCFjAD/ae+mG8b12EmWD4J9fSdSUbXyLDSRPnnstWxlwfKQG+
         0HtA==
X-Gm-Message-State: AOAM53300IGNj6qq71ZrEWOcQIniIcHflC0wTMiLVk7S1PIPzkx9i71N
        2BSFitXi9hZ7chWSj+gclA1A6dCSt1IEog==
X-Google-Smtp-Source: ABdhPJzR9jNbshrafTEJ5wdjnILqlN06XI6ZpmyDCddxY96H0D1MyVQR7LQd1PFyn2A0krtUcoMGMA==
X-Received: by 2002:a05:6512:208c:: with SMTP id t12mr2366268lfr.165.1610133939798;
        Fri, 08 Jan 2021 11:25:39 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id y4sm2113903lfl.179.2021.01.08.11.25.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 11:25:38 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id x20so25436021lfe.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 11:25:38 -0800 (PST)
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr2008203lji.48.1610133938011;
 Fri, 08 Jan 2021 11:25:38 -0800 (PST)
MIME-Version: 1.0
References: <X/d2DyLfXZmBIreY@redhat.com> <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
 <X/eLwQPd5bi620Vt@redhat.com> <CAHk-=whjS3pUZRJLR_HdgB0_1Sd4gWXUbLLyShKxOg0ySCdnUA@mail.gmail.com>
 <CAHk-=wgRZ5o5pUqKC6cwTLU=V-G+rF5DTexGh1kCMGrgXDufew@mail.gmail.com>
 <X/edsWgguQDgsOtx@redhat.com> <CAHk-=whTCBa6Frpbveuy7Hnz17P+g03yQvynkApFbBjV5rVrsA@mail.gmail.com>
 <20210108124815.GA4512@willie-the-truck> <X/iEyk0ijxhSvs9T@redhat.com>
 <CAHk-=wizOEqJTomh=K5CR300mtTCwWdj+QYYCXKHaiU-R0YE9Q@mail.gmail.com> <X/icBLF59bREm97b@redhat.com>
In-Reply-To: <X/icBLF59bREm97b@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Jan 2021 11:25:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjf-GwbXgDm8RDkW1ctajzDst4dp2LOZSd3+m7Ojo5vDA@mail.gmail.com>
Message-ID: <CAHk-=wjf-GwbXgDm8RDkW1ctajzDst4dp2LOZSd3+m7Ojo5vDA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce wrprotect_tlb_flush_pending
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Will Deacon <will@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 9:53 AM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> Do you intend to eventually fix the zygote vmsplice case or not?
> Because in current upstream it's not fixed currently using the
> enterprise default config.

Is this the hugepage case? Neither of your patches actually touched
that, so I've forgotten the details.

> Irrelevant special case as in: long term GUP pin on the memory?

Irrelevant special case in that

 (a) an extra COW shouldn't be a correctness issue unless somebody
does something horribly wrong (and obviously the code that hasn't
taken the mmap_lock for writing are then examples of that)

and

 (b) it's not a performance issue either unless you can find a real
load that does it.

Hmm?

               Linus
