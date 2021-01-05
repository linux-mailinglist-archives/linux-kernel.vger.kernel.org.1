Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08322EA30D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 02:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbhAEBxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 20:53:19 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53104 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbhAEBxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 20:53:18 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1051mppb106849;
        Tue, 5 Jan 2021 01:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=wP2/tgNY1y3yvr51jY9l12/nWUPlGU24K0xLRpyonrU=;
 b=y2qjuP84xbrYtpM84TJRojjql/GC8LmkVGAkzEXLU5ANIxe3wpq0EMbowsRfx4nENzvB
 XY4I8AtbPYNm7RIa5WDhXqLBRElkpxm4UZxkLZJqZcJU+Ei86BJ7EqLW2hZeRNL1ZIfQ
 stvxIeD+uQKzk/p2WsUPl9dOPJ3PsVgMjjfRdg5hdqbuKvf4jMlWfyyPAn2ihAWbtg+B
 RLWDscFMTG1mjs1r3v/QCF5a7O9bW8BSo6/DeqCqS/LX8rCsLlOnGJODM3W8qtWwO+CD
 eNpTDJ6iFr59lxug37Y2MAmgLYOTY1bXfP+9+UBCv3J/PCyMlKoyEUhrMfPIMKqIRRc7 1w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 35tgskpujb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 05 Jan 2021 01:52:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1051oNrA059571;
        Tue, 5 Jan 2021 01:50:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 35v4rauevc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Jan 2021 01:50:23 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1051oBGL032101;
        Tue, 5 Jan 2021 01:50:11 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 05 Jan 2021 01:50:11 +0000
Subject: Re: [PATCH 6/6] mm: hugetlb: remove VM_BUG_ON_PAGE from
 page_huge_active
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org
Cc:     hillf.zj@alibaba-inc.com, n-horiguchi@ah.jp.nec.com,
        ak@linux.intel.com, yongjun_wei@trendmicro.com.cn, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210104065843.5658-1-songmuchun@bytedance.com>
 <20210104065843.5658-6-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <370dff8a-c26f-a585-46c5-9c0282772fb9@oracle.com>
Date:   Mon, 4 Jan 2021 17:50:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20210104065843.5658-6-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050008
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9854 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101050008
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/21 10:58 PM, Muchun Song wrote:
> The page_huge_active() can be called from scan_movable_pages() which
> do not hold a reference count to the HugeTLB page. So when we call
> page_huge_active() from scan_movable_pages(), the HugeTLB page can
> be freed parallel. Then we will trigger a BUG_ON which is in the
> page_huge_active() when CONFIG_DEBUG_VM is enabled. Just remove the
> VM_BUG_ON_PAGE.
> 
> Fixes: 7e1f049efb86 ("mm: hugetlb: cleanup using paeg_huge_active()")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/hugetlb.c | 1 -
>  1 file changed, 1 deletion(-)

Thanks!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
