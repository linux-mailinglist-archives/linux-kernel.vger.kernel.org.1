Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765A72D595C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 12:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388926AbgLJLfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 06:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389455AbgLJLak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:30:40 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3998BC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 03:29:56 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CsBXd6MtTz9sXK; Thu, 10 Dec 2020 22:29:53 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <cover.1597770847.git.christophe.leroy@csgroup.eu>
References: <cover.1597770847.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 00/25] powerpc: Switch signal 32 to using unsafe_put_user() and friends
Message-Id: <160756605381.1313423.4311071771094696481.b4-ty@ellerman.id.au>
Date:   Thu, 10 Dec 2020 22:29:53 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 17:19:11 +0000 (UTC), Christophe Leroy wrote:
> This series leads to a reduction from 2.55s to 1.73s of
> the system CPU time with the following microbench app
> on an mpc832x with KUAP (approx 32%)
> 
> This series replaces copies to users by unsafe_put_user() and friends
> with user_write_access_begin() dance in signal32.
> 
> [...]

Applied to powerpc/next.

[01/25] powerpc/signal: Move inline functions in signal.h
        https://git.kernel.org/powerpc/c/95593e930d7d067ca9bbee996c845248930a01f9
[02/25] powerpc/ptrace: Move declaration of ptrace_get_reg() and ptrace_set_reg()
        https://git.kernel.org/powerpc/c/67e364b3295f9dbf3b820d0edde86fb7c95efc98
[03/25] powerpc/ptrace: Consolidate reg index calculation
        https://git.kernel.org/powerpc/c/e009fa433542cd09d6279e361b767a1f44ffd29a
[04/25] powerpc/ptrace: Create ptrace_get_fpr() and ptrace_put_fpr()
        https://git.kernel.org/powerpc/c/4d90eb97e292c7b14de8ba59fded35b340c73101
[05/25] powerpc/signal: Don't manage floating point regs when no FPU
        https://git.kernel.org/powerpc/c/b6254ced4da6cf28d49fbffe24ee4b3286dcb3f4
[06/25] powerpc/32s: Allow deselecting CONFIG_PPC_FPU on mpc832x
        https://git.kernel.org/powerpc/c/7d68c89169508064c460a1208f38ed0589d226fa
[07/25] powerpc/signal: Remove BUG_ON() in handler_signal functions
        https://git.kernel.org/powerpc/c/3fcfb5d1bf731bdbd847c29df57a5372d8ea58d3
[08/25] powerpc/signal: Move access_ok() out of get_sigframe()
        https://git.kernel.org/powerpc/c/454b1abb588b3942655638a8bcf1ea4501260579
[09/25] powerpc/signal: Remove get_clean_sp()
        https://git.kernel.org/powerpc/c/0ecbc6ad18e324012234183e21805423f5e0cc79
[10/25] powerpc/signal: Call get_tm_stackpointer() from get_sigframe()
        https://git.kernel.org/powerpc/c/c180cb305c9bba094657259487d563c8fbfb648b
[11/25] powerpc/signal: Refactor bad frame logging
        https://git.kernel.org/powerpc/c/7fe8f773ee248c726cec2addcdb94056049d6e34
[12/25] powerpc/signal32: Simplify logging in handle_rt_signal32()
        https://git.kernel.org/powerpc/c/debf122c777f361137a3114db7be8aecc65f6af2
[13/25] powerpc/signal32: Move handle_signal32() close to handle_rt_signal32()
        https://git.kernel.org/powerpc/c/3eea688be0ccba2221e047b7df6f9ae87361cdd6
[14/25] powerpc/signal32: Rename local pointers in handle_rt_signal32()
        https://git.kernel.org/powerpc/c/8e91cf8501f14d8b6727c71c98fd743e95e9b402
[15/25] powerpc/signal32: Misc changes to make handle_[rt_]_signal32() more similar
        https://git.kernel.org/powerpc/c/91b8ecd419cb46058e99b3a574184883c02b7729
[16/25] powerpc/signal32: Move signal trampoline setup to handle_[rt_]signal32
        https://git.kernel.org/powerpc/c/8d33001dd650b88e915a1a13e2ca807350e374df
[17/25] powerpc/signal32: Switch handle_signal32() to user_access_begin() logic
        https://git.kernel.org/powerpc/c/ad65f4909fd3736d84533784cd9ab76905536b34
[18/25] powerpc/signal32: Switch handle_rt_signal32() to user_access_begin() logic
        https://git.kernel.org/powerpc/c/9504db3e90b22dca19d8152ed5a82c68512dac0e
[19/25] powerpc/signal32: Remove ifdefery in middle of if/else
        https://git.kernel.org/powerpc/c/f1cf4f93de2ff66313a091320d7683735816a0bc
[20/25] signal: Add unsafe_put_compat_sigset()
        https://git.kernel.org/powerpc/c/14026b94ccfe626e512bc9fa01e0e72ee75c7a98
[21/25] powerpc/signal32: Add and use unsafe_put_sigset_t()
        https://git.kernel.org/powerpc/c/de781ebdf6b8a256742da4fd6b0e39bb22ed9fe3
[22/25] powerpc/signal32: Switch swap_context() to user_access_begin() logic
        https://git.kernel.org/powerpc/c/31147d7d6133ea17504b118114a191a8af85f3de
[23/25] powerpc/signal: Create 'unsafe' versions of copy_[ck][fpr/vsx]_to_user()
        https://git.kernel.org/powerpc/c/b3484a1d4d1fb54ad7b615a13003d8bc11919c96
[24/25] powerpc/signal32: Isolate non-copy actions in save_user_regs() and save_tm_user_regs()
        https://git.kernel.org/powerpc/c/968c4fccd1bb8b440326dac5078ad87d17af4a47
[25/25] powerpc/signal32: Transform save_user_regs() and save_tm_user_regs() in 'unsafe' version
        https://git.kernel.org/powerpc/c/ef75e73182949a94bde169a774de1b62ae21fbbc

cheers
