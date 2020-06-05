Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B7711EF5D5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 12:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgFEKzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 06:55:51 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:21482 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726669AbgFEKzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:55:51 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 055AsRaB024997;
        Fri, 5 Jun 2020 05:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=MZZwM1mapPdkA66kwxmX7dvBAJM5o5BJMZK04776MBw=;
 b=Xv2mynaGnlkxKt4yfc/u107qRNgqBOhm9vjaoFWu5N7tNK1vjj5NzMi+/mVveN9KFwnM
 rbu7MWABqTsiZJv7e4u0gwTzsGf6WLOzK8+5jEwY8dGnZ/T0O3slfHIqwbYlIzKL2blS
 gfWuQhie7rduZMbrIlOMK7XGcrm6T3vkECLaho/hVdOwTeKFpbr7BQgS81/qiMp8o3Xa
 0oeo7fP1fIuss52GgRDg+YztN0nh1uoRGKUEQz4Fr9lMNXZw1oao1tLFd4HYyibVfJE2
 pkL5OfXWRH3fzvsGABIDs+xnLhPCUVCgzR1tSXyweKv0OQrbTf7eR2ugJ13dH7OGFW0D 5w== 
Authentication-Results: ppops.net;
        spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 31f918s2v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 05 Jun 2020 05:55:43 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 5 Jun 2020
 11:55:42 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 5 Jun 2020 11:55:42 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2E8312AB;
        Fri,  5 Jun 2020 10:55:42 +0000 (UTC)
Date:   Fri, 5 Jun 2020 10:55:42 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
CC:     Lee Jones <lee.jones@linaro.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <emamd001@umn.edu>,
        <wu000273@umn.edu>, <kjlu@umn.edu>, <smccaman@umn.edu>
Subject: Re: [PATCH] mfd: arizona: handle pm_runtime_get_sync failure case
Message-ID: <20200605105542.GL71940@ediswmail.ad.cirrus.com>
References: <20200605024714.46178-1-navid.emamdoost@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200605024714.46178-1-navid.emamdoost@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com include:spf.protection.outlook.com
 ip4:5.172.152.52 -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0
 cotscore=-2147483648 lowpriorityscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1011
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006050084
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 09:47:13PM -0500, Navid Emamdoost wrote:
> Calling pm_runtime_get_sync increments the counter even in case of
> failure, causing incorrect ref count. Call pm_runtime_put_sync if
> pm_runtime_get_sync fails.
> 
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
