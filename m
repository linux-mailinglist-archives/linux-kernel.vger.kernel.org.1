Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5DCC2AB347
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 10:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729863AbgKIJMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 04:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgKIJMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 04:12:21 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D545C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 01:12:21 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id l10so9370233lji.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 01:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipacAfJrcUtFbk4kHEgOAkZMChrOufJTZqnjVylo3V4=;
        b=cfs1nbvSNaF0RgE6Xx5r9EKZ2Lpfy3eyp9kFQWTdkWi1XH1N5o0cjNLHHnXeF1HNL6
         B8CYQoZMucWCx5Rn7WQs8tcIecSHKUjRK+ZtqaCZHmpOnpCrr92wFIMAQdf4w+ovB3px
         dS0edwMrhuxRTG9uTnthhmr/AUdE5xMF4uk5uve0JxaBt7QpQvQ2TZEcVXa7wr5et9Pv
         uLIq0+6sNwp/qjE1TskxJLuOHtuGmrlftKifZi3wU0X3CjKrHRXOSlo017jQZe179qJ7
         6TQO/23kXEorFpfzmpr0PLNiJWfaaapQbDer0kvmsCsrUm+b4ik89oAGwEB3pr632R7C
         zZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipacAfJrcUtFbk4kHEgOAkZMChrOufJTZqnjVylo3V4=;
        b=DedTK6VaSjbSDJR2mphXZB9pbRY+Z7PDP5oF1eBPcsr/xvwgeq4uXpVs6jn6x7/9H3
         g92eocrno/G3X3qEMoHmIPYYzvwh+vgpyl5RZoMB7RYeYsC3PCX+pL/G90Qvu7mm2iiD
         j8CJFtkvUWqWhwVZaWZ7y+fet7mQrQIq0w5k/vzEzcd+oOcarGg6FMBgecFrn6L6te0I
         +A3K1yrpOw9F+0FzW+cGe60Jrg8fdLeT+VjvZsVoPZ0JhSM6H6aqnXW3wUJidgMsQpeD
         FFugrj2QpLydpY2GUszy12yk9nRI8q2WL2AVC04NrHa6O+rWijFUOiaSGjaV4TVmreqn
         ECUQ==
X-Gm-Message-State: AOAM533GOcToU3HZKc0doyKVJTIhi6ho97I6NDM/U0yzXCn7N16PoSA6
        SkSbdw17zvjAs//UlEXDgbet1mO+8WEx06yzx04=
X-Google-Smtp-Source: ABdhPJx3gb+Zqkqz8YKx0Q7b6qqEZP6KKzTy7i5HcpFtnMCHQGp8PS4EXys/cD1YCAPEF/BDQqI7PKbjHnczt/FAfnc=
X-Received: by 2002:a2e:95cf:: with SMTP id y15mr5247385ljh.209.1604913139942;
 Mon, 09 Nov 2020 01:12:19 -0800 (PST)
MIME-Version: 1.0
References: <20201104081438.2075-1-zhenzhong.duan@gmail.com>
 <CAFH1YnMoNJZUJr-duEvzOMzeX0sXgE41T_A6HA+2oAU8WC=ktg@mail.gmail.com> <9e5e5f48-e91d-adce-cbf5-b98fee3b56a6@linux.intel.com>
In-Reply-To: <9e5e5f48-e91d-adce-cbf5-b98fee3b56a6@linux.intel.com>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Mon, 9 Nov 2020 17:12:00 +0800
Message-ID: <CAFH1YnOW4ZMVC=AioJ=anLiDia1xx_NtSqgKFtfJ10icNccefg@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: avoid unnecessory panic if iommu init fail in tboot
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, ning.sun@intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, jroedel@suse.de, tboot-devel@lists.sourceforge.net,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On Mon, Nov 9, 2020 at 11:15 AM Lu Baolu <baolu.lu@linux.intel.com> wrote:
>
> Hi Zhenzhong,
>
> On 11/9/20 10:27 AM, Zhenzhong Duan wrote:
> > +intel iommu maintainers,
> >
> > Can anyone help review this patch? Thanks
> >
> > Zhenzhong
> >
> > On Wed, Nov 4, 2020 at 4:15 PM Zhenzhong Duan <zhenzhong.duan@gmail.com> wrote:
> >>
> >> "intel_iommu=off" command line is used to disable iommu and iommu is force
> >> enabled in a tboot system. Meanwhile "intel_iommu=tboot_noforce,off"
> >> could be used to force disable iommu in tboot for better performance.
> >>
> >> By default kernel should panic if iommu init fail in tboot for security
> >> reason, but it's unnecessory if we use "intel_iommu=tboot_noforce,off".
> >>
> >> Fix it by return 0 in tboot_force_iommu() so that force_on is not set.
> >>
> >> Fixes: 7304e8f28bb2 ("iommu/vt-d: Correctly disable Intel IOMMU force on")
> >> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> >> ---
> >>   arch/x86/kernel/tboot.c | 5 +----
> >>   1 file changed, 1 insertion(+), 4 deletions(-)
> >>
> >> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
> >> index 992fb1415c0f..9fd4d162b331 100644
> >> --- a/arch/x86/kernel/tboot.c
> >> +++ b/arch/x86/kernel/tboot.c
> >> @@ -511,12 +511,9 @@ struct acpi_table_header *tboot_get_dmar_table(struct acpi_table_header *dmar_tb
> >>
> >>   int tboot_force_iommu(void)
> >>   {
> >> -       if (!tboot_enabled())
> >> +       if (!tboot_enabled() || intel_iommu_tboot_noforce)
> >>                  return 0;
> >>
> >> -       if (intel_iommu_tboot_noforce)
> >> -               return 1;
>
> This was obviously wrong. It should return false, right?

I guess you missed above change: "if (!tboot_enabled() ||
intel_iommu_tboot_noforce)".
It does return false.

>
> It looks odd that intel_iommu_tboot_noforce is defined in Intel iommu
> implementation, but is used here. How about moving it back to the iommu
> driver?

That's better, will do. Thanks for your suggestion.

Zhenzhong
