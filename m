Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9801A2CDA93
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbgLCQAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:00:14 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:16324 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728997AbgLCQAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:00:13 -0500
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B3FuTSH005323;
        Thu, 3 Dec 2020 15:59:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=w04AUgMePyEqeqeRiVGvhu/h19hVh6IkUQigJ5V8574=;
 b=b/CaK7vyfKPQXh8G/XhsUUVZ+oDf3b7VacvAXqTurTHBdwOA+Uxan7Ztsdinvzmi6+QK
 PUVY0ep+n0qmC230+VzTPET7Y82lWjMg+T3E67wtfJityom/vzcOjhOU7ClfW/iF+ejQ
 b96WaxipZQrLI9K0Qi4vY4y1RpFOQ7iKE59acUg8zPfWiZ0uZMqQHK5U8D1LjmDO23wC
 VFUQqCJKSe9XMXerJvbK3UrOy99aJmsYzYtKHgNyXFVrOJLhJ+K1F51s4PpGMcxwRC1+
 T55FXdXz22XoEt0NbJ6kV3ZlR1KF/6QbBk1cxiHHsf+3ChSOIjk8e5U43yHhQz89VguL 8A== 
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 355rn2ts2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Dec 2020 15:59:13 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id 92BDD5B;
        Thu,  3 Dec 2020 15:59:12 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.214.129.62])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id A65644C;
        Thu,  3 Dec 2020 15:59:11 +0000 (UTC)
Date:   Thu, 3 Dec 2020 09:59:11 -0600
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Steve Wahl <steve.wahl@hpe.com>, x86@kernel.org,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix UV4 Hub Revision adjustment
Message-ID: <20201203155911.GQ1798712@swahl-home.5wahls.com>
References: <20201203152252.371199-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203152252.371199-1-mike.travis@hpe.com>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-03_08:2020-12-03,2020-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 malwarescore=0 impostorscore=0 adultscore=0
 clxscore=1011 spamscore=0 suspectscore=1 bulkscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012030095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

On Thu, Dec 03, 2020 at 09:22:52AM -0600, Mike Travis wrote:
> Fix UV4 Hub Revision adjustment as Hub chip starts with revision 1.
> Incorrectly identifies UV4 as UV4A and UV4A as UV5.
> 
> Fixes 647128f1536ef: x86/platform/uv: Update UV MMRs for UV5
> 
> Signed-off-by: Mike Travis <mike.travis@hpe.com>
> Acked-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> ---
>  arch/x86/kernel/apic/x2apic_uv_x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
> index 1b98f8c12b96..235f5cde06fc 100644
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -161,7 +161,7 @@ static int __init early_set_hub_type(void)
>  	/* UV4/4A only have a revision difference */
>  	case UV4_HUB_PART_NUMBER:
>  		uv_min_hub_revision_id = node_id.s.revision
> -					 + UV4_HUB_REVISION_BASE;
> +					 + UV4_HUB_REVISION_BASE - 1;
>  		uv_hub_type_set(UV4);
>  		if (uv_min_hub_revision_id == UV4A_HUB_REVISION_BASE)
>  			uv_hub_type_set(UV4|UV4A);
> -- 
> 2.21.0
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
