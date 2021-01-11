Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7162F1F44
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391113AbhAKT0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391030AbhAKT0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:26:38 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D340C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:25:58 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id u25so1236995lfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oKNFHHPFfD7wrwfuT7r81/lh6WrZWqpMnLmKMYRybYs=;
        b=T4dW7LSW7T2wg9bacwMkeXXtLd4Ok0sO57tNlnjcAH8Ux7LmYSjZ0lozL/qlAFcVMW
         /X7YR78gi7Ax/0lk70yZx3V9MQaMI7jS/gAfWwdp4tXVRSg+DjhZ8vv5aWsRaxJuwJRC
         ABafPi7lpmnzPtXbWxsMbYU5IEhVTnlyC3SEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKNFHHPFfD7wrwfuT7r81/lh6WrZWqpMnLmKMYRybYs=;
        b=YKRvL/IyVpQWh8Y//CbgmetY5UshaXlVJD0MpqTHOtlqqxRkHSW6FC3L91tr7dlyo0
         seasneBLxnWoDR+N2KUxSAersK1OUyUZAtRUbtulfJs/6I1GR8LBxy5nltse9rZE5QKT
         RstH6rwMrNcErDOu2X+O8k1ZWcvMdGG6jgCo2fSQ9AGUvrHxZh4Zo6JdnEA+rIh/3D4o
         V1oHyZM1HG42z923xTdtss2BBeru68caEovN1WSAc0R1Bv3vy251C7UvFip5dGsmLzYQ
         U1bU87yfW+zIlsdDX8/xiC6OnyKRU740p40jxu/LdpQliUvwBT/bAPKg5eST6lAt7Udc
         rmKA==
X-Gm-Message-State: AOAM5324YWFgiAiDuRo7x4gX0xG6Houdgk4/2I8pBaELwVolfjWUWpqg
        nVJmUnAPu4c9moea5gOOb44l0BbOJyIerw==
X-Google-Smtp-Source: ABdhPJxlMUpXZilwq+VegR8U7oceCgdDRyRJCtuueQh5aMeSEcvjZiHA+ADYkEsH/eLwqUzuDW9UmA==
X-Received: by 2002:a19:4c06:: with SMTP id z6mr502730lfa.284.1610393156097;
        Mon, 11 Jan 2021 11:25:56 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id x18sm87255lfe.36.2021.01.11.11.25.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 11:25:54 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id w26so165754ljo.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 11:25:54 -0800 (PST)
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr420017lji.48.1610393153712;
 Mon, 11 Jan 2021 11:25:53 -0800 (PST)
MIME-Version: 1.0
References: <20210108171517.5290-1-will@kernel.org> <CAHk-=wg3UkUdiTbqWFx3zBLXv9VJHuNZAa5QyDvXiSmD4gX94A@mail.gmail.com>
 <20210111142402.6euyktmcnpemanf7@box>
In-Reply-To: <20210111142402.6euyktmcnpemanf7@box>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 Jan 2021 11:25:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=whYs9XsO88iqJzN6NC=D-dp2m0oYXuOoZ=eWnvv=5OA+w@mail.gmail.com>
Message-ID: <CAHk-=whYs9XsO88iqJzN6NC=D-dp2m0oYXuOoZ=eWnvv=5OA+w@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Create 'old' ptes for faultaround mappings on
 arm64 with hardware access flag
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 6:24 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> I wonder if it would be acceptable to pass down to faultaround a copy
> of vmf, so it mess with it without risking to corrupt the original one?

I'd almost prefer to split vmf into two parts: the 'this is the fault
info' part and the 'this is the fault handling state' part.

So the first one would be filled in by the actual page faulter (or
GUP) - and then be 'const' during the lookup, while the second one
would be set up by handle_mm_fault() and would contain that "this is
the current state of my fault state machine" and contain things like
that ->pte thing.

And then if somebody actually needs to pass in "modified fault state"
(ie that whole "I'm doing fault-around, so I'll use multiple
addresses") they'd never modify the address in the fault info, they'd
just pass the address as an explicit argument (like most cases already
do - the "change addr or flags in vmf" is actually already _fairly_
rare).

               Linus
