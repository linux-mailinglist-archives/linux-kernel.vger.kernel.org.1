Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE90E2EC56B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 22:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbhAFVA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 16:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbhAFVA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 16:00:28 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5FDC061575
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 12:59:48 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id lt17so6951404ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 12:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FJUh0NIV6tLtFMoflZQxLvFWSm2r6hdgzOOra0YNnlc=;
        b=NfKFkHTEG0mg96jqLjPkdGOVVTVbu8hsSa43MU9A9FkmVjq/xrzNr15XfUCEVSHbmk
         5g0tiXWk38FKphoO8oDjPW9hPCaTO4s4QVrd6T3pnNtBWbc0tyCzW0MUb/iPq1gYrGi+
         ryVDSHq71A1l1gzgJ3ud3iR07I4P5mpqYpoFjX/S7r7+kSUrmAjGzRgwSuXdkrSdFFhC
         wlBvDtlRcPznuenaqm19dCQW80XMMy2pAkVmUAJA1ID2L3z/lmeH/Xzu9c01vK0WhETm
         fqdRzM5bm5jPyHhVicuNwPy2qAfFLWI6qNWbeUq3/j8a+SUisNryPOjqhoDljk5oru5T
         jRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FJUh0NIV6tLtFMoflZQxLvFWSm2r6hdgzOOra0YNnlc=;
        b=k9M4uJY4wGRA5Izx+itH2sguPMXzP1hG1uIYXdb8W9Qnl0G3GGoldBuN1iryAMO2aY
         j84WM+KLR4BGkZgHOUYWPo8o1oreU/WLRA2gQBrfmlDQHJQWh/yXAiPNdbCtaq+cawAH
         fpQLQaXBirmwrePzz95IBWXqWfwttz97cVcX2FvpIcgM7ZTEqr5C9rz+OFKzugogkE23
         ltyiN7jfzSG5uT0pi3MA6AYOH/HtnyjVIHq6wSW4rM/mF6n02iHuWb9NHrlQYkZkGhKL
         Py212FMCM9xYtB6cSxKgh7dbzm2OF2PdERyBLddK2ZVc8qV1E39MUmQ5eK7lGzqZC9z7
         NPnQ==
X-Gm-Message-State: AOAM530knDgv826NaOq+a4gDf18Sg+Bk5VRupGRJ79sHHXTbrKGx9IgG
        JaxWaVTyHpUValftkaeWse+JHQi0Bj7tu4LqMIPyvA==
X-Google-Smtp-Source: ABdhPJw3zG32UYB6jBCWioHclaVNAsP7+I1fOoAZB/RdH9vjT7yTo/Ilnb2CyiPJ6qkhTANMW6Vn8Gl9mIUF0Rv7PJM=
X-Received: by 2002:a17:906:2707:: with SMTP id z7mr4166564ejc.418.1609966787093;
 Wed, 06 Jan 2021 12:59:47 -0800 (PST)
MIME-Version: 1.0
References: <160996560236.3973505.14624475570488164641.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <160996560236.3973505.14624475570488164641.stgit@djiang5-desk3.ch.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 6 Jan 2021 12:59:35 -0800
Message-ID: <CAPcyv4jYeJ48eY5-PxjkARizjQWqsSZuG=63+d526f7sjLK_tQ@mail.gmail.com>
Subject: Re: [PATCH] x86: fix movdir64b() sparse warning
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        kernel test robot <lkp@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 12:40 PM Dave Jiang <dave.jiang@intel.com> wrote:
>
> Add missing __iomem anotation to address sparse warning.

s/anotation/annotation/

>
> "sparse warnings: (new ones prefixed by >>)"
>    drivers/dma/idxd/submit.c: note: in included file (through include/linux/io.h, include/linux/pci.h):
> >> arch/x86/include/asm/io.h:422:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *dst @@     got void [noderef] __iomem *dst @@
>    arch/x86/include/asm/io.h:422:27: sparse:     expected void *dst
>    arch/x86/include/asm/io.h:422:27: sparse:     got void [noderef] __iomem *dst

The sparse spew is somewhat interesting, but what would be more
helpful is explain the why. I.e. that existing and future users expect
to be passing an __iomem annotated pointer to this routine because...
<reasons go here>. Otherwise someone (reviewer / future git blame
user) might reasonably ask, "well, why is the driver passing an
__iomem annotated pointer in the first instance?".

To Ben's point you might also duplicate part of the comment from
movdir64b and say:

"Recall, from the comment in movdir64b @__dst  must be supplied as an
lvalue because this tells the compiler what the object is (its size)
the instruction accesses. I.e., not the pointers but what they point
to, thus the deref'ing '*'."

With clarified changelog for both you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
