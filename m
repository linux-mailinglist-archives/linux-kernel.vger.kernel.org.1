Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A81D42F2049
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 21:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391442AbhAKUBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 15:01:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48154 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391381AbhAKUBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:01:13 -0500
Received: from zn.tnic (p200300ec2f088f005dbd09e41b233316.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:8f00:5dbd:9e4:1b23:3316])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6AA491EC047F;
        Mon, 11 Jan 2021 21:00:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610395232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WmzVxxM+DzmpdAYX1z0hm6J9OZgiZvTuirfFZnWd0lA=;
        b=B1Zxq6QE1uHUJ4conEqrOfrp6wGt/tlzIBzdHuufQaZGGff9Npx5E40VqbM/D5xvMRjvOu
        ukPq0Yao8RqyVitA/CdXaCtIm4IeSHtz99FPG+u/+VpfvrIaY0dtB7mIzPVsAynJRJ+TGT
        iYV4WQx5U38AKYoq6y8ZkZMue1TcY2c=
Date:   Mon, 11 Jan 2021 21:00:27 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>, tdevries@suse.com,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: gdbserver + fsgsbase kaputt
Message-ID: <20210111200027.GH25645@zn.tnic>
References: <20210111181520.GE25645@zn.tnic>
 <CALCETrV98776mNd20v8r+JXt0uOUKemd_YnDYDoLXN_LDfQnog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrV98776mNd20v8r+JXt0uOUKemd_YnDYDoLXN_LDfQnog@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 11, 2021 at 11:27:38AM -0800, Andy Lutomirski wrote:
> Hmm.  Can you try booting with unsafe_fsgsbase and bisecting further?

Well, that bisection ended in that patch:

# first bad commit: [b745cfba44c152c34363eea9e052367b6b1d652b] x86/cpu: Enable FSGSBASE on 64bit by default and add a chicken bit

so I can't go further.

Or do you mean I should add "unsafe_fsgsbase" to grub cmdline and bisect
with fsgsbase enabled in all test kernels?

> And maybe send me your test binary?

It is trivial:

int
main (void)
{
  return 0;
}

how can that make any difference or are you thinking compiler differences?

Lemme send it to you.

> I tried to reproduce this, but it worked fine, even if I compile the
> test program with -fstack-protector-all.

Hmm.

> Off the top of my head, I would have expected this to fix it:
> 
> commit 40c45904f818c1f6555294ca27afc5fda4f09e68
> Author: Andy Lutomirski <luto@kernel.org>
> Date:   Fri Jun 26 10:24:29 2020 -0700
> 
>     x86/ptrace: Fix 32-bit PTRACE_SETREGS vs fsbase and gsbase

More hmm.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
