Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96CAF2A2CFE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgKBO3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:29:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12612 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725809AbgKBO3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:29:54 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A2E21nB096586;
        Mon, 2 Nov 2020 09:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=A211HEQL0o7cFFR+RWcWVCddjHLxzWcqy3gPnBa+C8k=;
 b=VTlEatNmT6+qBybENdZpVeDhU5nPZsplJ8TMszK0Q0GjbcatAZ8F8LHfM1oooVKYqpqU
 uE7uRVde+VYVzqyVnMRYgnZBYY1xF4UfZeNzQ/585ul7rBhCpAMDtod7V+QoAIR9JS6J
 kY7K6GFhSxuPQ+3f2diB8+G5EnLVJlgG84jkq+TbVuQt9+9TLrlOOJjUgOYTI6l1x31m
 qxD5aD1LGnyasJ46kQXTOh9dF/gq9qZEkXr0qT2WIGc97kZkF8aUlJjZ4yG9Ce8p1v4w
 AjQouYhZeTwvSsk5MOFrmSL7k0yhzyycJCBzRYDjaunbc5LcfuJssyGtdB9FsjvDMWqB Rw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34jfjpgq0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 09:29:38 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A2ET8ap001320;
        Mon, 2 Nov 2020 14:29:36 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 34h0fct6xp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 14:29:36 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A2ETYBC852580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Nov 2020 14:29:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 473C911C04C;
        Mon,  2 Nov 2020 14:29:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0FAE511C04A;
        Mon,  2 Nov 2020 14:29:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.4.98])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  2 Nov 2020 14:29:33 +0000 (GMT)
Subject: Re: [PATCH v2 2/2] misc: ocxl: config: Rename function attribute
 description
To:     Lee Jones <lee.jones@linaro.org>, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
References: <20201102142001.560490-1-lee.jones@linaro.org>
 <20201102142001.560490-2-lee.jones@linaro.org>
From:   Frederic Barrat <fbarrat@linux.ibm.com>
Message-ID: <b06fdb27-c799-c339-f3be-c1d5bccf41c1@linux.ibm.com>
Date:   Mon, 2 Nov 2020 15:29:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201102142001.560490-2-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-02_07:2020-11-02,2020-11-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011020107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 02/11/2020 à 15:20, Lee Jones a écrit :
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/misc/ocxl/config.c:81: warning: Function parameter or member 'dev' not described in 'get_function_0'
>   drivers/misc/ocxl/config.c:81: warning: Excess function parameter 'device' description in 'get_function_0'
> 
> Cc: Frederic Barrat <fbarrat@linux.ibm.com>
> Cc: Andrew Donnellan <ajd@linux.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---


Thanks!
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>


>   drivers/misc/ocxl/config.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
> index 4d490b92d951f..a68738f382521 100644
> --- a/drivers/misc/ocxl/config.c
> +++ b/drivers/misc/ocxl/config.c
> @@ -73,7 +73,7 @@ static int find_dvsec_afu_ctrl(struct pci_dev *dev, u8 afu_idx)
>   
>   /**
>    * get_function_0() - Find a related PCI device (function 0)
> - * @device: PCI device to match
> + * @dev: PCI device to match
>    *
>    * Returns a pointer to the related device, or null if not found
>    */
> 
