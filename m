Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B77926CBE8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgIPUgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:36:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52652 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726735AbgIPRK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:10:27 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GH4ADB183693;
        Wed, 16 Sep 2020 17:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=9bln1IG5mw+Sl51BcjQd98EtjhJKHV8PeNOGu2Eppew=;
 b=FlumdxNcjyxRf16TOvLGo9LzR9RZETJ7NOoP9l2Q5w2kHxcQw/Ai9OUQIhbd9+gxYo5x
 HMjCA2/mr9IBXAE3phlYjdZGEhmF0Jdvr4hv6B+IxYLhcnpIABuvvAktBUJelSUL0vMZ
 V+9b3B81qv6d5d4L4sN6v1sflHsg82My2UV2jS5p/mHthRPNxLt7PbXs0osZb266iwgO
 3oJxmIZcIXi+Myvxn2QZzNTQg364jIOjmsNaj5Ykt0EvezaC6TBNNlnoqGqTmyR9Hlkn
 TKNKcWxx6bOinJCQf7KsopDApR+mPprkVWlKnJ1l5dRngPvtAmkqpJ7a3FwacsgXG1Gt Wg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 33gnrr4ec2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 17:10:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08GH616O141707;
        Wed, 16 Sep 2020 17:10:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 33khpkrh6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 17:10:15 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08GHADqK029739;
        Wed, 16 Sep 2020 17:10:13 GMT
Received: from [10.175.184.173] (/10.175.184.173)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Sep 2020 17:10:13 +0000
Subject: Re: [PATCH v2] iommu/amd: Restore IRTE.RemapEn bit for
 amd_iommu_activate_guest_mode
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     mlevitsk@redhat.com, joro@8bytes.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org
References: <20200916111720.43913-1-suravee.suthikulpanit@amd.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <3dd694a9-ad1e-f9ed-ac9b-20052f985f38@oracle.com>
Date:   Wed, 16 Sep 2020 18:10:08 +0100
MIME-Version: 1.0
In-Reply-To: <20200916111720.43913-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=1
 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9746 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=1
 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/20 12:17 PM, Suravee Suthikulpanit wrote:
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
> 
FWIW,

Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
