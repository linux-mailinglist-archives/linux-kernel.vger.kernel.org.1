Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92DD2E7036
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 13:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgL2MBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 07:01:37 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:58836 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725979AbgL2MBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 07:01:37 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BTBrbs9003695;
        Tue, 29 Dec 2020 06:00:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=JuJssSRaUYe6JFnUlHct2u9BzdB+OHvVGf7j9G8SCnk=;
 b=gjDWEht7MTPdC2ANpFk4QDdsLrwOG5527gEQW30S+7wwr8RYyGLZEHgM19AFkdS5C9t8
 JbF8/yDzqc2xpNW58TlGbCvoLD/SeB98HlFkEBv/epxCvgaJeqx7yQsjnoGfw/eUNVu4
 2QlKvTsrXqrDPFlLnZ1OU0apWZ67TEpEaTUcEhzw7OYBW1E/hw35I311OJtClfaDLPri
 rGT95wqF+dhoyKBboolXaTFW33CetXYhmPl3UZtGhvlVjoX3Tdz4bt3WBRLLsqopTPvU
 b6aZSS97MsRoVierL4rl8iPu6QLK3D9A4JztTxkJAxIKMNfi3NDRp/mka2/92eacpRH5 pg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 35p2fs2a5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 29 Dec 2020 06:00:41 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 29 Dec
 2020 12:00:39 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 29 Dec 2020 12:00:39 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6C2E111CB;
        Tue, 29 Dec 2020 12:00:39 +0000 (UTC)
Date:   Tue, 29 Dec 2020 12:00:39 +0000
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
Subject: Re: [PATCH 04/14] mfd: arizona: Allow building arizona MFD-core as
 module
Message-ID: <20201229120039.GI9673@ediswmail.ad.cirrus.com>
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-5-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201227211232.117801-5-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 mlxlogscore=935 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012290075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 10:12:22PM +0100, Hans de Goede wrote:
> There is no reason why the arizona core,irq and codec model specific
> regmap bits cannot be build as a module. All they do is export symbols
> which are used by the arizona-spi and/or arizona-i2c modules, which
> themselves can be built as module.
> 
> Change the Kconfig and Makefile arizona bits so that the arizona MFD-core
> can be built as a module.
> 
> This is especially useful on x86 platforms with a WM5102 codec, this
> allows the arizona MFD driver necessary for the WM5102 codec to be
> enabled in generic distro-kernels without growing the base kernel-image
> size.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

I think this patch might still cause some issues. ASoC has an
idiom where the machine driver does a select on the necessary
CODEC drivers. Select doesn't take care of dependencies etc. So I
believe if you build the machine driver as built in, it then
selects the CODEC as built in. If you have the MFD as a module
the build then fails due to the the CODEC calling some Arizona
functions.

arizona_request_irq, arizona_free_irq, arizona_set_irq_wake

On Madera we made the equivalents inline functions to avoid the
issue, the same should work here.

include/linux/irqchip/irq-madera.h

Thanks,
Charles
