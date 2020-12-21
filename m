Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8092E02F5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 00:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgLUXhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 18:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgLUXhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 18:37:47 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC414C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 15:37:06 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m25so27651106lfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 15:37:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XEUwJ1B3pcWLfpPQa7kvc+ABD9Wxu3JslOygXEvY+B8=;
        b=bCl/WjkG/28ydsHCZmu2DitVaP/UIuwhWRUv8tqqH3u57qnFChPk7QRY0Gm/j0xM+l
         QXIwccH+sYgnsJnnIQRTGBvSqky0hhZ+Wyg74kg3WSEgQ9Kgpb60E8qMgykEKt/a7ynR
         5O+oTVRihSdPgZEpioYQ+5DuwGB1Vxz7Yi8OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XEUwJ1B3pcWLfpPQa7kvc+ABD9Wxu3JslOygXEvY+B8=;
        b=Cad8o2K9NZyAr2/UMetCifLCjzap7XfutzWIv5hO3ELsenLmp/chHfCCBqCJ0bKd45
         X6hs6inUp6LJy8I9gnSBkdKDVzKdYYM9UkHWi/f48fkpMUJHdPwFOmgPe00smuDzcT4T
         EVpnvmLSPrU+vNSTV8TaIpB4J/kcS1E9/SQbT1i2x+k38G+6DpOw56ZbE+PrEY7z95rd
         9RTA95+AorpCRNQ0y5iAtnG/dKW+aFRNLyp80m9cY9fOW1weZN41aCMt3rKAbWj5gNxM
         1qX22+rqC+IijnC9dViHtJbQiS4ycOI9CjYc4L4/BJWRSBoG6CtfpsrhvICT1xcxwcmA
         WXCg==
X-Gm-Message-State: AOAM5320PQm7WCDuqKM3lu48jvo7FquHgBO95dfyztMC4LXwC6cD7Wc0
        ulIv5j2bYrZaBsWKzEnmAOxwdei4T39e/A==
X-Google-Smtp-Source: ABdhPJy7eb9kPNDGW6Qt9UWt68dKOfjpv+8jc53ZFKdEk/rq2+tQbp2tdyBIVYB/gu2MuTcg+Hxl+w==
X-Received: by 2002:ac2:58dc:: with SMTP id u28mr6769572lfo.332.1608593825218;
        Mon, 21 Dec 2020 15:37:05 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id w14sm2285079lfn.169.2020.12.21.15.37.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 15:37:04 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id o17so27771097lfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 15:37:04 -0800 (PST)
X-Received: by 2002:ac2:4987:: with SMTP id f7mr7298452lfl.41.1608593446798;
 Mon, 21 Dec 2020 15:30:46 -0800 (PST)
MIME-Version: 1.0
References: <X97pprdcRXusLGnq@google.com> <DDA15360-D6D4-46A8-95A4-5EE34107A407@gmail.com>
 <20201221172711.GE6640@xz-x1> <76B4F49B-ED61-47EA-9BE4-7F17A26B610D@gmail.com>
 <X+D0hTZCrWS3P5Pi@google.com> <CAHk-=wg_UBuo7ro1fpEGkMyFKA1+PxrE85f9J_AhUfr-nJPpLQ@mail.gmail.com>
 <9E301C7C-882A-4E0F-8D6D-1170E792065A@gmail.com> <CAHk-=wg-Y+svNy3CDkJjj0X_CJkSbpERLg64-Vqwq5u7SC4z0g@mail.gmail.com>
 <X+ESkna2z3WjjniN@google.com> <1FCC8F93-FF29-44D3-A73A-DF943D056680@gmail.com>
 <20201221223041.GL6640@xz-x1> <B8095F3C-81E3-4AF9-A6A5-F597D51264BD@gmail.com>
In-Reply-To: <B8095F3C-81E3-4AF9-A6A5-F597D51264BD@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Dec 2020 15:30:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wihkGVvXXQL_qSPWF6s4NJYWyEkq+D3CUWQf9H5V1jqtg@mail.gmail.com>
Message-ID: <CAHk-=wihkGVvXXQL_qSPWF6s4NJYWyEkq+D3CUWQf9H5V1jqtg@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: fix memory corruption due to writeprotect
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Peter Xu <peterx@redhat.com>, Yu Zhao <yuzhao@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 2:55 PM Nadav Amit <nadav.amit@gmail.com> wrote:
>
> So as an alternative solution, I can do copying under the PTL after
> flushing, which seems to solve the problem.

I think that's a valid model, but note that we do the "re-check ptl"
in a (*completely(* different part than we do the actual PTE install.

Note that the "Re-validate under PTL" code in cow_user_page() is *not*
the "now we are installing the copy". No, that's actually for the
"uhhuh, the copy using the virtual address outside the ptl failed, now
we need to do something special".

The real "we hold teh ptl" actually happens in wp_page_copy(), after
cow_user_page() has already returned.

So you'd have to change how all of that works.

And honestly, I'm not sure it's worth it - if this was the *only*
case, then yes. But that whole "we load the original pte first, then
we do whatever we _think_ we will need to do, and then we install the
final pte after checking" is actually the case for every other page
fault handling case too.

So are we sure the COW case is so special?

I really think this is clearly just a userfaultfd bug that we hadn't
realized until now, and had possibly been hidden by timings or other
random stuff before.

    Linus
