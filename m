Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D572D1736
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 18:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgLGRLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgLGRLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:11:05 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D727FC061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 09:10:18 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id p22so2460822edu.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 09:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KSdUiyb5ZmZGus9Y18Esm/Zi55w1Hy2x+mQSpH1tzEg=;
        b=dHJ+4IMA3X/al5s5DbkYTlY6I3LlVghULMawjnKlSJ0ze0yAdXh3fCrv3mTZJCBv5T
         COs0CvYqumyk8HnIq52h+Q2+zeuex8E3vSrshRY8sEfQFqP4k8JwSUmB2yYVZ3zRW0S2
         a4+D6euycenV66JUlcpEKePPOO4+mC63iaSxPHS8aMqUJIucKw+0jCpXS1KCQN+g8A9W
         KCjzNaQ53v7EV+5sAfnYd2YDUSVZmVsbh4yxapvRPCAQ4sCavkK1hafYGGbkjrnoFHGn
         +fTLlRh13G3GV5h3wNlQOj6l0hRVljg5R5H5HRAWUS+c2v7uertmQtRBqZLDyFw+KRWC
         w8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KSdUiyb5ZmZGus9Y18Esm/Zi55w1Hy2x+mQSpH1tzEg=;
        b=T+XdafQhxaAVP6EXZzaQJy//5dylp+ormNvdDcHml/CYlIPS75wPlpgTotWvi/a0Ac
         sJnnnzGFYS4NVPteFOY8w9oBg+O5fIPnU5daBWjfYwZOyExEzyessqkqNzevwy6gX5ky
         M1/OoeYJW76e4rZc2EMJWaLlmsckKLBPLlQ0laPuZlsA1cLWJHFzrkgUjx6OT9nyGhQe
         JBlDWz7mNHZL8tbQ7nqNNbtpj3tlvy/c+zl9XU6z8oklLis5COSCseSApnKJtf/5+HEW
         G88HharClaaIkFPeYdHU2Q5JRbL5dBVeAtNkTOfdbSxVmDevU3JSdSBCEFBvIJ0pJr/o
         1y1Q==
X-Gm-Message-State: AOAM532IaZYL/0SwEkMA+qWMaZaxNIlmpQMBXqTi65IFzGq0zqOg2Euj
        2GutppjXUkYHUKU63P4MFWHQ2gcs8zFwhWag6UUiQw==
X-Google-Smtp-Source: ABdhPJwIY/AvBAO1IUq++8k81Pl67K5DOxG9V6nkqs+h+0gM8fHl+Ak6grDKEj8FlGUvbPzQkEzvfQ/hzY1pBXmaeoI=
X-Received: by 2002:a05:6402:366:: with SMTP id s6mr9267484edw.44.1607361017612;
 Mon, 07 Dec 2020 09:10:17 -0800 (PST)
MIME-Version: 1.0
References: <20201119153901.53705-1-steven.price@arm.com> <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
 <20201119184248.4bycy6ouvaxqdiiy@kamzik.brq.redhat.com> <db5ad775fa7cfe7defbd78d9ca6ccfd8@kernel.org>
 <c25c297e-e9b5-ab3f-e401-c21ddd4d2ad1@arm.com> <CAJc+Z1H7akXwDtVvQLiGVVyZ0DfmsxyJQhE7Sno6aAO9GaafEA@mail.gmail.com>
 <46fd98a2-ee39-0086-9159-b38c406935ab@arm.com> <CAFEAcA_Q8RSB-zcS8+cEfvWz_0U5GLzmsf12m_7BFjX8h-1hrA@mail.gmail.com>
 <b975422f-14fd-13b3-c8ca-e8b1a68c0837@arm.com> <20201207164428.GD3135@work-vm>
In-Reply-To: <20201207164428.GD3135@work-vm>
From:   Peter Maydell <peter.maydell@linaro.org>
Date:   Mon, 7 Dec 2020 17:10:06 +0000
Message-ID: <CAFEAcA9mq0xh1CNvw9UZoNwcOBuoVnCNcBkRDSUv7UK27qdESg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Steven Price <steven.price@arm.com>,
        David Gibson <dgibson@redhat.com>,
        Haibo Xu <haibo.xu@linaro.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juan Quintela <quintela@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Dave Martin <Dave.Martin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020 at 16:44, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> * Steven Price (steven.price@arm.com) wrote:
> > Sorry, I know I simplified it rather by saying it's similar to protected VM.
> > Basically as I see it there are three types of memory access:
> >
> > 1) Debug case - has to go via a special case for decryption or ignoring the
> > MTE tag value. Hopefully this can be abstracted in the same way.
> >
> > 2) Migration - for a protected VM there's likely to be a special method to
> > allow the VMM access to the encrypted memory (AFAIK memory is usually kept
> > inaccessible to the VMM). For MTE this again has to be special cased as we
> > actually want both the data and the tag values.
> >
> > 3) Device DMA - for a protected VM it's usual to unencrypt a small area of
> > memory (with the permission of the guest) and use that as a bounce buffer.
> > This is possible with MTE: have an area the VMM purposefully maps with
> > PROT_MTE. The issue is that this has a performance overhead and we can do
> > better with MTE because it's trivial for the VMM to disable the protection
> > for any memory.
>
> Those all sound very similar to the AMD SEV world;  there's the special
> case for Debug that Peter mentioned; migration is ...complicated and
> needs special case that's still being figured out, and as I understand
> Device DMA also uses a bounce buffer (and swiotlb in the guest to make
> that happen).

Mmm, but for encrypted VMs the VM has to jump through all these
hoops because "don't let the VM directly access arbitrary guest RAM"
is the whole point of the feature. For MTE, we don't want in general
to be doing tag-checked accesses to guest RAM and there is nothing
in the feature "allow guests to use MTE" that requires that the VMM's
guest RAM accesses must do tag-checking. So we should avoid having
a design that require us to jump through all the hoops. Even if
it happens that handling encrypted VMs means that QEMU has to grow
some infrastructure for carefully positioning hoops in appropriate
places, we shouldn't use it unnecessarily... All we actually need is
a mechanism for migrating the tags: I don't think there's ever a
situation where you want tag-checking enabled for the VMM's accesses
to the guest RAM.

thanks
-- PMM
