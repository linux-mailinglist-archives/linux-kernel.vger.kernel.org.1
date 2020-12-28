Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D6E2E6A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 19:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbgL1SwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 13:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728014AbgL1SwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 13:52:02 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD273C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 10:51:22 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id i5so7806139pgo.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 10:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MT7WE2RSyCbGtuDCyPKbtyLz25UcvjpcuYev/WTGrqU=;
        b=Vkg5PVaLVC0ujFTl7nQquscVOVHYuEIEtB2nRj7WinwY2fyIHNj61NsQZV5nJBGm42
         elw3C2F9h+6G57l5uIFIK46JTEE/DYm+rzUM124ztVad8o6vHkUcXcvo06EKamWwDRy5
         zNFF2L9MXCn2ic/iYOsCg5E8ugQBq12uWp6HJ8DxXZdu1RtN6QSYiN+tyHA3ZHnl70y4
         nw+a6ST5AHUSLORauJIOc8pdBkP3yX/0Es0/LU+BCv3OkS+DuZgiKXbPEsEfXN72Ls5H
         HPKMZd75GZEnb5JzOaaUPvpdcp7fzfpAX5WojR3CLEuDg0ZUZAytWQMjSGWo8K52+UkG
         Aa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MT7WE2RSyCbGtuDCyPKbtyLz25UcvjpcuYev/WTGrqU=;
        b=pvovD84kueBeED7SY4uTq8bAJEJCant1hn26Mv18/Qhb9elPAU/gFVWaj728W/G0ro
         a+lOEXtwtr2r4Qhw/HYFtGZIYWRpaNzvjNqrK2GdrOTkfKa4uDqSnxYAXX1qdm6UW2MO
         OcfQUSjdA4iNIXES3ik97mSHW0vu5+K+xHqo0yYZWcpqNL/5DZcIeTFtvr9z5bvKZWD4
         sy/X6RrbZv139dP7EFv91Nzwgt+MvxaOOLQ2aHULBIt2qMEbWy4Cw7Mesvf3kc1kQ08N
         ZijlFI+ybN6Ck/86VXSzVFuYWooQ+XC5GhIABcP0w/FD5Bs6Sli17W2hUbLx7foyi/i7
         Ne6w==
X-Gm-Message-State: AOAM531XS/8m/AfGRJCoLgEQqV/nvhegnL00x+oz500fosNlRv245Yc6
        hEmibQ7ApCLuzNrhqCPqXSp+pT3ZF6c7Cw==
X-Google-Smtp-Source: ABdhPJyJZiABPbIldtTT/zyFc95r3TY4iuB4//dN2nEFb5U7Jn8vwWWlBKkI8UMmrTP8ulSQghwTuA==
X-Received: by 2002:aa7:9312:0:b029:1a3:82bd:83cc with SMTP id 18-20020aa793120000b02901a382bd83ccmr42417144pfj.11.1609181482119;
        Mon, 28 Dec 2020 10:51:22 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id ay21sm135313pjb.1.2020.12.28.10.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 10:51:21 -0800 (PST)
Date:   Mon, 28 Dec 2020 10:51:15 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 04/19] x86/insn-eval: Handle return values from the
 decoder
Message-ID: <X+opI92rzCNZ151F@google.com>
References: <20201223174233.28638-1-bp@alien8.de>
 <20201223174233.28638-5-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223174233.28638-5-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 23, 2020, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Now that the different instruction-inspecting functions return a value,
> test that and return early from callers if error has been encountered.
>
> While at it, do not call insn_get_modrm() when calling
> insn_get_displacement() because latter will make sure to call
> insn_get_modrm() if ModRM hasn't been parsed yet.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/lib/insn-eval.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
> index 265d23a0c334..7e49aaf5454c 100644
> --- a/arch/x86/lib/insn-eval.c
> +++ b/arch/x86/lib/insn-eval.c
> @@ -1106,18 +1106,21 @@ static int get_eff_addr_modrm_16(struct insn *insn, struct pt_regs *regs,
>   * @base_offset will have a register, as an offset from the base of pt_regs,
>   * that can be used to resolve the associated segment.
>   *
> - * -EINVAL on error.
> + * Negative value on error.
>   */
>  static int get_eff_addr_sib(struct insn *insn, struct pt_regs *regs,
>  			    int *base_offset, long *eff_addr)
>  {
>  	long base, indx;
>  	int indx_offset;
> +	int ret;
>  
>  	if (insn->addr_bytes != 8 && insn->addr_bytes != 4)
>  		return -EINVAL;
>  
> -	insn_get_modrm(insn);
> +	ret = insn_get_modrm(insn);

This patch is incomplete/inconsistent, and arguably wrong.

  - get_eff_addr_reg() and get_eff_addr_modrm() still ignore the return of
    insn_get_modrm() after this patch.

  - Calling insn_get_modrm() from get_eff_addr_sib() is unnecessary (unless the
    caller passed uninitialized garbage in @insn) as get_eff_addr_sib() is
    called if and only if sib.nbytes!=0, and sib.nbytes can be non-zero if and
    only if the modrm and sib have been got.

  - get_addr_ref_16() does insn_get_displacement, i.e. guarantees the modrm is
    parsed, while the 32/64 variants do not.

What about adding a prereq patch (or three) to call insn_get_displacement() in
insn_get_addr_ref() prior to switching on insn->addr_bytes?  Then the various
internal helpers could be changed to either omit the sanity checks entirely or
WARN on invalid calls?  Or better yet, add an INSN_WARN_ON() macro that compiles
out the checks by default?  E.g. something like:

diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 7e49aaf5454c..348969146e0f 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -928,12 +928,8 @@ static int get_seg_base_limit(struct insn *insn, struct pt_regs *regs,
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 7e49aaf5454c..348969146e0f 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -928,12 +928,8 @@ static int get_seg_base_limit(struct insn *insn, struct pt_regs *regs,
 static int get_eff_addr_reg(struct insn *insn, struct pt_regs *regs,
                            int *regoff, long *eff_addr)
 {
-       insn_get_modrm(insn);
-
-       if (!insn->modrm.nbytes)
-               return -EINVAL;
-
-       if (X86_MODRM_MOD(insn->modrm.value) != 3)
+       if (INSN_WARN_ON(!insn->modrm.got || !insn->modrm.nbytes ||
+                        X86_MODRM_MOD(insn->modrm.value) != 3)
                return -EINVAL;

        *regoff = get_reg_offset(insn, regs, REG_TYPE_RM);
@@ -978,15 +974,9 @@ static int get_eff_addr_modrm(struct insn *insn, struct pt_regs *regs,
 {
        long tmp;

-       if (insn->addr_bytes != 8 && insn->addr_bytes != 4)
-               return -EINVAL;
-
-       insn_get_modrm(insn);
-
-       if (!insn->modrm.nbytes)
-               return -EINVAL;
-
-       if (X86_MODRM_MOD(insn->modrm.value) > 2)
+       if (INSN_WARN_ON((insn->addr_bytes != 8 && insn->addr_bytes != 4) ||
+                        !insn->modrm.got || !insn->modrm.nbytes ||
+                        X86_MODRM_MOD(insn->modrm.value) > 2)
                return -EINVAL;

        *regoff = get_reg_offset(insn, regs, REG_TYPE_RM);
@@ -1046,15 +1036,8 @@ static int get_eff_addr_modrm_16(struct insn *insn, struct pt_regs *regs,
        int addr_offset1, addr_offset2, ret;
        short addr1 = 0, addr2 = 0, displacement;

-       if (insn->addr_bytes != 2)
-               return -EINVAL;
-
-       insn_get_modrm(insn);
-
-       if (!insn->modrm.nbytes)
-               return -EINVAL;
-
-       if (X86_MODRM_MOD(insn->modrm.value) > 2)
+       if (WARN_ON_ONCE(insn->addr_bytes != 2 || !insn->modrm.got ||
+                        !insn->modrm.nbytes || insn->modrm.value > 2))
                return -EINVAL;

        ret = get_reg_offset_16(insn, regs, &addr_offset1, &addr_offset2);
@@ -1199,10 +1182,7 @@ static void __user *get_addr_ref_16(struct insn *insn, struct pt_regs *regs)
        short eff_addr;
        long tmp;

-       if (insn_get_displacement(insn))
-               goto out;
-
-       if (insn->addr_bytes != 2)
+       if (INSN_WARN_ON(insn->addr_bytes != 2))
                goto out;

        if (X86_MODRM_MOD(insn->modrm.value) == 3) {
@@ -1263,7 +1243,7 @@ static void __user *get_addr_ref_32(struct insn *insn, struct pt_regs *regs)
        long tmp;
        int ret;

-       if (insn->addr_bytes != 4)
+       if (INSN_WARN_ON(insn->addr_bytes != 4))
                goto out;

        if (X86_MODRM_MOD(insn->modrm.value) == 3) {
@@ -1356,7 +1336,7 @@ static void __user *get_addr_ref_64(struct insn *insn, struct pt_regs *regs)
        int regoff, ret;
        long eff_addr;

-       if (insn->addr_bytes != 8)
+       if (INSN_WARN_ON(insn->addr_bytes != 8))
                goto out;

        if (X86_MODRM_MOD(insn->modrm.value) == 3) {
@@ -1408,6 +1388,9 @@ void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs)
        if (!insn || !regs)
                return (void __user *)-1L;

+       if (insn_get_displacement(insn))
+               return (void __user *)-1L;
+
        switch (insn->addr_bytes) {
        case 2:
                return get_addr_ref_16(insn, regs);

