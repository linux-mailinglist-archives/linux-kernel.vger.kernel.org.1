Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A592D1EB5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 01:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgLHAAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 19:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgLHAAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 19:00:12 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2416C061793
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 15:59:31 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id b62so14303137otc.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 15:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ADhDNSNt6I8G4BtstjMfXOHtK2RWSiGfFOI+5bfvv/g=;
        b=vmxkKZSv7VtJpr+t5DKiSVA794FYtcGFDnbYWzkb632YWPmVzxoA6KiZkk9K9ZjCmK
         K+afPxSRTfRy7lbRd1heu0q0NEiNVE3YQgrrL1Go5S77wRwoWFpsIUtZ9hmNddMNv7iY
         MRcsv7KdtV7Qkd0buVKHVyc5DEMB7XUs3Iqt08298ZrD4FB3EiRYUnc6CoPsQtha8o8V
         ZI/b1YN2CYP3IAvVFA0ceq/8TjMIat1YlJlCWJ6XB5+dJw+MdwXGuA8M1+43WreAokso
         Ek6GISInoQc8aJHQsU/FCAnweyQnfiSt4cfS6mfSFNkcA8rejc1TIf5gOeLpjjPg9XOi
         8CDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ADhDNSNt6I8G4BtstjMfXOHtK2RWSiGfFOI+5bfvv/g=;
        b=X4R6tDF9nUBhd9k0XL/5/7X5yC4lQT33OfVfsQva2o6nYTKTvIqODQRFNPzeKJe/hQ
         WtCbfskj6pAIBHhyDHNDemME0mgydIBUyevRQrXJGxe2WW5RRMSfN7nfXwRwmUaV28LM
         A3p7M7qFfotSHktkOQLoiwIwsZ4PDui0HgtfM7UkGM8GDBhRccYG/BFHTHYPI65JmSUf
         xyLAooVKsj09WDVGYy93pmcyGpWLXtd283nzPuQ90OCCHv/DOmUanEXlOORr0StxtwY8
         OKI5v6ePMrUeMDM2vxwtAmAn2vxpYQm8LzDWmzMtinJ26oDYUiHObP/mYZlG1jlFRLDx
         F3VQ==
X-Gm-Message-State: AOAM5332mw91eN9X7Jr3usXqVHq/y7+VweegQQUGq0C0uLqSNvKLzCsm
        JdTLL3pOgd1YD3VAAtIcfbbRdO9Fzw0F427D4e5ahA==
X-Google-Smtp-Source: ABdhPJxVnIzHHS2bwBxnDCWUT4TZipV2qBZNEk39qhR5IcdxUxY4wTyuUeyLIUup9wRfLyQrxQPkpjsz+0beZ3xqopQ=
X-Received: by 2002:a9d:d01:: with SMTP id 1mr14556642oti.295.1607385571022;
 Mon, 07 Dec 2020 15:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20201007014417.29276-1-sean.j.christopherson@intel.com>
 <99334de1-ba3d-dfac-0730-e637d39b948f@yandex.ru> <20201008175951.GA9267@linux.intel.com>
 <7efe1398-24c0-139f-29fa-3d89b6013f34@yandex.ru> <20201009040453.GA10744@linux.intel.com>
 <5dfa55f3-ecdf-9f8d-2d45-d2e6e54f2daa@yandex.ru> <20201009153053.GA16234@linux.intel.com>
 <b38dff0b-7e6d-3f3e-9724-8e280938628a@yandex.ru> <c206865e-b2da-b996-3d48-2c71d7783fbc@redhat.com>
 <c0c473c1-93af-2a52-bb35-c32f9e96faea@yandex.ru>
In-Reply-To: <c0c473c1-93af-2a52-bb35-c32f9e96faea@yandex.ru>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 7 Dec 2020 15:59:19 -0800
Message-ID: <CALMp9eSMt1DwXL=wE-xyHcOyCvZzzHdgZ=N9Pqdm1CW6aSzOKw@mail.gmail.com>
Subject: Re: KVM_SET_CPUID doesn't check supported bits (was Re: [PATCH 0/6]
 KVM: x86: KVM_SET_SREGS.CR4 bug fixes and cleanup)
To:     stsp <stsp2@yandex.ru>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 3:47 AM stsp <stsp2@yandex.ru> wrote:
>
> 07.12.2020 14:29, Paolo Bonzini =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On 07/12/20 12:24, stsp wrote:
> >> It tries to enable VME among other things.
> >> qemu appears to disable VME by default,
> >> unless you do "-cpu host". So we have a situation where
> >> the host (which is qemu) doesn't have VME,
> >> and guest (dosemu) is trying to enable it.
> >> Now obviously KVM_SET_CPUID doesn't check anyting
> >> at all and returns success. That later turns
> >> into an invalid guest state.
> >>
> >>
> >> Question: should KVM_SET_CPUID check for
> >> supported bits, end return error if not everything
> >> is supported?
> >
> > No, it is intentional.  Most bits of CPUID are not ever checked by
> > KVM, so userspace is supposed to set values that makes sense
> By "that makes sense" you probably
> meant to say "bits_that_makes_sense masked
> with the ones returned by KVM_GET_SUPPORTED_CPUID"?
>
> So am I right that KVM_SET_CPUID only "lowers"
> the supported bits? In which case I don't need to
> call it at all, but instead just call KVM_GET_SUPPORTED_CPUID
> and see if the needed bits are supported, and
> exit otherwise, right?

"Lowers" is a tricky concept for CPUID information. Some feature bits
report 0 for "present" and 1 for "not-present." Some multi-bit fields
are interpreted as numbers, which may be signed or unsigned. Some
multi-bit fields are strings. Some fields have dependencies on other
fields. Etc.
