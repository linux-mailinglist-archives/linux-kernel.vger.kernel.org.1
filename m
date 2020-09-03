Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328AC25CC87
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 23:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgICVor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 17:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgICVoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 17:44:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5213C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 14:44:43 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id w186so3162621pgb.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 14:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wkni4eXx9E7Yx63VN0+vnviLhaoHNM+yB8xZjp7w5hM=;
        b=O5o59mUdRprA27/bBNjMETG5FChmb/k7jW6G/CEqPxqkNExuhCDFNEGkwkwsAAOk9B
         S/ND1TkN2Kb21Yt+dermQ1eJzMamhppfZcA/5BLAHvK0xooF6lH1S7/GgEK+o+mFn5sC
         Q+9Q6xNOHekU+wFfZY8e2e5GVn6y3TV0ytjI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wkni4eXx9E7Yx63VN0+vnviLhaoHNM+yB8xZjp7w5hM=;
        b=iXJOjSnckWDCzw18yicXkQWRidFNlPsYRkd2uyB0fTZkxda+CSSUY/DTabveWXBDcB
         3L2+BCyaOsdZOBV4FBCo2XeS7po0vO7Ap4RqFxpQs8+QPxQq9wKMqBcsEMS3DBncnViT
         coz+r5ixqHob9OoaVLAGI/TolT3mNTiY+NwDLPMcuOjMqT7V7k2LLdGiwvMYCeb/7FP+
         oX4O7/lpAtm/Pn0T3ApI9Tqn/XowM8LLKPW+QdXJlB2op79zc5fMPdGbzwvnNX6BAEGx
         jSna9dZ3DhR+TFBq59SwsQpjouJKiNnyjnOQ6o0hhGweZKSW7vTfzP7Yb85xb3iQdd6u
         fdCw==
X-Gm-Message-State: AOAM531nUIcUPzIlgCXHNNTiwdL6v2HmkmVfyZv4fuNSSR00CxmUEMIu
        uA9y37ilDNMoNjgL/KEioQRYaQ==
X-Google-Smtp-Source: ABdhPJzAv2fIwHx5fjsh6FyQ4DUXacQqnpd1HrcO3mYGfEva7Q9zQka0PVlCAE3Ap8Ww7DWt19mfFg==
X-Received: by 2002:a62:1809:: with SMTP id 9mr5726960pfy.217.1599169483379;
        Thu, 03 Sep 2020 14:44:43 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d77sm4259177pfd.121.2020.09.03.14.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 14:44:42 -0700 (PDT)
Date:   Thu, 3 Sep 2020 14:44:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v2 01/28] x86/boot/compressed: Disable relocation
 relaxation
Message-ID: <202009031444.F2ECA89E@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-2-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-2-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:26PM -0700, Sami Tolvanen wrote:
> From: Arvind Sankar <nivedita@alum.mit.edu>
> 
> The x86-64 psABI [0] specifies special relocation types
> (R_X86_64_[REX_]GOTPCRELX) for indirection through the Global Offset
> Table, semantically equivalent to R_X86_64_GOTPCREL, which the linker
> can take advantage of for optimization (relaxation) at link time. This
> is supported by LLD and binutils versions 2.26 onwards.
> 
> The compressed kernel is position-independent code, however, when using
> LLD or binutils versions before 2.27, it must be linked without the -pie
> option. In this case, the linker may optimize certain instructions into
> a non-position-independent form, by converting foo@GOTPCREL(%rip) to $foo.
> 
> This potential issue has been present with LLD and binutils-2.26 for a
> long time, but it has never manifested itself before now:
> - LLD and binutils-2.26 only relax
> 	movq	foo@GOTPCREL(%rip), %reg
>   to
> 	leaq	foo(%rip), %reg
>   which is still position-independent, rather than
> 	mov	$foo, %reg
>   which is permitted by the psABI when -pie is not enabled.
> - gcc happens to only generate GOTPCREL relocations on mov instructions.
> - clang does generate GOTPCREL relocations on non-mov instructions, but
>   when building the compressed kernel, it uses its integrated assembler
>   (due to the redefinition of KBUILD_CFLAGS dropping -no-integrated-as),
>   which has so far defaulted to not generating the GOTPCRELX
>   relocations.
> 
> Nick Desaulniers reports [1,2]:
>   A recent change [3] to a default value of configuration variable
>   (ENABLE_X86_RELAX_RELOCATIONS OFF -> ON) in LLVM now causes Clang's
>   integrated assembler to emit R_X86_64_GOTPCRELX/R_X86_64_REX_GOTPCRELX
>   relocations. LLD will relax instructions with these relocations based
>   on whether the image is being linked as position independent or not.
>   When not, then LLD will relax these instructions to use absolute
>   addressing mode (R_RELAX_GOT_PC_NOPIC). This causes kernels built with
>   Clang and linked with LLD to fail to boot.
> 
> Patch series [4] is a solution to allow the compressed kernel to be
> linked with -pie unconditionally, but even if merged is unlikely to be
> backported. As a simple solution that can be applied to stable as well,
> prevent the assembler from generating the relaxed relocation types using
> the -mrelax-relocations=no option. For ease of backporting, do this
> unconditionally.
> 
> [0] https://gitlab.com/x86-psABIs/x86-64-ABI/-/blob/master/x86-64-ABI/linker-optimization.tex#L65
> [1] https://lore.kernel.org/lkml/20200807194100.3570838-1-ndesaulniers@google.com/
> [2] https://github.com/ClangBuiltLinux/linux/issues/1121
> [3] https://reviews.llvm.org/rGc41a18cf61790fc898dcda1055c3efbf442c14c0
> [4] https://lore.kernel.org/lkml/20200731202738.2577854-1-nivedita@alum.mit.edu/
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
