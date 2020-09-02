Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE50925AECE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 17:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgIBP1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 11:27:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:53764 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgIBP06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:26:58 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082FDdqp181299;
        Wed, 2 Sep 2020 15:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=L+79zCjMk1iGPCCMBqtUC7B8MQuLqWdDq02UmUaPKcw=;
 b=fm3L9CGqKQD8oekjSlqCLx6b5O8FyB71rYNI8k1aLbnDOX/xBiGThbtotU1tbbR9GObh
 JuCPwqxDse9q8tasQFlcEpH5IQK4BrM2OG2q8fdhCkUrR6UPnSOOqxFTt8ReELzqN7Dh
 U42haAbqaavWM6dX/gcbKwh8BkY4E+i/Zp8XckpZsMUmVw1GzbCsPKIa1rADlKVQEr+J
 +yeLlNxImmmNp/AMnhf1b+7NGmwBCD/dLQDypnZnotrBzQVnRml2aIwDpcNRIIjeM9Mk
 ts3XmyysJgJI7vsIrxiFnaI4k2E2steNQWrFMzDKStvQM8ohaI/sRNyplO4Tx7jnDTE/ qA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 339dmn1qv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 15:26:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082FPJwx143766;
        Wed, 2 Sep 2020 15:26:42 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 3380su4s2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 15:26:42 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 082FQe7G012961;
        Wed, 2 Sep 2020 15:26:40 GMT
Received: from [10.175.214.7] (/10.175.214.7)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 08:26:40 -0700
Subject: Re: [PATCH 1/2] iommu: amd: Restore IRTE.RemapEn bit after
 programming IRTE
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        joro@8bytes.org, sean.m.osborne@oracle.com,
        james.puthukattukaran@oracle.com, boris.ostrovsky@oracle.com,
        jon.grimm@amd.com
References: <20200902045110.4679-1-suravee.suthikulpanit@amd.com>
 <20200902045110.4679-2-suravee.suthikulpanit@amd.com>
From:   Joao Martins <joao.m.martins@oracle.com>
Message-ID: <f38b77db-fbb2-bcab-56ef-9d23a368533b@oracle.com>
Date:   Wed, 2 Sep 2020 16:26:36 +0100
MIME-Version: 1.0
In-Reply-To: <20200902045110.4679-2-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=881 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020147
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 mlxlogscore=878 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=1
 spamscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 5:51 AM, Suravee Suthikulpanit wrote:
> Currently, the RemapEn (valid) bit is accidentally cleared when
> programming IRTE w/ guestMode=0. It should be restored to
> the prior state.
> 
Probably requires:

 Fixes: b9fc6b56f478 ("iommu/amd: Implements irq_set_vcpu_affinity() hook to setup vapic
mode for pass-through devices")

?

> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

FWIW,

 Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
