Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E3E2D4233
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731659AbgLIMgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:36:18 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:46230 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730974AbgLIMgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:36:18 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9CXYfw030646;
        Wed, 9 Dec 2020 12:35:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=uAtbp6FlKUllmr+yHGq3Pv/VB5lfTrcVbzi/Vo9937M=;
 b=IAEUhaS2kdS1CLykMSAJgfswBZwFaoZsSUedBFW3zRzZU0sSyTnBQr/FqFPPGV3kWslX
 +elj9a5AQTDiTMYPe2roDdS4OpLPNnvMAxC476aNA8UIaLQBEQc+2m3qbPGjSWT/k1VS
 lF7wVNfaoI3ndGS7pHIfDsQRH3o5ecWa/CuFlPJODtqje7QIfI6xXNqzTnV6lbw6J1ZV
 dBr69adjApWiru89fDMDsVJN+Va8pw4eHj1BiNEaQI7lBtlO0EBZEzBA6MIqywEpZP9J
 NuMjgD5OlDLTUN8KZzd8jiutFed6P/2U5AYqoxYQd70WP8jZnfdBDfInH7muqW0StLSt VA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35825m7wtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Dec 2020 12:35:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9CTlu4160349;
        Wed, 9 Dec 2020 12:33:30 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 358m50gmf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Dec 2020 12:33:30 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B9CXS0r031296;
        Wed, 9 Dec 2020 12:33:28 GMT
Received: from [10.39.218.141] (/10.39.218.141)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Dec 2020 04:33:28 -0800
Subject: Re: [PATCH] xen/xenbus: make xs_talkv() interruptible for SIGKILL
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>
References: <20201209101114.31522-1-jgross@suse.com>
From:   boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <8eae89eb-9250-ec03-e78a-686efc38742e@oracle.com>
Date:   Wed, 9 Dec 2020 07:33:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201209101114.31522-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090088
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090089
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/9/20 5:11 AM, Juergen Gross wrote:
> In case a process waits for any Xenstore action in the xenbus driver
> it should be interruptible via SIGKILL.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


