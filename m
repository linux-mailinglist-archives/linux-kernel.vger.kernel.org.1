Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C282F0365
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 21:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbhAIUSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 15:18:18 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:59066 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbhAIUSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 15:18:17 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kyKg3-000C1r-5P; Sat, 09 Jan 2021 13:17:35 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kyKg1-002zDO-RD; Sat, 09 Jan 2021 13:17:34 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        Yu Zhao <yuzhao@google.com>, Peter Xu <peterx@redhat.com>
References: <3d34069ab2d249d866ea1d18a47e4170dbfb5982.1610132102.git.luto@kernel.org>
Date:   Sat, 09 Jan 2021 14:16:34 -0600
In-Reply-To: <3d34069ab2d249d866ea1d18a47e4170dbfb5982.1610132102.git.luto@kernel.org>
        (Andy Lutomirski's message of "Fri, 8 Jan 2021 10:55:05 -0800")
Message-ID: <87wnwl27dp.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kyKg1-002zDO-RD;;;mid=<87wnwl27dp.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19uC6CfjDUjhVI9OFmoq23lyzi5iE8hdC0=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4994]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Andy Lutomirski <luto@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 783 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 13 (1.7%), b_tie_ro: 11 (1.4%), parse: 1.73
        (0.2%), extract_message_metadata: 41 (5.2%), get_uri_detail_list: 6
        (0.7%), tests_pri_-1000: 46 (5.8%), tests_pri_-950: 1.41 (0.2%),
        tests_pri_-900: 1.09 (0.1%), tests_pri_-90: 210 (26.8%), check_bayes:
        181 (23.1%), b_tokenize: 13 (1.6%), b_tok_get_all: 12 (1.6%),
        b_comp_prob: 22 (2.8%), b_tok_touch_all: 118 (15.1%), b_finish: 5
        (0.6%), tests_pri_0: 450 (57.4%), check_dkim_signature: 1.06 (0.1%),
        check_dkim_adsp: 4.0 (0.5%), poll_dns_idle: 0.78 (0.1%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 13 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] x86/vm86/32: Remove VM86_SCREEN_BITMAP support
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> The implementation was rather buggy.  It unconditionally marked PTEs
> read-only, even for VM_SHARED mappings.  I'm not sure whether this is
> actually a problem, but it certainly seems unwise.  More importantly, it
> released the mmap lock before flushing the TLB, which could allow a racing
> CoW operation to falsely believe that the underlying memory was not
> writable.
>
> I can't find any users at all of this mechanism, so just remove it.

In another age this was used by dosemu.  Have you looked at dosemu to
see if it still uses this support (on 32bit where dosemu can use vm86)?

It may still be a valid removal target I just wanted to point out what
the original user was.

Eric

> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Linux-MM <linux-mm@kvack.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: x86@kernel.org
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Yu Zhao <yuzhao@google.com>
> Cc: Peter Xu <peterx@redhat.com>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/include/uapi/asm/vm86.h |  2 +-
>  arch/x86/kernel/vm86_32.c        | 55 ++++++--------------------------
>  2 files changed, 10 insertions(+), 47 deletions(-)
>
> diff --git a/arch/x86/include/uapi/asm/vm86.h b/arch/x86/include/uapi/asm/vm86.h
> index d2ee4e307ef8..50004fb4590d 100644
> --- a/arch/x86/include/uapi/asm/vm86.h
> +++ b/arch/x86/include/uapi/asm/vm86.h
> @@ -106,7 +106,7 @@ struct vm86_struct {
>  /*
>   * flags masks
>   */
> -#define VM86_SCREEN_BITMAP	0x0001
> +#define VM86_SCREEN_BITMAP	0x0001        /* no longer supported */
>  
>  struct vm86plus_info_struct {
>  	unsigned long force_return_for_pic:1;
> diff --git a/arch/x86/kernel/vm86_32.c b/arch/x86/kernel/vm86_32.c
> index 764573de3996..28b9e8d511e1 100644
> --- a/arch/x86/kernel/vm86_32.c
> +++ b/arch/x86/kernel/vm86_32.c
> @@ -160,49 +160,6 @@ void save_v86_state(struct kernel_vm86_regs *regs, int retval)
>  	do_exit(SIGSEGV);
>  }
>  
> -static void mark_screen_rdonly(struct mm_struct *mm)
> -{
> -	struct vm_area_struct *vma;
> -	spinlock_t *ptl;
> -	pgd_t *pgd;
> -	p4d_t *p4d;
> -	pud_t *pud;
> -	pmd_t *pmd;
> -	pte_t *pte;
> -	int i;
> -
> -	mmap_write_lock(mm);
> -	pgd = pgd_offset(mm, 0xA0000);
> -	if (pgd_none_or_clear_bad(pgd))
> -		goto out;
> -	p4d = p4d_offset(pgd, 0xA0000);
> -	if (p4d_none_or_clear_bad(p4d))
> -		goto out;
> -	pud = pud_offset(p4d, 0xA0000);
> -	if (pud_none_or_clear_bad(pud))
> -		goto out;
> -	pmd = pmd_offset(pud, 0xA0000);
> -
> -	if (pmd_trans_huge(*pmd)) {
> -		vma = find_vma(mm, 0xA0000);
> -		split_huge_pmd(vma, pmd, 0xA0000);
> -	}
> -	if (pmd_none_or_clear_bad(pmd))
> -		goto out;
> -	pte = pte_offset_map_lock(mm, pmd, 0xA0000, &ptl);
> -	for (i = 0; i < 32; i++) {
> -		if (pte_present(*pte))
> -			set_pte(pte, pte_wrprotect(*pte));
> -		pte++;
> -	}
> -	pte_unmap_unlock(pte, ptl);
> -out:
> -	mmap_write_unlock(mm);
> -	flush_tlb_mm_range(mm, 0xA0000, 0xA0000 + 32*PAGE_SIZE, PAGE_SHIFT, false);
> -}
> -
> -
> -
>  static int do_vm86_irq_handling(int subfunction, int irqnumber);
>  static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus);
>  
> @@ -282,6 +239,15 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
>  			offsetof(struct vm86_struct, int_revectored)))
>  		return -EFAULT;
>  
> +
> +	/* VM86_SCREEN_BITMAP had numerous bugs and appears to have no users. */
> +	if (v.flags & VM86_SCREEN_BITMAP) {
> +		char comm[TASK_COMM_LEN];
> +
> +		pr_info_once("vm86: '%s' uses VM86_SCREEN_BITMAP, which is no longer supported\n", get_task_comm(comm, current);
> +		return -EINVAL;
> +	}
> +
>  	memset(&vm86regs, 0, sizeof(vm86regs));
>  
>  	vm86regs.pt.bx = v.regs.ebx;
> @@ -370,9 +336,6 @@ static long do_sys_vm86(struct vm86plus_struct __user *user_vm86, bool plus)
>  	update_task_stack(tsk);
>  	preempt_enable();
>  
> -	if (vm86->flags & VM86_SCREEN_BITMAP)
> -		mark_screen_rdonly(tsk->mm);
> -
>  	memcpy((struct kernel_vm86_regs *)regs, &vm86regs, sizeof(vm86regs));
>  	return regs->ax;
>  }
