Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB4F2C3F65
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgKYL5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:57:44 -0500
Received: from ozlabs.org ([203.11.71.1]:52839 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbgKYL5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:57:43 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Cgzsd48jmz9sTR; Wed, 25 Nov 2020 22:57:41 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Mackerras <paulus@samba.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20201028080433.26799-1-ardb@kernel.org>
References: <20201028080433.26799-1-ardb@kernel.org>
Subject: Re: [PATCH] powerpc: avoid broken GCC __attribute__((optimize))
Message-Id: <160630540052.2174375.9307119240987760572.b4-ty@ellerman.id.au>
Date:   Wed, 25 Nov 2020 22:57:41 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 09:04:33 +0100, Ard Biesheuvel wrote:
> Commit 7053f80d9696 ("powerpc/64: Prevent stack protection in early boot")
> introduced a couple of uses of __attribute__((optimize)) with function
> scope, to disable the stack protector in some early boot code.
> 
> Unfortunately, and this is documented in the GCC man pages [0], overriding
> function attributes for optimization is broken, and is only supported for
> debug scenarios, not for production: the problem appears to be that
> setting GCC -f flags using this method will cause it to forget about some
> or all other optimization settings that have been applied.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Avoid broken GCC __attribute__((optimize))
      https://git.kernel.org/powerpc/c/a7223f5bfcaeade4a86d35263493bcda6c940891

cheers
