Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7103274531
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgIVPYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:24:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42192 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgIVPYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:24:50 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MF99uD108659;
        Tue, 22 Sep 2020 15:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=r25X6J1q+Ighced5STv1N+Q9x56TJMr0M8XmPWVmk4w=;
 b=bB8Tp/a2lSI+UwYmqXXKz5Y23TH5yE09ciN0f0sy3qt19cNhEhgksqgJ9nY6Q7FHdqr5
 Bj6NZjV37L+9k30k+sStCWjIWjb3Ku8CSL6l1POKFNXfXE7HYCIV82SAjw7MQKGPgnDR
 Kw5X2XpfKcODiRMBXcg9wFTOahB8pyoEu3wJaCPA3pS5RO6mExJgFsqXBwcDKafq5t6B
 hQMtnhiJ37dQzyVQCoh1oa9eh/nLFNekem8w4gp1vbNpKm+sEpYKhcbEqKkOoPjQ1OAn
 1TucTPU5tN6rNwjoHoSKQdXi9Gtq8zA8k12iNAEJCTzdfjm7ZqUf68EhJIGFWJhinzYg 9Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 33q5rgbsn3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 15:24:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08MFAMQ1168760;
        Tue, 22 Sep 2020 15:24:29 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33nujnbted-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 15:24:29 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08MFOPZn012709;
        Tue, 22 Sep 2020 15:24:25 GMT
Received: from [10.74.86.236] (/10.74.86.236)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 22 Sep 2020 08:24:25 -0700
Subject: Re: [PATCH 6/6] x86/xen: open code alloc_vm_area in
 arch_gnttab_valloc
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
References: <20200918163724.2511-1-hch@lst.de>
 <20200918163724.2511-7-hch@lst.de>
 <0833b9a8-5096-d105-a850-1336150eada1@oracle.com>
 <20200922145819.GA28420@lst.de>
From:   boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <ebd69ba1-fc06-3cc7-348e-3cb0004c2a34@oracle.com>
Date:   Tue, 22 Sep 2020 11:24:20 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20200922145819.GA28420@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220120
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9752 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220120
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/22/20 10:58 AM, Christoph Hellwig wrote:
> On Mon, Sep 21, 2020 at 04:44:10PM -0400, boris.ostrovsky@oracle.com wrote:
>> This will end up incrementing area->ptes pointer. So perhaps something like
>>
>>
>> pte_t **ptes = area->ptes;
>>
>> if (apply_to_page_range(&init_mm, (unsigned long)area->area->addr,
>>                         PAGE_SIZE * nr_frames, gnttab_apply, &ptes)) {
>>
>>        ...
> Yeah.  What do you think of this version? 


Oh yes, this is way better. This now can actually be read without trying to mentally unwind triple pointers. (You probably want to initialize idx to zero before calling apply_to_page_range(), I am not sure it's guaranteed to be zero).


>  I think it is a little
> cleaner and matches what xenbus does.  At this point it probably should
> be split into a Xen and a alloc_vm_area removal patch, though.


Right.


-boris

