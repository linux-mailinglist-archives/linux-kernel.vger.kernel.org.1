Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0FDD2E708A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 13:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgL2MLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 07:11:34 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:4206 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726492AbgL2MLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 07:11:31 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BTC6OiU003407;
        Tue, 29 Dec 2020 06:10:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=b2p/w4UnxX8C3PmPAuMuKiC0cnORaVzXsa0NBHbWtOM=;
 b=qVaYrJjO3xxPjDkZnyjzxkfnmd4dcrDco/F4/9nTokm/23ZhF1e+24ekZK6tOrck+LYS
 +MWGnsU2aViYcHHjLEu+PO1KHdJdnd9c5/TWMrWgi55kCLccUQDNvW3VWglIoglegzTo
 oImtnZQXS3bGIcS7EMJ7gykErNkBVhRhjvJkAzytDXZ4TvDaPMqMftzex0U96a10mOjc
 QlTLssPcl9EtDjWZxfK3EiKfU0HWu/DxzONW5L/d/j5I82KnU4ojX/blaFzRaABLaUy4
 kxBzsXVINXQlC+ps2BBfY8woZk+lzFOn5dYNj9V86RspsiwxgCwg7GzvMW2ZK6KlT74K iQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 35p3f7a8wr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 29 Dec 2020 06:10:39 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 29 Dec
 2020 12:10:37 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 29 Dec 2020 12:10:37 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9AB902AB;
        Tue, 29 Dec 2020 12:10:37 +0000 (UTC)
Date:   Tue, 29 Dec 2020 12:10:37 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH 06/14] extcon: arizona: Fix various races on driver unbind
Message-ID: <20201229121037.GJ9673@ediswmail.ad.cirrus.com>
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-7-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201227211232.117801-7-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxlogscore=995
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012290077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 10:12:24PM +0100, Hans de Goede wrote:
> We must free/disable all interrupts and cancel all pending works
> before doing further cleanup.
> 
> Before this commit arizona_extcon_remove() was doing several
> register writes to shut things down before disabling the IRQs
> and it was cancelling only 1 of the 3 different works used.
> 
> Move all the register-writes shutting things down to after
> the disabling of the IRQs and add the 2 missing
> cancel_delayed_work_sync() calls.
> 
> This fixes various possible races on driver unbind. One of which
> would always trigger on devices using the mic-clamp feature for
> jack detection. The ARIZONA_MICD_CLAMP_MODE_MASK update was
> done before disabling the IRQs, causing:
> 1. arizona_jackdet() to run
> 2. detect a jack being inserted (clamp disabled means jack inserted)
> 3. call arizona_start_mic() which:
> 3.1 Enables the MICVDD regulator
> 3.2 takes a pm_runtime_reference
> 
> And this was all happening after the ARIZONA_MICD_ENA bit clearing,
> which would undo 3.1 and 3.2 because the ARIZONA_MICD_CLAMP_MODE_MASK
> update was being done after the ARIZONA_MICD_ENA bit clearing.
> 
> So this means that arizona_extcon_remove() would exit with
> 1. MICVDD enabled and 2. The pm_runtime_reference being unbalanced.
> 
> MICVDD still being enabled caused the following oops when the
> regulator is released by the devm framework:
> 
> [ 2850.745757] ------------[ cut here ]------------
> [ 2850.745827] WARNING: CPU: 2 PID: 2098 at drivers/regulator/core.c:2123 _regulator_put.part.0+0x19f/0x1b0
> [ 2850.745835] Modules linked in: extcon_arizona ...
> ...
> [ 2850.746909] Call Trace:
> [ 2850.746932]  regulator_put+0x2d/0x40
> [ 2850.746946]  release_nodes+0x22a/0x260
> [ 2850.746984]  __device_release_driver+0x190/0x240
> [ 2850.747002]  driver_detach+0xd4/0x120
> ...
> [ 2850.747337] ---[ end trace f455dfd7abd9781f ]---
> 
> Note this oops is just one of various theoretically possible races caused
> by the wrong ordering inside arizona_extcon_remove(), this fixes the
> ordering fixing all possible races, including the reported oops.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Sorry yes there are a few rough corners on the extcon stuff, I
have clean up series I have been working on as part of
upstreaming the Madera extcon hopefully I will get that sent out
one day.

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
