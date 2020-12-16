Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293DC2DBAF8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 07:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgLPGDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 01:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgLPGDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 01:03:36 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39121C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 22:02:56 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v1so908120pjr.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 22:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=dEIBkjaz1JW9MJFloIUwr6rBoz6T3L6jcYcfmy6MbLM=;
        b=oVQ1b2fn/FCW5ZZKajet+Qvo0XQF1rCG/NqwLfjNEnb85YRdmWcKxi8ic9qVEPXJ5A
         TMz5sBBjUT/a81k3ilJG4mKQo6mehjER6tNTzKDWc2Y9pRUMNtEbSvhGZCOUCZZBCHMH
         uZ2Fh3kSClNlRZOXKMXrwX9ehbTaQrJzoEiQpmwg1/v9QH6ZdFo3ePdSFD/43gBAj6Yp
         utS3xpoV4Oer5Jt5eWnc8+ByVPEt1PjSZlzvtaTwGzpFz8nAp2lgZtXSHwgz0U2IPmjd
         6MxTkJXuv0AHXcZw3mGf3sfDQxkltgG5aj4936GM3TFU4rCJKlu2iaLvuB3iUys54pFC
         X6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=dEIBkjaz1JW9MJFloIUwr6rBoz6T3L6jcYcfmy6MbLM=;
        b=rXTTDndFSTqJv5oZGvj1zwHBj/h9gvpQXEXxvQuSe49SbFa5sNAuOG8ssQHdoW47Dn
         f7GDbps4xcy1eNhCUtmoEU8T6wwLlb00mpZYNiZS4S0hE1/FKqlVWn5ZTq18jhYW2PUy
         LzbfxgUKmqFb9obnjPcyk4gHgszW00ZKgn7tI3ZXK70+F0Mezt+aYat2zqkY8g04l1BS
         VbUzJoStFx60VajK3VeaZSu6gqyPh7lvzserL+DyvhDeEjnM99VJdkfPMCxcPrtzx2Dv
         +iP6JA4IWy/twgBXUzDJCs3AXAzq1z2RU79cQ61aY7R4XirNmeYCtAewjoBIweYHmOZx
         wD+A==
X-Gm-Message-State: AOAM531kiMhzDY9zPR04uBrkbox3cT3RMrzguYu2Njsp+8FShT50k3wM
        N80kgR6yRwxRE84oeQz/CTd0dUIIqqK59kb5
X-Google-Smtp-Source: ABdhPJxKdwdNAxQUtCLfd/IMbi11HU9qicNckr4xevWaGtrPv5uwG19ZxWQCWZxhfsGVowD8JgfQkQ==
X-Received: by 2002:a17:90a:e60d:: with SMTP id j13mr1870046pjy.52.1608098575211;
        Tue, 15 Dec 2020 22:02:55 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v6sm953257pfi.31.2020.12.15.22.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 22:02:54 -0800 (PST)
Date:   Tue, 15 Dec 2020 22:02:54 -0800 (PST)
X-Google-Original-Date: Tue, 15 Dec 2020 22:02:50 PST (-0800)
Subject:     Re: [PATCH v3 3/5] RISC-V: Align the .init.text section
In-Reply-To: <20201105000439.1491243-4-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        Jim Wilson <jimw@sifive.com>, aou@eecs.berkeley.edu,
        akpm@linux-foundation.org, anup@brainfault.org, ardb@kernel.org,
        greentime.hu@sifive.com, ren_guo@c-sky.com,
        linux-riscv@lists.infradead.org, walken@google.com,
        ojeda@kernel.org, rppt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-5b9a6df7-f6a2-4db8-aaf9-b4e89115522d@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Nov 2020 16:04:37 PST (-0800), Atish Patra wrote:
> In order to improve kernel text protection, we need separate .init.text/
> .init.data/.text in separate sections. However, RISC-V linker relaxation
> code is not aware of any alignment between sections. As a result, it may
> relax any RISCV_CALL relocations between sections to JAL without realizing
> that an inter section alignment may move the address farther. That may
> lead to a relocation truncated fit error. However, linker relaxation code
> is aware of the individual section alignments.
>
> The detailed discussion on this issue can be found here.
> https://github.com/riscv/riscv-gnu-toolchain/issues/738
>
> Keep the .init.text section aligned so that linker relaxation will take
> that as a hint while relaxing inter section calls.
> Here are the code size changes for each section because of this change.
>
> section         change in size (in bytes)
>   .head.text      +4
>   .text           +40
>   .init.text      +6530
>   .exit.text      +84
>
> The only significant increase in size happened for .init.text because
> all intra relocations also use 2MB alignment.
>
> Suggested-by: Jim Wilson <jimw@sifive.com>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/vmlinux.lds.S | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index 3ffbd6cbdb86..cacd7898ba7f 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -30,7 +30,13 @@ SECTIONS
>  	. = ALIGN(PAGE_SIZE);
>
>  	__init_begin = .;
> -	INIT_TEXT_SECTION(PAGE_SIZE)
> +	__init_text_begin = .;
> +	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) ALIGN(SECTION_ALIGN) { \
> +		_sinittext = .;						\
> +		INIT_TEXT						\
> +		_einittext = .;						\
> +	}
> +
>  	. = ALIGN(8);
>  	__soc_early_init_table : {
>  		__soc_early_init_table_start = .;

Not sure what's going on here (or why I wasn't catching it earlier), but this
is breaking boot on one of my test configs.  I'm not getting any Linux boot
spew, so it's something fairly early.  I'm running defconfig with

    CONFIG_PREEMPT=y
    CONFIG_DEBUG_PREEMPT=y
    CONFIG_PROVE_LOCKING=y

It looks like that's been throwing a bunch of warnings for a while, but it did
at least used to boot.  No idea what PREEMPT would have to do with this, and
the other two don't generally trigger issues that early in boot (or at least,
trigger halts that early in boot).

There's a bunch of other stuff that depends on this that's on for-next so I
don't want to just drop it, but I also don't want to break something.  I'm just
running QEMU's virt board.

I'll take a look again tomorrow night, but if anyone has some time to look
that'd be great!

