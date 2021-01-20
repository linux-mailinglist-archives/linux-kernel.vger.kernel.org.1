Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55DC02FD52D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391313AbhATQNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391242AbhATQJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:09:57 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BB3C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:09:11 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b2so26387376edm.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFPoWmdT1E7447c/foHDjqNJuO8UPeUXJAj8ZTCeNuI=;
        b=bNp4m8GXBuiU/FXyjO9D9cA/C4gIGIPznUcpKtSxPEKyebwvVQ+aRwdeBURGW60Aqn
         LWDM8IY14JaXyGVpmy9pspE7lfObh3UXUk1T9JUoE9m742jY/UWqwZOuCBJ1bPyIODGl
         UnlPbfbmqFegwGszXH5A2WM1t7WLON4F/hTTf41tPfVOHi9uvgUn8pBT7w/CdD4OSxCR
         Pj4XoIeByZmeoQNQ4FhMnueL2wZ9/ttGENz2s0DHc9xIW18UNCzE7rgOV30lEB4IWM6K
         z43ISZVwDPuNuqM8j3RZAlGmRUAK0i/ai2ThrTF7kmw/zPRYVf/biTfeZ/ArEDWa+95U
         iDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFPoWmdT1E7447c/foHDjqNJuO8UPeUXJAj8ZTCeNuI=;
        b=T821vr5SP6sj7VcmO+8pyXKh7/54g2kaQcoVLERD4KRyr7Q5EtWR6ArzSnNxZAIX2w
         VO30foH994bKMjIhFawSjoIhQeBe9/NPD3ex5A/zHnAm5tKdy47if2pFf02wQgjHr2oI
         MDm3Qvn8deU0qTy0IrJnHHbYvMDgnuPXhsYeFdxyPqBYoh2XqYy0hKmKUhRxQUmrojFB
         JcVrwF/Z8jcYpJA0+l5Gfwew60/th1o73xWAgdTNek71Nkaq/aymTcPi9jMI9e2RMNda
         OkRxekFViCjVy2PHcAJZgGvRS2Ab/Zfzq8CgTet+1QWwqDIljwJaP63tIssW8z2Thscs
         o5Nw==
X-Gm-Message-State: AOAM533DzQb9159V1PhuOKPnBByD7UITYGfbmJYV4mukLgkjyDoQ2UF6
        n72hQBeFu1avBegAw2LRumXLgtM01P/qnmwsuWFYcQ==
X-Google-Smtp-Source: ABdhPJzzrx43U/MRM+U+2IS6fjT5/s61ISkHSJJW/uV0YTHN3o25ui9xpDMoE2/qruoEGyRFVzUk7yyVBnemuDxnOFQ=
X-Received: by 2002:aa7:d803:: with SMTP id v3mr7685979edq.153.1611158950213;
 Wed, 20 Jan 2021 08:09:10 -0800 (PST)
MIME-Version: 1.0
References: <20210120120058.29138-1-wei.liu@kernel.org> <20210120120058.29138-5-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-5-wei.liu@kernel.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 20 Jan 2021 11:08:34 -0500
Message-ID: <CA+CK2bByGvCr_H3_wv_3-vAOONhRenonFNeHff5UdeFLDxSoUw@mail.gmail.com>
Subject: Re: [PATCH v5 04/16] iommu/hyperv: don't setup IRQ remapping when
 running as root
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Joerg Roedel <jroedel@suse.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 7:01 AM Wei Liu <wei.liu@kernel.org> wrote:
>
> The IOMMU code needs more work. We're sure for now the IRQ remapping
> hooks are not applicable when Linux is the root partition.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Acked-by: Joerg Roedel <jroedel@suse.de>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/iommu/hyperv-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/hyperv-iommu.c b/drivers/iommu/hyperv-iommu.c
> index 1d21a0b5f724..b7db6024e65c 100644
> --- a/drivers/iommu/hyperv-iommu.c
> +++ b/drivers/iommu/hyperv-iommu.c
> @@ -20,6 +20,7 @@
>  #include <asm/io_apic.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/hypervisor.h>
> +#include <asm/mshyperv.h>
>
>  #include "irq_remapping.h"
>
> @@ -122,7 +123,7 @@ static int __init hyperv_prepare_irq_remapping(void)
>
>         if (!hypervisor_is_type(X86_HYPER_MS_HYPERV) ||
>             x86_init.hyper.msi_ext_dest_id() ||
> -           !x2apic_supported())
> +           !x2apic_supported() || hv_root_partition)
>                 return -ENODEV;

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
