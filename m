Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912332AD5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgKJMCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:02:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726706AbgKJMCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:02:10 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AABVufw025787;
        Tue, 10 Nov 2020 07:01:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=/DPqYVC7ZZ60c5ApNonguqemmgj1RiB38XeTxKptSSI=;
 b=Z/Stl1XUR7g1H1G7ObQ5ViFR1JYlxfOek8mM91ovGnkVDqtaBRfS/Crh+EnsRiwg4cjR
 fGe56xuXpc+0cEkiOslqI9JZzZBJhifwCGCvyn8oY9TvnZIyig6oEwgwBOyzt64J5djU
 16WGHnsmIjenJKkdINwwz2YGmKq6h4tCNz4GWuRXGhxnVgR1WMH4AMneNiILzdCW7oAk
 Af6haa5Eqg1lqpSx/hhoB7yw0M4H7wvBSxGYr5hIp8C9rL4K9LX4Le7EZ0ac/1mtP//C
 5TAohEukN7pNeyPx6qeViBoCqN742i9UiswR2OZASkT8xnoc0cvRYb5+eIZh3XQYtuvr GA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34qsbcj5g7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 07:01:10 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AABcTje054767;
        Tue, 10 Nov 2020 07:01:10 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34qsbcj5eu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 07:01:10 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AABv5Hw008467;
        Tue, 10 Nov 2020 12:01:07 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 34q0840prd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 12:01:07 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AAC15WE62718292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 12:01:05 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40270A4054;
        Tue, 10 Nov 2020 12:01:05 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E87D1A4064;
        Tue, 10 Nov 2020 12:01:04 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Nov 2020 12:01:04 +0000 (GMT)
Received: from [9.81.202.220] (unknown [9.81.202.220])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 95E4BA0218;
        Tue, 10 Nov 2020 23:01:02 +1100 (AEDT)
Subject: Re: [PATCH] powerpc/powernv/sriov: fix unsigned int win compared to
 less than zero
To:     xiakaixu1987@gmail.com, fbarrat@linux.ibm.com, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
References: <1605007170-22171-1-git-send-email-kaixuxia@tencent.com>
From:   Andrew Donnellan <ajd@linux.ibm.com>
Message-ID: <40b8ba6f-4916-55c2-a1f0-b7daa3c2e201@linux.ibm.com>
Date:   Tue, 10 Nov 2020 23:01:01 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1605007170-22171-1-git-send-email-kaixuxia@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_04:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=671
 mlxscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/20 10:19 pm, xiakaixu1987@gmail.com wrote:
> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> Fix coccicheck warning:
> 
> ./arch/powerpc/platforms/powernv/pci-sriov.c:443:7-10: WARNING: Unsigned expression compared with zero: win < 0
> ./arch/powerpc/platforms/powernv/pci-sriov.c:462:7-10: WARNING: Unsigned expression compared with zero: win < 0
> 
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

This seems like the right fix, the value assigned to win can indeed be 
-1 so it should be signed. Thanks for sending the patch.

Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>

> ---
>   arch/powerpc/platforms/powernv/pci-sriov.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-sriov.c b/arch/powerpc/platforms/powernv/pci-sriov.c
> index c4434f20f42f..92fc861c528f 100644
> --- a/arch/powerpc/platforms/powernv/pci-sriov.c
> +++ b/arch/powerpc/platforms/powernv/pci-sriov.c
> @@ -422,7 +422,7 @@ static int pnv_pci_vf_assign_m64(struct pci_dev *pdev, u16 num_vfs)
>   {
>   	struct pnv_iov_data   *iov;
>   	struct pnv_phb        *phb;
> -	unsigned int           win;
> +	int		       win;
>   	struct resource       *res;
>   	int                    i, j;
>   	int64_t                rc;
> 

-- 
Andrew Donnellan              OzLabs, ADL Canberra
ajd@linux.ibm.com             IBM Australia Limited
