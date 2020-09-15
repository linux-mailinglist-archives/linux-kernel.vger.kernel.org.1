Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B7826A425
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 13:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgIOL2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 07:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43305 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbgIOLZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600169117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60FvI2fqcP6GhvmqdoyF8WY6GpsYnPO581gMKI3U6q4=;
        b=HPzZklTnkmBmxVf2hEeSCgBmDx5lQvU/du3Mz6jekmpZj4J3IKXDaAbx2f9M1qBL4xB5Tc
        tpqw7HGZCXvAwAkb/RiG869314lj9ZxAaR6D/dx6yCGvrGKBHDaZscO7kwSBBCZ5FBHhkL
        9wAzTsIl1v339MJfhnt7TCAgq6xFclc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-ni2I88g9NyiUDlg-1Gwv8w-1; Tue, 15 Sep 2020 07:25:15 -0400
X-MC-Unique: ni2I88g9NyiUDlg-1Gwv8w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D92E664080;
        Tue, 15 Sep 2020 11:25:13 +0000 (UTC)
Received: from starship (unknown [10.35.207.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 294DB5DDDE;
        Tue, 15 Sep 2020 11:25:10 +0000 (UTC)
Message-ID: <04a8ab5cb1f6662f72bcad856da3415d6d9b2593.camel@redhat.com>
Subject: Re: [PATCH] iommu/amd: fix interrupt remapping for avic
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Joao Martins <joao.m.martins@oracle.com>,
        Joerg Roedel <joro@8bytes.org>
Date:   Tue, 15 Sep 2020 14:25:01 +0300
In-Reply-To: <60856c61-062b-8d92-e565-38bd00855228@amd.com>
References: <20200913124211.6419-1-mlevitsk@redhat.com>
         <60856c61-062b-8d92-e565-38bd00855228@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-09-14 at 21:48 +0700, Suravee Suthikulpanit wrote:
> Maxim,
> 
> On 9/13/2020 7:42 PM, Maxim Levitsky wrote:
> > Commit e52d58d54a32 ("iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE")
> > accidentally removed an assumption that modify_irte_ga always set the valid bit
> > and amd_iommu_activate_guest_mode relied on that.
> > 
> > Side effect of this is that on my machine, VFIO based VMs with AVIC enabled
> > would eventually crash and show IOMMU errors like that:
> > 
> > AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0055 address=0xfffffffdf8000000 flags=0x0008]
> > 
> > Fixes: e52d58d54a321 ("iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE")
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >   drivers/iommu/amd/iommu.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> > index 07ae8b93887e5..aff4cc1869356 100644
> > --- a/drivers/iommu/amd/iommu.c
> > +++ b/drivers/iommu/amd/iommu.c
> > @@ -3853,6 +3853,7 @@ int amd_iommu_activate_guest_mode(void *data)
> >   	entry->hi.fields.ga_root_ptr       = ir_data->ga_root_ptr;
> >   	entry->hi.fields.vector            = ir_data->ga_vector;
> >   	entry->lo.fields_vapic.ga_tag      = ir_data->ga_tag;
> > +	entry->lo.fields_remap.valid = 1;
> >   
> >   	return modify_irte_ga(ir_data->irq_2_irte.devid,
> >   			      ir_data->irq_2_irte.index, entry, ir_data);
> > 
> 
> Could you please try with the following patch instead?
> 
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3840,14 +3840,18 @@ int amd_iommu_activate_guest_mode(void *data)
>   {
>          struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
>          struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
> +       u64 valid;
> 
>          if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
>              !entry || entry->lo.fields_vapic.guest_mode)
>                  return 0;
> 
> +       valid = entry->lo.fields_vapic.valid;
> +
>          entry->lo.val = 0;
>          entry->hi.val = 0;
> 
> +       entry->lo.fields_vapic.valid       = valid;
>          entry->lo.fields_vapic.guest_mode  = 1;
>          entry->lo.fields_vapic.ga_log_intr = 1;
>          entry->hi.fields.ga_root_ptr       = ir_data->ga_root_ptr;
> @@ -3864,12 +3868,14 @@ int amd_iommu_deactivate_guest_mode(void *data)
>          struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
>          struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
>          struct irq_cfg *cfg = ir_data->cfg;
> -       u64 valid = entry->lo.fields_remap.valid;
> +       u64 valid;
> 
>          if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
>              !entry || !entry->lo.fields_vapic.guest_mode)
>                  return 0;
> 
> +       valid = entry->lo.fields_remap.valid;
> +
>          entry->lo.val = 0;
>          entry->hi.val = 0;
I see. I based my approach on the fact that valid bit was
set always to true anyway before, plus that amd_iommu_activate_guest_mode
should be really only called when someone activates a valid interrupt remapping
entry, but IMHO the approach of preserving the valid bit is safer anyway.

It works on my system (I applied the patch manually, since either your or my email client,
seems to mangle the patch)

Thanks,
Best regards,
	Maxim Levitsky


> --

> 
> Thanks,
> Suravee
> 


