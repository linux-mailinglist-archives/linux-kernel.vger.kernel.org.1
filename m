Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D9827EAB7
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 16:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgI3ONx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 10:13:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56480 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbgI3ONw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 10:13:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UE55JZ169228;
        Wed, 30 Sep 2020 14:13:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=0Tu7KhorhnS/GIgWf3boys7UzLxnsTMgPv4MJWNbOQQ=;
 b=vNXiy2Wtl3YwsT2l8/AWOCHnMwzzFPJ1qFVmauADuTBDp5hEqsBUd7Zuxz5DJKg2Ooei
 Dtn8maNiYM6BKDP12m++U0FgGdp+ndorl7rKR6eT6HKjeK7sWzHq/lHhMloEAlVeBXuo
 1RT9+Wq7CqOCmhQFXQpbfD2ovOrbdLkW9pC4hoZ2zElDjbAarogPP0xw1gmTfLVc24YB
 1I/Ni30dAC2Hsvo/Qc8NyXEXrORZiJpcBNqIqb8u+lzoiSV9/kv495DUUR0iG32IJ4px
 g8SQLItT/sN8Nyja6DVDUty5kd5shT11yQlwTN4OlW783pdTxqOj5A/NZM+SKTKqMgW2 Zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 33sx9n8nf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 14:13:44 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08UEAoC3185373;
        Wed, 30 Sep 2020 14:13:43 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33tfdu00ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Sep 2020 14:13:43 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08UEDgB7020641;
        Wed, 30 Sep 2020 14:13:42 GMT
Received: from [10.74.86.12] (/10.74.86.12)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 30 Sep 2020 07:13:41 -0700
Subject: Re: [PATCH] xen/arm: do not setup the runstate info page if kpti is
 enabled
To:     Stefano Stabellini <sstabellini@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Bertrand Marquis <Bertrand.Marquis@arm.com>, jgross@suse.com
References: <20200924234955.15455-1-sstabellini@kernel.org>
From:   boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <4aca4d30-f418-bfab-8a9c-74f349f4ca02@oracle.com>
Date:   Wed, 30 Sep 2020 10:13:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200924234955.15455-1-sstabellini@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009300113
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9759 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1011
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009300112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/20 7:49 PM, Stefano Stabellini wrote:

> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
>
> The VCPUOP_register_runstate_memory_area hypercall takes a virtual
> address of a buffer as a parameter. The semantics of the hypercall are
> such that the virtual address should always be valid.
>
> When KPTI is enabled and we are running userspace code, the virtual
> address is not valid, thus, Linux is violating the semantics of
> VCPUOP_register_runstate_memory_area.
>
> Do not call VCPUOP_register_runstate_memory_area when KPTI is enabled.
>
> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> CC: Bertrand Marquis <Bertrand.Marquis@arm.com>
> CC: boris.ostrovsky@oracle.com
> CC: jgross@suse.com


Applied to for-linus-5.10



-boris

