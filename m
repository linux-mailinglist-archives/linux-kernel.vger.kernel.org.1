Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADD92D1EA5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 00:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgLGX44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 18:56:56 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38064 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgLGX4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:56:55 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B7Nrx76149590;
        Mon, 7 Dec 2020 23:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Tueq5whBtLsp2a0o8pSIRIag4QTwwNeexz4YhPhpU3k=;
 b=tz7Jyf3YdxhXAg9ydLFiyS7oTuMO3eqAm/va2SdIkiA/xvI9FlPMNxBEADONL2cDaoO+
 WgN2kTyW5KrKeNuY9WbK9gjdne+fgkvNCG2Sutywo4j1TYcKsDkmgbX6rk5Hm15CPQWc
 zaM41FT6Cv53uQ7QsguSbpuU/SSWgo22QAzJH8f4fJbY2+mwRePtu4JOnY1fitYO9CeU
 cCiZCxfzS8Ly5JPVd7KFPWnhqUVF73kmleOY+rDRFGRArSZkV1bvHaeA3PunB6oNEely
 kd0yIZptHVW1CLDDvidOiQyYRKex6IakyAmAsSHD9TODIkZHePWMnkdZtvRW+9bUlfX/ lw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3581mqr5wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 07 Dec 2020 23:56:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B7NsbtL102334;
        Mon, 7 Dec 2020 23:56:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 358kys1hxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Dec 2020 23:56:08 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B7Nu7Uh011934;
        Mon, 7 Dec 2020 23:56:07 GMT
Received: from [10.39.215.209] (/10.39.215.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 07 Dec 2020 15:56:06 -0800
Subject: Re: [PATCH 2/2] xen: don't use page->lru for ZONE_DEVICE memory
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>
References: <20201207133024.16621-1-jgross@suse.com>
 <20201207133024.16621-3-jgross@suse.com>
From:   boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <eea24527-15d8-7d54-9e82-7737f0e3cf70@oracle.com>
Date:   Mon, 7 Dec 2020 18:56:05 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201207133024.16621-3-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012070158
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9828 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070158
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/7/20 8:30 AM, Juergen Gross wrote:


> --- a/drivers/xen/unpopulated-alloc.c
> +++ b/drivers/xen/unpopulated-alloc.c
> @@ -12,7 +12,7 @@
>  #include <xen/xen.h>
>  
>  static DEFINE_MUTEX(list_lock);
> -static LIST_HEAD(page_list);
> +static struct page *page_list;


next_page or next_allocated_page?


Either way


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


