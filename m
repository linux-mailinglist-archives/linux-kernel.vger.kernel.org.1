Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3212D33B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgLHUXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgLHUWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:22:50 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDA5C0617B0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:22:10 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id n7so13224243pgg.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KksDPeWutRhl2xACgV90xOoRvAUNuB/xdjRuh3OGqZI=;
        b=P5vYhzOOWD8I6gSA+a5XyErnmd39EmGe2ziQEznTSC34ocQA6nP0hrUVtx30wcw+Tq
         7XB0LbTcIbrMIQIcRWbBTzW0DrWWVI4pOeIflG3c7CLCrMsnqfSM3cw31QVpAE8g8oPq
         Z3tWaCoJZ2PlOclONd7NWWc8flhCsoZhLOqaYL9kBhKWqyw600THzvmElKRROXl0khyI
         pbJ19ypih/Vhz7nSsJRgMdM5MI31r9BfLtIoJ4xHjT5eE1a+rWmtzIC6trX39tueoG+J
         Gb/gJ50UKZFROIr3jhCI76HXT2AVRurQwNJcX6eIKjUeKa8Tq7WhTZJoU17WV1lo/h/A
         jBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KksDPeWutRhl2xACgV90xOoRvAUNuB/xdjRuh3OGqZI=;
        b=eWs15WBJ/soNVwq+kNg4kGzLpqdJ1LjWIs7oFUQjZLDkTT1j74EwsKq1LTAhgPPIu5
         vvrsaFRSmasgJzvsgT3Vgpy8tj7itzRVW3nI3O/ewnvW3N+kLX1UEVUpVxFf4d8U6r+r
         71wX0ASdzYB25tsTQk+U+GqurjQHzshNCnoc2m5dVtW027v2t1rtE5XAC3G4OF7RHmoq
         1KG8Y0LUfJhzkNDuMEbNjqArR6fTYk92j0Om1FiNSMgpzqB8cBqPxmB+RQftSwoDgcjN
         2+pIH4XTfm4KuefkmT0pNZF5NYYsZzPtBMZneE59uX6nG/ur1MJmcdOd+Ybl7lZbGyzv
         xA4Q==
X-Gm-Message-State: AOAM53322OH2dCSQzOoDdJHMXZKNf/LW3AB+2HbioYyIkE0WhMz/ZWsz
        1fXO4lS5N557yuD6uB77ApniYKBEiLEYwkmj7LlFTBCQp1U=
X-Google-Smtp-Source: ABdhPJyfCbcKrOYRJdnfbMWFnq6M7iLjXhIs1Nwn2K2AD+VjibcvpoUMU5l+qG+Wk2sAOPvdaXKnReB92CrLZn/FTC4=
X-Received: by 2002:a05:6102:a07:: with SMTP id t7mr18143495vsa.30.1607457515239;
 Tue, 08 Dec 2020 11:58:35 -0800 (PST)
MIME-Version: 1.0
References: <1607455638-4436-1-git-send-email-jrdr.linux@gmail.com> <875z5ccc0h.fsf@igel.home>
In-Reply-To: <875z5ccc0h.fsf@igel.home>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 9 Dec 2020 01:28:44 +0530
Message-ID: <CAFqt6zbp56nOfnLvuieMMtpEi7TXuB67bGS_Y=offyiROc=etg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fixed kernel test robot warning
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@linux.alibaba.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 9, 2020 at 1:21 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Dez 09 2020, Souptick Joarder wrote:
>
> > Kernel test robot throws below warning -
> >
> >    arch/riscv/kernel/asm-offsets.c:14:6: warning: no previous prototype
> > for 'asm_offsets' [-Wmissing-prototypes]
> >       14 | void asm_offsets(void)
> >          |      ^~~~~~~~~~~
> >
> > This patch should fixed it.
>
> Or rename it to main, like most other asm-offsets files.

Few asm-offsets files named it as foo(). Does a rename to main() will
work straight forward ?
I don't know much about this area of code.

>
> Andreas.
>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
