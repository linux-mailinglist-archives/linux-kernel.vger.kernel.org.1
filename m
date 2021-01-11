Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE822F24AC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404946AbhALAZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:35380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404160AbhAKXlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 18:41:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8821A22D00
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 23:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610408432;
        bh=fwOr4/4Gkta7ccSR5AGFd1vU9Z/WchantQ67F+lxtCE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NKRp0tWe7n0RTpEoa+4zHlRg6gTW+TuJLV8Q3VaaQIlN1CJc9pLaOGfdo1nYNhw6T
         L7ydMuS2IPLN1zohZdl+JM7U0RRpyu1l9xVWP/XhOKoqZURbFNjgC+wLT06uKNA3At
         ShTV4jIWscMK5KkC5/+jpo51i2V6oEF2DcJivEXswf7nWjv8k+EeUDTXobrkmaKmYP
         5MjBb+KjAF/gKvlhX8Rp/vCbDoNUvwlxlsfngpiLZcDiLVe3DUXySTttWlJFPL0fbt
         MAr13PmDUS4J3YnG8tegsq6qYsQSNbLLlpt/FVtPdbgiOyxGbPzQxn46396t9uo2I8
         /kHiUwprunmTw==
Received: by mail-ej1-f43.google.com with SMTP id lt17so894591ejb.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 15:40:32 -0800 (PST)
X-Gm-Message-State: AOAM533iiAdmJ8qYIOVtZRydofrnAk2s3wWLemXytr/k1gVx66ReooXi
        UnPVuBVNRYvQfXpCil+QiibsrbCwJfh4pDkE/wfJ0w==
X-Google-Smtp-Source: ABdhPJwgtdayx1MbPX+ct2UaJ9IVCWqIcr85bc6w36O/ZqpEBBYA0XKL0IdjobEX+DcNSEvYSU2mGrM1J50T7RF6AqA=
X-Received: by 2002:a17:906:ae55:: with SMTP id lf21mr1203125ejb.101.1610408431143;
 Mon, 11 Jan 2021 15:40:31 -0800 (PST)
MIME-Version: 1.0
References: <20210111200027.GH25645@zn.tnic> <E74AC970-CFCF-4CFD-A71F-F719F5BCE2DC@amacapital.net>
In-Reply-To: <E74AC970-CFCF-4CFD-A71F-F719F5BCE2DC@amacapital.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 11 Jan 2021 15:40:19 -0800
X-Gmail-Original-Message-ID: <CALCETrV=BpFwR-RU5ORioBCZj3RwK7nmD2Yz3VNd4gfFjukRAw@mail.gmail.com>
Message-ID: <CALCETrV=BpFwR-RU5ORioBCZj3RwK7nmD2Yz3VNd4gfFjukRAw@mail.gmail.com>
Subject: Re: gdbserver + fsgsbase kaputt
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>, tdevries@suse.com,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 1:06 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
>
> > On Jan 11, 2021, at 12:00 PM, Borislav Petkov <bp@alien8.de> wrote:
> >
>
>
> > Or do you mean I should add "unsafe_fsgsbase" to grub cmdline and bisect
> > with fsgsbase enabled in all test kernels?
>
> Yes. But I can also look myself in a bit.
>

Tom, if I reproduce it in an interactive gdb and play a bit, I get:

Program received signal SIGSEGV, Segmentation fault.
0xf7df2cb6 in init_cacheinfo () from target:/lib/libc.so.6
(gdb) p $gs = $gs
$1 = 99
(gdb) si

Program terminated with signal SIGSEGV, Segmentation fault.
The program no longer exists.

That's gdb itself crashing.  Any idea what's wrong?
