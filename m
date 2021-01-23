Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9CE301486
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 11:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbhAWKaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jan 2021 05:30:30 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:45456 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbhAWKa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jan 2021 05:30:27 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10NALX5K000499;
        Sat, 23 Jan 2021 04:29:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=N8VY8ZhWw1Ykg91W9SCMQqQirNkeklf/Pp6cfAv8oAc=;
 b=bIBBSZdBg2XOpW560XKbUEBfVSoV6EZAtbiJBavKNt89VAB9O5PmdYmZqd4HNGbcuOoa
 TmFYxCMS7Z0vv8xLUyE8v8wilS+Yqyjp2ry/Ds0422rsP52Oxr3FkzM92HaVye4F6LAo
 QN+YfuyuaGDzyaU5aXn4YjUOmtFJRNdZ1cSh8/YxrihKy004ydJNZkLGZiFDHvBJy2E6
 5eJoa2PE61kVjd5rl35w9YKX/y8H7itOZO/PJDNvt/hmlffEIUbbVB2h/Nd4/uewCb1i
 ULibYZipch9LV2Dl4ePV9nyEG+ZCMGHc7dfQX0z3+Izz+k+/UEWPeH0JqBdMe75SM8kp kg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 368h3u0186-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 23 Jan 2021 04:29:42 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Sat, 23 Jan
 2021 10:29:41 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Sat, 23 Jan 2021 10:29:41 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6214945;
        Sat, 23 Jan 2021 10:29:41 +0000 (UTC)
Date:   Sat, 23 Jan 2021 10:29:41 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] regulator: core: Avoid debugfs: Directory ... already
 present! error
Message-ID: <20210123102941.GK106851@ediswmail.ad.cirrus.com>
References: <20210122183250.370571-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210122183250.370571-1-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 clxscore=1015 mlxlogscore=999 mlxscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101230056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 07:32:50PM +0100, Hans de Goede wrote:
> Sometimes regulator_get() gets called twice for the same supply on the
> same device. This may happen e.g. when a framework / library is used
> which uses the regulator; and the driver itself also needs to enable
> the regulator in some cases where the framework will not enable it.
> 
> Commit ff268b56ce8c ("regulator: core: Don't spew backtraces on
> duplicate sysfs") already takes care of the backtrace which would
> trigger when creating a duplicate consumer symlink under
> /sys/class/regulator/regulator.%d in this scenario.
> 
> Commit c33d442328f5 ("debugfs: make error message a bit more verbose")
> causes a new error to get logged in this scenario:
> 
> [   26.938425] debugfs: Directory 'wm5102-codec-MICVDD' with parent 'spi-WM510204:00-MICVDD' already present!
> 
> There is no _nowarn variant of debugfs_create_dir(), but we can detect
> and avoid this problem by checking the return value of the earlier
> sysfs_create_link_nowarn() call.
> 
> Add a check for the earlier sysfs_create_link_nowarn() failing with
> -EEXIST and skip the debugfs_create_dir() call in that case, avoiding
> this error getting logged.
> 
> Fixes: c33d442328f5 ("debugfs: make error message a bit more verbose")
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

> -	int err;
> +	int err = 0;
>  
> @@ -1663,8 +1663,8 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
>  
> -	regulator->debugfs = debugfs_create_dir(supply_name,
> -						rdev->debugfs);
> +	if (err != -EEXIST)
> +		regulator->debugfs = debugfs_create_dir(supply_name, rdev->debugfs);

There is a slight oddity here in that if this regulator has
no struct device we will still get the warning. However, I
am totally not clear on when/why a regulator might not have a
dev, and am fairly sure it isn't common. So my vote would be
to cross that bridge if we ever come to it.

Thanks,
Charles
