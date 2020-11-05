Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950722A862D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731350AbgKESha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgKESh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:37:29 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A07DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 10:37:29 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id s30so3757514lfc.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R2JqSxD5FeNpFchLmibpz22i5tPINLMs1s3cxayerRk=;
        b=ZsWfXSphEsFaPJLgC3WwNOJfG8aDtTfiIcsV3aoJbQ2jC9sOmi+LZ/UEBZeeBDv92m
         LXI0C5GeUu80b50KVyt2Phe35u4qkf0XjgOsc5XDS+XUocZPPRRufFeZ+9DPG4D9Q36b
         ssBxXHGcfyK3pFSdVmzxKCp4kNWMAw/ugIcP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R2JqSxD5FeNpFchLmibpz22i5tPINLMs1s3cxayerRk=;
        b=GyDNswWlZyJIgNXeDKGSG2KmZTRxz18JyjwOfGHrb+E0MtxMr6QfnoJyGu49LIXl/j
         BCAt6VTizSkHY0jrZQvPgyTacoC0dyFMxEKgoH61mc2F8tD1ESXq+7D9PL6EmAHnP+Eo
         DpDlKE8ICCsXkoBN55n7phFDDICPZJfFpEcoR5BgekTTNCzMcV520/ZVsbW5FPwptFiw
         TV5pf/Xk/dnnc5eihSH8c97go/4dR2LnGQ8zNAIY0w6YzM2Lg96zMlzWSdMwNIpcWdkH
         WKZ/IUApo4JKtn3h7shGp4BsW6mrmHbt1wCvhw4+khO6QJMgj0evrUwPmo9/yskYgetP
         YJzg==
X-Gm-Message-State: AOAM5316TRII6WAEMbSZUpDtTEAw+7Awo9ArALcUYckl+nR/p4aRQjQZ
        JtLTHngXeJi92TT5s4BFIw2bVixIB7nlfw==
X-Google-Smtp-Source: ABdhPJxswYRw3TRNt59KDtsGFtbaWvXfI/+depvofI1GpDrgIcs6FQ36ZVBhmRhp4km0QBE3ZWXRmA==
X-Received: by 2002:a19:ec11:: with SMTP id b17mr1434450lfa.521.1604601447032;
        Thu, 05 Nov 2020 10:37:27 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id d26sm214304ljj.102.2020.11.05.10.37.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 10:37:25 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id v18so801899ljc.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 10:37:24 -0800 (PST)
X-Received: by 2002:a05:651c:110:: with SMTP id a16mr1488334ljb.285.1604601444134;
 Thu, 05 Nov 2020 10:37:24 -0800 (PST)
MIME-Version: 1.0
References: <20201102091428.GK31092@shao2-debian> <CAHk-=wiRnRsS4CqLypK533G2Ho=NVTt_s-e9KXZ=b0ptOSB15A@mail.gmail.com>
 <dd22f78e-764b-4896-e2d0-5f4e4cf178af@linux.intel.com>
In-Reply-To: <dd22f78e-764b-4896-e2d0-5f4e4cf178af@linux.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Nov 2020 10:37:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjMgTdpsXeuBfRBz23mTSD67V_BB_aV2bCzDHF2-k0WBg@mail.gmail.com>
Message-ID: <CAHk-=wjMgTdpsXeuBfRBz23mTSD67V_BB_aV2bCzDHF2-k0WBg@mail.gmail.com>
Subject: Re: [LKP] Re: [mm/gup] a308c71bf1: stress-ng.vm-splice.ops_per_sec
 -95.6% regression
To:     Xing Zhengjun <zhengjun.xing@linux.intel.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Jann Horn <jannh@google.com>, Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>, zhengjun.xing@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 12:29 AM Xing Zhengjun
<zhengjun.xing@linux.intel.com> wrote:
>
> > Rong - mind testing this? I don't think the zero-page _should_ be
> > something that real loads care about, but hey, maybe people do want to
> > do things like splice zeroes very efficiently..
>
> I test the patch, the regression still existed.

Thanks.

So Jann's suspicion seems interesting but apparently not the reason
for this particular case.

For being such a _huge_ difference (20x improvement followed by a 20x
regression), it's surprising how little the numbers give a clue. The
big changes are things like
"interrupts.CPU19.CAL:Function_call_interrupts", but while those
change by hundreds of percent, most of the changes seem to just be
about them moving to different CPU's. IOW, we have things like

      5652 =C2=B1 59%    +387.9%      27579 =C2=B1 96%
interrupts.CPU13.CAL:Function_call_interrupts
     28249 =C2=B1 32%     -69.3%       8675 =C2=B1 50%
interrupts.CPU28.CAL:Function_call_interrupts

which isn't really much of a change at all despite the changes looking
very big - it's just the stats jumping from one CPU to another.

Maybe there's some actual change in there, but it's very well hidden if so.

Yes, some of the numbers get worse:

    868396 =C2=B1  3%     +20.9%    1050234 =C2=B1 14%
interrupts.RES:Rescheduling_interrupts

so that's a 20% increase in rescheduling interrupts,  But it's a 20%
increase, not a 500% one. So the fact that performance changes by 20x
is still very unclear to me.

We do have a lot of those numa-meminfo changes, but they could just
come from allocation patterns.

That said - another difference between the fast-cup code and the
regular gup code is that the fast-gup code does

                if (pte_protnone(pte))
                        goto pte_unmap;

and the regular slow case does

        if ((flags & FOLL_NUMA) && pte_protnone(pte))
                goto no_page;

now, FOLL_NUMA is always set in the slow case if we don't have
FOLL_FORCE set, so this difference isn't "real", but it's one of those
cases where the zero-page might be marked for NUMA faulting, and doing
the forced COW might then cause it to be accessible.

Just out of curiosity, do the numbers change enormously if you just remove =
that

                if (pte_protnone(pte))
                        goto pte_unmap;

test from the fast-cup case (top of the loop in gup_pte_range()) -
effectively making fast-gup basically act like FOLL_FORCE wrt numa
placement..

I'm not convinced that's a valid change in general, so this is just a
"to debug the odd performance numbers" issue.

Also out of curiosity: is the performance profile limited to just the
load, or is it a system profile (ie do you have "-a" on the perf
record line or not).

               Linus
