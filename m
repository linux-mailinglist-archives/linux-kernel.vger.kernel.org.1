Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C72F28559A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 02:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgJGAvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 20:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgJGAvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 20:51:05 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639C5C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 17:51:05 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id md26so474874ejb.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 17:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eRgpBFDQ71r3jZmAEWAU5ispHXswfcNPKvXGtL8hegk=;
        b=MrdR1Mx+X+SeJ23S2PnH5HipsAt0mLLjg8Qsk3HtHtaMT6qKs80nxn/ZtQD1O4E4k9
         yzMsQ1eaaxP+we98Wk+3I6R7MK5Iwgd/AiZ/8Y22njGHOlNX6NnC0rRBTTGQsoKLykX1
         rL81TNWoUTP2mYuNE7Z7vLtG8YEDodvSY1heIAHezmt8ug6ELrA9l9JGlPWrbQiKD/w1
         Ot3G7Z6uVl2UFVh5isZSYS78Wx/Rx0MnNZeIcnJZW6HFni9vDb2lh/UPm5I2N1gZSpQH
         hnU6+jis26zSubOANjvPkfAWHDskkMjbaX4wyWQb6JfwTolFKMuI/h9yWP2dkim5B/3N
         +Qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eRgpBFDQ71r3jZmAEWAU5ispHXswfcNPKvXGtL8hegk=;
        b=KdZ+Chph62VTNcrrfoid3NKdiR/nD8rHdonvURWGyH3DWY61bQORsWastA9kChFvZj
         LAhTTtLGhY8/yIU3kWeFSctvFsZLnchAYj4JK+fkU9RrxJZXzz2xWNgXnnRyJkip13Iq
         5Vwn7nARWmRWfbtsLMBmNrMKvrA0mRXNG/vA857+I8IKZ3UB6Wcc0UvHBKG2Zt44r5/7
         ftNsI3SABdemk36o4imh9MzVNG8csYYUzaS4Ca8HrDuUaF/FhaEVNQjukElXofkZlwPr
         A0523n6Rjn6Udf/4dyUNDn+NCJ6LQBHOtS2rPOScZECCdJq5l/e5Y3SzfnlpfgZcQ4o9
         Kmuw==
X-Gm-Message-State: AOAM531YYVQhYaJ6fXIIMQ0B3+2O4szqOIW+1DWJ2Po7fxVMUXidlz16
        U+XhKQWWYDHehkL0h+2U6O+b6rtoGnzqlqaCj61xpA==
X-Google-Smtp-Source: ABdhPJxJJ1TsiRyKiZr0F9iwPg0xQoz9g238e5l71p9cVxLuHyITngG+hiywuYgs4FdTP0coxxVgOm8lYRFVkX1sSM8=
X-Received: by 2002:a17:906:7d52:: with SMTP id l18mr735056ejp.220.1602031863860;
 Tue, 06 Oct 2020 17:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20201006231706.2744579-1-haoluo@google.com> <CAEf4BzY1ggHq6UGkHQ_S=0_US=bLPc9u+9pyeUP2hWb_3kWN+w@mail.gmail.com>
In-Reply-To: <CAEf4BzY1ggHq6UGkHQ_S=0_US=bLPc9u+9pyeUP2hWb_3kWN+w@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 6 Oct 2020 17:50:52 -0700
Message-ID: <CA+khW7hVh4PJHtZSNG-_ZPxthQdvKSxoL4P17GZn5NdQxjnHxA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix test_verifier after introducing resolve_pseudo_ldimm64
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 6, 2020 at 5:43 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Oct 6, 2020 at 4:45 PM Hao Luo <haoluo@google.com> wrote:
> >
> > Commit 4976b718c355 ("bpf: Introduce pseudo_btf_id") switched
> > the order of check_subprogs() and resolve_pseudo_ldimm() in
> > the verifier. Now an empty prog and the prog of a single
> > invalid ldimm expect to see the error "last insn is not an
> > exit or jmp" instead, because the check for subprogs comes
> > first. Fix the expection of the error message.
> >
> > Tested:
> >  # ./test_verifier
> >  Summary: 1130 PASSED, 538 SKIPPED, 0 FAILED
> >  and the full set of bpf selftests.
> >
> > Fixes: 4976b718c355 ("bpf: Introduce pseudo_btf_id")
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
[...]
> > diff --git a/tools/testing/selftests/bpf/verifier/ld_imm64.c b/tools/testing/selftests/bpf/verifier/ld_imm64.c
> > index 3856dba733e9..f300ba62edd0 100644
> > --- a/tools/testing/selftests/bpf/verifier/ld_imm64.c
> > +++ b/tools/testing/selftests/bpf/verifier/ld_imm64.c
> > @@ -55,7 +55,7 @@
> >         .insns = {
> >         BPF_RAW_INSN(BPF_LD | BPF_IMM | BPF_DW, 0, 0, 0, 0),
> >         },
> > -       .errstr = "invalid bpf_ld_imm64 insn",
> > +       .errstr = "last insn is not an exit or jmp",
>
> but this completely defeats the purpose of the test; better add
> BPF_EXIT_INSN() after ldimm64 instruction to actually get to
> validation of ldimm64
>

Actually there is already a test (test4) that covers this case. So it
makes sense to remove it, I think. I will resend with this change.

> >         .result = REJECT,
> >  },
> >  {
> > --
> > 2.28.0.806.g8561365e88-goog
> >
