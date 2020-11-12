Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A009D2B08CE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 16:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgKLPsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 10:48:41 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:51828 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727789AbgKLPsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 10:48:40 -0500
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACFSRrb011455;
        Thu, 12 Nov 2020 15:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=am/hQTORqGTgFSiAPw/esERQ1tn2MlSFXRWxoiKNb8Y=;
 b=pV6oRrQ5lk8fOKI26YSvMmFTLnRu6ijkFHsAi2Lcct4s6gV+FkG1Qkmjz8Ln9eWF/dyW
 p7QygLU5GmidYZpmczwFu1z5THYPIIz/r2jI8W0W6xSUr0qCYF+kKfLuP2PDLUO+9qgZ
 hLBmBpcbAfxtukiHRDtgiq9sWciQF5JI01eR19LY+VwblpfSaYb/8b0cwd5HcZd8Bikm
 0aUewLvK9+WxzARiiOa4NYUMpWPByUDZUEYajRv7spfD+H6dUs0IGfhqZqZFEDjz2C+4
 xCPM5P1t2OOnwKwKOm+wUDS0TitJK8fTQn9oWoOgQSsmt7FzcLrfONxQcxmrwdhhUV0+ wA== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 34ressba78-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 15:48:18 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 1304074;
        Thu, 12 Nov 2020 15:48:17 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.214.129.62])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 980BF57;
        Thu, 12 Nov 2020 15:48:16 +0000 (UTC)
Date:   Thu, 12 Nov 2020 09:48:16 -0600
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Mike Travis <mike.travis@hpe.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/platform/uv: UV5 Fix copied output archtype
Message-ID: <20201112154816.GI1468175@swahl-home.5wahls.com>
References: <20201111010418.82133-1-mike.travis@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111010418.82133-1-mike.travis@hpe.com>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_06:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 malwarescore=0 suspectscore=1
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011120093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 07:04:18PM -0600, Mike Travis wrote:
> A test shows that the output contains a space:
>     # cat /proc/sgi_uv/archtype
>     NSGI4 U/UVX
> Remove that embedded space by copying the "trimmed" buffer instead of the
> untrimmed input character list.  Use sizeof to remove size dependency
> on copy out length.  Increase output buffer size by one character just
> in case BIOS sends an 8 character string for archtype.
> 
> Fixes: 1e61f5a95f191 (Add and decode Arch Type in UVsystab)
> 
> Signed-off-by: Mike Travis <mike.travis@hpe.com>

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>


> ---
>  arch/x86/kernel/apic/x2apic_uv_x.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
> index 3115caa7d7d0..1b98f8c12b96 100644
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -33,7 +33,7 @@ static union uvh_apicid		uvh_apicid;
>  static int			uv_node_id;
>  
>  /* Unpack AT/OEM/TABLE ID's to be NULL terminated strings */
> -static u8 uv_archtype[UV_AT_SIZE];
> +static u8 uv_archtype[UV_AT_SIZE + 1];
>  static u8 oem_id[ACPI_OEM_ID_SIZE + 1];
>  static u8 oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
>  
> @@ -320,7 +320,7 @@ static int __init decode_arch_type(unsigned long ptr)
>  
>  	if (n > 0 && n < sizeof(uv_ate->archtype)) {
>  		pr_info("UV: UVarchtype received from BIOS\n");
> -		uv_stringify(UV_AT_SIZE, uv_archtype, uv_ate->archtype);
> +		uv_stringify(sizeof(uv_archtype), uv_archtype, uv_ate->archtype);
>  		return 1;
>  	}
>  	return 0;
> @@ -378,7 +378,7 @@ static int __init uv_set_system_type(char *_oem_id, char *_oem_table_id)
>  	if (!early_get_arch_type())
>  
>  		/* If not use OEM ID for UVarchtype */
> -		uv_stringify(UV_AT_SIZE, uv_archtype, _oem_id);
> +		uv_stringify(sizeof(uv_archtype), uv_archtype, oem_id);
>  
>  	/* Check if not hubbed */
>  	if (strncmp(uv_archtype, "SGI", 3) != 0) {
> -- 
> 2.21.0
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
