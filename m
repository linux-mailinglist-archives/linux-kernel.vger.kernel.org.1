Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3D53016F8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 17:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbhAWQnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 11:43:50 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:25418 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726131AbhAWQnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 11:43:40 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10NGWvdH004024;
        Sat, 23 Jan 2021 10:41:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=StJtUBgk3cw6y1gq/d8OpCLc1Bye/Dx20IpZ+lgO+IQ=;
 b=R27wgC52CB4rD1N71nAlUZRJP5jnrMY1Yp7XTsD0zKfIqmmrONSmN9LftiqbQ0l2XFjp
 96KA+6jZokzzR6CGJ152wqxZnR+kL3H9j8l/7nfittxzKmLJJWzyI8htqObmAKrANqK3
 2bZEUKtKh9MhITqB6yEr5SFQSFomz8z6hN7A8sHBzGIUx/hAFZO+wjEVp5blxMiHj30E
 /qoYepZ3Ko96BURTtXf1Ca7Kww8uXPa070xJfEgErZVPaSj2fMbgItAXAkszF9yLoW38
 USSdVjKwxLVN94ABY0JH2KbY+CxplcSByfQG/k8ZAOSB5+OmIegfPaRvd+u1B93NZ+Ep DQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 368j3609c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 23 Jan 2021 10:41:47 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Sat, 23 Jan
 2021 16:41:45 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Sat, 23 Jan 2021 16:41:45 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AA73B45;
        Sat, 23 Jan 2021 16:41:45 +0000 (UTC)
Date:   Sat, 23 Jan 2021 16:41:45 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v4 05/13] extcon: arizona: Always use
 pm_runtime_get_sync() when we need the device to be awake
Message-ID: <20210123164145.GL106851@ediswmail.ad.cirrus.com>
References: <20210123121313.79530-1-hdegoede@redhat.com>
 <20210123121313.79530-6-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210123121313.79530-6-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101230094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 23, 2021 at 01:13:05PM +0100, Hans de Goede wrote:
> Before this commit the extcon-arizona code was mixing pm_runtime_get()
> and pm_runtime_get_sync() in different places.
> 
> In all places where pm_runtime_get[_sync]() is called, the code
> makes use of the device immediately after the call.
> This means that we should always use pm_runtime_get_sync().
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
