Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194DD2E6B22
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:00:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731902AbgL1W4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729596AbgL1V7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 16:59:43 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3142DC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 13:59:03 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id s26so26852217lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 13:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l7m3SnG2byIKSUnU3LGhGJnX6zTtZd1eKGo8z5V3mzE=;
        b=fiM1q+0IVYY4uj9MX58uHfv2pJalKxWjDggR7FEvNQSJyBIr2SF36vF8wH1Ott4CES
         No9E+aMy4aJrRCDTJ9cTE1AZibFDvDrjGOVocfK03fYD/Ii98ezl6YtZa8g0fLXCMmDt
         2OPi5rPnE2CtS9NbOFJWyfUiC2vPte3YO9gDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l7m3SnG2byIKSUnU3LGhGJnX6zTtZd1eKGo8z5V3mzE=;
        b=AzuGUduSNWyVg8TRwnHP9q0DMWmYj551wKNEhEznKXGv5ACRMRJqtuq8g2e071ynVO
         qUEfM4Ohp3tXfXPvAaUx/oCd4RDqFrCQw58L1fmdtkTr5bUyrnGPpWxjig0iAqiAaYsN
         rqIxrY3lISADPGmC2+Xz66PIOf0MDYteZUBXGfkBHGDclify7bOZSNc4FWIoX+g6hVQ5
         J/+jAt77Khwi/GIZV5WxsDIPWX1T6LiRvJp+3lKK+hVPD3q0wzT/6kP7/+lyJgU2Z+p6
         HDXlgNIQ9dbdFTJJCOxqM8jrxpIGKOmkAZOciypi1NivGi6mK0mJVqYvizgFMaFVULZa
         f0Yg==
X-Gm-Message-State: AOAM532eoriOblQv2YEgXTn544j/Hgj12nRs4xIxvaKdFxQpVVT/SqVW
        Pjy96w3mm3HmGSB9N4m4tZ11+/y3MZY62Q==
X-Google-Smtp-Source: ABdhPJwLHaPoLsOnovuSxt+i2MUw+Ue6Fc9zqNXZDps8YLCDHZKeQAsLrd3rpjMRBlMmBIDPEJ/i0Q==
X-Received: by 2002:a05:6512:33b5:: with SMTP id i21mr20739020lfg.228.1609192739984;
        Mon, 28 Dec 2020 13:58:59 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id e2sm6640251ljp.75.2020.12.28.13.58.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Dec 2020 13:58:57 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id b26so26857509lff.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 13:58:57 -0800 (PST)
X-Received: by 2002:a19:7d85:: with SMTP id y127mr20651667lfc.253.1609192736859;
 Mon, 28 Dec 2020 13:58:56 -0800 (PST)
MIME-Version: 1.0
References: <20201226204335.dikqkrkezqet6oqf@box> <alpine.LSU.2.11.2012261246450.1629@eggly.anvils>
 <CAHk-=wjesveWEQZ4tqRssSSQvuxx46LqYfME+uxKfghxAe6U_w@mail.gmail.com>
 <20201226224016.dxjmordcfj75xgte@box> <alpine.LSU.2.11.2012261623140.1022@eggly.anvils>
 <alpine.LSU.2.11.2012261816520.1071@eggly.anvils> <CAHk-=wjHvipz5DqWUFP5zuPK-kWM4QD-eokf75V8NGNATnn+BQ@mail.gmail.com>
 <20201227234853.5mjyxcybucts3kbq@box> <CAHk-=wiVrd4R2EVGCGtmybt6+u9LoGgMdnf12zc=sYL=QbvRWQ@mail.gmail.com>
 <alpine.LSU.2.11.2012272233170.24487@eggly.anvils> <20201228125352.phnj2x2ci3kwfld5@box>
 <CAHk-=wg4bzJ9ugrOp7DBoMjNpHechm4QWb0-HC3A_pN564RU5A@mail.gmail.com>
In-Reply-To: <CAHk-=wg4bzJ9ugrOp7DBoMjNpHechm4QWb0-HC3A_pN564RU5A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Dec 2020 13:58:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=whwJcJubrP8ELH=UvEHX146_Jdmfn992W55KJgPvUx_Uw@mail.gmail.com>
Message-ID: <CAHk-=whwJcJubrP8ELH=UvEHX146_Jdmfn992W55KJgPvUx_Uw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: Allow architectures to request 'old' entries when prefaulting
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Hugh Dickins <hughd@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 28, 2020 at 10:47 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I personally think it's wrong to update vmf->pte at all. We should
> just have a local 'ptep' pointer that we update as we walk along. But
> that requires another change to the calling convention, namely to
> "do_set_pte()".

Actually, I think we should not use do_set_pte() at all.

About half of do_set_pte() is about the FAULT_FLAG_WRITE case, which
the fault-around code never has set (and would be wrong if it did).

So I think do_set_pte() should be made local to mm/memory.c, and the
filemap_map_pages() code should do it's own simplified version that
just does the non-writable case, and that just gets passed the address
and the pte pointer.

At that point, there would no longer be any need to update the
address/pte fields in the vmf struct, and in fact I think it could be
made a "const" pointer in this cal chain.

This is all just from looking at the code, I haven't tried to write a
patch to do this, so I might be missing some case.

             Linus
