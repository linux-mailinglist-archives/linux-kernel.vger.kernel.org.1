Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5DD2FF225
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 18:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388904AbhAURjk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Jan 2021 12:39:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:22437 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388526AbhAURgI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 12:36:08 -0500
IronPort-SDR: H/s3FXlvXhCqlUZiQVHPfuZXKrlHYkUnRZcD+/zybpP+wV0DIVsiJitRexjs5ccLweysdzdBZh
 /tGHR3GFRCfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="179461030"
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="179461030"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 09:34:49 -0800
IronPort-SDR: okOxonF+6uWkGLGISoNEO/KJa5uvFvaO8hFDVZbP8SoV/mpAUjR54m8JXzrsUXf5nxy8bt7fG4
 hlWy+Ri29AOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,364,1602572400"; 
   d="scan'208";a="467527245"
Received: from irsmsx605.ger.corp.intel.com ([163.33.146.138])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jan 2021 09:34:46 -0800
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 IRSMSX605.ger.corp.intel.com (163.33.146.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 21 Jan 2021 17:34:45 +0000
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Thu, 21 Jan 2021 17:34:45 +0000
From:   "Rojewski, Cezary" <cezary.rojewski@intel.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
CC:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mateusz Gorski <mateusz.gorski@linux.intel.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Majczak <lma@semihalf.com>
Subject: RE: [PATCH v2 2/2] ASoC: Intel: Skylake: Zero snd_ctl_elem_value
Thread-Topic: [PATCH v2 2/2] ASoC: Intel: Skylake: Zero snd_ctl_elem_value
Thread-Index: AQHW8Bk4ltU3amcxfkyZEse4eO7dYaoyVvrQ
Date:   Thu, 21 Jan 2021 17:34:45 +0000
Message-ID: <b0097763cee24ba897dee59908730ddc@intel.com>
References: <20210121171644.131059-1-ribalda@chromium.org>
 <20210121171644.131059-2-ribalda@chromium.org>
In-Reply-To: <20210121171644.131059-2-ribalda@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
x-originating-ip: [163.33.253.164]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-21 6:16 PM, Ricardo Ribalda wrote:
> Clear struct snd_ctl_elem_value before calling ->put() to avoid any data
> leak.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

Thanks,
Czarek

