Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C83127F139
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgI3SV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:21:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60172 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgI3SV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:21:26 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UIJ6PH035322;
        Wed, 30 Sep 2020 18:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=B+fcGQBdGNaLebwUov6nFzUiAkCZlQZJuaanr/Jxh98=;
 b=EeyePEhhSTSfBtRQw9dO0B3vVM/b5ZY0HACHFXcXNy5po7u0XstyMM9FegqupIm1IoRR
 R0ibTxVOXsxS3OV4YoJrfuLVadY7atz6tUyDmRRZgVW3gxteOQXOXnTbHxtIkdicY1p7
 oXnyGpOp5lSGhThMhEhZw6rxUZWGpJaTiefll89qk0u/dwrURRi4MdObnC0nW0tf9UEl
 eCTrJI16qUTx2BBOukjJbYwrL5yE61tDvCHBQCLyKBqMp44wMGlZ7yKvrRCy3kw86Ve3
 0IZw4W0JDso7P188T0gJHnUBiFeaxwNXN3yCOYJkh3cwEN9UR8UAq0dSXCwKxzutVZ8+ 5A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33sx9na0pn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 18:20:10 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UIEtil141719;
        Wed, 30 Sep 2020 18:20:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 33uv2fs0m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 18:20:09 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08UIK69q032421;
        Wed, 30 Sep 2020 18:20:07 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Sep 2020 11:20:06 -0700
Subject: Re: [v5] mm: khugepaged: recalculate min_free_kbytes after memory
 hotplug as expected by khugepaged
To:     Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        Allen Pais <apais@microsoft.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <1601398153-5517-1-git-send-email-vijayb@linux.microsoft.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <2a380b84-4fee-fa4e-e862-8a8577961088@oracle.com>
Date:   Wed, 30 Sep 2020 11:20:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1601398153-5517-1-git-send-email-vijayb@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9760 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=2 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9760 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=2
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300146
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/20 9:49 AM, Vijay Balakrishna wrote:
> When memory is hotplug added or removed the min_free_kbytes should be
> recalculated based on what is expected by khugepaged.  Currently
> after hotplug, min_free_kbytes will be set to a lower default and higher
> default set when THP enabled is lost.  This change restores min_free_kbytes
> as expected for THP consumers.
> 
> Fixes: f000565adb77 ("thp: set recommended min free kbytes")
> 
> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Sorry for jumping in so late.  Should we use this as an opportunity to
also fix up the messages logged when (re)calculating mfk?  They are wrong
and could be quite confusing.  For example consider the following sequence
of operations and corresponding log messages produced.

Freshly booted VM with 2 nodes and 8GB memory:
# cat /proc/sys/vm/min_free_kbytes
90112
# echo 90000 > /proc/sys/vm/min_free_kbytes
# cat /proc/sys/vm/min_free_kbytes
90000
# echo 0 > /sys/devices/system/node/node1/memory56/online
[  135.099947] Offlined Pages 32768
[  135.102362] min_free_kbytes is not updated to 11241 because user defined value 90000 is preferred
[  135.109070] khugepaged: raising min_free_kbytes from 90000 to 90112 to help t
ransparent hugepage allocations
# cat /proc/sys/vm/min_free_kbytes
90112
# echo 1 > /sys/devices/system/node/node1/memory56/online
[  231.656075] min_free_kbytes is not updated to 11334 because user defined value 90000 is preferred
# cat /proc/sys/vm/min_free_kbytes
90112

-- 
Mike Kravetz
