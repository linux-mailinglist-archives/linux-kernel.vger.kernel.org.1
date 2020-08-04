Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D472823C190
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 23:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgHDVdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 17:33:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24916 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727773AbgHDVdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:33:14 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 074LWlri093545;
        Tue, 4 Aug 2020 17:32:51 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qe8ta4uq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 17:32:51 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 074LWobZ093985;
        Tue, 4 Aug 2020 17:32:50 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32qe8ta4mx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 17:32:48 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 074LG3RR014804;
        Tue, 4 Aug 2020 21:32:33 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04wdc.us.ibm.com with ESMTP id 32n0193fc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 21:32:33 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 074LWWt641419044
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Aug 2020 21:32:32 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC1BDB2066;
        Tue,  4 Aug 2020 21:32:32 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 013E3B205F;
        Tue,  4 Aug 2020 21:32:31 +0000 (GMT)
Received: from oc3560204572.ibm.com (unknown [9.85.148.242])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 Aug 2020 21:32:31 +0000 (GMT)
Message-ID: <45838c4ad8e331121f48ec13cde49422e8ae7ba9.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 3/7] powerpc/pseries/iommu: Move window-removing part
 of remove_ddw into remove_dma_window
From:   David Dai <zdai@linux.vnet.ibm.com>
To:     Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Joel Stanley <joel@jms.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Aug 2020 16:32:31 -0500
In-Reply-To: <20200716071658.467820-4-leobras.c@gmail.com>
References: <20200716071658.467820-1-leobras.c@gmail.com>
         <20200716071658.467820-4-leobras.c@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_04:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008040147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-07-16 at 04:16 -0300, Leonardo Bras wrote:
> Move the window-removing part of remove_ddw into a new function
> (remove_dma_window), so it can be used to remove other DMA windows.
> 
> It's useful for removing DMA windows that don't create
> DIRECT64_PROPNAME
> property, like the default DMA window from the device, which uses
> "ibm,dma-window".
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> ---
>  arch/powerpc/platforms/pseries/iommu.c | 45 +++++++++++++++---------
> --
>  1 file changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c
> b/arch/powerpc/platforms/pseries/iommu.c
> index 1a933c4e8bba..4e33147825cc 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -781,25 +781,14 @@ static int __init disable_ddw_setup(char *str)
>  
>  early_param("disable_ddw", disable_ddw_setup);
>  
> -static void remove_ddw(struct device_node *np, bool remove_prop)
> +static void remove_dma_window(struct device_node *np, u32
> *ddw_avail,
> +			      struct property *win)
>  {
>  	struct dynamic_dma_window_prop *dwp;
> -	struct property *win64;
> -	u32 ddw_avail[DDW_APPLICABLE_SIZE];
>  	u64 liobn;
> -	int ret = 0;
> -
> -	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
> -					 &ddw_avail[0],
> DDW_APPLICABLE_SIZE);
> -
> -	win64 = of_find_property(np, DIRECT64_PROPNAME, NULL);
> -	if (!win64)
> -		return;
> -
> -	if (ret || win64->length < sizeof(*dwp))
> -		goto delprop;
> +	int ret;
>  
> -	dwp = win64->value;
> +	dwp = win->value;
>  	liobn = (u64)be32_to_cpu(dwp->liobn);
>  
>  	/* clear the whole window, note the arg is in kernel pages */
> @@ -821,10 +810,30 @@ static void remove_ddw(struct device_node *np,
> bool remove_prop)
>  		pr_debug("%pOF: successfully removed direct window:
> rtas returned "
>  			"%d to ibm,remove-pe-dma-window(%x) %llx\n",
>  			np, ret, ddw_avail[DDW_REMOVE_PE_DMA_WIN],
> liobn);
> +}
> +
> +static void remove_ddw(struct device_node *np, bool remove_prop)
> +{
> +	struct property *win;
> +	u32 ddw_avail[DDW_APPLICABLE_SIZE];
> +	int ret = 0;
> +
> +	ret = of_property_read_u32_array(np, "ibm,ddw-applicable",
> +					 &ddw_avail[0],
> DDW_APPLICABLE_SIZE);
> +	if (ret)
> +		return;
> +
> +	win = of_find_property(np, DIRECT64_PROPNAME, NULL);
> +	if (!win)
> +		return;
> +
> +	if (win->length >= sizeof(struct dynamic_dma_window_prop))
> +		remove_dma_window(np, ddw_avail, win);
> +
> +	if (!remove_prop)
> +		return;
>  
> -delprop:
> -	if (remove_prop)
> -		ret = of_remove_property(np, win64);
> +	ret = of_remove_property(np, win);
>  	if (ret)
>  		pr_warn("%pOF: failed to remove direct window property:
> %d\n",
>  			np, ret);
Tested-by: David Dai <zdai@linux.vnet.ibm.com>

