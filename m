Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308201FBEE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 21:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgFPTYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 15:24:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58694 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729989AbgFPTYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 15:24:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592335471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yJJchc/3/oiBSyYGsoPh65MH8REAAPcH1btCjP0IdhE=;
        b=NUjK/Mi3yiuufjHIM7/ux4mH3yrbkZcInfJ+crngYwBlyEtU9HjDwbwP0wrwqjrTxP/T5L
        WOEiMxCtrcMrbB1Q0se7YgYzf0z+FYiX3gSY69dgTma3v6R5BQL04Re/jYHN/OGjqJ02d7
        3a62Zwxmqhq1pCP1Y5STfcca3idbOZQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-pIBZkOcTMyiHszXuA_VCeA-1; Tue, 16 Jun 2020 15:24:28 -0400
X-MC-Unique: pIBZkOcTMyiHszXuA_VCeA-1
Received: by mail-qv1-f71.google.com with SMTP id o1so16305206qvq.14
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 12:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJJchc/3/oiBSyYGsoPh65MH8REAAPcH1btCjP0IdhE=;
        b=fbr60vYzxBwBldGCxQ/+FC6O4OxNUuFOIvGzxj7wyF61sVfVav+rzps4fcMcXuOejx
         C/FPabzjqwzScc+6ZCglX9NPfprBBIy3mEWEhhV4RnuklZPDT+Xc38m7Zw0bFTWRMe4Z
         jA2qi9FqyPR0jZpYY/D+dEFf3tnIrlALWwTT4ZxQMkCUn5eXZWBMurvd8XERSNZ+RPhw
         AHM8Qm29qaairtituRA3wHr2th2QfXB1YbAvsBLW/bsKqHx3nsypLXJqaxue6T/txvVL
         KVSeMR4ajeWAKH3xu9Meczg5RPuzpZbVHFASNiXMENdFULhaNaUK9a29TGbjpskm5Buk
         uBxA==
X-Gm-Message-State: AOAM531EeIMYITYSWskwBUa2UqCTkVzCdxhTaTR9YX34UD/S9x4bPrsB
        qZhou+utIdb7t/bINA/PeFX3ViHKZ/JGMFIhc63NaaDVFSTI5MGGAPWzqvt/RaRY34r4F/tgx3n
        2QfHrGPGY6OxjhP1DL9SP0ArjtVhBtc97ibBhIC+0
X-Received: by 2002:a37:b9c7:: with SMTP id j190mr21239258qkf.210.1592335467529;
        Tue, 16 Jun 2020 12:24:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRLKhrAT5D0qef/kb/5pjAggc0Bv6Aa9Iba08kzEC4wcbjXgabWHE5L9Sz4tsPkKCI+kvj6hKhM6AGD6pGoDk=
X-Received: by 2002:a37:b9c7:: with SMTP id j190mr21239229qkf.210.1592335467195;
 Tue, 16 Jun 2020 12:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <1575057559-25496-1-git-send-email-bhsharma@redhat.com>
 <1575057559-25496-3-git-send-email-bhsharma@redhat.com> <63d6e63c-7218-d2dd-8767-4464be83603f@arm.com>
 <af0fd2b0-99db-9d58-bc8d-0dd9d640b1eb@redhat.com> <f791e777-781c-86ce-7619-1de3fe3e7b90@arm.com>
 <351975548.1986001.1578682810951.JavaMail.zimbra@redhat.com>
 <04287d60-e99e-631b-c134-d6dc39e6a193@redhat.com> <974f3601-25f8-f4e6-43a8-ff4275e9c174@arm.com>
 <CACi5LpOK6Q3ud3M3zakexLJNOtHy9TODHyYSHVwE3JHVakKzqA@mail.gmail.com>
 <d401b003-af3e-c525-ba00-0de48486b7a0@broadcom.com> <f644ddb6fdb926606bb376a9f491ee79@mail.gmail.com>
In-Reply-To: <f644ddb6fdb926606bb376a9f491ee79@mail.gmail.com>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Wed, 17 Jun 2020 00:54:14 +0530
Message-ID: <CACi5LpO-x6M4WYYoKUW0G_so5dusDY6AJwz84kLFUS2dA+sNRA@mail.gmail.com>
Subject: Re: Re: [RESEND PATCH v5 2/5] arm64/crash_core: Export TCR_EL1.T1SZ
 in vmcoreinfo
To:     Bharat Gooty <bharat.gooty@broadcom.com>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        Will Deacon <will@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>,
        James Morse <james.morse@arm.com>,
        Dave Anderson <anderson@redhat.com>,
        bhupesh linux <bhupesh.linux@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Steve Capper <steve.capper@arm.com>,
        Ray Jui <ray.jui@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bharat,

On Wed, Jun 10, 2020 at 10:17 PM Bharat Gooty <bharat.gooty@broadcom.com> wrote:
>
> Hello Bhupesh,
> V6 patch set on Linux 5.7, did not help.
> I have applied makedump file
> http://lists.infradead.org/pipermail/kexec/2019-November/023963.html changes
> also (makedump-1.6.6). Tried to apply it on makedumpfile 1.6.7.  Patch set_2
> failed. Would like to know, if you have V5 patch set for makedump file
> changes. With makedump 1.6.6, able to collect the vmore file.
> I used latest crash utility
> (https://www.redhat.com/archives/crash-utility/2019-November/msg00014.html
> changes are present)
> When I used crash utility, following is the error:
>
> Thanks,
> -Bharat
>
>
> -----Original Message-----
> From: Scott Branden [mailto:scott.branden@broadcom.com]
> Sent: Thursday, April 30, 2020 4:34 AM
> To: Bhupesh Sharma; Amit Kachhap
> Cc: Mark Rutland; x86@kernel.org; Will Deacon; Linux Doc Mailing List;
> Catalin Marinas; Ard Biesheuvel; kexec mailing list; Linux Kernel Mailing
> List; Kazuhito Hagio; James Morse; Dave Anderson; bhupesh linux;
> linuxppc-dev@lists.ozlabs.org; linux-arm-kernel; Steve Capper; Ray Jui;
> Bharat Gooty
> Subject: Re: Re: [RESEND PATCH v5 2/5] arm64/crash_core: Export TCR_EL1.T1SZ
> in vmcoreinfo
>
> Hi Bhupesh,
>
> On 2020-02-23 10:25 p.m., Bhupesh Sharma wrote:
> > Hi Amit,
> >
> > On Fri, Feb 21, 2020 at 2:36 PM Amit Kachhap <amit.kachhap@arm.com> wrote:
> >> Hi Bhupesh,
> >>
> >> On 1/13/20 5:44 PM, Bhupesh Sharma wrote:
> >>> Hi James,
> >>>
> >>> On 01/11/2020 12:30 AM, Dave Anderson wrote:
> >>>> ----- Original Message -----
> >>>>> Hi Bhupesh,
> >>>>>
> >>>>> On 25/12/2019 19:01, Bhupesh Sharma wrote:
> >>>>>> On 12/12/2019 04:02 PM, James Morse wrote:
> >>>>>>> On 29/11/2019 19:59, Bhupesh Sharma wrote:
> >>>>>>>> vabits_actual variable on arm64 indicates the actual VA space size,
> >>>>>>>> and allows a single binary to support both 48-bit and 52-bit VA
> >>>>>>>> spaces.
> >>>>>>>>
> >>>>>>>> If the ARMv8.2-LVA optional feature is present, and we are running
> >>>>>>>> with a 64KB page size; then it is possible to use 52-bits of
> >>>>>>>> address
> >>>>>>>> space for both userspace and kernel addresses. However, any kernel
> >>>>>>>> binary that supports 52-bit must also be able to fall back to
> >>>>>>>> 48-bit
> >>>>>>>> at early boot time if the hardware feature is not present.
> >>>>>>>>
> >>>>>>>> Since TCR_EL1.T1SZ indicates the size offset of the memory region
> >>>>>>>> addressed by TTBR1_EL1 (and hence can be used for determining the
> >>>>>>>> vabits_actual value) it makes more sense to export the same in
> >>>>>>>> vmcoreinfo rather than vabits_actual variable, as the name of the
> >>>>>>>> variable can change in future kernel versions, but the
> >>>>>>>> architectural
> >>>>>>>> constructs like TCR_EL1.T1SZ can be used better to indicate
> >>>>>>>> intended
> >>>>>>>> specific fields to user-space.
> >>>>>>>>
> >>>>>>>> User-space utilities like makedumpfile and crash-utility, need to
> >>>>>>>> read/write this value from/to vmcoreinfo
> >>>>>>> (write?)
> >>>>>> Yes, also write so that the vmcoreinfo from an (crashing) arm64
> >>>>>> system can
> >>>>>> be used for
> >>>>>> analysis of the root-cause of panic/crash on say an x86_64 host using
> >>>>>> utilities like
> >>>>>> crash-utility/gdb.
> >>>>> I read this as as "User-space [...] needs to write to vmcoreinfo".
> >>> That's correct. But for writing to vmcore dump in the kdump kernel, we
> >>> need to read the symbols from the vmcoreinfo in the primary kernel.
> >>>
> >>>>>>>> for determining if a virtual address lies in the linear map range.
> >>>>>>> I think this is a fragile example. The debugger shouldn't need to
> >>>>>>> know
> >>>>>>> this.
> >>>>>> Well that the current user-space utility design, so I am not sure we
> >>>>>> can
> >>>>>> tweak that too much.
> >>>>>>
> >>>>>>>> The user-space computation for determining whether an address lies
> >>>>>>>> in
> >>>>>>>> the linear map range is the same as we have in kernel-space:
> >>>>>>>>
> >>>>>>>>      #define __is_lm_address(addr)    (!(((u64)addr) &
> >>>>>>>> BIT(vabits_actual -
> >>>>>>>>      1)))
> >>>>>>> This was changed with 14c127c957c1 ("arm64: mm: Flip kernel VA
> >>>>>>> space"). If
> >>>>>>> user-space
> >>>>>>> tools rely on 'knowing' the kernel memory layout, they must have to
> >>>>>>> constantly be fixed
> >>>>>>> and updated. This is a poor argument for adding this to something
> >>>>>>> that
> >>>>>>> ends up as ABI.
> >>>>>> See above. The user-space has to rely on some ABI/guaranteed
> >>>>>> hardware-symbols which can be
> >>>>>> used for 'determining' the kernel memory layout.
> >>>>> I disagree. Everything and anything in the kernel will change. The
> >>>>> ABI rules apply to
> >>>>> stuff exposed via syscalls and kernel filesystems. It does not apply
> >>>>> to kernel internals,
> >>>>> like the memory layout we used yesterday. 14c127c957c1 is a case in
> >>>>> point.
> >>>>>
> >>>>> A debugger trying to rely on this sort of thing would have to play
> >>>>> catchup whenever it
> >>>>> changes.
> >>>> Exactly.  That's the whole point.
> >>>>
> >>>> The crash utility and makedumpfile are not in the same league as other
> >>>> user-space tools.
> >>>> They have always had to "play catchup" precisely because they depend
> >>>> upon kernel internals,
> >>>> which constantly change.
> >>> I agree with you and DaveA here. Software user-space debuggers are
> >>> dependent on kernel internals (which can change from time-to-time) and
> >>> will have to play catch-up (which has been the case since the very
> >>> start).
> >>>
> >>> Unfortunately we don't have any clear ABI for software debugging tools -
> >>> may be something to look for in future.
> >>>
> >>> A case in point is gdb/kgdb, which still needs to run with KASLR
> >>> turned-off (nokaslr) for debugging, as it confuses gdb which resolve
> >>> kernel symbol address from symbol table of vmlinux. But we can
> >>> work-around the same in makedumpfile/crash by reading the 'kaslr_offset'
> >>> value. And I have several users telling me now they cannot use gdb on
> >>> KASLR enabled kernel to debug panics, but can makedumpfile + crash
> >>> combination to achieve the same.
> >>>
> >>> So, we should be looking to fix these utilities which are broken since
> >>> the 52-bit changes for arm64. Accordingly, I will try to send the v6
> >>> soon while incorporating the comments posted on the v5.
> >> Any update on the next v6 version. Since this patch series is fixing the
> >> current broken kdump so need this series to add some more fields in
> >> vmcoreinfo for Pointer Authentication work.
> > Sorry for the delay. I was caught up in some other urgent arm64
> > user-space issues.
> > I am preparing the v6 now and hopefully will be able to post it out
> > for review later today.
>
> Did v6 get sent out?

Like I mentioned in a different thread reply, I did not put out the
user-space changes just yet, since we are waiting for the kernel
patches to be accepted first.

In the last review cycle (v5) we had inconsistencies between the
user-space and kernel as user-space utilities like crash accepted the
v5 patches while we had to respin the v6 for the kernel side.

But since a few other Red Hat arm partners have asked for the same,
please find below my public github trees (with prescribed branches),
which you can use for testing the v6 kernel patchset:

1. makedumpfile:
<https://github.com/bhupesh-sharma/makedumpfile/tree/52-bit-va-support-via-vmcore-upstream-v6-rebase>
2. crash-utility:
<https://github.com/bhupesh-sharma/crash/tree/52-bit-va-support-via-vmcore-upstream-v6-rebase>

Hope this helps.

Thanks,
Bhupesh

