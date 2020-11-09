Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1105C2AAF77
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 03:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgKIC2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 21:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgKIC2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 21:28:12 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D933C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 18:28:12 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id v144so10206131lfa.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 18:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3k3rzhXGnCavdgR7PU+xYV8G0+6UcvU+HiFcuDdSrD4=;
        b=CfhJd3s8xF3/QjuQfFs0lAj9QelLCvpOfvWTqGAuqWsu26wDrrcKot93DWFpewtQ4j
         IFntnuMsIuV2/MB9SOBD1pASEomJ6vk44mZoHaDVZD8LmjR1QlSwka7kdDTk6vyb1CUL
         3s/uCOkBz8EYld41If9/Tn6lQltU+NdrcvR0UUxJuWf82/SJaGhLJRc3nIN3iTbVyCPJ
         e7e1WPgioCpdihJ3hJWxhgt++28ETES79ffy0GXRZtcrkPKWpn56QVEEJKelDjgvGs/Q
         3BvW7m2TY3jyvrMUBC9XMOJ4VHG6VG6W+RbhwLLgvOzzhbA5fuhsX5JN67+OoGGj8RA+
         S9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3k3rzhXGnCavdgR7PU+xYV8G0+6UcvU+HiFcuDdSrD4=;
        b=Bb1z81C7kd53Mbm0F/QIwQayeIadx0sedrDJQPHy3fzkIUNBA+EVm9Cn/xZzA2pv+i
         yJ4bbRAeTABYRjU882YeZT7G+jW2CsyY+3S2yQd1XO81S8FbTGjOxTq55g0/epsl9KRP
         MkgbPbxXZCRm7DWYir8rzsQ4PEDoS0yt8xjcR3r9UQODMqzz4ujEglcOOsmOtkRdI9IP
         ZUOM7Fy74RZg1N66on3tGaNliQ8p2VaLEqVHT/OiF/yGSP0nXVRb8LL98hYwI/2qsAFK
         LRk1q3BRxqG1D2BrYjvK21hOjL4q8mckRwiszggW25MHQc0/MDTvxwgGf7/sUHyGmsYW
         OkEQ==
X-Gm-Message-State: AOAM533XmVqDGOJla3LYioNgl1pbKpPMwBYarszjfQuPII0Ffz4q/ITF
        tgq06P6ISkeJrt01BaPK2COom8KnpPO/duklPpBnH8xu
X-Google-Smtp-Source: ABdhPJw48w+yfmG8qqdLqg95+NqCjOKWIIfqme+l87Pct7D8cIF3Sp2DiMVhArshQU5xzv6l9pR0hi9VtX4bwwoRH8o=
X-Received: by 2002:ac2:5ca3:: with SMTP id e3mr4581368lfq.591.1604888890607;
 Sun, 08 Nov 2020 18:28:10 -0800 (PST)
MIME-Version: 1.0
References: <20201104081438.2075-1-zhenzhong.duan@gmail.com>
In-Reply-To: <20201104081438.2075-1-zhenzhong.duan@gmail.com>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Mon, 9 Nov 2020 10:27:51 +0800
Message-ID: <CAFH1YnMoNJZUJr-duEvzOMzeX0sXgE41T_A6HA+2oAU8WC=ktg@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: avoid unnecessory panic if iommu init fail in tboot
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     ning.sun@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, jroedel@suse.de, tboot-devel@lists.sourceforge.net,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+intel iommu maintainers,

Can anyone help review this patch? Thanks

Zhenzhong

On Wed, Nov 4, 2020 at 4:15 PM Zhenzhong Duan <zhenzhong.duan@gmail.com> wrote:
>
> "intel_iommu=off" command line is used to disable iommu and iommu is force
> enabled in a tboot system. Meanwhile "intel_iommu=tboot_noforce,off"
> could be used to force disable iommu in tboot for better performance.
>
> By default kernel should panic if iommu init fail in tboot for security
> reason, but it's unnecessory if we use "intel_iommu=tboot_noforce,off".
>
> Fix it by return 0 in tboot_force_iommu() so that force_on is not set.
>
> Fixes: 7304e8f28bb2 ("iommu/vt-d: Correctly disable Intel IOMMU force on")
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> ---
>  arch/x86/kernel/tboot.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
> index 992fb1415c0f..9fd4d162b331 100644
> --- a/arch/x86/kernel/tboot.c
> +++ b/arch/x86/kernel/tboot.c
> @@ -511,12 +511,9 @@ struct acpi_table_header *tboot_get_dmar_table(struct acpi_table_header *dmar_tb
>
>  int tboot_force_iommu(void)
>  {
> -       if (!tboot_enabled())
> +       if (!tboot_enabled() || intel_iommu_tboot_noforce)
>                 return 0;
>
> -       if (intel_iommu_tboot_noforce)
> -               return 1;
> -
>         if (no_iommu || swiotlb || dmar_disabled)
>                 pr_warn("Forcing Intel-IOMMU to enabled\n");
>
> --
> 2.25.1
>
