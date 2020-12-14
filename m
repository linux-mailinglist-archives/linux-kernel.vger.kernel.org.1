Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074B62D992F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 14:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408131AbgLNNmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 08:42:37 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:39034 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406512AbgLNNmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:42:09 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BEDc9eH032162;
        Mon, 14 Dec 2020 07:41:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=AUJbEVt+xcr9JudRJq6czZ/xGOKIYbyS0jkgoeJnzDI=;
 b=kvpAeMyeXq/jHf8sg2DL3qiIDiza89GLug+UOc/3XZnbZorZ7UMYM/VGagFXcWUx2gnu
 b2jmJTbGFZunLj87HCHVLqqMOxEdEA9t/RbEeZAi0NgP4IoMTn5JmDHJJMBpkTqs56Sf
 KmepCMz1v4Eh93FdWPYDnQ4oMLhu1abwYCzpL379HQmJfKl0TN7JKbxnoBLE1xv9kx5Z
 xfR+27HkqazsGALgziUYGljkcXwDbFKVhKyZlAj/BGGjTm0THHnkeO7P5AxAuAfmMwaj
 Cl4wn0WdS3OWCFH8cDzFY7VOFcyiKGGhyXWLGYcH0f221dbvdDENsb021ZefYAlBuuuM ow== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35cu5rtcj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Dec 2020 07:41:18 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 14 Dec
 2020 13:41:16 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 14 Dec 2020 13:41:16 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BFD6311CA;
        Mon, 14 Dec 2020 13:41:16 +0000 (UTC)
Date:   Mon, 14 Dec 2020 13:41:16 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] mfd: wm831x-auxadc: Prevent use after free in
 wm831x_auxadc_read_irq()
Message-ID: <20201214134116.GC9673@ediswmail.ad.cirrus.com>
References: <X9dTjo3VQIMJP6O9@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <X9dTjo3VQIMJP6O9@mwanda>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012140095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 02:59:10PM +0300, Dan Carpenter wrote:
> The "req" struct is always added to the "wm831x->auxadc_pending" list,
> but it's only removed from the list on the success path.  If a failure
> occurs then the "req" struct is freed but it's still on the list,
> leading to a use after free.
> 
> Fixes: 78bb3688ea18 ("mfd: Support multiple active WM831x AUXADC conversions")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
