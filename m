Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F1C2DCCBF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 07:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgLQGvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 01:51:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726547AbgLQGvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 01:51:53 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD00C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 22:51:12 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id r4so14604358pls.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 22:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=A2L6oL6ADpLP0KoW9Pu9uKXnU693BVKyVAwaJ1jmZqk=;
        b=QEKst/rL0NDLTjaWaQ81OMKHsSIAvNH6uOLS8fgS8RMMf4zHzKwnBFyKUZeKBOPjz0
         vIbWWO+xvsaqxlmI85uVYTh9XarJMsqk1BK7vrKew3Ox7k8kzQhnV9yr6A1vWZQrvIkO
         ESJsHkYoJVhVW4IN05AaJLj+7MCYc8Q4u4wHqDeAtORb3NO81qD3zLzz23//ygzFW3hJ
         kyKpuLFyvfiTxeWSgGl43q+BFeeilNQaNsbWP612Ex4lOkfpN4hhXqvTBJBIW9HZl6th
         ddeQonf+4UzDMGCaCvh/0oxLD5w/y35XHIrt2nZr2QIeeyTmWBkvjmuK1/P3OGCLwNID
         2mLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=A2L6oL6ADpLP0KoW9Pu9uKXnU693BVKyVAwaJ1jmZqk=;
        b=WkuiGH5aF2zIKenww5Dj92G5sl6VDQSYLSmj3xuoC1xfRFrtRjbYtFU1VIIDLUO8eI
         krdgfCBzcqTxLcORVRNg4cEiYqw0w+UN5a5Asr5ganOECTN8kqRSompNnaXUSHED4tBG
         jaM1L0nxOf6nr6D3Vp70hhy0VV3tFOOVz+EKXULax8cdIQhj+EQeQBG0y7Gqp86iOrn8
         NXN3xqlRk1eA4Z58x7Y05covcs02/6T9n5ORR5f/p8pBapVeFWSbx/KIeejhWx8RvZgG
         QkR2PZcfPOt19gVAgLwADxFKsd5GI+DMBr26VaGUO+NwUs4RRaEZBjVSsrBwnt++CYzV
         N0Tw==
X-Gm-Message-State: AOAM530e26AsTJDC7iAHHRDt+/GwDqZ96/pYPTLi6V3wui9VF6MpPv3O
        KUfNvZ2xCFI3ZiKPoTeN0owUMg==
X-Google-Smtp-Source: ABdhPJxdUkeYMyF2EK90JXhK9sm4VgAdfvMOw2GsBXOw6TCNUrEtRZNEMLQFdFBE8SXz1E5qjrOekA==
X-Received: by 2002:a17:90a:e28f:: with SMTP id d15mr6652761pjz.10.1608187872349;
        Wed, 16 Dec 2020 22:51:12 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z13sm3979942pjt.45.2020.12.16.22.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 22:51:11 -0800 (PST)
Date:   Wed, 16 Dec 2020 22:51:11 -0800 (PST)
X-Google-Original-Date: Wed, 16 Dec 2020 22:51:07 PST (-0800)
Subject:     Re: [PATCH v3 3/5] RISC-V: Align the .init.text section
In-Reply-To: <mhng-5b9a6df7-f6a2-4db8-aaf9-b4e89115522d@palmerdabbelt-glaptop>
CC:     Atish Patra <Atish.Patra@wdc.com>, linux-kernel@vger.kernel.org,
        Atish Patra <Atish.Patra@wdc.com>,
        Jim Wilson <jimw@sifive.com>, aou@eecs.berkeley.edu,
        akpm@linux-foundation.org, anup@brainfault.org, ardb@kernel.org,
        greentime.hu@sifive.com, ren_guo@c-sky.com,
        linux-riscv@lists.infradead.org, walken@google.com,
        ojeda@kernel.org, rppt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-ec25b026-f312-4d65-9afb-1c34a5cac6c7@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Dec 2020 22:02:54 PST (-0800), Palmer Dabbelt wrote:
> On Wed, 04 Nov 2020 16:04:37 PST (-0800), Atish Patra wrote:
>> In order to improve kernel text protection, we need separate .init.text/
>> .init.data/.text in separate sections. However, RISC-V linker relaxation
>> code is not aware of any alignment between sections. As a result, it may
>> relax any RISCV_CALL relocations between sections to JAL without realizing
>> that an inter section alignment may move the address farther. That may
>> lead to a relocation truncated fit error. However, linker relaxation code
>> is aware of the individual section alignments.
>>
>> The detailed discussion on this issue can be found here.
>> https://github.com/riscv/riscv-gnu-toolchain/issues/738
>>
>> Keep the .init.text section aligned so that linker relaxation will take
>> that as a hint while relaxing inter section calls.
>> Here are the code size changes for each section because of this change.
>>
>> section         change in size (in bytes)
>>   .head.text      +4
>>   .text           +40
>>   .init.text      +6530
>>   .exit.text      +84
>>
>> The only significant increase in size happened for .init.text because
>> all intra relocations also use 2MB alignment.
>>
>> Suggested-by: Jim Wilson <jimw@sifive.com>
>> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> ---
>>  arch/riscv/kernel/vmlinux.lds.S | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
>> index 3ffbd6cbdb86..cacd7898ba7f 100644
>> --- a/arch/riscv/kernel/vmlinux.lds.S
>> +++ b/arch/riscv/kernel/vmlinux.lds.S
>> @@ -30,7 +30,13 @@ SECTIONS
>>  	. = ALIGN(PAGE_SIZE);
>>
>>  	__init_begin = .;
>> -	INIT_TEXT_SECTION(PAGE_SIZE)
>> +	__init_text_begin = .;
>> +	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) ALIGN(SECTION_ALIGN) { \
>> +		_sinittext = .;						\
>> +		INIT_TEXT						\
>> +		_einittext = .;						\
>> +	}
>> +
>>  	. = ALIGN(8);
>>  	__soc_early_init_table : {
>>  		__soc_early_init_table_start = .;
>
> Not sure what's going on here (or why I wasn't catching it earlier), but this
> is breaking boot on one of my test configs.  I'm not getting any Linux boot
> spew, so it's something fairly early.  I'm running defconfig with
>
>     CONFIG_PREEMPT=y
>     CONFIG_DEBUG_PREEMPT=y
>     CONFIG_PROVE_LOCKING=y
>
> It looks like that's been throwing a bunch of warnings for a while, but it did
> at least used to boot.  No idea what PREEMPT would have to do with this, and
> the other two don't generally trigger issues that early in boot (or at least,
> trigger halts that early in boot).
>
> There's a bunch of other stuff that depends on this that's on for-next so I
> don't want to just drop it, but I also don't want to break something.  I'm just
> running QEMU's virt board.
>
> I'll take a look again tomorrow night, but if anyone has some time to look
> that'd be great!

Looks like this breaks on QEMU 5.0.0 but works on 5.2.0.  I guess technically
that means could be considered a regression, but as we don't really have any
scheme for which old versions of QEMU we support it's not absolute.  I'd
usually err on the side of keeping support for older platforms, but in this
case it's probably just not worth the time so I'm going to just ignore it.
