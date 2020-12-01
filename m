Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 300F52CB123
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 00:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgLAXzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 18:55:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726765AbgLAXzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 18:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606866815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kTWwMY4ZKYnVUyQmcMgy5Pq772/cdOxveE8A1FOaxjU=;
        b=WoMBZY4MTnb5dk49WYTgy6DGGiAI1DhAxZlyfSIgL5OXTvUDiqZ0+pZsRBw1fbfdaDQhD+
        MOSwcRj7I212ihU5VDWJRmLXtHc5z4Ud8wOmtkaX+fI59IAo1WTsi4b3kAsTHKtfNTg+L3
        OPQrgPqNG/bIOlWEgTJpI/BasdlPtSk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-2hvNe-EpO3uScfjEgOC8QA-1; Tue, 01 Dec 2020 18:53:33 -0500
X-MC-Unique: 2hvNe-EpO3uScfjEgOC8QA-1
Received: by mail-qt1-f198.google.com with SMTP id a22so2539762qtx.20
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 15:53:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=kTWwMY4ZKYnVUyQmcMgy5Pq772/cdOxveE8A1FOaxjU=;
        b=Z5EzAvr72TBRpoYv4+p9uJf5gegQRo2ez+ThgOMT/VvakYF+oigb/EhfTyoJzhRa30
         WrIYxSBqeIvR2l12/wtAh+N/VllUCkn/9Q9EKF/ALG0ltlLQopwITZh1SvLl947igSib
         HeKbQ+EkAyiGL/bCSA18mO+r6wnxaOSoaHYeY+gag5j4g6fgQFsWfe5fngU/JzzK7+LS
         +cSVibELNAdFt6ABKXhmtbnz/Xx2pAfNdWFfDNFZr/Oi90Kp97jZ3GJcLFMn+3SkhJrl
         0sb2Xuu3Q7R6/dRcKk7BTOCEugsyBA7qQGYcoy1sP8Pz46b4FeJm/E6nJR+NDxTKr/DK
         iPyw==
X-Gm-Message-State: AOAM53249qiNqJUB8liDclpwJ+N/3flRaW2VLX++4lbGi5euWT5JOk8q
        Fm+v95Ate95hDkQH3Vdw+txifyaZhoJXtQ3R11aT1D5agAoej+y4yOGETnCJWBKYhv4/MjbhTdZ
        c2k9b9o8+pAAFcHe6oQEdMg4U
X-Received: by 2002:ac8:3855:: with SMTP id r21mr5604054qtb.380.1606866813077;
        Tue, 01 Dec 2020 15:53:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzOzxndVYqPQFSh1N3T/G4TW6qTcdOT3oSZXbfEAVOFr6V95caA3iOSHKHcZ/VW/NY87Kq1Rw==
X-Received: by 2002:ac8:3855:: with SMTP id r21mr5604045qtb.380.1606866812869;
        Tue, 01 Dec 2020 15:53:32 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id b197sm36856qkg.65.2020.12.01.15.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 15:53:27 -0800 (PST)
References: <20201015025002.87997-1-suravee.suthikulpanit@amd.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/amd: Increase interrupt remapping table limit to
 512 entries
In-reply-to: <20201015025002.87997-1-suravee.suthikulpanit@amd.com>
Date:   Tue, 01 Dec 2020 16:53:25 -0700
Message-ID: <87sg8pkrre.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Suravee Suthikulpanit @ 2020-10-14 19:50 MST:

> Certain device drivers allocate IO queues on a per-cpu basis.
> On AMD EPYC platform, which can support up-to 256 cpu threads,
> this can exceed the current MAX_IRQ_PER_TABLE limit of 256,
> and result in the error message:
>
>     AMD-Vi: Failed to allocate IRTE
>
> This has been observed with certain NVME devices.
>
> AMD IOMMU hardware can actually support upto 512 interrupt
> remapping table entries. Therefore, update the driver to
> match the hardware limit.
>
> Please note that this also increases the size of interrupt remapping
> table to 8KB per device when using the 128-bit IRTE format.
>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 30a5d412255a..427484c45589 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -406,7 +406,11 @@ extern bool amd_iommu_np_cache;
>  /* Only true if all IOMMUs support device IOTLBs */
>  extern bool amd_iommu_iotlb_sup;
>  
> -#define MAX_IRQS_PER_TABLE	256
> +/*
> + * AMD IOMMU hardware only support 512 IRTEs despite
> + * the architectural limitation of 2048 entries.
> + */
> +#define MAX_IRQS_PER_TABLE	512
>  #define IRQ_TABLE_ALIGNMENT	128
>  
>  struct irq_remap_table {

With this change should DTE_IRQ_TABLE_LEN be changed to 9? IIUC the spec
correctly leaving it at 8 is saying the table is 256 entries long.

Regards,
Jerry

