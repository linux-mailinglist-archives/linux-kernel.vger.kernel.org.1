Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7BE21F62C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 17:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgGNPaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 11:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgGNPaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 11:30:04 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34482C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:30:03 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m26so12002859lfo.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VvONWUUx+ge2aRqADFFqhcoKfa3RbBALz1DV1ooGJ/Y=;
        b=XijJsNpSPPnejytiYcdHjB1XQVu8uaH3j6/gEPYZl+pAI0TcIHWcBLqvOFrhR7jXBP
         9cveXgeLbceG8D7dAL+Zepto6GIlhPMkZ8CJdbQEnOtls2STHYWDEB8MFah9uo0hpegd
         YSVwiX5OVwFQLLXykgySPxhz+QTAG24MkW3WE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VvONWUUx+ge2aRqADFFqhcoKfa3RbBALz1DV1ooGJ/Y=;
        b=Mqm/MNIq+JRjAywsiDrEBzcEkCw82Oz8Pxjr9FFiZL9fLf7LWe/Ok2QINa1E1wQ+fR
         gW6iR/4PL0xc2UNoxgOBWu3E7iofKzMfQs8g4d67l2Y8sz7k5REyn0J9P5yGzbutJ+A1
         RG+S8mQwuBL0PJAhjGMI+hvRHXUZFM1yQYpoVW0cBL/n0VpNMKCqcPch/bEpzOgBBhGv
         gHHo4yf0gWKLbj6rusGz9CItPGPa3WjaRS/PKd8p4zGAHIg2aHcTekDw2sehjkn6w1nS
         PBd9zezWow55s8bDJ1IZ/0V6qOtugJ1bkDA714kDQsg/TIwAp4VJdYmgPu5dXCrCNSbh
         Bzlw==
X-Gm-Message-State: AOAM532/DaoVYo05l/JCC1bvMcBJ6sNjG/9acDbY52yox6Eh5h2DLwV/
        KmkJXUZUoYATRxYqUc31XFtkQ4irf10=
X-Google-Smtp-Source: ABdhPJyTYS66sgl+WsQmBPala5jfxGfktif+2nnRUbvaU8CQEYRQOOaXUXTt68kHfHHsUE9/1JG2GA==
X-Received: by 2002:ac2:51a1:: with SMTP id f1mr2480766lfk.173.1594740601264;
        Tue, 14 Jul 2020 08:30:01 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id r13sm5335710lfp.80.2020.07.14.08.29.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 08:30:00 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id h22so23294384lji.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 08:29:59 -0700 (PDT)
X-Received: by 2002:a2e:760b:: with SMTP id r11mr2752959ljc.285.1594740599299;
 Tue, 14 Jul 2020 08:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200714105505.935079-1-hch@lst.de> <20200714105505.935079-6-hch@lst.de>
In-Reply-To: <20200714105505.935079-6-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jul 2020 08:29:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvwd9AWMCoUidO8pT3iw6e6NXCKThqbpDQOoz1=WTP7g@mail.gmail.com>
Message-ID: <CAHk-=whvwd9AWMCoUidO8pT3iw6e6NXCKThqbpDQOoz1=WTP7g@mail.gmail.com>
Subject: Re: [PATCH 5/6] uaccess: add force_uaccess_{begin,end} helpers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 4:08 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Add helpers to wrap the get_fs/set_fs magic for undoing any damange done
> by set_fs(KERNEL_DS).  There is no real functional benefit, but this
> documents the intent of these calls better, and will allow stubbing the
> functions out easily for kernels builds that do not allow address space
> overrides in the future.

It would perhaps have been nicer to rename the save variabel too
(neither "seg" nor "oldfs" make much sense once you get rid of the old
x86-inspired name).

But from a greppability standpoint and a doc standpoint, I guess just
renaming the function is sufficient (and certainly easier).

               Linus
