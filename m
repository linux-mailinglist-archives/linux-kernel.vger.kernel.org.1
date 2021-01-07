Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59E942ED749
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbhAGTL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:11:28 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44246 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728362AbhAGTL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:11:27 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 107J9ZZf093132;
        Thu, 7 Jan 2021 19:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=f4YlWjiMKOPZnipFfsaJcj0Yqv+ngkw69DJro0tpNyE=;
 b=gX+llP9RiJXOByvaEho9EgjKFwsZWLFxsh/7xKQk4bZMQbtQhMb2xXgaWsc9gNIDakWP
 jODKJ2EKKj647wP9d2/+KBNFm8ysNqSNBla6eYMpT/0WSHdxBwXhneCh8fmny3yOp7Fc
 BpcJYS4JQIiQ8JetI7/q7ZmXOai6UsR32dkII8dA5rRi5HL96HMI/WXAIA60okx73s9/
 WmmXnB787GeVNHx0EL10HGyqO0/+2GooPqVySfejncavAQTx/W08TSx9vAlYwbC4vffz
 /QvzfTfGiOgWAXohBNzDU+uVZ1nRWMDxqqdgPMrNPISTwrMk3yOD078zNRK8x/NbSaIN ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 35wftxdg14-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 07 Jan 2021 19:10:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 107IxSkM159542;
        Thu, 7 Jan 2021 19:08:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 35w3g36mj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jan 2021 19:08:36 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 107J8ZXM028620;
        Thu, 7 Jan 2021 19:08:35 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Jan 2021 19:08:34 +0000
Subject: Re: [PATCH] mm/hugetlb: Fix potential missing huge page size info
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210107123449.38481-1-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <240018cd-d0b7-6cc9-e026-6b90729254d2@oracle.com>
Date:   Thu, 7 Jan 2021 11:08:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210107123449.38481-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101070110
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101070111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/21 4:34 AM, Miaohe Lin wrote:
> The huge page size is encoded for VM_FAULT_HWPOISON errors only. So if we
> return VM_FAULT_HWPOISON, huge page size would just be ignored.
> 
> Fixes: aa50d3a7aa81 ("Encode huge page size for VM_FAULT_HWPOISON errors")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
