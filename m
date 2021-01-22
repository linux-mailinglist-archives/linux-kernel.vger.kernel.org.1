Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20236300147
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbhAVLOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:14:16 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:7252 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728151AbhAVLIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:08:52 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MB7rsS030517;
        Fri, 22 Jan 2021 05:07:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=xpg9HQpwaknEm815/jkH3pctz/69T/ZbqgbwyYSv4aQ=;
 b=inSCE9ERIZS61sBTmB+RJbsOU8LKoBdaVPU6h+zoQf2XL9TfeLIK/MjZWEZBhadEzUia
 jMsiZGkg3dmg+7Cz0OCV8ZHt6/ccZbqGFhdmDz0gNMC8cFKXZxS4+DOQbDDXoOfsHZWP
 JMilVrRi7Zj1qwUq4KOkHMpqFiDZIDwgmfERIjCbRhpJNB+j5umOUIuUtz03hRDCKDmD
 Hl4UfJ+ARkRv5nspr6aVEN5Gu6XxG6jg9Nkas2/r6zWL+6O9Vo18qEOEbVrQQ7j5EgWs
 ZOX4GZAAk8rpR2qMbEh5QYmtcyUYZyNnggBvsmXJcX13hkCfxLlMFEAgZO4cWmRtEdMw 1g== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3668pdugda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 Jan 2021 05:07:53 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 22 Jan
 2021 11:07:52 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 22 Jan 2021 11:07:52 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F21BC11CB;
        Fri, 22 Jan 2021 11:07:51 +0000 (UTC)
Date:   Fri, 22 Jan 2021 11:07:51 +0000
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
Subject: Re: [PATCH v2 03/12] ASoC: arizona-jack: Fix some issues when HPDET
 IRQ fires after the jack has been unplugged
Message-ID: <20210122110751.GF106851@ediswmail.ad.cirrus.com>
References: <20210117160555.78376-1-hdegoede@redhat.com>
 <20210117160555.78376-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210117160555.78376-4-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 17, 2021 at 05:05:46PM +0100, Hans de Goede wrote:
> When the jack is partially inserted and then removed again it may be
> removed while the hpdet code is running. In this case the following
> may happen:
> 
> 1. The "JACKDET rise" or ""JACKDET fall" IRQ triggers
> 2. arizona_jackdet runs and takes info->lock
> 3. The "HPDET" IRQ triggers
> 4. arizona_hpdet_irq runs, blocks on info->lock
> 5. arizona_jackdet calls arizona_stop_mic() and clears info->hpdet_done
> 6. arizona_jackdet releases info->lock
> 7. arizona_hpdet_irq now can continue running and:
> 7.1 Calls arizona_start_mic() (if a mic was detected)
> 7.2 sets info->hpdet_done
> 
> Step 7 is undesirable / a bug:
> 7.1 causes the device to stay in a high power-state (with MICVDD enabled)
> 7.2 causes hpdet to not run on the next jack insertion, which in turn
>     causes the EXTCON_JACK_HEADPHONE state to never get set
> 
> This fixes both issues by skipping these 2 steps when arizona_hpdet_irq
> runs after the jack has been unplugged.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
