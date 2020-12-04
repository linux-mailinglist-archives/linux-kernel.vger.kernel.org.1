Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4D22CEAEB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729408AbgLDJaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgLDJaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:30:00 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BACAC061A51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 01:29:19 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id k10so4942746wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 01:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XiJ5BDEGoGYirLhZDEpjz2dLqBloYKJnO58y6bUjOOM=;
        b=IJnXQlvQibREByEcd15QSI5t14skxHKdSP/2K/F5YM1zbAJlfuU65bIDautsMCgRId
         zWJC/Z1AP0iMiI79G8lBm8kzclkRi66HScJPwK3R6wzKrFN+p5V/O4GmMnag0MKhY7tD
         ed9gqtcXQ2tSwmE15LdzjlbNM+JunmUrp1XYnSfYHKfya2wSQBKqL6XMPAJYUyHpg9rd
         OitAateqGA3boBuyS02D4UrWqi1a/Jgosjj9Tp+vXwTiMCbbe0DydJ17P93IkNFHHUMb
         QoJ0efQKhjP9ajs9muay8XxhV3X28TqrNaKsJgQFCqqFv29XKWqrU1TdBX5fPgpS93T3
         sSwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XiJ5BDEGoGYirLhZDEpjz2dLqBloYKJnO58y6bUjOOM=;
        b=gC/lbgjXHkGSZnTsAslwIYHYa3bvsy9HoDa6E7f7Aa0GrCUgKDS+64z/LY5dR8zAzZ
         vM+6RK8NPrV6nCJLajTJPkOHFqdVVLbv5o7Zfb1pczcB6pUEVamkEi+M+8/NYe5TLTB2
         ouar0m8K5H67xFdquOBg1bA0stolKCiYndKq6jVuxLeGshWHZ+ai/BQqElMlJBLRdSI5
         49rReYro5X5ok9GhrDVfHzADOYIgGyR04hLD8JIqyLqY9XXsC3WzOiWfhdbiX6PVwcnD
         Ssyc+yOR0NdNR8Pbcgn7zn2n/NaRoICJjfCrxO2MxFZCnbp9ZgRmqafO5ZEMb8nPFHUn
         eE3Q==
X-Gm-Message-State: AOAM533RI6iAjtXX8q1+kuaRMR3RGx46d8pzIh+PC89pVOeSA0ZGQnfR
        684PZK9XXHemYXc30keMshDuRYpdJZt8eg==
X-Google-Smtp-Source: ABdhPJz50mdvZa8wJbp3+7QRXkuW6CMpycOB9Wo4Omw6A2gcsHdmcsJ00fpmIoiJ5TpYNvEL5zKhzA==
X-Received: by 2002:a05:600c:21d1:: with SMTP id x17mr3119061wmj.16.1607074158120;
        Fri, 04 Dec 2020 01:29:18 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id v4sm2799562wru.12.2020.12.04.01.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 01:29:17 -0800 (PST)
Date:   Fri, 4 Dec 2020 09:29:13 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH bpf-next v3 09/14] bpf: Pull out a macro for interpreting
 atomic ALU operations
Message-ID: <X8oBaf4c+EAd8LQE@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-10-jackmanb@google.com>
 <f1d5ec7e-6231-0876-f25d-9dd5da4112d0@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1d5ec7e-6231-0876-f25d-9dd5da4112d0@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 10:30:18PM -0800, Yonghong Song wrote:
> 
> 
> On 12/3/20 8:02 AM, Brendan Jackman wrote:
> > Since the atomic operations that are added in subsequent commits are
> > all isomorphic with BPF_ADD, pull out a macro to avoid the
> > interpreter becoming dominated by lines of atomic-related code.
> > 
> > Note that this sacrificies interpreter performance (combining
> > STX_ATOMIC_W and STX_ATOMIC_DW into single switch case means that we
> > need an extra conditional branch to differentiate them) in favour of
> > compact and (relatively!) simple C code.
> > 
> > Change-Id: I8cae5b66e75f34393de6063b91c05a8006fdd9e6
> > Signed-off-by: Brendan Jackman <jackmanb@google.com>
> 
> Ack with a minor suggestion below.
> 
> Acked-by: Yonghong Song <yhs@fb.com>
> 
> > ---
> >   kernel/bpf/core.c | 79 +++++++++++++++++++++++------------------------
> >   1 file changed, 38 insertions(+), 41 deletions(-)
> > 
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 28f960bc2e30..498d3f067be7 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -1618,55 +1618,52 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
> >   	LDX_PROBE(DW, 8)
> >   #undef LDX_PROBE
> > -	STX_ATOMIC_W:
> > -		switch (IMM) {
> > -		case BPF_ADD:
> > -			/* lock xadd *(u32 *)(dst_reg + off16) += src_reg */
> > -			atomic_add((u32) SRC, (atomic_t *)(unsigned long)
> > -				   (DST + insn->off));
> > -			break;
> > -		case BPF_ADD | BPF_FETCH:
> > -			SRC = (u32) atomic_fetch_add(
> > -				(u32) SRC,
> > -				(atomic_t *)(unsigned long) (DST + insn->off));
> > -			break;
> > -		case BPF_XCHG:
> > -			SRC = (u32) atomic_xchg(
> > -				(atomic_t *)(unsigned long) (DST + insn->off),
> > -				(u32) SRC);
> > -			break;
> > -		case BPF_CMPXCHG:
> > -			BPF_R0 = (u32) atomic_cmpxchg(
> > -				(atomic_t *)(unsigned long) (DST + insn->off),
> > -				(u32) BPF_R0, (u32) SRC);
> > +#define ATOMIC(BOP, KOP)						\
> 
> ATOMIC a little bit generic. Maybe ATOMIC_FETCH_BOP?

Well it doesn't fetch in all cases and "BOP" is intended to
differentiate from KOP i.e. BOP = BPF operation KOP = Kernel operation.

Could go with ATOMIC_ALU_OP?

> > +		case BOP:						\
> > +			if (BPF_SIZE(insn->code) == BPF_W)		\
> > +				atomic_##KOP((u32) SRC, (atomic_t *)(unsigned long) \
> > +					     (DST + insn->off));	\
> > +			else						\
> > +				atomic64_##KOP((u64) SRC, (atomic64_t *)(unsigned long) \
> > +					       (DST + insn->off));	\
> > +			break;						\
> > +		case BOP | BPF_FETCH:					\
> > +			if (BPF_SIZE(insn->code) == BPF_W)		\
> > +				SRC = (u32) atomic_fetch_##KOP(		\
> > +					(u32) SRC,			\
> > +					(atomic_t *)(unsigned long) (DST + insn->off)); \
> > +			else						\
> > +				SRC = (u64) atomic64_fetch_##KOP(	\
> > +					(u64) SRC,			\
> > +					(atomic64_t *)(s64) (DST + insn->off)); \
> >   			break;
> > -		default:
> > -			goto default_label;
> > -		}
> > -		CONT;
> >   	STX_ATOMIC_DW:
> > +	STX_ATOMIC_W:
> >   		switch (IMM) {
> > -		case BPF_ADD:
> > -			/* lock xadd *(u64 *)(dst_reg + off16) += src_reg */
> > -			atomic64_add((u64) SRC, (atomic64_t *)(unsigned long)
> > -				     (DST + insn->off));
> > -			break;
> > -		case BPF_ADD | BPF_FETCH:
> > -			SRC = (u64) atomic64_fetch_add(
> > -				(u64) SRC,
> > -				(atomic64_t *)(s64) (DST + insn->off));
> > -			break;
> > +		ATOMIC(BPF_ADD, add)
> > +
> >   		case BPF_XCHG:
> > -			SRC = (u64) atomic64_xchg(
> > -				(atomic64_t *)(u64) (DST + insn->off),
> > -				(u64) SRC);
> > +			if (BPF_SIZE(insn->code) == BPF_W)
> > +				SRC = (u32) atomic_xchg(
> > +					(atomic_t *)(unsigned long) (DST + insn->off),
> > +					(u32) SRC);
> > +			else
> > +				SRC = (u64) atomic64_xchg(
> > +					(atomic64_t *)(u64) (DST + insn->off),
> > +					(u64) SRC);
> >   			break;
> >   		case BPF_CMPXCHG:
> > -			BPF_R0 = (u64) atomic64_cmpxchg(
> > -				(atomic64_t *)(u64) (DST + insn->off),
> > -				(u64) BPF_R0, (u64) SRC);
> > +			if (BPF_SIZE(insn->code) == BPF_W)
> > +				BPF_R0 = (u32) atomic_cmpxchg(
> > +					(atomic_t *)(unsigned long) (DST + insn->off),
> > +					(u32) BPF_R0, (u32) SRC);
> > +			else
> > +				BPF_R0 = (u64) atomic64_cmpxchg(
> > +					(atomic64_t *)(u64) (DST + insn->off),
> > +					(u64) BPF_R0, (u64) SRC);
> >   			break;
> > +
> >   		default:
> >   			goto default_label;
> >   		}
> > 
