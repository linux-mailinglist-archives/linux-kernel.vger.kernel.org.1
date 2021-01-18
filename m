Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7372F9E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390310AbhARL3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:29:51 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42614 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390270AbhARL3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:29:06 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id A53081F44CE7
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Collabora kernel ML <kernel@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 RESEND 1/2] arm: lib: xor-neon: remove unnecessary
 GCC < 4.6 warning
In-Reply-To: <CAK8P3a3dDgbppAB3Bm2iJA7LOqRvHZew1_e-yE1R=9mS4W4xjQ@mail.gmail.com>
References: <20210118105557.186614-1-adrian.ratiu@collabora.com>
 <20210118105557.186614-2-adrian.ratiu@collabora.com>
 <CAK8P3a3dDgbppAB3Bm2iJA7LOqRvHZew1_e-yE1R=9mS4W4xjQ@mail.gmail.com>
Date:   Mon, 18 Jan 2021 13:28:18 +0200
Message-ID: <87wnwafprh.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jan 2021, Arnd Bergmann <arnd@kernel.org> wrote:
> On Mon, Jan 18, 2021 at 11:56 AM Adrian Ratiu 
> <adrian.ratiu@collabora.com> wrote: 
>> 
>> From: Nathan Chancellor <natechancellor@gmail.com> 
>> 
>> Drop warning because kernel now requires GCC >= v4.9 after 
>> commit 6ec4476ac825 ("Raise gcc version requirement to 4.9") 
>> and clarify that -ftree-vectorize now always needs enabling for 
>> GCC by directly testing the presence of CONFIG_CC_IS_GCC. 
>> 
>> Another reason to remove the warning is that Clang exposes 
>> itself as GCC < 4.6 so it triggers the warning about GCC which 
>> doesn't make much sense and risks misleading users. 
>> 
>> As a side-note remark, -fttree-vectorize is on by default in 
>> Clang, but it currently does not work (see linked issues). 
>> 
>> Link: https://github.com/ClangBuiltLinux/linux/issues/496 Link: 
>> https://github.com/ClangBuiltLinux/linux/issues/503 
>> Reported-by: Nick Desaulniers <ndesaulniers@google.com> 
>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com> 
>> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com> 
>> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com> 
> 
> Shouldn't there be a check for whatever minimum version of clang 
> produces optimized code now? As I understand it, the warning was 
> originally meant to complain about both old gcc and any version 
> of clang, while waiting for a new version of clang to produce 
> vectorized code. 
> 
> Has that happened now? 

No, clang does not produce vectorized code by default, not even 
with the -ftree-vectorize flag explicitely added like in the next 
patch in this series (that flag is enabled by default in clang 
anyway, so no effect).

Clang needs more investigation and testing because with additional 
code changes it can be "forced" to output vectorized code, but 
that is outside the scope of this series.

If you think it's a good idea I can add a warning only for Clang 
which makes more sense than telling clang users to upgrade their 
GCC, since now Clang is officially supported. What do you think?


>
>        Arnd
