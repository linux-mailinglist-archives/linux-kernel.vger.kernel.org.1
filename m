Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D2726CB84
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbgIPU3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:29:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbgIPRYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600277005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0FBHbk68iVZgx7bJXMjUxCpKA5G+DPHMYndfXbzqZBk=;
        b=DZJzl9kVrSGmki2zkzK6nz44M28KKXSBxKH+ue+TPelc8nXf+xh2DHbrdNxyTBnI1akNw8
        hFgUH8EWn80fLDz3zc0zWwgG4eueKNsYKNMrgX3iwfOCuvX9XcX64mZL/5CXOEye0457WC
        Q1DXrHG0QMloit5ZMlNX/flyXJT8HI4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-ssaaT3QjOJKzRu4Ac00xZA-1; Wed, 16 Sep 2020 11:12:41 -0400
X-MC-Unique: ssaaT3QjOJKzRu4Ac00xZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86E7064095;
        Wed, 16 Sep 2020 15:12:39 +0000 (UTC)
Received: from starship (unknown [10.35.206.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD9F25FC36;
        Wed, 16 Sep 2020 15:12:37 +0000 (UTC)
Message-ID: <adcd725ec06d2a72de4f7e035edc743697fdbbb2.camel@redhat.com>
Subject: Re: [PATCH v2] iommu/amd: Restore IRTE.RemapEn bit for
 amd_iommu_activate_guest_mode
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, Joao Martins <joao.m.martins@oracle.com>
Date:   Wed, 16 Sep 2020 18:12:36 +0300
In-Reply-To: <20200916111720.43913-1-suravee.suthikulpanit@amd.com>
References: <20200916111720.43913-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-16 at 11:17 +0000, Suravee Suthikulpanit wrote:
> Commit e52d58d54a32 ("iommu/amd: Use cmpxchg_double() when updating
> 128-bit IRTE") removed an assumption that modify_irte_ga always set
> the valid bit, which requires the callers to set the appropriate value
> for the struct irte_ga.valid bit before calling the function.
> 
> Similar to the commit 26e495f34107 ("iommu/amd: Restore IRTE.RemapEn
> bit after programming IRTE"), which is for the function
> amd_iommu_deactivate_guest_mode().
> 
> The same change is also needed for the amd_iommu_activate_guest_mode().
> Otherwise, this could trigger IO_PAGE_FAULT for the VFIO based VMs with
> AVIC enabled.
> 
> Reported-by: Maxim Levitsky <mlevitsk@redhat.com>
> Tested-by: Maxim Levitsky <mlevitsk@redhat.com>
> Cc: Joao Martins <joao.m.martins@oracle.com>
> Fixes: e52d58d54a321 ("iommu/amd: Use cmpxchg_double() when updating 128-bit IRTE")
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index e938677af8bc..db4fb840c59c 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3900,14 +3900,18 @@ int amd_iommu_activate_guest_mode(void *data)
>  {
>  	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
>  	struct irte_ga *entry = (struct irte_ga *) ir_data->entry;
> +	u64 valid;
>  
>  	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) ||
>  	    !entry || entry->lo.fields_vapic.guest_mode)
>  		return 0;
>  
> +	valid = entry->lo.fields_vapic.valid;
> +
>  	entry->lo.val = 0;
>  	entry->hi.val = 0;
>  
> +	entry->lo.fields_vapic.valid       = valid;
>  	entry->lo.fields_vapic.guest_mode  = 1;
>  	entry->lo.fields_vapic.ga_log_intr = 1;
>  	entry->hi.fields.ga_root_ptr       = ir_data->ga_root_ptr;

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky

