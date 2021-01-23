Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B4A3011D5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 02:05:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbhAWBD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 20:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbhAWBCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 20:02:34 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D40C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 17:01:58 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id hs11so10242118ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 17:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PHDV0F8C9xV1vp1h4qwpCoKFhZYLm088KEHP1thlvVw=;
        b=RioQLWr8ugo0DlsJFFgTZ1skKROqX3tElaG7qVKsO1ExATj1jaapKuyc8wa4MtUXmc
         4GWcvQe0O9w3B4WSwmgsrwlcwrG9seP2gqB7lkI1Am+SfLSjrzODjd71vCyxb7CLwy9+
         4Iv4YXUPKTWpcPDNV/rNLYeNqSEBuZ48ChE6bV/oEkxfBjzthdflfC43U+yjNaiOlmbx
         ZX3lPPpccT2+4g6VJAGTnDxGdfN4Uoz7pQt0KKvBjysqjnkNUDAxqknD22gL9n5g/uaE
         CQluVWVHzL0r1iwlfTPUp6U35jakRKixlLujrqlxnOSb6x6TbjbWReoYvXxYvaP5I/Ir
         9tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PHDV0F8C9xV1vp1h4qwpCoKFhZYLm088KEHP1thlvVw=;
        b=jP0pYH5NxnIRxnZjslYC+BAWCQB+BwqB48skGmHPAXlcxEx0iE50qJfXoq/Kss2bvT
         fh2QQFjSsYkI+k1eGXCE2COqB7DHLgM/9B4k6Xv0VeY6SIszcgqdVK7h5C4qzwYGMSgE
         kZCA5FDBh2hBb2d/1HCPZSeyf/VfW2kogg7cCsLGZhS26rlPdCHCVdh9fpijo2dY/AV1
         pUbGZatRUQaqbcOzYAcdH8SS3uyuLRiRebGP/xdEzV0Yfd1960fGfAhPk+aq9F4NW+aD
         +6LbAphM82ddwyEc7DW7+XSAJI1lpReU1F62EEtwqnU9mOnUrH3fmQxmA/UkSjPboQAd
         ++6Q==
X-Gm-Message-State: AOAM5304AGczm+pYGJcWV35h942o2ouDuV8C+Dz2TU/8ceeME6mEfS1T
        NZ4Eb+M4eJYLGyQbqSbENeNE4VzGn/ON0lSLJ5CmZA==
X-Google-Smtp-Source: ABdhPJyDwoCJc13K0qCHh6qwD51iPWaoNHnrbKE5Ph4azKcwJVRrPO628EHxEm5a3QaN3e8sAxa2eLt6Zs5v1ZMDiuo=
X-Received: by 2002:a17:907:96a5:: with SMTP id hd37mr996462ejc.541.1611363717599;
 Fri, 22 Jan 2021 17:01:57 -0800 (PST)
MIME-Version: 1.0
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-9-pasha.tatashin@soleen.com> <ea2b39d7-d496-d9ac-23c9-c279ec29f5d5@arm.com>
In-Reply-To: <ea2b39d7-d496-d9ac-23c9-c279ec29f5d5@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 22 Jan 2021 20:01:21 -0500
Message-ID: <CA+CK2bAsC-ZBPh-CPhmdjdwtLshHcPOsnEu_NzJ38pvPh0YPPQ@mail.gmail.com>
Subject: Re: [PATCH v9 08/18] arm64: kexec: move relocation function setup
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        Selin Dag <selindag@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 1:01 PM James Morse <james.morse@arm.com> wrote:
>
> Hi Pavel,
>
> On 26/03/2020 03:24, Pavel Tatashin wrote:
> > Currently, kernel relocation function is configured in machine_kexec()
> > at the time of kexec reboot by using control_code_page.
> >
> > This operation, however, is more logical to be done during kexec_load,
> > and thus remove from reboot time. Move, setup of this function to
> > newly added machine_kexec_post_load().
>
> This would avoid the need to special-case the cache maintenance, so its a good cleanup...

Yes, the computation should be moved from kexec-reboot to kexec-load
when possible.

>
>
> > Because once MMU is enabled, kexec control page will contain more than
> > relocation kernel, but also vector table, add pointer to the actual
> > function within this page arch.kern_reloc. Currently, it equals to the
> > beginning of page, we will add offsets later, when vector table is
> > added.
>
> If the vector table always comes second, wouldn't this be extra work to hold the value 0?
> You can control the layout of this relocation code, as it has to be written in assembly.
> I don't get why this would be necessary.
>
>
> > diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
> > index ae1bad0156cd..ec71a153cc2d 100644
> > --- a/arch/arm64/kernel/machine_kexec.c
> > +++ b/arch/arm64/kernel/machine_kexec.c
> > @@ -58,6 +59,17 @@ void machine_kexec_cleanup(struct kimage *kimage)
> >       /* Empty routine needed to avoid build errors. */
> >  }
> >
> > +int machine_kexec_post_load(struct kimage *kimage)
> > +{
> > +     void *reloc_code = page_to_virt(kimage->control_code_page);
> > +
> > +     memcpy(reloc_code, arm64_relocate_new_kernel,
> > +            arm64_relocate_new_kernel_size);
> > +     kimage->arch.kern_reloc = __pa(reloc_code);
>
> Could we move the two cache maintenance calls for this area in here too. Keeping it next
> to the modification makes it clearer why it is required.

Yes, I moved it.

>
> In this case we can use flush_icache_range() instead of its __variant because this now
> happens much earlier.

True.

>
>
> > +     return 0;
> > +}
>
> Regardless,
> Reviewed-by: James Morse <james.morse@arm.com>

Thank you for your review.

Pasha

>
>
> Thanks,
>
> James
