Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D852A2667
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 09:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgKBIv7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Nov 2020 03:51:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:12835 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbgKBIv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 03:51:59 -0500
IronPort-SDR: /zPEr7dCat0wsHLq/vyNxdurgJ9H3KAzpBOqvQB2bouvimo0JV3XsdDY8TdmIFUVjUEikg1PCB
 wusWKODmAYAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9792"; a="166263344"
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="166263344"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 00:51:58 -0800
IronPort-SDR: Ez6aIQ88DZfasGjDz8/CO+SfAG1BU447CU6ekVYNghUvD70LlB1zKi74SM8gPJyaZPt1qVVP+Y
 OcwmdeenYW4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,444,1596524400"; 
   d="scan'208";a="425930387"
Received: from irsmsx603.ger.corp.intel.com ([163.33.146.9])
  by fmsmga001.fm.intel.com with ESMTP; 02 Nov 2020 00:51:56 -0800
Received: from irsmsx601.ger.corp.intel.com (163.33.146.7) by
 irsmsx603.ger.corp.intel.com (163.33.146.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Nov 2020 08:51:55 +0000
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7]) by
 irsmsx601.ger.corp.intel.com ([163.33.146.7]) with mapi id 15.01.1713.004;
 Mon, 2 Nov 2020 08:51:55 +0000
From:   "Rojewski, Cezary" <cezary.rojewski@intel.com>
To:     "trix@redhat.com" <trix@redhat.com>
CC:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
        "yang.jie@linux.intel.com" <yang.jie@linux.intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH] ASoC: Intel: remove unneeded semicolon
Thread-Topic: [PATCH] ASoC: Intel: remove unneeded semicolon
Thread-Index: AQHWsHM3jEYvSMjE+0qRlXlim9MAEKm0iYAg
Date:   Mon, 2 Nov 2020 08:51:55 +0000
Message-ID: <020eb49a79794823954f4a5885374ab3@intel.com>
References: <20201101171943.2305030-1-trix@redhat.com>
In-Reply-To: <20201101171943.2305030-1-trix@redhat.com>
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

On 2020-11-01 6:19 PM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A semicolon is not needed after a switch statement.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

Thanks for this update, Tom.

Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>

Regards,
Czarek

