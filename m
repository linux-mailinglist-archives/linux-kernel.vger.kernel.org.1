Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38E82DE38E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 14:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgLRN6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 08:58:04 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:58486 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgLRN6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 08:58:03 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BIDrnEE058266;
        Fri, 18 Dec 2020 13:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=uAj8JiZpRneHr+O/z5OM78d5g7FuBEj0ARu6xAVnizQ=;
 b=mNePPLfG+3prEcXPXV03F/z6I9IGA+AVYAbq25bJh263FUiqzqPzk7J6+ySE1AWxOcfT
 edvaQ6ontTruI7QwwhuuyFDYHd0M2AXK2ZPBiCjUO7G71nuSQKAZ6bV2DO2vqw3y5PKc
 ykeBkWKdu9nKCNhOwhjX96inHNVRd7Bd5ifs1EhgnPXnZB/iB97rZjUnLdqscG3vv05J
 ET2uz6Pkr+X30fOd4GSrVylNaRVe61xHXdyQaFCNoFBz4LI4RYCyiS3W7I7VN/CtAaOR
 FnWODNk8kTPZ2JxWOkHaRhmcSGHmxPlUUhLvN1ygHhi5kDUMHqg1NN50fsNzK99qP/cr hA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35cntmjb4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Dec 2020 13:56:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BIDjMed154031;
        Fri, 18 Dec 2020 13:54:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 35g3rg7fms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Dec 2020 13:54:37 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BIDsWtg017951;
        Fri, 18 Dec 2020 13:54:32 GMT
Received: from [10.191.15.101] (/10.191.15.101)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Dec 2020 05:54:32 -0800
Subject: Re: [PATCH] mm/vmscan: DRY cleanup for do_try_to_free_pages()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
References: <20201218102217.186836-1-jian.w.wen@oracle.com>
 <20201218121752.GK15600@casper.infradead.org>
From:   Jacob Wen <jian.w.wen@oracle.com>
Message-ID: <f28e270f-ae6d-1779-453d-b1fb3ac5a548@oracle.com>
Date:   Fri, 18 Dec 2020 21:54:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201218121752.GK15600@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=925 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=955 impostorscore=0 priorityscore=1501 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180098
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/18/20 8:17 PM, Matthew Wilcox wrote:
> On Fri, Dec 18, 2020 at 06:22:17PM +0800, Jacob Wen wrote:
>> This patch reduces repetition of set_task_reclaim_state() around
>> do_try_to_free_pages().
> what is a DRY cleanup?
>
DRY is short for "Don't repeat yourself"[1].

[1] https://en.wikipedia.org/wiki/Don%27t_repeat_yourself


