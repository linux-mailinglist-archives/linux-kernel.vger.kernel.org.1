Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C44274F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgIWCcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 22:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726548AbgIWCcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600828372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2MO7lymMp9srQF8kov4JxrV28TWE85qvWXzbFlo1Ctk=;
        b=b8KdMM/ZsAlXaV1hoIS+Q1Rgk60NAoxaer2Ip8ZwhyPlGnhbI1b3XXYBwBve5h+e/o6jQ9
        lLe1K3HbNmbv35u64xJGWk/tc2LWbFneU4Rwahwh5eAk6H4gfdjU90gD7uOesE+g0R96/K
        5azZBPAC1b4epOcXB2174sXXYY2Xgr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-VUP15onONwOwCZEB1an0-A-1; Tue, 22 Sep 2020 22:32:48 -0400
X-MC-Unique: VUP15onONwOwCZEB1an0-A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BA6D1074641;
        Wed, 23 Sep 2020 02:32:47 +0000 (UTC)
Received: from localhost (ovpn-12-42.pek2.redhat.com [10.72.12.42])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8796F5D9CC;
        Wed, 23 Sep 2020 02:32:46 +0000 (UTC)
Date:   Wed, 23 Sep 2020 10:32:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     joro@8bytes.org, ahuang12@lenovo.com
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        jsnitsel@redhat.com
Subject: Re: [PATCH] Revert "iommu/amd: Treat per-device exclusion ranges as
 r/w unity-mapped regions"
Message-ID: <20200923023244.GK25604@MiWiFi-R3L-srv>
References: <20200923022655.750-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923022655.750-1-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot CC-ing Jerry, add him.

On 09/23/20 at 10:26am, Baoquan He wrote:
> A regression failure of kdump kernel boot was reported on a HPE system.
> Bisect points at commit 387caf0b759ac43 ("iommu/amd: Treat per-device
> exclusion ranges as r/w unity-mapped regions") as criminal. Reverting it
> fix the failure.
> 
> With the commit, kdump kernel will always print below error message, then
> naturally AMD iommu can't function normally during kdump kernel bootup.
> 
>   ~~~~~~~~~
>   AMD-Vi: [Firmware Bug]: IVRS invalid checksum
> 
> Why commit 387caf0b759ac43 causing it haven't been made clear.

Hi Joerg, Adrian

We only have one machine which can reproduce the issue, it's a gen10-01
of HPE. If any log or info are needed, please let me know, I can attach
here.

Thanks
Baoquan

> 
> From the commit log, a discussion thread link is pasted. In that discussion
> thread, Adrian told the fix is for a system with already broken BIOS, and
> Joerg suggested two options. Finally option 2) is taken. Maybe option 1)
> should be the right approach?
> 
>   1) Bail out and disable the IOMMU as the BIOS screwed up
>   2) Treat per-device exclusion ranges just as r/w unity-mapped
>      regions.
> 
> https://lists.linuxfoundation.org/pipermail/iommu/2019-November/040117.html
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  drivers/iommu/amd/init.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 9aa1eae26634..bbe7ceae5949 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1109,17 +1109,22 @@ static int __init add_early_maps(void)
>   */
>  static void __init set_device_exclusion_range(u16 devid, struct ivmd_header *m)
>  {
> +	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
> +
>  	if (!(m->flags & IVMD_FLAG_EXCL_RANGE))
>  		return;
>  
> -	/*
> -	 * Treat per-device exclusion ranges as r/w unity-mapped regions
> -	 * since some buggy BIOSes might lead to the overwritten exclusion
> -	 * range (exclusion_start and exclusion_length members). This
> -	 * happens when there are multiple exclusion ranges (IVMD entries)
> -	 * defined in ACPI table.
> -	 */
> -	m->flags = (IVMD_FLAG_IW | IVMD_FLAG_IR | IVMD_FLAG_UNITY_MAP);
> +	if (iommu) {
> +		/*
> +		 * We only can configure exclusion ranges per IOMMU, not
> +		 * per device. But we can enable the exclusion range per
> +		 * device. This is done here
> +		 */
> +		set_dev_entry_bit(devid, DEV_ENTRY_EX);
> +		iommu->exclusion_start = m->range_start;
> +		iommu->exclusion_length = m->range_length;
> +	}
> +
>  }
>  
>  /*
> -- 
> 2.17.2
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 

