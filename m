Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EE22B28DB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgKMW56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgKMW56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:57:58 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F51C0617A6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:57:58 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id f27so8303701pgl.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c8GixgWnF9JvI3p9D4QQqxEMTJGIS0uxRmnIsQ5izgo=;
        b=Ct1AIFE+vuR87KAbOc13resi7UCdNJ2/997/1bagYm67ZTq5HMzjWgz/Aboq3SNmC1
         +G5Nca7aODmzMkFhMFTgCcjb0egQRrRalhViOgy52gdKuN6fdnUkLg68wXd3rxxwL4GK
         YWimqfxXlMCzxWbgjBQSBYgR5V0wpsxJ5WxIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c8GixgWnF9JvI3p9D4QQqxEMTJGIS0uxRmnIsQ5izgo=;
        b=VIggkIR32OuRX6V0FfY1GNDh8kjYrKvEGFGouLAKg5d3qz1K2dAdv+khMPy209NJnM
         wXyO++ZmDBsbKGxwsmyw2klp+47T92T1/eSla/q9ml8RSob/6mIs2KneKfanvxCQmCyi
         /QMQkX5zrMEDxS8hUERPKf0w/i4Ik8O9e/aBmSqs0zJ1N4rlPIkTMIlX9hVs5n8Yrolr
         erGbto2uDqg0M6j94EvTxLv3BGm+bJkzAop1BMxzAiW2F8Iu3sdURheSqCCQronnS9Ig
         nHMq3g+DJzE7IdAIRgWsx7gwWWHzKDH6eNF5qhot9lDmSJ7CfvOrxOzjeTk6w5BrtqHC
         Ek3A==
X-Gm-Message-State: AOAM530QGMBm23GlU42BxsT/EjCjQ9W2GNES3EQlyQtQ/0VJLWG5HgjH
        r+slojGO4917KRKQLyjDDTSQ2A==
X-Google-Smtp-Source: ABdhPJwRJwTtnFY/6BjYKPSK+PmsQ0FoNu6LYAYkFl4fSh9ptNzAoTCp10JrrkbeynhU2uHt526eDg==
X-Received: by 2002:a17:90a:a602:: with SMTP id c2mr5297821pjq.224.1605308277714;
        Fri, 13 Nov 2020 14:57:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z7sm11158701pfq.214.2020.11.13.14.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 14:57:56 -0800 (PST)
Date:   Fri, 13 Nov 2020 14:57:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     guoren@kernel.org
Cc:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        bjorn.topel@gmail.com, atish.patra@wdc.com,
        cooper.qu@linux.alibaba.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH v4] riscv: Enable per-task stack canaries
Message-ID: <202011131457.63270B286@keescook>
References: <1603024697-30080-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603024697-30080-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 18, 2020 at 12:38:17PM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> This enables the use of per-task stack canary values if GCC has
> support for emitting the stack canary reference relative to the
> value of tp, which holds the task struct pointer in the riscv
> kernel.
> 
> After compare arm64 and x86 implementations, seems arm64's is more
> flexible and readable. The key point is how gcc get the offset of
> stack_canary from gs/el0_sp.
> 
> x86: Use a fix offset from gs, not flexible.
> 
> struct fixed_percpu_data {
> 	/*
> 	 * GCC hardcodes the stack canary as %gs:40.  Since the
> 	 * irq_stack is the object at %gs:0, we reserve the bottom
> 	 * 48 bytes of the irq stack for the canary.
> 	 */
> 	char            gs_base[40]; // :(
> 	unsigned long   stack_canary;
> };
> 
> arm64: Use -mstack-protector-guard-offset & guard-reg
> 	gcc options:
> 	-mstack-protector-guard=sysreg
> 	-mstack-protector-guard-reg=sp_el0
> 	-mstack-protector-guard-offset=xxx
> 
> riscv: Use -mstack-protector-guard-offset & guard-reg
> 	gcc options:
> 	-mstack-protector-guard=tls
> 	-mstack-protector-guard-reg=tp
> 	-mstack-protector-guard-offset=xxx
> 
>  GCC's implementation has been merged:
>  commit c931e8d5a96463427040b0d11f9c4352ac22b2b0
>  Author: Cooper Qu <cooper.qu@linux.alibaba.com>
>  Date:   Mon Jul 13 16:15:08 2020 +0800
> 
>      RISC-V: Add support for TLS stack protector canary access
> 
> In the end, these codes are inserted by gcc before return:
> 
> *  0xffffffe00020b396 <+120>:   ld      a5,1008(tp) # 0x3f0
> *  0xffffffe00020b39a <+124>:   xor     a5,a5,a4
> *  0xffffffe00020b39c <+126>:   mv      a0,s5
> *  0xffffffe00020b39e <+128>:   bnez    a5,0xffffffe00020b61c <_do_fork+766>
>    0xffffffe00020b3a2 <+132>:   ld      ra,136(sp)
>    0xffffffe00020b3a4 <+134>:   ld      s0,128(sp)
>    0xffffffe00020b3a6 <+136>:   ld      s1,120(sp)
>    0xffffffe00020b3a8 <+138>:   ld      s2,112(sp)
>    0xffffffe00020b3aa <+140>:   ld      s3,104(sp)
>    0xffffffe00020b3ac <+142>:   ld      s4,96(sp)
>    0xffffffe00020b3ae <+144>:   ld      s5,88(sp)
>    0xffffffe00020b3b0 <+146>:   ld      s6,80(sp)
>    0xffffffe00020b3b2 <+148>:   ld      s7,72(sp)
>    0xffffffe00020b3b4 <+150>:   addi    sp,sp,144
>    0xffffffe00020b3b6 <+152>:   ret
>    ...
> *  0xffffffe00020b61c <+766>:   auipc   ra,0x7f8
> *  0xffffffe00020b620 <+770>:   jalr    -1764(ra) # 0xffffffe000a02f38 <__stack_chk_fail>
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>

Thanks for getting this working! It looks good to me. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
