Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BB5277C5F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 01:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgIXXnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 19:43:13 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55644 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgIXXnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 19:43:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08ONZx0j085851;
        Thu, 24 Sep 2020 23:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=VvCv4Gti0LRNvu/JiuhQzqXwh4k4ms6S4iJ4yRBRgEM=;
 b=MMVLyPrv7sPtJ1/RwS7dn5G6wMF0WLG4ffVhrRrQHgdemGHrQEKGFjfZfcvc1bqEP4AN
 aHjVeVEMTc2nfLh3f3jd7D7bgCB0wPhBNJAA2DUnyUVt/WVGsksMCyTDcGpnQo+Ve0V5
 x2YWLO/6uCk0REcuKVztrcAzZ0/Mpn68GAFWjhjvWFKguSxvqjNZ+qqRO7Eq3IOA0gfw
 M2gm6L672PBJtZxbuoSJpxzvnhHurd0xQJPFSNuYIWPu4qMoIbDqoIo9UjvPaPugqqHi
 C41EQ5bVrLxxVt2MHMnZACz8qXoTqnKUKL5aajg5l1UHFQX/47Trpqczl0R+xCwGy2st 5g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33q5rgscs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 23:42:39 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08ONZTet163174;
        Thu, 24 Sep 2020 23:42:38 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33nux3jpbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 23:42:38 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08ONgVnu011111;
        Thu, 24 Sep 2020 23:42:31 GMT
Received: from [10.74.109.22] (/10.74.109.22)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Sep 2020 16:42:31 -0700
Subject: Re: [PATCH 09/11] xen/xenbus: use apply_to_page_range directly in
 xenbus_map_ring_pv
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nitin Gupta <ngupta@vflare.org>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
References: <20200924135853.875294-1-hch@lst.de>
 <20200924135853.875294-10-hch@lst.de>
From:   boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <ab2913a6-c5ac-c067-6e55-e2549b286f36@oracle.com>
Date:   Thu, 24 Sep 2020 19:42:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200924135853.875294-10-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240170
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1011 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240170
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/24/20 9:58 AM, Christoph Hellwig wrote:
> Replacing alloc_vm_area with get_vm_area_caller + apply_page_range
> allows to fill put the phys_addr values directly instead of doing
> another loop over all addresses.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


-boris

