Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42EC2AE4DF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 01:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbgKKAZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 19:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgKKAZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 19:25:12 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567D1C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:25:10 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id i19so309313ejx.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 16:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2O6LIbW3W1fyPRRz6Q2ugAoXMb1CF9Vg+VkIYIaeEto=;
        b=lzTpU0r87pk4y6h34io+WvlgUIGcBLyA7ro331I4mTZJeLaJR4TA//cDV8W5J/BQUY
         ND4Rxi7HVlG6Isz9aIu+NiblYCN/AMdvIG+p3HcHSRb2rg3mXcJTNf1cNykx8kLNh6o9
         Ey7hiKYbqRCeTosc4zpX2vFY3z1AQLirY2i35nYzgh09Ef+VZYJeT1WmQNsCHYTS7hhk
         VqdzzAMc6EdY9cIb1hgG9h7zpbamGZ64NZJaKiFJQ1fo/EP+1N+oAyUvpfKNQk0sORWL
         gXHJHu9WbxjxEp8y4Lokg7Rrxjk3iq0h2A7LEi9PYUKwAmpjJ6UFadkPBP36DMA8zJZw
         n65g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2O6LIbW3W1fyPRRz6Q2ugAoXMb1CF9Vg+VkIYIaeEto=;
        b=d0mFykByG1rvZnChHYVVBY6apHprZpykrEhwBLENQWVj/PpimrBYI9jZ31/KaZcbfS
         FOSGyTtYSvJxe234Ph0aZg8Af0oXpAuxK8WZoXJ6uE4V7N5fpAD/B2Cma7NtlMIJBlPV
         uyTB9vJkS8SUCBD7McTiOYN3t/p4w0l+ObfsdJ+pmlOi19siatEkfMurKkGDuJ8Gm8TE
         l8G+TCx39ZFHBqsGqCl3/QsM1StoIeqUJaEhNH/Z4ARGXtHCOwLI4X/A30+3jKamJkwS
         QVVYy1saSAkEjZgBq+0OHPqw8H0/c1Uny6pdM9DnjV9Ha7GwprFbR58rXB325ECMzBNZ
         bfOQ==
X-Gm-Message-State: AOAM532bb6J0Bjg72JlhWEa9XLMhVQ4FnVsKXZTgn2u2abPIvYzMwYwF
        5aaCGzie17tJZkuYIOscAKSeUxSt0Ujs/dGI98E=
X-Google-Smtp-Source: ABdhPJx/VNilzppU5AdybE2mXkG021YFimA/sh9NK/KQLMFJ2kNYiaoe2MndQR0ypFROirBkv0XJ87TjyrWs9dDvZxQ=
X-Received: by 2002:a17:906:b312:: with SMTP id n18mr23363538ejz.353.1605054308883;
 Tue, 10 Nov 2020 16:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20201110071908.3133-1-zhenzhong.duan@gmail.com> <4cfa1f1827e0ccbfbc94de3beba64a4a141b2248.camel@linux.intel.com>
In-Reply-To: <4cfa1f1827e0ccbfbc94de3beba64a4a141b2248.camel@linux.intel.com>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Wed, 11 Nov 2020 08:24:52 +0800
Message-ID: <CAFH1YnMb0MB+-hg7KWEzpGc_bUAv0UhR4_zBn4Sh8T3zjDMKuw@mail.gmail.com>
Subject: Re: [PATCH v2] iommu/vt-d: avoid unnecessory panic if iommu init fail
 in tboot system
To:     Lukasz Hawrylko <lukasz.hawrylko@linux.intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, ning.sun@intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, tboot-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

On Tue, Nov 10, 2020 at 11:53 PM Lukasz Hawrylko
<lukasz.hawrylko@linux.intel.com> wrote:
>
> Hi Zhenzhong
>
> On Tue, 2020-11-10 at 15:19 +0800, Zhenzhong Duan wrote:
> > "intel_iommu=off" command line is used to disable iommu but iommu is force
> > enabled in a tboot system for security reason.
> >
> > However for better performance on high speed network device, a new option
> > "intel_iommu=tboot_noforce" is introduced to disable the force on.
> >
> > By default kernel should panic if iommu init fail in tboot for security
> > reason, but it's unnecessory if we use "intel_iommu=tboot_noforce,off".
> >
> > Fix the code setting force_on and move intel_iommu_tboot_noforce
> > from tboot code to intel iommu code.
> >
> > Fixes: 7304e8f28bb2 ("iommu/vt-d: Correctly disable Intel IOMMU force on")
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> > ---
> > v2: move ckeck of intel_iommu_tboot_noforce into iommu code per Baolu.
>
> I have check it on my TXT testing environment with latest TBOOT,
> everything works as expected.

Thanks very much for help checking, may I have your Tested-by?

Zhenzhong
