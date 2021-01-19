Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144BD2FBEAB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 19:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389124AbhASSNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 13:13:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42390 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389030AbhASSMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 13:12:36 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JI9Vpn129656;
        Tue, 19 Jan 2021 18:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=/8H0gRV+vabZL2YMXaE14tkDEFhy2VZT/nTE+fC2j5c=;
 b=Wxkpi+RbE3Lw1H75S4H8U2wX1HvG+zfsXv/mf5X437Okr/qOS4vJfLIv7BU6HA2Y0W6t
 W1AaqSpiouzi9RXksq7k2n/99PaErGnGjLVchtQA5sVo0X0swetL1/b2/xaOgovJnnBK
 RVXfWf+bZ4FbMQKhCT3dMHzokY3VSK6aUFN1DIsrDGl+XhHeNKoiD84V2d1ULta3t4q9
 6rmZoR9E37spK5nxL+NXL+RgwYHiRwbkcsGCrOVpGXj4OFI9wU8gdofzvfOJ+32ai5ab
 7oo7xtGoXAsSXIzaOUATbpWPD3eG4/Do/6kib02Zp0d+d2XmaA9MoXjbfonobxk821z0 fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 363xyhsr6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 18:11:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10JIAdTm051219;
        Tue, 19 Jan 2021 18:11:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3661khmae2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jan 2021 18:11:24 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 10JIBNTM011585;
        Tue, 19 Jan 2021 18:11:23 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jan 2021 10:11:22 -0800
Subject: Re: [PATCH] hugetlbfs: Use helper macro default_hstate in
 init_hugetlbfs_fs
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210116091827.20982-1-linmiaohe@huawei.com>
 <0aa2f156-a2c9-3b2e-4244-ecf68208b4a0@oracle.com>
Message-ID: <77e3b0b1-36f2-3af3-d208-7b3a0384be3f@oracle.com>
Date:   Tue, 19 Jan 2021 10:11:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <0aa2f156-a2c9-3b2e-4244-ecf68208b4a0@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101190102
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9869 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501 spamscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101190102
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Andrew

On 1/19/21 9:53 AM, Mike Kravetz wrote:
> On 1/16/21 1:18 AM, Miaohe Lin wrote:
>> Since commit e5ff215941d5 ("hugetlb: multiple hstates for multiple page
>> sizes"), we can use macro default_hstate to get the struct hstate which
>> we use by default. But init_hugetlbfs_fs() forgot to use it.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Thanks,
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
