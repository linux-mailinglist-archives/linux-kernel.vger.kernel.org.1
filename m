Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D771C2FE7E0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729675AbhAUKnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:43:17 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:1110 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729820AbhAUKil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:38:41 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10LAZnJd032763;
        Thu, 21 Jan 2021 04:37:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=xLdqq6hhO8/n0d4Thnqw0F4ZlNDIuO5MhIN1bKH6sOE=;
 b=jlrdbbY+w12fsHVVNULS/SmejqKgpuCP9IxK4d/uibyh0Lr+jcN/n+H3AzXeu+Huqbv+
 ll1xw68vbp5fM+4eiRlXROynEhOGsIcGlz8FKy4ambhjEZA2yCsdiQYLK+jTYVa3WzJh
 MXae1++MTQMLwHzOVVyPqr+ooKmerm51UAws9hy2Gnipn2IFUV7w63Wcl2C2pmPjpLX5
 glq7bUd6w31R5dDOnTJNbggh7gqRxmOLFFW52oOXFUUTHYkuPi5XxDHAPVQGZkLD04Le
 kRNqwwWsoo2dDB7vYQtQSGZw06q5yeVaBD3w7rO5ifHfV2Lsq+XFXYXaRTTwUpXl9o6C Yw== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36692r9xws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Jan 2021 04:37:42 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 21 Jan
 2021 10:37:40 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 21 Jan 2021 10:37:40 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 25CB445;
        Thu, 21 Jan 2021 10:37:40 +0000 (UTC)
Date:   Thu, 21 Jan 2021 10:37:40 +0000
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
Subject: Re: [PATCH v4 5/5] ASoC: Intel: bytcr_wm5102: Add machine driver for
 BYT/WM5102
Message-ID: <20210121103740.GE106851@ediswmail.ad.cirrus.com>
References: <20210120214957.140232-1-hdegoede@redhat.com>
 <20210120214957.140232-6-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210120214957.140232-6-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101210056
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 10:49:57PM +0100, Hans de Goede wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Add a new ASoc Machine driver for Intel Baytrail platforms with a
> Wolfson Microelectronics WM5102 codec.
> 
> This is based on a past contributions [1] from Paulo Sergio Travaglia
> <pstglia@gmail.com> based on the Levono kernel [2] combined with
> insights in things like the speaker GPIO from the android-x86 android
> port for the Lenovo Yoga Tablet 2 1051F/L [3].
> 
> [1] https://patchwork.kernel.org/project/alsa-devel/patch/593313f5.3636c80a.50e05.47e9@mx.google.com/
> [2] https://github.com/lenovo-yt2-dev/android_kernel_lenovo_baytrail/blob/cm-12.1/sound/soc/intel/board/byt_bl_wm5102.c
> [3] https://github.com/Kitsune2222/Android_Yoga_Tablet_2-1051F_Kernel
> 
> The original machine driver from the Android ports was a crude modified
> copy of bytcr_rt5640.c adjusted to work with the WM5102 codec.
> This version has been extensively reworked to:
> 
> 1. Remove all rt5640 related quirk handling. to the best of my knowledge
> this setup is only used on the Lenovo Yoga Tablet 2 series (8, 10 and 13
> inch models) which all use the same setup. So there is no need to deal
> with all the variations with which we need to deal on rt5640 boards.
> 
> 2. Rework clock handling, properly turn off the FLL and the platform-clock
> when they are no longer necessary and don't reconfigure the FLL
> unnecessarily when it is already running. This fixes a number of:
> "Timed out waiting for lock" warnings being logged.
> 
> 3. Add the GPIO controlled Speaker-VDD regulator as a DAPM_SUPPLY
> 
> This only adds the machine driver and ACPI hooks, the BYT-CR detection
> quirk which these devices need will be added in a separate patch.
> 
> BugLink: https://github.com/thesofproject/linux/issues/2485
> Co-authored-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
