Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05102B9ABA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbgKSSeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 13:34:36 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36030 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbgKSSee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:34:34 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJITohF128981;
        Thu, 19 Nov 2020 18:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=w9M2+if15vunLknC1wy2lWFuK0w0jsKKPPwIlLNNRbc=;
 b=YTFNxchfMLbxvd+d1TDTSlfKw+hR77l2qK/nMrEOLdxWo6lJtk+CPZ9xlsgD5yrEBaea
 gsfwR0+s4G7/IlXCD7+9+PQS63oFSTn6UhnWWeEf+7mMco7ezCrhRdIiVVwNLLeNPLP/
 rUNj0XGT7kNHZPCZI7zr/z7q3mqZg4k4jadd3vcWlqHLA//R1cTfwGMPxY30YbjvwWhR
 aiQC5DvWvsCpg7vw0JouHNik5aYbSnNdTQUwec4BEZ6Y9TV1W3bO3uoaZylB15Djrc0T
 tTRQOR28T8H46sMl3Zh3IwFzuJsD9eGrddOjs90+qAb+GTawlDM6Sc//aoYlh6QJuK7i Mw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 34t7vneyxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Nov 2020 18:34:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AJIVaFS108354;
        Thu, 19 Nov 2020 18:34:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34ts0u4dtt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Nov 2020 18:34:24 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0AJIYKGv013817;
        Thu, 19 Nov 2020 18:34:20 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Nov 2020 10:34:20 -0800
Subject: Re: [PATCH v2] mm: hugetlb: fix type of delta parameter and related
 local variables in gather_surplus_pages()
To:     Liu Xiang <liu.xiang@zlingsmart.com>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        liuxiang_1999@126.com, Pan Jiagen <pan.jiagen@zlingsmart.com>
References: <1605793733-3573-1-git-send-email-liu.xiang@zlingsmart.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <9dbafb55-a1f7-7f6e-d0e9-00dfabc8e2b6@oracle.com>
Date:   Thu, 19 Nov 2020 10:34:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1605793733-3573-1-git-send-email-liu.xiang@zlingsmart.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9810 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011190130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/20 5:48 AM, Liu Xiang wrote:
> On 64-bit machine, delta variable in hugetlb_acct_memory() may be larger
> than 0xffffffff, but gather_surplus_pages() can only use the low 32-bit
> value now. So we need to fix type of delta parameter and related local
> variables in gather_surplus_pages().
> 
> Reported-by: Ma Chenggong <ma.chenggong@zlingsmart.com>
> Signed-off-by: Liu Xiang <liu.xiang@zlingsmart.com>
> Signed-off-by: Pan Jiagen <pan.jiagen@zlingsmart.com>
> 
> ---
> Changes in v2:
>   as suggested by Mike, apply the same fix to the related local
>   variables in gather_surplus_pages().
> ---
> ---
>  mm/hugetlb.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Thank you,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
