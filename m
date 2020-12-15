Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9A12DB48B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 20:39:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgLOThP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 14:37:15 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53692 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgLOTgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 14:36:47 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFJXqZR156836;
        Tue, 15 Dec 2020 19:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=s0Cs1JEkSZnaprExuXHSIt4siSUpbCCqvHiWI9iK+Dc=;
 b=Ro0VZ1qVg2R7st409/BXYUjldRN15ppn5/7vDVpnV4wjD6w0NRhRg0F3GxDfUffJdrcj
 J/Sn0PRL/olk8HDRkDJses0JNQLQPMRmzEx6U5SVqz7G/HMIRhNbP6tV5eZbaIdNL8KL
 OSHjhYovQUtqDjo4Mjd7kw+2HNP4kOdZDoTVhGrNuBiPM3gr6YAjkgy/PKM+QvNXkJ9z
 ynGyBfTY56XK5Gf/ocSXBrOOfi1RUrToOBmJ+angZ7hhisKhy8gC6pErPGa9frP2FIA+
 MSzvk6Q6HhKO++64dLImSbUWzf0qet0e5d1UXVlwwMM7SbrJu1clVyWUaq5OESlfWV1m AQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 35cntm4dwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Dec 2020 19:35:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BFJZ9UW009806;
        Tue, 15 Dec 2020 19:35:58 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 35e6jrmaqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Dec 2020 19:35:57 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BFJZv03011217;
        Tue, 15 Dec 2020 19:35:57 GMT
Received: from [10.39.237.186] (/10.39.237.186)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Dec 2020 11:35:56 -0800
Subject: Re: [PATCH v2] xen/xenbus: make xs_talkv() interruptible
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>
References: <20201215111055.3810-1-jgross@suse.com>
From:   boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <bd15d0d7-e4d9-74e8-31d5-131434af7f1e@oracle.com>
Date:   Tue, 15 Dec 2020 14:35:55 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201215111055.3810-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012150130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9836 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012150130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/15/20 6:10 AM, Juergen Gross wrote:
> In case a process waits for any Xenstore action in the xenbus driver
> it should be interruptible by signals.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - don't special case SIGKILL as libxenstore is handling -EINTR fine


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com



