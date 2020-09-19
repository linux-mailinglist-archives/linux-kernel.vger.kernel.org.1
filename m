Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4542709A6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 03:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgISB2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 21:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgISB2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 21:28:51 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88ECC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 18:28:50 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y17so8029080lfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 18:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=03DDUpv2KYWvBoJTaf6UGmiZwq2gyd+Rx2kPEv84BC8=;
        b=L8nqdAiGERMhCaqM49alokZdWE19BEVx224/Tifw/M/twFSu3nqs7U4UvuJJpfUnnR
         7BbRW4cvK78o5X7c2vrFwb8nMoZFrGXJfX2wGo/a/gbB4vU9s/YGGR+c1gRDdijwWnSa
         s4qp9bxyMNGGSIFTX9WPv4pEZFmvPOvav/e5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=03DDUpv2KYWvBoJTaf6UGmiZwq2gyd+Rx2kPEv84BC8=;
        b=QEUibuvE4Vd6gSapoa6zXv3jY57dqH1jzhO/oddjuvWVk0RyZLVxNdgHuAu7mRlxAv
         xcMJrKOyURDeo9b8K+8ItW7NAyPJYSbW5HL6NVQU3uwwkPqaxwJ7In3TIkoprEpujQ+P
         Bjwkze3uhKV43fHLWgXHYCb/K+WFwworkML6q/8u8jTKM13K4/rOJHLp3Hc2dz3pGxFc
         KlzNp5wkco/lEzosY1d//D2ViWS9qyei9L0El1pyxh7OQSyOT+eaukTQxJk33wZXjIGP
         KqwOfTX9sM2x/LKcuAvsLLtasLGqf0Us+tGomC0RdtU6776v+reYCOHczYFcPwuEnj2d
         L+2w==
X-Gm-Message-State: AOAM533Prbxv/+klw62CbIj+6f1wAVdP6D6b0ZhpEiY4sJqyQCb9AnzP
        jQdqzm+0oy6Qe6kqvEXimOgECN2E8MT8zQ==
X-Google-Smtp-Source: ABdhPJyQJsoVegd9gboZLnPt4mvPJIPz2I0pazXuZB3EBXgBqGtHM9N47ScKqX5A2vz838puLjrxOg==
X-Received: by 2002:ac2:4e92:: with SMTP id o18mr12876674lfr.527.1600478928728;
        Fri, 18 Sep 2020 18:28:48 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id n14sm927705lfi.50.2020.09.18.18.28.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 18:28:47 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id u4so6496500ljd.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 18:28:47 -0700 (PDT)
X-Received: by 2002:a05:651c:104c:: with SMTP id x12mr13659558ljm.285.1600478927200;
 Fri, 18 Sep 2020 18:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200918162305.GB25599@embeddedor> <CAHk-=wjH+OH08yjp=LpexkUnGp0Ogusk3WX0G7Q+Lh7Anfr21A@mail.gmail.com>
 <20200918193426.GA15213@embeddedor> <CAHk-=wg=vvSf3M9O1VkwyYB4D4W6XS2AHVpQn6hEQY+usWrKGg@mail.gmail.com>
 <20200918200252.GH32101@casper.infradead.org> <CAHk-=wiNjJGhAMBwYixwkADpNharvcuOG-AMCdii1q_Xo_Ky_A@mail.gmail.com>
 <20200918202909.GA2946008@rani.riverdale.lan> <CAHk-=wh-ryuY7KBNWr1n+kgQ5_CHB3-X+od-djBV4W-1kQFokA@mail.gmail.com>
 <20200918210050.GA2953017@rani.riverdale.lan> <CAHk-=wgyKF9vnac3mw6v-Bo5D8X-rcrkF=BsZ2jX+OveGkGgBw@mail.gmail.com>
 <20200918223957.GA2964553@rani.riverdale.lan>
In-Reply-To: <20200918223957.GA2964553@rani.riverdale.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Sep 2020 18:28:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+3Poqh_HQ93nPMWOXLQHZhvYNuwScoQ-WaYWuriLYAg@mail.gmail.com>
Message-ID: <CAHk-=wg+3Poqh_HQ93nPMWOXLQHZhvYNuwScoQ-WaYWuriLYAg@mail.gmail.com>
Subject: Re: [GIT PULL] percpu fix for v5.9-rc6
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 3:40 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Ouch, offsetof() and sizeof() will give different results in the
> presence of alignment padding.

Indeed. But from an allocation standpoint, the offsetof()+size is I
think the correct size. The padding at the end makes very little sense
for something like "struct_size()".

Padding at the end is required for sizeof() for a very simple reason:
arrays.  The "sizeof()" needs to be aligned to the alignment of the
entry, because if it isn't, then the standard C array traversal
doesn't work.

But you cannot sanely have arrays of these structures of variable size
entries either - even if standard C cheerfully allows you to declare
them (again: it will not behave like a variable sized array, it will
behave like a zero-sized one).

That was in fact one of the test-cases that I submitted to the sparse
list - the insanity of allowing arrays of structures that have a
flexible array at the end is just the C standard being confused. The C
standard may allow it, but I don't think we should allow it in the
kernel.

Oh, I can see why somebody would want to have an array of those things
- exactly because they want to have some "initializer _without_ the
flexible array part", and they actually don't want that variably-sized
array at all for that case.

But I'm pretty sure we really really don't want that kind of oddities
in the kernel. If we really want a separate "struct head_struct", then
I think we should do so explicitly, and have something like

    struct real_struct {
        // Unnamed head struct here
        struct head_struct {
                    ,,,,
        };
        unsigned int variable_array[];
    };

and if you want the part without the flexible array at the end, then
you use that "struct head_struct".

Instead of depending on the imho broken model of the C standard that
says "in lots of cases, we'll just silently make that flexible array
be a zero-sized one".

            Linus
