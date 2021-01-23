Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFB73011BD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 01:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbhAWAg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 19:36:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbhAWAgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 19:36:25 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B92C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:35:45 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s11so8576236edd.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 16:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jKriZlsSDwDLtrvuS7JPodDHbZ5HjWBpExZmVExyvSs=;
        b=JHInQcPKISPhjzL2Lb26o0L1L0IJr7VawH+94lMdfU+FNHDsQjFTAkXOukMR2gUOVZ
         DF0iQshXuJ6QzUTNBmuAXDqqryeiXEhbw+IvUcUtqJmnYqVB2V2VdbdCbFfogiXhEnes
         IwvCzEfw9eY1b8NoG7yxvHJaFITAD+Hu1hh1drDNGPc5+Ui0HPRTxsGs6xEIIoOzEnzV
         uW3YljoP2C+iRw1vqOPqzOacNtOyQoxWI+9Z6ZivCGUvPUSbgi34FMm2awEN20DULGPx
         ItoBpdr5UXpBq0B9MURbPDXR/3p6472apAzoC2FYIYifpn2iLuHO4RayNpIoI+iZO9tX
         YH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jKriZlsSDwDLtrvuS7JPodDHbZ5HjWBpExZmVExyvSs=;
        b=Qd7UkngktBX4C+OAq9N1QvU0Qaf0Fh9kQaMP7FY7pfK4/ERhwhLJgSI1rCE++J4n0U
         xjeJHCezhuBbh+bRRV0nHuue9yWxaKk+8IOaIw0rH6XIuXHVADzTvEV9kHePrN+RWqJv
         GYml030b3h23s43mM0sJJdLxRFQz+GG/jB7DLOkOVFrJ51Zb59FsG8I2lFhCgBFL6ZWf
         SMd3E16O6EsBR6TroKxD77cJcGXdHef8bo4PF3UMVbn9SNg8hkP9LY++uhWz8OMtJ63i
         spjQ8wHtGmvhDasHJn5A4alElrYbSxsLzqgG+MPflhvm9TdKfeKmoElJWOGzK5UZXix3
         fhkQ==
X-Gm-Message-State: AOAM5332C8dpT66hBSOj8F1qXH90YWeQWPEcQNcSxjLDc45zB8hGNrqs
        o13ePjsjOE1ySGHrgHQn6wV0KU1nTb1uqNTZVHz7lQ==
X-Google-Smtp-Source: ABdhPJzgAnFPMJXD87lWu7NwW9XxgA0xtR1GGer/YVjam0yyb3ILvC28MrWvLVVkeiZcxW0cwVal5DvGg4MclvOTYxU=
X-Received: by 2002:a05:6402:3508:: with SMTP id b8mr669502edd.341.1611362144184;
 Fri, 22 Jan 2021 16:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20200326032420.27220-1-pasha.tatashin@soleen.com>
 <20200326032420.27220-8-pasha.tatashin@soleen.com> <b79b0b58-5f8e-913b-3913-b95551ef7ce1@arm.com>
In-Reply-To: <b79b0b58-5f8e-913b-3913-b95551ef7ce1@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 22 Jan 2021 19:35:08 -0500
Message-ID: <CA+CK2bD0amaPDJgoYn2-VK_LbzCkJBa_oMBgVsDTfbZvUw=3QA@mail.gmail.com>
Subject: Re: [PATCH v9 07/18] arm64: trans_pgd: hibernate: idmap the single
 page that holds the copy page routines
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
        Bhupesh Sharma <bhsharma@redhat.com>,
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
> > From: James Morse <james.morse@arm.com>
> >
> > To resume from hibernate, the contents of memory are restored from
> > the swap image. This may overwrite any page, including the running
> > kernel and its page tables.
> >
> > Hibernate copies the code it uses to do the restore into a single
> > page that it knows won't be overwritten, and maps it with page tables
> > built from pages that won't be overwritten.
> >
> > Today the address it uses for this mapping is arbitrary, but to allow
> > kexec to reuse this code, it needs to be idmapped. To idmap the page
> > we must avoid the kernel helpers that have VA_BITS baked in.
> >
> > Convert create_single_mapping() to take a single PA, and idmap it.
> > The page tables are built in the reverse order to normal using
> > pfn_pte() to stir in any bits between 52:48. T0SZ is always increased
> > to cover 48bits, or 52 if the copy code has bits 52:48 in its PA.
> >
> > Pasha: The original patch from James
> > inux-arm-kernel/20200115143322.214247-4-james.morse@arm.com
>
> -EBROKENLINK
>
> The convention is to use a 'Link:' tag in the signed-off area.
> e.g. 5a3577039cbe

OK Fixed.

>
> > Adopted it to trans_pgd, so it can be commonly used by both Kexec
> > and Hibernate. Some minor clean-ups.
>
> Please describe your changes just before your SoB. This means each author sign's off on
> the stuff above their SoB, and its obvious who made which changes.
>
> Search for 'Lucky K Maintainer' in process/submitting-patches.rst for an example.

OK, Fixed.
eed the maximum T0SZ.
> > + *
> > + * Returns 0 on success, and -ENOMEM on failure.
> > + * On success trans_ttbr0 contains page table with idmapped page, t0sz is set to
>
> > + * maxumum T0SZ for this page.
>
> maxumum
>

Ok.
