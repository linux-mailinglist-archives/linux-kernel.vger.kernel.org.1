Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34C942E180A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 05:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgLWEPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 23:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgLWEPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 23:15:15 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB4EC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 20:14:35 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id i7so9781687pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 20:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=DpJfWZlzSKSP4XNPXNftOM5U8d4zQSgq/lLxvEzZ7Mg=;
        b=1qieBuMMitK+X2gMsnpWu/s0ICcZDSdIaD+QOjaZtQJjNfvLpFy0SqOUQ3YoSQn7g+
         eRK8xmyXxreqiB8derpCCBzSUj9QtCGZk/zKf3zC7BH6jadaGHTyCt+zsGxTWzPCkLGo
         LJqmcrYhVkQtJR09xLvQOI63RBDUNmgO7Rph+dHO+tQtSEL+pJtGX1XFvy6rYHKxk4Y6
         U23ix2LUKN/rDL0cjCJ5nOaej+dN4mA4wqVwWTHZJ+algKl7Z7IwQXf+kTDPK+XvMwzh
         vP0Vj4ri9mT9VBg0bOIAD27vWMyDp9BJzVm5jbrgpGDGXIrFHAv+rVOMv4zIgjEyVyyu
         nDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=DpJfWZlzSKSP4XNPXNftOM5U8d4zQSgq/lLxvEzZ7Mg=;
        b=PC6mZlVF3IiyTLzzO0Yx7SJ4uGew0OOqjv5FyhqKUhu2Pjc9od74kCIkA7v10AEupB
         uRe6Z3wODYaVBUcs0GxfhUuC5nvwgnv8d7qyGPGsecNhrmigXgs4FaiIgjH+Ue6wMqVm
         Av1r+MTqwcoPzaNINe4+30tTZmgpjXJUQSkD8uQk8zuaQvh2Yk8zyYrgP40IPEouUmI9
         FE1g8ZDvxRkr+y3a7S4gbYyWNg5XuNxrc+KdneBPdeWPbDKU3MkmUutCHcoBeJm74quk
         HiHODXp8CyvwSPt6YpQ+1/dB1FIUYZZJ7XsOF8OqxPNyxC3eBVWr/EdlICHmwbrhlQNX
         ASVw==
X-Gm-Message-State: AOAM531zh3Yo70Jxf15tIk6mx8G9zWlbnDNYdqfnLc5Hq1xDkDj2zc/X
        MSiF48asahm/BrHdLFJyRh/0BKq3g+t8DBe9
X-Google-Smtp-Source: ABdhPJxVcS9QqGDj7wMtPI2XxmwojfmqaaRAx+h6rP/IKY2hNJdArm0Dy8uOHFC/Dm59FGWSf0MBxg==
X-Received: by 2002:a62:1ec1:0:b029:1a8:2c01:13c0 with SMTP id e184-20020a621ec10000b02901a82c0113c0mr714346pfe.8.1608696874413;
        Tue, 22 Dec 2020 20:14:34 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q9sm21999214pgb.82.2020.12.22.20.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 20:14:33 -0800 (PST)
Date:   Tue, 22 Dec 2020 20:14:33 -0800 (PST)
X-Google-Original-Date: Tue, 22 Dec 2020 20:14:31 PST (-0800)
Subject:     Re: [PATCH v3 3/5] RISC-V: Align the .init.text section
In-Reply-To: <CAOnJCU+T3QcZbC0N5h0+916=V-8NSp2O7eZ83F-AUJf5-cTx5A@mail.gmail.com>
CC:     Alistair Francis <Alistair.Francis@wdc.com>, aou@eecs.berkeley.edu,
        zong.li@sifive.com, anup@brainfault.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Atish Patra <Atish.Patra@wdc.com>, ren_guo@c-sky.com,
        Paul Walmsley <paul.walmsley@sifive.com>, ojeda@kernel.org,
        greentime.hu@sifive.com, akpm@linux-foundation.org,
        walken@google.com, ardb@kernel.org, rppt@kernel.org,
        Jim Wilson <jimw@sifive.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-3b4b9aaa-92d1-4f82-a4d3-ce6b24453877@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Dec 2020 00:19:09 PST (-0800), atishp@atishpatra.org wrote:
> On Thu, Dec 17, 2020 at 12:33 AM Atish Patra <atishp@atishpatra.org> wrote:
>>
>> On Wed, Dec 16, 2020 at 10:51 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> >
>> > On Tue, 15 Dec 2020 22:02:54 PST (-0800), Palmer Dabbelt wrote:
>> > > On Wed, 04 Nov 2020 16:04:37 PST (-0800), Atish Patra wrote:
>> > >> In order to improve kernel text protection, we need separate .init.text/
>> > >> .init.data/.text in separate sections. However, RISC-V linker relaxation
>> > >> code is not aware of any alignment between sections. As a result, it may
>> > >> relax any RISCV_CALL relocations between sections to JAL without realizing
>> > >> that an inter section alignment may move the address farther. That may
>> > >> lead to a relocation truncated fit error. However, linker relaxation code
>> > >> is aware of the individual section alignments.
>> > >>
>> > >> The detailed discussion on this issue can be found here.
>> > >> https://github.com/riscv/riscv-gnu-toolchain/issues/738
>> > >>
>> > >> Keep the .init.text section aligned so that linker relaxation will take
>> > >> that as a hint while relaxing inter section calls.
>> > >> Here are the code size changes for each section because of this change.
>> > >>
>> > >> section         change in size (in bytes)
>> > >>   .head.text      +4
>> > >>   .text           +40
>> > >>   .init.text      +6530
>> > >>   .exit.text      +84
>> > >>
>> > >> The only significant increase in size happened for .init.text because
>> > >> all intra relocations also use 2MB alignment.
>> > >>
>> > >> Suggested-by: Jim Wilson <jimw@sifive.com>
>> > >> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> > >> ---
>> > >>  arch/riscv/kernel/vmlinux.lds.S | 8 +++++++-
>> > >>  1 file changed, 7 insertions(+), 1 deletion(-)
>> > >>
>> > >> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
>> > >> index 3ffbd6cbdb86..cacd7898ba7f 100644
>> > >> --- a/arch/riscv/kernel/vmlinux.lds.S
>> > >> +++ b/arch/riscv/kernel/vmlinux.lds.S
>> > >> @@ -30,7 +30,13 @@ SECTIONS
>> > >>      . = ALIGN(PAGE_SIZE);
>> > >>
>> > >>      __init_begin = .;
>> > >> -    INIT_TEXT_SECTION(PAGE_SIZE)
>> > >> +    __init_text_begin = .;
>> > >> +    .init.text : AT(ADDR(.init.text) - LOAD_OFFSET) ALIGN(SECTION_ALIGN) { \
>> > >> +            _sinittext = .;                                         \
>> > >> +            INIT_TEXT                                               \
>> > >> +            _einittext = .;                                         \
>> > >> +    }
>> > >> +
>> > >>      . = ALIGN(8);
>> > >>      __soc_early_init_table : {
>> > >>              __soc_early_init_table_start = .;
>> > >
>> > > Not sure what's going on here (or why I wasn't catching it earlier), but this
>> > > is breaking boot on one of my test configs.  I'm not getting any Linux boot
>> > > spew, so it's something fairly early.  I'm running defconfig with
>> > >
>> > >     CONFIG_PREEMPT=y
>> > >     CONFIG_DEBUG_PREEMPT=y
>> > >     CONFIG_PROVE_LOCKING=y
>> > >
>> > > It looks like that's been throwing a bunch of warnings for a while, but it did
>> > > at least used to boot.  No idea what PREEMPT would have to do with this, and
>> > > the other two don't generally trigger issues that early in boot (or at least,
>> > > trigger halts that early in boot).
>> > >
>
> I am able to reproduce this issue but with CONFIG_PROVE_LOCKING not
> CONFIG_PREEMPT.
> With CONFIG_PREEMPT, I see a bunch of warnings around smp_processor_id
> but it boots even with 5.0.
> If CONFIG_PROVE_LOCKING is enabled, I am not able to boot using 5.0.
> However, 5.2.0 works fine.
> I am going to take a look at the issue with 5.0 and PROVE_LOCKING.
>
> The config preempt warnings are resolved by the following patch. I
> have tested it in Qemu.
>
> https://patchwork.kernel.org/project/linux-riscv/patch/20201116081238.44223-1-wangkefeng.wang@huawei.com/

Thanks!

>
>> > > There's a bunch of other stuff that depends on this that's on for-next so I
>> > > don't want to just drop it, but I also don't want to break something.  I'm just
>> > > running QEMU's virt board.
>> > >
>>
>> I just verified for-next on QEMU 5.2.0 for virt (RV32,64, nommu) and
>> sifive_u as well.
>> I will give it a try on unleashed tomorrow as well with the above
>> configs enabled.
>>
>> > > I'll take a look again tomorrow night, but if anyone has some time to look
>> > > that'd be great!
>> >
>> > Looks like this breaks on QEMU 5.0.0 but works on 5.2.0.
>>
>> I will take a look tomorrow to check the root cause.
>>
>> I guess technically
>> > that means could be considered a regression, but as we don't really have any
>> > scheme for which old versions of QEMU we support it's not absolute.  I'd
>> > usually err on the side of keeping support for older platforms, but in this
>> > case it's probably just not worth the time so I'm going to just ignore it.
>> >
>> > _______________________________________________
>> > linux-riscv mailing list
>> > linux-riscv@lists.infradead.org
>> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
>>
>>
>> --
>> Regards,
>> Atish
