Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD9E2D72FF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 10:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393729AbgLKJlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 04:41:21 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:20834 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726086AbgLKJlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 04:41:07 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BB9WkZC027941;
        Fri, 11 Dec 2020 03:40:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=ewFevuZlpvGDvvGAKG9Hx5GCnbrFYf1gOE/LOfzTYJg=;
 b=F42ZKZIrrVXd2Fc6HVHJTs7N4Va537tNvcq5FH7H3yBnvMEa3zfI5LP36D2g5lon0wZm
 LbhyAQQ4MKAy/lrsl7j0Un8ZJPqGjfjEusMXjq4TqnrO6jldkvbbxmmsmcMWreum0YUC
 QoCfwMa+SWrBYf50Kxa8jD42ykkpmWbXmlUBAyt2DL8x8x2k8Ldl0+Sa40Cz/e3EEj3j
 h8stQV1IxhmUZDprlykVFcAoZdYpVEixHDQmxHPz+kObh48WsO+vuRFpQeyXdNKTYvzx
 TTLlXWj7cr8CB7KZH/E0nATduCm89s5WBFCbDs61S+LxPClCpqY43m67A93WASG4lKxg 6g== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3587gtqxd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Dec 2020 03:40:16 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 11 Dec
 2020 09:40:14 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 11 Dec 2020 09:40:14 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8770F11CB;
        Fri, 11 Dec 2020 09:40:14 +0000 (UTC)
Date:   Fri, 11 Dec 2020 09:40:14 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
CC:     <lgirdwood@gmail.com>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] regulator: wm831x-isink: convert comma to semicolon
Message-ID: <20201211094014.GA9673@ediswmail.ad.cirrus.com>
References: <20201211084440.2210-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201211084440.2210-1-zhengyongjun3@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011
 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501 mlxlogscore=853
 lowpriorityscore=0 phishscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012110059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 04:44:40PM +0800, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
