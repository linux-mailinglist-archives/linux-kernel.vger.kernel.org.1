Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D29270710
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 22:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgIRU3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 16:29:36 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58558 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIRU3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:29:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08IKOThe008412;
        Fri, 18 Sep 2020 20:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=AGh6GdQ6iGI/ijxVQf3T3UWbsmAoNJYygTOKY8yEQyQ=;
 b=JbCQPhyquJ8ObBCnDfXYqHW6RN5AX5PaioMBpiaVujCkm61wiMhH4n5+QPVe7aTc9iO/
 Zj4DvITCe5IQQTl/WpfhT44J7asZzMhluYK3jXtoA3EuqfH2GGTtr5LVVvkxX+etY1iP
 0pq8KiOYHTGuXwQmkJ221dINaOEW3yxUdrxsYNpzkCNWDJFI6gMfelzdo4CEPUu0F8Cu
 h+pUhqJdS4xZyWNK11Qyu8jdYJYgjStBZ1P2ZBFuWiNnQQOtxu+eXvwWExWi66t+FNYr
 +x2CVwbwv8sPkxR+maEUlHvsI9TkgAB8AhPrBauE4/MdnvH6CTk/6SLHKdoj0EZxwCAL MA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33j91e2xg1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Sep 2020 20:29:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08IKPdqd175708;
        Fri, 18 Sep 2020 20:29:21 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 33h88ff85v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Sep 2020 20:29:21 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08IKTJvO010547;
        Fri, 18 Sep 2020 20:29:19 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 18 Sep 2020 20:29:19 +0000
Subject: Re: [PATCH V3 6/8] mm: and drivers core: Convert
 hugetlb_report_node_meminfo to sysfs_emit
To:     Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J.Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Denis Efremov <efremov@linux.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Alex Dewar <alex.dewar90@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <cover.1600285923.git.joe@perches.com>
 <894b351b82da6013cde7f36ff4b5493cd0ec30d0.1600285923.git.joe@perches.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <ecf4c968-1da3-43a8-23f1-09f8b38cad9e@oracle.com>
Date:   Fri, 18 Sep 2020 13:29:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <894b351b82da6013cde7f36ff4b5493cd0ec30d0.1600285923.git.joe@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9748 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009180165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9748 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 mlxlogscore=999
 clxscore=1011 adultscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009180165
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/20 1:40 PM, Joe Perches wrote:
> Convert the unbound sprintf in hugetlb_report_node_meminfo to use
> sysfs_emit_at so that no possible overrun of a PAGE_SIZE buf can occur.
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
