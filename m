Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B432EE674
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 21:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbhAGUAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 15:00:30 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:36488 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbhAGUA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 15:00:29 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 107JtT9h013643;
        Thu, 7 Jan 2021 19:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=AY+nAlYViTGNUiSI/WSmw8nztJ4X4iNaCQEpR42VzdU=;
 b=VPCJTL4KvVfwJ/vVZ77y+eh6B7JIaUV0ka23c6x24XQceLAGAagsUSctWMrXVeZv7sn5
 VOYHp2JMYeAUimv069VmXRSF32b+XTwaqQZAQdLe5Io+wE/tC5FeymzPdS4ezS8gtwcc
 SMjlekCUPdbVrr7UF2J1Vu1VTzEGTaxhTzOQQb6i6EHOhWAmPvsnm+ZUIxf3oqaHP+hp
 hPNO8nKpnDnV97iOyZmD1X/fqLF3E+gimNu6qolOP2azLx4EUf6mfKlO00xQ945ws9DR
 oUrNbDgnIvDq/Vsu4Dot8oHpM0SenSV0SkKGLVX6v4swAxZZ0DBgkTnwrRnTdRer/nhc Og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 35wepme34k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 07 Jan 2021 19:59:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 107Jss0u026078;
        Thu, 7 Jan 2021 19:59:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 35v1fbn4sd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jan 2021 19:59:41 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 107Jxe2Y018316;
        Thu, 7 Jan 2021 19:59:40 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Jan 2021 19:59:39 +0000
Subject: Re: [PATCH] mm/hugetlb: Fix potential double free in
 hugetlb_register_node() error path
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210107123249.36964-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a8753475-e9a8-a730-c095-086530ecdd17@oracle.com>
Date:   Thu, 7 Jan 2021 11:59:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210107123249.36964-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101070115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101070115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/21 4:32 AM, Miaohe Lin wrote:
> In hugetlb_sysfs_add_hstate(), we would do kobject_put() on hstate_kobjs
> when failed to create sysfs group but forget to set hstate_kobjs to NULL.
> Then in hugetlb_register_node() error path, we may free it again via
> hugetlb_unregister_node().
> 
> Fixes: a3437870160c ("hugetlb: new sysfs interface")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/hugetlb.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thanks, this is a potential issue that should be fixed.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

This has been around for a long time (more than 12 years).  I suspect
nobody actually experienced this issue.  You just discovered via code
inspection.  Correct?
At one time cc stable would not be accepted for this type of issue,
not sure about today.
-- 
Mike Kravetz
