Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7D4255EBB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 18:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgH1Q03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 12:26:29 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56020 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgH1Q02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:26:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07SGK9PD010059;
        Fri, 28 Aug 2020 16:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=M254Zg/7rYWaZiNOZ57Wd4gQ7uzYXeY92ofIEme+oPg=;
 b=sQCUdTHqeXFgiNX+jEFzB83qsmh+DJt48vy4AG6J4F/hl8CyBxrG2avjPG8ZPBvArMut
 NBOjX6GS9T7xQK0U5hdta9i5GliOSGBy0xHrYzeTDRRZ6jTLJgAIV0z4rgzio7d9+h6x
 z5hWXCDloPE+JAweyTjfxv3U8kcRQTfQpaCZ2iHHLKbKks1tUCWluH6Gm3nsdH6bFPHf
 BCbgXxJkT9xkpTft+uz1TM1Di/E8Odntk2Ya1qHmBtQIwjnqwL5MvXh0RKenp/WSnSPK
 wIPLtB6BOPA6j8miPDaMvSyrS+23bqRFE9hhYwbB4DS8IA4srdGiaVJMGMfvB9Yp0Def Hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 333dbscugu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Aug 2020 16:21:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07SGLGO5104079;
        Fri, 28 Aug 2020 16:21:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 333r9pumjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Aug 2020 16:21:21 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07SGLKJk026909;
        Fri, 28 Aug 2020 16:21:20 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Aug 2020 09:21:20 -0700
Subject: Re: [Patch v2 2/7] mm/hugetlb: remove VM_BUG_ON(!nrg) in
 get_file_region_entry_from_cache()
To:     Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, bhe@redhat.com
References: <20200828033242.8787-1-richard.weiyang@linux.alibaba.com>
 <20200828033242.8787-3-richard.weiyang@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <11b2397a-3a53-8003-a30a-cee7ffe45e0d@oracle.com>
Date:   Fri, 28 Aug 2020 09:21:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828033242.8787-3-richard.weiyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9727 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008280121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9727 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008280121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 8:32 PM, Wei Yang wrote:
> We are sure to get a valid file_region, otherwise the
> VM_BUG_ON(resv->region_cache_count <= 0) at the very beginning would be
> triggered.
> 
> Let's remove the redundant one.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>

Thank you.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
