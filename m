Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C993277C68
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 01:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgIXXoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 19:44:07 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:38056 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgIXXoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 19:44:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08ONZFwE100834;
        Thu, 24 Sep 2020 23:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=4T7MwI86Tdbp1GAwGn7YNnD5aIov6tuCb1xRlBKCjkY=;
 b=CYXf0fTjvhIsR7MRYK2KBGHpbztF/aSBrKi4pyo0Dba7lP1QzffF9CPARQdraZNI73aD
 pdTLv7jyyHQLejhJ4nowJicKzV9gY1GPionBKQtyk/PZ06iumKvC+pD6mk+0hyk7njzC
 GS9T7iPfoRsFXVyUllxOxzYlTSD7hNgYxKidCnPTF5w4IwR+Y6WXV0nJOoWfy5LL8j5G
 DEy3hiWToLa1rsZaobLFJjE5t/9errRxvKU5Y4gsvZV4F6anOfwOMiN+iuLrTmY9HVe8
 BCIHK9AWEb4xKtyvEZG3kf6gdFAhc+AL12nagwzml2CVspzeSy2PiT1xs8T6NG3nU2ow mg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 33ndnuu3fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Sep 2020 23:43:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08ONZTrb163168;
        Thu, 24 Sep 2020 23:43:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33nux3jpv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Sep 2020 23:43:42 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08ONhexi002750;
        Thu, 24 Sep 2020 23:43:40 GMT
Received: from [10.74.109.22] (/10.74.109.22)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 24 Sep 2020 16:43:40 -0700
Subject: Re: [PATCH 10/11] x86/xen: open code alloc_vm_area in
 arch_gnttab_valloc
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
 <20200924135853.875294-11-hch@lst.de>
From:   boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <5222d13f-8eff-1536-4e8d-e4013039ecca@oracle.com>
Date:   Thu, 24 Sep 2020 19:43:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <20200924135853.875294-11-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240170
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9754 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009240170
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/24/20 9:58 AM, Christoph Hellwig wrote:
> Replace the last call to alloc_vm_area with an open coded version using
> an iterator in struct gnttab_vm_area instead of the triple indirection
> magic in alloc_vm_area.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


