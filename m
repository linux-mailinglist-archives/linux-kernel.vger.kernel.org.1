Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6115F2E7000
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 12:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgL2Llv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 06:41:51 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:48704 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725964AbgL2Llu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 06:41:50 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BTBd0IG001283;
        Tue, 29 Dec 2020 05:40:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=2xtBZ1d+TCpg6I9iqVlmPO8l3el6VdhLDsfmtyqgneU=;
 b=b9X6z/yj7WPnBRLgRHVQsnh4lVaiM7ZKLEBV7yIQzCqCEHWCGtP4KxuNjbJUy9Jar3zg
 ClohS/WdyT1BFXas/9SiW8TEIl6t3tYNNpDVpKxR+EU1dZopB2ik8sdVXClIiZAcQuWL
 sOk/y6G6SmzI/CnsSjs4XQEL0WLzlyi1ct8LEuom+yNv7S/4I1QecJwO0iQVOhBpggTk
 55JALUX3wIaOX0ysIKfQ/tvjFfAghb1Hb6dXsmHnlg1I8gUqVgaLfKWC4ziNfwNhX3wi
 yB9z3oVX9ZkQKw89adZ2hKrwck9Vm9PY5pRYwLaK8gMcDivdT3lfLBzFAHeR9N9MX49f dA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 35p3f7a8as-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 29 Dec 2020 05:40:56 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 29 Dec
 2020 11:40:54 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 29 Dec 2020 11:40:54 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9CA3F11CB;
        Tue, 29 Dec 2020 11:40:54 +0000 (UTC)
Date:   Tue, 29 Dec 2020 11:40:54 +0000
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
Subject: Re: [PATCH 02/14] mfd: arizona: Add MODULE_SOFTDEP("pre:
 arizona_ldo1")
Message-ID: <20201229114054.GH9673@ediswmail.ad.cirrus.com>
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201227211232.117801-3-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012290073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 10:12:20PM +0100, Hans de Goede wrote:
> The (shared) probing code of the arizona-i2c and arizona-spi modules
> takes the following steps during init:
> 
> 1. Call mfd_add_devices() for a set of early child-devices, this
> includes the arizona_ldo1 device which provides one of the
> core-regulators.
> 
> 2. Bulk enable the core-regulators.
> 
> 3. Read the device id.
> 
> 4. Call mfd_add_devices() for the other child-devices.
> 
> This sequence depends on 1. leading to not only the child-device
> being created, but also the driver for the child-device binding
> to it and registering its regulator.
> 
> This requires the arizona_ldo1 driver to be loaded before the
> shared probing code runs. Add a doftdep for this to both modules to
> ensure that this requirement is met.
> 
> Note this mirrors the existing MODULE_SOFTDEP("pre: wm8994_regulator")
> in the wm8994 code, which has a similar init sequence.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
