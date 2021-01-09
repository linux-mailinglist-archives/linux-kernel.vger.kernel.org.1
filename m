Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428AA2F038F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 21:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbhAIUnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 15:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbhAIUnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 15:43:41 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2665BC061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 12:43:01 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id c132so9950356pga.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 12:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=iDC8zu1DnkHayfNIvehs/kpoM8d8bZ4+CgqaiflpHGo=;
        b=DjbCOGe9WIyDX24Jo8PAIImBM0mrum3QfT+hTtSRZt9/9kAUBg10owQ7/XURwWvORw
         BfnjCnFUEkBiEsPEPZiutaMMfA+XbBdkD3MKd80mQHdz88C37OcnYIu83HMU4AyTYE0K
         BJOF3xJn9qzr6bUaghVmW8QIS8CncIGplVvVORNZksx3eEYMLynwKXplw0f73c11LAm7
         PfkMwagmjNVLlixc5tWnWCelSbtFmwjWYjIQwn4hCEoaOOLwhlLroxrKBUgF/cM0rtcA
         cXcW/zBCczJUwndN1Kz2TtUPsO06oxywsJqYCQ98AfxGjphk7rzrDsLf33dNnxHtpv2M
         0+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=iDC8zu1DnkHayfNIvehs/kpoM8d8bZ4+CgqaiflpHGo=;
        b=seutn7KkOWFmW0Bw1t+eqKsNytRH9VUYxRoS+0bcALhpD2GrjsWEhPaGwCMQpuYf++
         +4A58LFGXfXLXoDzWxZSOfqEdzYxFg+CqqUub9qLhPk0mu+6VYiGwR9KbF6NGQWrxwOT
         Phh6dls7gIO5KDQHULsrHYgkR2RTfzSn2lNM/0G+Tp4APLTZrkVm+uYD+p5zcwKfmgn8
         la4anJhWeYSfY5MJUxp2V2uIA2uIPlF2luWrUfJL5SuOt39dOXgny8aaCLP5hs5/XdR4
         UsUj+amIepttPZFuoaOHyFKbzkX80hCYH6tRnJdRe7ulK3UpwoF46Mx58j9nme1YlZjM
         bpkg==
X-Gm-Message-State: AOAM531Lr1HQZcm3kvA8d5X6+aFXZ/6/KVgO/Mwu4owJ1Xt4YMoAGJjF
        +g7lDHyx5jAjk55w9d60EMJcGg==
X-Google-Smtp-Source: ABdhPJw2glJ1RJ6LkYDXffm3GGsIit0j65/2pHvNzTsMsL4wCNfz5snM6XVu/ivVy5nTWLwje6g+cA==
X-Received: by 2002:a62:a502:0:b029:1ae:6d07:b10f with SMTP id v2-20020a62a5020000b02901ae6d07b10fmr9698738pfm.12.1610224980710;
        Sat, 09 Jan 2021 12:43:00 -0800 (PST)
Received: from ?IPv6:2600:1010:b057:c69:2465:1316:86ee:af99? ([2600:1010:b057:c69:2465:1316:86ee:af99])
        by smtp.gmail.com with ESMTPSA id t206sm13334338pgb.84.2021.01.09.12.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 12:42:59 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/vm86/32: Remove VM86_SCREEN_BITMAP support
Date:   Sat, 9 Jan 2021 12:42:57 -0800
Message-Id: <F808C59D-03FD-47C6-A081-5184AF17AE2D@amacapital.net>
References: <87wnwl27dp.fsf@x220.int.ebiederm.org>
Cc:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        Yu Zhao <yuzhao@google.com>, Peter Xu <peterx@redhat.com>
In-Reply-To: <87wnwl27dp.fsf@x220.int.ebiederm.org>
To:     ebiederm@xmission.com
X-Mailer: iPhone Mail (18B121)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 9, 2021, at 12:17 PM, ebiederm@xmission.com wrote:
>=20
> =EF=BB=BFAndy Lutomirski <luto@kernel.org> writes:
>=20
>> The implementation was rather buggy.  It unconditionally marked PTEs
>> read-only, even for VM_SHARED mappings.  I'm not sure whether this is
>> actually a problem, but it certainly seems unwise.  More importantly, it
>> released the mmap lock before flushing the TLB, which could allow a racin=
g
>> CoW operation to falsely believe that the underlying memory was not
>> writable.
>>=20
>> I can't find any users at all of this mechanism, so just remove it.
>=20
> In another age this was used by dosemu.  Have you looked at dosemu to
> see if it still uses this support (on 32bit where dosemu can use vm86)?
>=20
> It may still be a valid removal target I just wanted to point out what
> the original user was.

I=E2=80=99m pretty sure that dosemu2 does not use this support.  I think the=
 original dosemu doesn=E2=80=99t either, but I=E2=80=99m also not convinced i=
t has any users at all.

I meant to cc Stas, and I will for v2.

>=20
> Eric
>=20
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Linux-MM <linux-mm@kvack.org>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: x86@kernel.org
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Jann Horn <jannh@google.com>
>> Cc: Jan Kara <jack@suse.cz>
>> Cc: Yu Zhao <yuzhao@google.com>
>> Cc: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Andy Lutomirski <luto@kernel.org>
>> ---
>> arch/x86/include/uapi/asm/vm86.h |  2 +-
>> arch/x86/kernel/vm86_32.c        | 55 ++++++--------------------------
>> 2 files changed, 10 insertions(+), 47 deletions(-)
>>=20
>> diff --git a/arch/x86/include/uapi/asm/vm86.h b/arch/x86/include/uapi/asm=
/vm86.h
>> index d2ee4e307ef8..50004fb4590d 100644
>> --- a/arch/x86/include/uapi/asm/vm86.h
>> +++ b/arch/x86/include/uapi/asm/vm86.h
>> @@ -106,7 +106,7 @@ struct vm86_struct {
>> /*
>>  * flags masks
>>  */
>> -#define VM86_SCREEN_BITMAP    0x0001
>> +#define VM86_SCREEN_BITMAP    0x0001        /* no longer supported */
>>=20
>> struct vm86plus_info_struct {
>>    unsigned long force_return_for_pic:1;
>> diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
>> index 764573de3996..28b9e8d511e1 100644
>> --- a/arch/x86/kernel/vm86_32.c
>> +++ b/arch/x86/kernel/vm86_32.c
>> @@ -160,49 +160,6 @@ void save_v86_state(struct kernel_vm86_regs *regs, i=
nt retval)
>>    do_exit(SIGSEGV);
>> }
>>=20
>> -static void mark_screen_rdonly(struct mm_struct *mm)
>> -{
>> -    struct vm_area_struct *vma;
>> -    spinlock_t *ptl;
>> -    pgd_t *pgd;
>> -    p4d_t *p4d;
>> -    pud_t *pud;
>> -    pmd_t *pmd;
>> -    pte_t *pte;
>> -    int i;
>> -
>> -    mmap_write_lock(mm);
>> -    pgd =3D pgd_offset(mm, 0xA0000);
>> -    if (pgd_none_or_clear_bad(pgd))
>> -        goto out;
>> -    p4d =3D p4d_offset(pgd, 0xA0000);
>> -    if (p4d_none_or_clear_bad(p4d))
>> -        goto out;
>> -    pud =3D pud_offset(p4d, 0xA0000);
>> -    if (pud_none_or_clear_bad(pud))
>> -        goto out;
>> -    pmd =3D pmd_offset(pud, 0xA0000);
>> -
>> -    if (pmd_trans_huge(*pmd)) {
>> -        vma =3D find_vma(mm, 0xA0000);
>> -        split_huge_pmd(vma, pmd, 0xA0000);
>> -    }
>> -    if (pmd_none_or_clear_bad(pmd))
>> -        goto out;
>> -    pte =3D pte_offset_map_lock(mm, pmd, 0xA0000, &ptl);
>> -    for (i =3D 0; i < 32; i++) {
>> -        if (pte_present(*pte))
>> -            set_pte(pte, pte_wrprotect(*pte));
>> -        pte++;
>> -    }
>> -    pte_unmap_unlock(pte, ptl);
>> -out:
>> -    mmap_write_unlock(mm);
>> -    flush_tlb_mm_range(mm, 0xA0000, 0xA0000 + 32*PAGE_SIZE, PAGE_SHIFT, f=
alse);
>> -}
>> -
>> -
>> -
>> static int do_vm86_irq_handling(int subfunction, int irqnumber);
>> static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool pl=
us);
>>=20
>> @@ -282,6 +239,15 @@ static long do_sys_vm86(struct vm86plus_struct __use=
r *user_vm86, bool plus)
>>            offsetof(struct vm86_struct, int_revectored)))
>>        return -EFAULT;
>>=20
>> +
>> +    /* VM86_SCREEN_BITMAP had numerous bugs and appears to have no users=
. */
>> +    if (v.flags & VM86_SCREEN_BITMAP) {
>> +        char comm[TASK_COMM_LEN];
>> +
>> +        pr_info_once("vm86: '%s' uses VM86_SCREEN_BITMAP, which is no lo=
nger supported\n", get_task_comm(comm, current);
>> +        return -EINVAL;
>> +    }
>> +
>>    memset(&vm86regs, 0, sizeof(vm86regs));
>>=20
>>    vm86regs.pt.bx =3D v.regs.ebx;
>> @@ -370,9 +336,6 @@ static long do_sys_vm86(struct vm86plus_struct __user=
 *user_vm86, bool plus)
>>    update_task_stack(tsk);
>>    preempt_enable();
>>=20
>> -    if (vm86->flags & VM86_SCREEN_BITMAP)
>> -        mark_screen_rdonly(tsk->mm);
>> -
>>    memcpy((struct kernel_vm86_regs *)regs, &vm86regs, sizeof(vm86regs));
>>    return regs->ax;
>> }
