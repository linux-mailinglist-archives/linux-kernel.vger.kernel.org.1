Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 276F02412AA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 23:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgHJV7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 17:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgHJV7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:59:18 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A42C061787
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 14:59:18 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id u24so10341402oiv.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 14:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vlEq2Dpha15y0ydLscbk8ovts5dUH9uys7Vvw2mMr1U=;
        b=CQdU0Zj3KV4YFfYLuNp2l0iGi/XCf1EB3qgvYjBRajbbDv1b/6CfLGKGP/v2RPGOw9
         FJbM6Kuz3rbx8chfTXiQeM4dfr4IdX7J4PnTFUVc0vDgH6m2inCY5hhsESUKG+rsid+D
         BiVgujInT4P4N8Im2b3QnoeQL//flLZ1O/xr3ir4+Bn4yXSvPLwUeBqcF5LoR7IXG+T+
         r5/cWeSQBAo/FX0LcRC3+MZ2zy+dyCE4lNsjNKsD/D/7JpElMIh8kRkoE5/5yQvLBSg/
         VxjSPrwqMvH5QYS0TsWozDgC8SOiTPWCMTIp87Uq9HMbQp5XzxY3YY3ojd1IRngkC9pQ
         Z5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vlEq2Dpha15y0ydLscbk8ovts5dUH9uys7Vvw2mMr1U=;
        b=mXOsd+zshU3mw8V0p7BC9jrvOEARfYLG1/TL40VnTFIuclf+HNN3/WP8V5Ueg4Lweb
         +4630IyEMdzCVkELyVsvIeJZ9pWN8hiIcaop72KuY5nmUItepOol5yWjKIN+AaTgtXvq
         kF2hhhcYO13M+2PyYfYWNrIvEM7BIkg5BZc0SVCvAWBXLT58f/gq5wsyKL1pS0lP2Ayo
         qmylKwwNiLmF2/UxcRFJsvlgWJzHdvzNB3ZFM1sZqi/+TmRojUQn3qW+YL5YnjxNN8fW
         NUCHyw3deGEP7gryMVAsiNZnXPIzcyCYrToRhTBBbuEKJYpBggFb1ul3H4f+yrcQbTvW
         GT8g==
X-Gm-Message-State: AOAM530kI9lgOenvztxfBcO/2LaHvplIqxHTDH2qNpgZYp17qPFxIsu4
        BWgde3Aqlry7lPBriY7VVwJ5G7w4Ij5/J4J0Qtp/kQ==
X-Google-Smtp-Source: ABdhPJy0vpqdRLdZh/x8lBYNreooVNRhS2sxNdUzPpyKoDlQfzP2uwM8DDVmt67XNtHjMgNRlUh5dKt1mgJM/sH70KE=
X-Received: by 2002:a54:4795:: with SMTP id o21mr1141052oic.13.1597096757767;
 Mon, 10 Aug 2020 14:59:17 -0700 (PDT)
MIME-Version: 1.0
References: <159676101387.12805.18038347880482984693.stgit@bmoger-ubuntu> <159676126090.12805.5961438692882905158.stgit@bmoger-ubuntu>
In-Reply-To: <159676126090.12805.5961438692882905158.stgit@bmoger-ubuntu>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 10 Aug 2020 14:59:06 -0700
Message-ID: <CALMp9eTa4TWVJj=i12WwyGCju_or-xnLpjxmJTu=KC9fq-XZJg@mail.gmail.com>
Subject: Re: [PATCH v4 12/12] KVM:SVM: Enable INVPCID feature on AMD
To:     Babu Moger <babu.moger@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 5:47 PM Babu Moger <babu.moger@amd.com> wrote:
>
> The following intercept bit has been added to support VMEXIT
> for INVPCID instruction:
> Code    Name            Cause
> A2h     VMEXIT_INVPCID  INVPCID instruction
>
> The following bit has been added to the VMCB layout control area
> to control intercept of INVPCID:
> Byte Offset     Bit(s)    Function
> 14h             2         intercept INVPCID
>
> Enable the interceptions when the the guest is running with shadow
> page table enabled and handle the tlbflush based on the invpcid
> instruction type.
>
> For the guests with nested page table (NPT) support, the INVPCID
> feature works as running it natively. KVM does not need to do any
> special handling in this case.
>
> AMD documentation for INVPCID feature is available at "AMD64
> Architecture Programmer=E2=80=99s Manual Volume 2: System Programming,
> Pub. 24593 Rev. 3.34(or later)"
>
> The documentation can be obtained at the links below:
> Link: https://www.amd.com/system/files/TechDocs/24593.pdf
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
