Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BFD2D0D04
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgLGJ3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:29:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726011AbgLGJ3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607333305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6qrnWwjmFtSVqE1nCYYjX2OgHJMarljryfL3WzdzuOk=;
        b=A3Hr3G6bX2XKuMr3dn2PQTbShdWeI5tDXYHJlYVX+/Qc42wr+0cn66+DbPm9eHw4kNI/jY
        HZSwGwc3LVf2kuqOGqVoLN3Oy6nyMaqWlU7W31lxy3RI/epspVJtAxs15qZVDcoVzswrF7
        KNA8DmjOdDJb4kmenL3h3Yv6kufFGBQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-EuuKKJhFNT61xSyY8vk8fg-1; Mon, 07 Dec 2020 04:28:24 -0500
X-MC-Unique: EuuKKJhFNT61xSyY8vk8fg-1
Received: by mail-io1-f69.google.com with SMTP id n9so11413513iog.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 01:28:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=6qrnWwjmFtSVqE1nCYYjX2OgHJMarljryfL3WzdzuOk=;
        b=JPPE22J+BfJQQFlbhn0AZCFXif/0cvSBar6bwCVteAjxaAu9Yf4WXspEMfpJ7awej6
         6I3Z9bvEbxUZpRcVXS5/LE2KRWULEpCC0f51fpEVM/FW9HbJeesZ/U80ERrnhdc62PAS
         k3eb+93zrKm4b2E7SUtNuQTziQGTVmrY81umRZ1F0x7vhuJEigxXeFZs0AKlKYy8oMYB
         aH8zybu8Y9Ld83kqOQib1lF8H6IoT9Znr4RP4+akNZ+VEl2lbsj5rSAj+ujcr67XSdVx
         AWixZg5iHPbOPs6eGUuLzWxWFXhuat0ISNZrxwQc+3wLRiQ2GJmBNhWY1MnkSIO1vJCy
         K9BQ==
X-Gm-Message-State: AOAM530acO6OIe9bAZJ7NqIusLCUkrJcq9yzg1Htx174AHr9pPaEQ5ML
        9t82svBNwXFpRDPlgwo47KvBJ7f2o+g3RE0ReJjwoSpMfWJJOGh4rd45wW/dN9XRamTKUCI86Fs
        PwuplDra61VEekLg7i7djbRVk
X-Received: by 2002:a6b:7801:: with SMTP id j1mr14958159iom.17.1607333303184;
        Mon, 07 Dec 2020 01:28:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDeY2O6DXZTuNKUmmjnn6q642QkKRkKnpp1/z+FVrKsgGZ3hLKlszE4AUMS1UPcFkAU7/nAg==
X-Received: by 2002:a6b:7801:: with SMTP id j1mr14958152iom.17.1607333302821;
        Mon, 07 Dec 2020 01:28:22 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id t1sm6996674ile.1.2020.12.07.01.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 01:28:22 -0800 (PST)
References: <20201207091920.3052-1-suravee.suthikulpanit@amd.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        joro@8bytes.org, will@kernel.org, Jon.Grimm@amd.com,
        brijesh.singh@amd.com
Subject: Re: [PATCH] iommu/amd: Set DTE[IntTabLen] to represent 512 IRTEs
In-reply-to: <20201207091920.3052-1-suravee.suthikulpanit@amd.com>
Date:   Mon, 07 Dec 2020 02:28:20 -0700
Message-ID: <87eek2rmmj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Suravee Suthikulpanit @ 2020-12-07 02:19 MST:

> According to the AMD IOMMU spec, the commit 73db2fc595f3
> ("iommu/amd: Increase interrupt remapping table limit to 512 entries")
> also requires the interrupt table length (IntTabLen) to be set to 9
> (power of 2) in the device table mapping entry (DTE).
>
> Fixes: 73db2fc595f3 ("iommu/amd: Increase interrupt remapping table limit to 512 entries")
> Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 89647700bab2..494b42a31b7a 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -257,7 +257,7 @@
>  #define DTE_IRQ_REMAP_INTCTL_MASK	(0x3ULL << 60)
>  #define DTE_IRQ_TABLE_LEN_MASK	(0xfULL << 1)
>  #define DTE_IRQ_REMAP_INTCTL    (2ULL << 60)
> -#define DTE_IRQ_TABLE_LEN       (8ULL << 1)
> +#define DTE_IRQ_TABLE_LEN       (9ULL << 1)
>  #define DTE_IRQ_REMAP_ENABLE    1ULL
>  
>  #define PAGE_MODE_NONE    0x00

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

