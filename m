Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBEA2963AD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 19:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899762AbgJVR0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 13:26:06 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45546 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503988AbgJVR0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 13:26:06 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09MHJ35Y052764;
        Thu, 22 Oct 2020 17:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=eW5M8N9OjpZ2xL1Em9EOREfZ5+0xjdYsVVxq7LL6VV4=;
 b=eW84goyjo0/eSWC9b90kF8pTRcRxxfUOrYwpFN6xrQCu34AB60HZaVAla/WgGo1gQskx
 O9SvuwYQYypqKj9uPjbm7qAxIkHTcvSip6pmPOrv1qBJvfgbL88c0yVa+Oe3KYU2dJKm
 EYZ8c5qSRK2ExrfBOQpMA9Ee3fWBQ/HiugT5agXQ1wg2dKFOEAACS+AMVbLSvVfyRhLU
 NxsnGOKBlErIYn4xvPlllf4VjraIH78BP18sA2xZTbulvHA7uqqSMqTHiuPPyYz8Ne0B
 t5BajvEv9b8//4wzSmNn/a5/a166njgLLczEyjhfabG7NPC85YA5dYvlYuBqvAU5G023 PQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 347p4b7ax9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 22 Oct 2020 17:25:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09MHL4aY073736;
        Thu, 22 Oct 2020 17:25:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 348aj01dr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Oct 2020 17:25:55 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09MHPrkK003513;
        Thu, 22 Oct 2020 17:25:54 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 22 Oct 2020 10:25:53 -0700
Subject: Re: [PATCH rfc 0/2] mm: cma: make cma_release() non-blocking
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@fb.com
References: <20201016225254.3853109-1-guro@fb.com>
 <3f455d27-6d99-972f-b77f-b5b473b7614d@oracle.com>
 <20201022023352.GC300658@carbon.dhcp.thefacebook.com>
 <91779b4c-378d-66ee-2df0-edb270dd4d04@oracle.com>
 <20201022171628.GE300658@carbon.dhcp.thefacebook.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7ac469ef-552b-8b7a-a0a1-8bcd07f263b7@oracle.com>
Date:   Thu, 22 Oct 2020 10:25:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201022171628.GE300658@carbon.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9782 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9782 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010220112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/20 10:16 AM, Roman Gushchin wrote:
> As now, I want to unblock Zi Yan on his work on 1 GB THPs, so maybe
> we can go with introducing cma_release_nowait(), as I suggested in
> the other e-mail in this thread? Do you have any objections?

No objections from me.  And, I like that it could be used by the hugetlb
code to make it simpler.

-- 
Mike Kravetz
