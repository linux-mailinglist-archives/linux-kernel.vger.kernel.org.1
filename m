Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33DF2C1E25
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 07:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgKXGXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 01:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbgKXGXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:23:50 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C3EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 22:23:50 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id z5so6715197ejp.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 22:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ea9p0fmJPFNpEgB12VaWhqnXhpED05YV6h4eqw7k4Jw=;
        b=GpmFH8GoovWZrv136TrrpnkLeKb2YoeQ0BHIO9djvJeVzJjUMJI9V0izar0oL+FT1x
         KplPsAnfjFcL2V/QEuTyCZGlxZJBO5La8ddCEXUtytGoWSCdnTsCS1H/5r/3Zi8s4s/o
         4N7aDejPZMSKN+O0/HkYlyYf3svqtJn+NP0qpkh9jbgW1YxwJSLMUUw0VmyOUFZaczNi
         HYtAyO2FTie+0xfooKft4OyV7R0HO3SHy9aKcRQY1aPreDfKHM5cfbVHX96m60eNklYA
         8I4DSrztVV0R1lOHsMFJdO9GI0MxZBCiro/esI/jpp85zpKfMJCmCNiKpJwtmCWP5M92
         CUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ea9p0fmJPFNpEgB12VaWhqnXhpED05YV6h4eqw7k4Jw=;
        b=G0NoaonnAV2CjwnBUQlqkxSTzi1OLdPfwGvJ4E6bL9rEFOKNWJKV2W4sPBvB+6TLqg
         vj4R/SDf27Sv/drDxXyft1E8KwcBxQTaqfImkdkLI2hFulE2tPUaX6/CXbDosxdOT01P
         ss0kQrLOjmKgF2kLYC9BKEQ3NHL1e53GyddfAPIWgtqleExtTMMjxG5U8hwgSrsbaBcV
         JJT4SQz9Fr0d5kvrNPrnxIvoL06vbUNFvuETITq2LcuAbjABi0rtrkAYx6KZaQIWIZZs
         +7wrBE6cax+h0VYlzc2N/ORemNfr5aAN9nQTE2HV7JIpHSa3z77sC0zbjpy3GMvnxc3n
         Ty5w==
X-Gm-Message-State: AOAM530ZZ3qgYHs+7ZRxvOHvlSUjp4ovlR40/mB4B5qA/7pecS/oXGEa
        7CyDRjNNUOtWXiIQkKKf2+LgGypdgBoJ16EwpZSBbB3akQM=
X-Google-Smtp-Source: ABdhPJzyBRowPqsb+9M9UTDNcaK5shLY7FnnrsnqSsdsUMMuhKZHpoM3uU05dUerU38PKBmybEMKiCoRNxRXMK1QEH0=
X-Received: by 2002:a17:906:6a51:: with SMTP id n17mr2891757ejs.478.1606199028729;
 Mon, 23 Nov 2020 22:23:48 -0800 (PST)
MIME-Version: 1.0
References: <cover.1606192458.git.joe@perches.com> <9542a8be9954c1dca744f93f53bb1af6dd1436e8.1606192458.git.joe@perches.com>
In-Reply-To: <9542a8be9954c1dca744f93f53bb1af6dd1436e8.1606192458.git.joe@perches.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Tue, 24 Nov 2020 07:23:38 +0100
Message-ID: <CAMGffE=fH0WL7Aw81_2EB7tZjnqv6Y=yfJiLNwz=ZiXau-u5Dg@mail.gmail.com>
Subject: Re: [PATCH 2/2] scsi: pm8001: Fix misindentation
To:     Joe Perches <joe@perches.com>
Cc:     kernel test robot <lkp@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 5:36 AM Joe Perches <joe@perches.com> wrote:
>
> kernel robot reported a misindentation of a goto.
>
> Fix it.
>
> At the same time, use a temporary for a repeated entry in the same block
> to reduce visual noise.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Joe Perches <joe@perches.com>
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> ---
>  drivers/scsi/pm8001/pm8001_init.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
> index 38907f45c845..17b29163c13d 100644
> --- a/drivers/scsi/pm8001/pm8001_init.c
> +++ b/drivers/scsi/pm8001/pm8001_init.c
> @@ -386,17 +386,17 @@ static int pm8001_alloc(struct pm8001_hba_info *pm8001_ha,
>         pm8001_ha->memoryMap.region[FORENSIC_MEM].element_size = 0x10000;
>         pm8001_ha->memoryMap.region[FORENSIC_MEM].alignment = 0x10000;
>         for (i = 0; i < pm8001_ha->max_memcnt; i++) {
> +               struct mpi_mem *region = &pm8001_ha->memoryMap.region[i];
> +
>                 if (pm8001_mem_alloc(pm8001_ha->pdev,
> -                       &pm8001_ha->memoryMap.region[i].virt_ptr,
> -                       &pm8001_ha->memoryMap.region[i].phys_addr,
> -                       &pm8001_ha->memoryMap.region[i].phys_addr_hi,
> -                       &pm8001_ha->memoryMap.region[i].phys_addr_lo,
> -                       pm8001_ha->memoryMap.region[i].total_len,
> -                       pm8001_ha->memoryMap.region[i].alignment) != 0) {
> -                       pm8001_dbg(pm8001_ha, FAIL,
> -                                  "Mem%d alloc failed\n",
> -                                  i);
> -                               goto err_out;
> +                                    &region->virt_ptr,
> +                                    &region->phys_addr,
> +                                    &region->phys_addr_hi,
> +                                    &region->phys_addr_lo,
> +                                    region->total_len,
> +                                    region->alignment) != 0) {
> +                       pm8001_dbg(pm8001_ha, FAIL, "Mem%d alloc failed\n", i);
> +                       goto err_out;
>                 }
>         }
>
> --
> 2.26.0
>
