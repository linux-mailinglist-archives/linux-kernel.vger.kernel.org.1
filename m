Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295A4270AB9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 06:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgISEl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 00:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgISEl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 00:41:29 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4600EC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 21:41:29 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k13so4055823plk.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 21:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=0U+Dbiw8JUnuvLwJ+RFlNrwPxKsZPBsQuslXlMIRDCg=;
        b=VYQfGUEAu1xJLuJK5YTF17kGuh93Q5ohcNEDSoejfjVEt3m7CxO8A7tcG7NArx8/0E
         a5W1lLZgVlcr9x/t/TSsOh2I4v/4F1aoa4LLr0iNm1aRfzTu0TQZXVb317zLs+BSlnSH
         ARB6Z5n+2hRN6Hc0xVMTnSBKaSSDCHpBLI3ddFtup8AdiSi3n56bbU6wCkQLqud595Wx
         mL9wyWOI6o7OJ2xnlVXivkB0Pva17j0PCM/kknp6x4WwqC0IdNGZZjiXmCXdW8zRUIcT
         SabCsY2uLEzb3bLZ8mhu1kQPmSVDMp7N1CkybT5fiJ+/kH0dTfNcxmIiHBd2xK7ctNjF
         GfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=0U+Dbiw8JUnuvLwJ+RFlNrwPxKsZPBsQuslXlMIRDCg=;
        b=oYl580o6yoMxNC9ckT+dN0kWDPRkGTnWCBnB8rZRNqQ729zpuP+wA6ywwjKAuhZ6hd
         CZNOjDpHEcm6cZrfhTrxD33lIZXsLJdNAbH6UhPtTzVh5HaxNDS9JSsBBrBuZV31kQsi
         pIQY5i7espHc1hhUdJU7OPdYmiINiai/QWWSC/AiX4khuLSQzraU1HexRyn1BVn9vvKd
         PVwlULYUGYL3Jr5FYqBoL5vwSocDewvlXJmi6ByN6hD6biyLbzuS6+UlFRYSQuNKBh9b
         IEy+D1alDfVf8xxOQl636a6wrMx94p/Er5QNtsPJTx/lGgINwwBcevplRb8Qpf8BQTmQ
         URUg==
X-Gm-Message-State: AOAM530XUUPBybnC9k6Rpw7DsLosobmVR4SLZ3ZxLAM2W74Vx2GIEuXg
        FdkpLeJ8ZbAT0f1T/8wXV26ong==
X-Google-Smtp-Source: ABdhPJyB02vYW/ZXzBUzwm+xOgsNi4YTZThESy5B6wG3Zj++xNSulybh5FYd1yIMeM4g9UNRjmkveQ==
X-Received: by 2002:a17:902:ee54:b029:d1:f2ae:e2 with SMTP id 20-20020a170902ee54b02900d1f2ae00e2mr14059738plo.3.1600490488574;
        Fri, 18 Sep 2020 21:41:28 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id o20sm5044877pgh.63.2020.09.18.21.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 21:41:27 -0700 (PDT)
Date:   Fri, 18 Sep 2020 21:41:27 -0700 (PDT)
X-Google-Original-Date: Fri, 18 Sep 2020 21:41:25 PDT (-0700)
Subject:     Re: [PATCH] riscv: Add sfence.vma after page table changed
In-Reply-To: <CAHCEehKnFpdDamANoOfSJV2pbeMzjhxWja667PL6Sueid9imPw@mail.gmail.com>
CC:     catalin.marinas@arm.com, Will Deacon <willdeacon@google.com>,
        Marc Zyngier <maz@kernel.org>, mark.rutland@arm.com,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, aou@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>, syven.wang@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     greentime.hu@sifive.com
Message-ID: <mhng-9dba0867-f793-4cec-a3a0-82190bfcfde4@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 20:58:13 PDT (-0700), greentime.hu@sifive.com wrote:
> Palmer Dabbelt <palmer@dabbelt.com> 於 2020年8月5日 週三 上午10:03寫道：
>>
>> On Mon, 03 Aug 2020 20:29:32 PDT (-0700), anup@brainfault.org wrote:
>> > On Tue, Aug 4, 2020 at 8:32 AM Greentime Hu <greentime.hu@sifive.com> wrote:
>> >>
>> >> This patch addes local_flush_tlb_page(addr) to use sfence.vma after the
>> >
>> > s/addes/adds
>> >
>> >> page table changed. That address will be used immediately in
>> >> memset(nextp, 0, PAGE_SIZE) to cause this issue so we should add the
>> >> sfence.vma before we use it.
>> >
>> > Alternate version of this commit description can be:
>> >
>> > Invalidate local TLB after both set_pet() and clear_pte() because the
>> > address can be used immediately after page table change.
>> >
>> >> Fixes: f2c17aabc917 ("RISC-V: Implement compile-time fixed mappings")
>> >>
>> >> Reported-by: Syven Wang <syven.wang@sifive.com>
>> >> Signed-off-by: Syven Wang <syven.wang@sifive.com>
>> >> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
>> >> ---
>> >>  arch/riscv/mm/init.c | 7 +++----
>> >>  1 file changed, 3 insertions(+), 4 deletions(-)
>> >>
>> >> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
>> >> index f4adb3684f3d..29b0f7108054 100644
>> >> --- a/arch/riscv/mm/init.c
>> >> +++ b/arch/riscv/mm/init.c
>> >> @@ -202,12 +202,11 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
>> >>
>> >>         ptep = &fixmap_pte[pte_index(addr)];
>> >>
>> >> -       if (pgprot_val(prot)) {
>> >> +       if (pgprot_val(prot))
>> >>                 set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, prot));
>> >> -       } else {
>> >> +       else
>> >>                 pte_clear(&init_mm, addr, ptep);
>> >> -               local_flush_tlb_page(addr);
>> >> -       }
>> >> +       local_flush_tlb_page(addr);
>> >>  }
>>
>> arm64 appears to be upgrading all set_pte()s on valid kernel mappings to
>> include the fence.  It looks like the message from 7f0b1bf04511 ("arm64: Fix
>> barriers used for page table modifications") is out of date, as I can't find
>> create_mapping() any more.  If that was some generic kernel thing then we
>> should probably upgrade ours as well, but if it was arch/arm64/ code then this
>> approach seems fine as __set_fixmap() isn't on the hot path -- I guess this is
>> fine either way, but there may be other issues that the arm64 approach fixes.
>>
>> Do you guys happen to remember what was going on here?
>
> Hi Palmer,
>
> Some architectures add cache writeback in set_pte(), just like nds32, csky.
>
> https://github.com/torvalds/linux/blob/master/arch/nds32/include/asm/pgtable.h#L213
> https://github.com/torvalds/linux/blob/master/arch/csky/include/asm/pgtable.h#L104
>
> Would you like to pick this patch or should I send another patch to
> implement it in set_pte()?

Sorry, I forgot about this.  I'm picking up this patch on fixes, as it clearly
fixes a bug.  We might also have uncovered another bug, but there's no sense in
letting this one hang around until we figure that out.

I've cleaned up the comment text a bit, as Anup pointed out some issuses.

Thanks!
