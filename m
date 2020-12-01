Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E58E02CA2C2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730845AbgLAMcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbgLAMcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:32:46 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9FDC0617A7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 04:32:06 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id k10so2472073wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 04:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X+PI9vLKymaLOQD8gASWCveE8MDPWdmQTefuQiMAqD8=;
        b=a6wUuoyiOM9TN72NYCbT9ianphpodmS5T71zFcnIankv9e0w1On3cyokfMgXPgjYat
         XHiToCr3Af6cCFjDGblrP3sOohA8tb0KgCwzE0GR6BjwQjWcOnPtu1tX6fq69Jl1QhM/
         k+j2wMlxBNw5t/D1m5rz9OyoALLX1nuN/XiZSQhdGLERtpW6mpx4qz8iLBQhzOJ6wPZh
         lDy6tJYbXMAbwhuF15d8YA1/VfGGP3F78lR2Q+Hn0/G0ToQIJosEKS9vOTykuIrkDtT2
         rswrnUmwpyjEVNxEHqdn+fL/T0lhOskzs60zjbaR2Go9il8v02sT6/R5iqF5WoQX4uoZ
         M6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X+PI9vLKymaLOQD8gASWCveE8MDPWdmQTefuQiMAqD8=;
        b=SBIE7XLqy48SR2L7Q7Oopco8DZEsGRP/EPQKA9jqMo8SiAzCjg0mrpRZw/BokNO76w
         cCGx49+adLdM8ytpBw2tnU+a1llMrKGKl54oNtkvHjeivd+dTo92RwluwcVfhKrv5YNu
         0IKgnLuzK6wUqin150n+FH5cR+b2yQdXUH/Q/L/i49Is5Z2iV+dKJ5/6etVW03mPJovQ
         ES1D85Gb+ZltzOUHn93AXtYCrqFRsGNlu/Wr1ANxO1LcEnG20WnX7ry7XRQg6yzYMvNK
         gwpxp2jSrYANTdnSfIJBCYBFaPGtGEWE8RERIOzLfpfZr2FvbovF55lquERRBbAXBR4Y
         FoUQ==
X-Gm-Message-State: AOAM531I8YIIO97nzdzImNj2NBVRuZMFG+oOpOmkXPEYIkMn8ltAdKjF
        8lUvXxQKa/sQk2Q2kLZQl4U8BQ==
X-Google-Smtp-Source: ABdhPJwjXrbVm+7UfG4pcCS8y+a/lEkYuWpkwNIJ7aGp/3bD5Lj/4/4f+TuOsyHuiMEG9uDTF7yJFw==
X-Received: by 2002:a1c:3b46:: with SMTP id i67mr2377043wma.108.1606825924706;
        Tue, 01 Dec 2020 04:32:04 -0800 (PST)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id f4sm2552189wmb.47.2020.12.01.04.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 04:32:03 -0800 (PST)
Date:   Tue, 1 Dec 2020 12:32:00 +0000
From:   Brendan Jackman <jackmanb@google.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v2 bpf-next 08/13] bpf: Add instructions for
 atomic_[cmp]xchg
Message-ID: <20201201123200.GF2114905@google.com>
References: <20201127175738.1085417-1-jackmanb@google.com>
 <20201127175738.1085417-9-jackmanb@google.com>
 <20201129012748.i5rws2hvmqptfmy7@ast-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129012748.i5rws2hvmqptfmy7@ast-mbp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 28, 2020 at 05:27:48PM -0800, Alexei Starovoitov wrote:
> On Fri, Nov 27, 2020 at 05:57:33PM +0000, Brendan Jackman wrote:
> >  
> >  /* atomic op type fields (stored in immediate) */
> > -#define BPF_FETCH	0x01	/* fetch previous value into src reg */
> > +#define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
> > +#define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
> > +#define BPF_FETCH	0x01	/* fetch previous value into src reg or r0*/
> 
> I think such comment is more confusing than helpful.
> I'd just say that the fetch bit is not valid on its own.
> It's used to build other instructions like cmpxchg and atomic_fetch_add.

OK sounds good.

> > +		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
> > +			   insn->imm == (BPF_CMPXCHG)) {
> 
> redundant ().

Ack, thanks

> > +			verbose(cbs->private_data, "(%02x) r0 = atomic%s_cmpxchg(*(%s *)(r%d %+d), r0, r%d)\n",
> > +				insn->code,
> > +				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
> > +				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
> > +				insn->dst_reg, insn->off,
> > +				insn->src_reg);
> > +		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
> > +			   insn->imm == (BPF_XCHG)) {
> 
> redundant ().

Ack, thanks
