Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62972412F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 00:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgHJWZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 18:25:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56442 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgHJWZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:25:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07AMMbrt054686;
        Mon, 10 Aug 2020 22:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=sFhzNkNCrKqKJGLHZgkoZ8SLfUYLuFL/ciZnSi0rdKc=;
 b=LygDwQ8s6r8FXyL2ztjkCYfsJsgyCTB63CeKoSJc2OW0rJpFly8HrgD9+AZrSML6kVMk
 KNdUjBQ2kUo6KMqyPPaHTgsDnlQtPdkqa7O67NMhkedSBrpOC0WZI3UmHyF/Se+pAAZl
 gvwSY3S1dAWXbDghu9ctDzSJ/I6v3Dv1W+49Y7pSFTljteM9hPSs/+KEgINgyITw+Lsb
 oTlMiNHtnnWmudAgKH/Omvaj1T5pqz7F+1eutS0ftQCNfqVGehWOTrL0a0JkM++DFvJI
 MmQzO0SRab8aurqF+s+bTgpTisaGFWTslCrSQLdSMeyVj/Ikhuzq0KfjKcefpdsUVeGX Ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 32smpn9a9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Aug 2020 22:25:27 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07AMNGx6082027;
        Mon, 10 Aug 2020 22:25:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 32t5y24vdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 22:25:26 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07AMPPjr006806;
        Mon, 10 Aug 2020 22:25:25 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Aug 2020 22:25:25 +0000
Subject: Re: [PATCH 07/10] mm/hugetlb: a page from buddy is not on any list
To:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-8-richard.weiyang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <d9d6600d-0a4d-b727-788d-ef56017abb8c@oracle.com>
Date:   Mon, 10 Aug 2020 15:25:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807091251.12129-8-richard.weiyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008100153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/20 2:12 AM, Wei Yang wrote:
> The page allocated from buddy is not on any list, so just use list_add()
> is enough.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
