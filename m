Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B79928AC55
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 05:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgJLDCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 23:02:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgJLDCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 23:02:34 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A722E208FE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 03:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602471753;
        bh=w6L5MpnyA+wLnn/eFyAG9iaR26/MmDi1yL8iwqc3U2g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xq0aR52nk7kVJUHd4y7i2ZLi2fpRn/Wg2lOioAVsLbdTuk6DO364k/wr5dnZA+Jl4
         QGGH/JUUWqK8JXwVUbFG4ChT/9yu9xUW0X2eSw4Rp+Bm/kBDWZGWA7Yqgfo5jGeqai
         I8fKXR68MVJ3pXPeqqlGeOsOsSu00ht4G6/rWvh0=
Received: by mail-wm1-f47.google.com with SMTP id f21so15864988wml.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 20:02:33 -0700 (PDT)
X-Gm-Message-State: AOAM532P+OkFSzDF973whXZIBotSIzU4zATFQ/t26jj2U4rxMdnU8U0b
        l1454iZ/eMk0Oi5OAiWm0C1nKTvuWoatQdY+3NKXiQ==
X-Google-Smtp-Source: ABdhPJyAxvriVnKvB3vscVPWC2ww4cS1XzgW1dHtwnHInrcej5aEaf0IFeMcFXFHkev6oGhM414LyfLn+ObDSvChQAs=
X-Received: by 2002:a1c:6457:: with SMTP id y84mr8597461wmb.36.1602471752124;
 Sun, 11 Oct 2020 20:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <20201012014837.14305-1-jrtc27@jrtc27.com>
In-Reply-To: <20201012014837.14305-1-jrtc27@jrtc27.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 11 Oct 2020 20:02:21 -0700
X-Gmail-Original-Message-ID: <CALCETrV4BFQ_Cdt98NTWnzQ1H4eJfzOpz_UO=Ak+i6jDQAmcrA@mail.gmail.com>
Message-ID: <CALCETrV4BFQ_Cdt98NTWnzQ1H4eJfzOpz_UO=Ak+i6jDQAmcrA@mail.gmail.com>
Subject: Re: [PATCH] x86: Fix x32 System V message queue syscalls
To:     Jessica Clarke <jrtc27@jrtc27.com>
Cc:     linux-x86_64@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 11, 2020 at 6:48 PM Jessica Clarke <jrtc27@jrtc27.com> wrote:
>
> POSIX specifies that the first field of the supplied msgp, namely mtype,
> is a long, not a __kernel_long_t, and it's a user-defined struct due to
> the variable-length mtext field so we can't even bend the spec and make
> it a __kernel_long_t even if we wanted to. Thus we must use the compat
> syscalls on x32 to avoid buffer overreads and overflows in msgsnd and
> msgrcv respectively.
>
> Due to erroneously including the first 4 bytes of mtext in the mtype
> this would previously also cause non-zero msgtyp arguments for msgrcv to
> search for the wrong messages, and if sharing message queues between x32
> and non-x32 (i386 or x86_64) processes this would previously cause mtext
> to "move" and, depending on the direction and ABI combination, lose the
> first 4 bytes.

This has a few problems.

First, the 512-547 range is a legacy wart and we shouldn't extend it.
I thought I had documented this, but I didn't -- oops.  Patch sent.
The correct way to do this nowadays is to use the same number twice,
once for x64 and once for x32.  If you try to do this and encounter
problems with the build, please either fix them or let me know :)

Second, since this is an ABI issue, can you please include a little
test case that compiles for i386, x86_64 and x32, works correctly on
all three with whatever patch you send, and fails on x32 without the
patch?

Third, how does this interact with various libc implementations?
msgsnd(2) and msgrcv(2) have glibc wrappers.  Have they never been
tested on x32?

Fourth, if there is some deployed code that uses the buggy x32 path
and actually works by accident, do we risk breaking it if we fix the
bug?

--Andy
