Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210F42FB717
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389715AbhASKOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:14:53 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:57532 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389159AbhASJwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 04:52:46 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10J9poiF017510;
        Tue, 19 Jan 2021 03:51:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=ZGcMmV8ud8RsHGVG+9fWIXTvDt1zAVWYEvH2Lib4jVI=;
 b=E0FLQ5IMWCry+Mfo6u3aruWZbOGbkgCf5ivhN9bPBatcRSsUC23rbZ/0dEjXNZWThb9w
 wZi8T0ROP1rZ9E0mqKjoU19GwrVHFtFfF2kcepgO6LuFzeva57UYD/XhAISQIe5olW1I
 aX5+WU8g/4hur2QF4ISPcjdgXx0WMXdY73NzYedr5dq199O9Nc/gB8FlIuzxEuNjMesX
 1+haR7jWn0j9o00um2j/6DXTf3qcTiG9R4Dd986tFzHlG0SSUZt18WM3onJ0vqRZZPV2
 j1NNVT/6qMCTI450P9AFWCfKUJbWu8O7Mua0kl1Mdt6XkQq5f9JtANGOtvrXlgOXYF4v 3w== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 363xe7avy7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 19 Jan 2021 03:51:50 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 19 Jan
 2021 09:51:48 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 19 Jan 2021 09:51:48 +0000
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.215])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 84AA311CB;
        Tue, 19 Jan 2021 09:51:41 +0000 (UTC)
Subject: Re: [PATCH v2 08/12] ASoC: arizona-jack: convert into a helper
 library for codec drivers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <20210117160555.78376-1-hdegoede@redhat.com>
 <20210117160555.78376-9-hdegoede@redhat.com>
 <CAHp75VeSqVYWE9o-6JwY+pmjU7nfBJwZvaSk0v-ngjeGMMxQAQ@mail.gmail.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <e902dc43-42d1-c90b-98df-d054a72a5558@opensource.cirrus.com>
Date:   Tue, 19 Jan 2021 09:51:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VeSqVYWE9o-6JwY+pmjU7nfBJwZvaSk0v-ngjeGMMxQAQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=937 mlxscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101190059
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2021 17:24, Andy Shevchenko wrote:
> On Sun, Jan 17, 2021 at 6:06 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Convert the arizona extcon driver into a helper library for direct use
>> from the arizona codec-drivers, rather then being bound to a separate
>> MFD cell.
>>
>> Note the probe (and remove) sequence is split into 2 parts:
>>
>> 1. The arizona_jack_codec_dev_probe() function inits a bunch of
>> jack-detect specific variables in struct arizona_priv and tries to get
>> a number of resources where getting them may fail with -EPROBE_DEFER.
>>
>> 2. Then once the machine driver has create a snd_sock_jack through
>> snd_soc_card_jack_new() it calls snd_soc_component_set_jack() on
>> the codec component, which will call the new arizona_jack_set_jack(),
>> which sets up jack-detection and requests the IRQs.
>>
>> This split is necessary, because the IRQ handlers need access to the
>> arizona->dapm pointer and the snd_sock_jack which are not available
>> when the codec-driver's probe function runs.
>>
>> Note this requires that machine-drivers for codecs which are converted
>> to use the new helper functions from arizona-jack.c are modified to
>> create a snd_soc_jack through snd_soc_card_jack_new() and register
>> this jack with the codec through snd_soc_component_set_jack().
> 
> ...
> 
>> +int arizona_jack_codec_dev_probe(struct arizona_priv *info, struct device *dev)
>>   {
>> -       struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
>> +       struct arizona *arizona = info->arizona;
>>          struct arizona_pdata *pdata = &arizona->pdata;
> 
>> +       int ret, mode;
>>
>>          if (!dev_get_platdata(arizona->dev))
>> -               arizona_extcon_device_get_pdata(&pdev->dev, arizona);
>> +               arizona_extcon_device_get_pdata(dev, arizona);
>>
>> -       info->micvdd = devm_regulator_get(&pdev->dev, "MICVDD");
>> +       info->micvdd = devm_regulator_get(arizona->dev, "MICVDD");
> 
> I'm wondering if arizona->dev == dev here. if no, can this function
> get a comment / kernel-doc explaining what dev is?
> 

pdev->dev would be *this* driver.
arizona->dev should be the MFD parent driver.

I think these gets should be against the dev passed in as argument
(I assume that is the caller's pdev->dev). So they are owned by this
driver, not its parent.

