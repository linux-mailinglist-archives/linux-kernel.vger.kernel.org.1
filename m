Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2F52FD516
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391212AbhATQJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732197AbhATQIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:08:16 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7AFC061757
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:07:35 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j13so2105786edp.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 08:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=odx+DIka95/c6zrkDR8kFE4sUKEXLWcK1XgsQ64ZqzY=;
        b=UMnPQ/JMGjxdP+z21Xc0rMdynZ2F0/J98NfDoBgwtmxhotW2QGV2jdCpP/jnDdF+a9
         t0TDXmlE+faEnS+090/bYRA/KjWHkaodSI/IplZnq1ZLL2b/SaMsRbTa4Cj8p/F4jSVi
         oOeR3NyDb3+wpTLdgaGPmdnNysc00uvxirVYEcFmZiWTNZUTv3NrY+AlNuvS+7Gjelg3
         W+a239Cc+KCibmr3e7lV7xnhShn1E6Qzyk78zvOEmmjdS7m1Z3wsXTckFVACoAM7rN+f
         UuAVI6hYX9K9sVw6pwc5Z7u01qATw6GAws+9iSSXFn81Cdu/CcyTQFibhnW4KDrxc4TG
         +RXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=odx+DIka95/c6zrkDR8kFE4sUKEXLWcK1XgsQ64ZqzY=;
        b=WXbKXo1VYsJ6aqmO2AZGSm9JXlNm+fMRhvLW3G94jk3dORRvTwENqMJB9ZMP54DBb9
         C9XAvcApReawaeMnR84s5B/BHZhO2oGTitCEwXJL7C8F9FaKSvSDsCy7M2eQcrF2IBSK
         KacqdQebRWGldVsfSLwsQznusze7Lz2ADtU9FvXwCv2ivPVet4RxICZsI16aDFkI5VAj
         a0WH8uLBSiyGwGDy/glTLO020Y/OB9qNonaGCjIcRPzddr5L4/060EocRlMQY6YvxV1g
         HJO5b5nxLJiyEunz9Ct23qogU5liM2vEP8pQK7YLVdH2QmE3N6QDxD4LO7kAATZdNvgj
         sm4Q==
X-Gm-Message-State: AOAM533Pa/1pyot5VAbxyU/JHT5aDSDpG+R5BWYqZxktBJWDal+fXLGx
        UxFj8jTGe/5E2dAZ+SNlh0TDWvqzafrRMlDGgd6I74c+RhGnWA==
X-Google-Smtp-Source: ABdhPJw1NEcdnEbxX+CkQBkpBO6Vc2zgJb1eRfvm75+kgadtVnofZIhH+bMdVnrUYhwCtF+ahQ/2RUr6G06e0f8kpQ8=
X-Received: by 2002:a05:6402:304e:: with SMTP id bu14mr7526130edb.60.1611158854493;
 Wed, 20 Jan 2021 08:07:34 -0800 (PST)
MIME-Version: 1.0
References: <20210120120058.29138-1-wei.liu@kernel.org> <20210120120058.29138-4-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-4-wei.liu@kernel.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 20 Jan 2021 11:06:58 -0500
Message-ID: <CA+CK2bBUSN5N4XYepibbvakKFgkzEWwFN4DUMrufPtDrYBJvDQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/16] Drivers: hv: vmbus: skip VMBus initialization if
 Linux is root
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 7:01 AM Wei Liu <wei.liu@kernel.org> wrote:
>
> There is no VMBus and the other infrastructures initialized in
> hv_acpi_init when Linux is running as the root partition.
>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v3: Return 0 instead of -ENODEV.
> ---
>  drivers/hv/vmbus_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 502f8cd95f6d..ee27b3670a51 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2620,6 +2620,9 @@ static int __init hv_acpi_init(void)
>         if (!hv_is_hyperv_initialized())
>                 return -ENODEV;
>
> +       if (hv_root_partition)
> +               return 0;
> +

Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
