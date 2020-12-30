Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D72D2E7806
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 12:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgL3LYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 06:24:40 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:16860 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726500AbgL3LYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 06:24:40 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BUBMZkA024101;
        Wed, 30 Dec 2020 05:23:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=YQSxHTOBkRNqYWuYUwewKqooZOwjVVh8M/4grr5+ZIQ=;
 b=fx75Kyj6yVkMxUP2CcAIsfkDRMjoWLE44Xrm4SJAfEjWHlJMfJSn0RarRusvEMI5bkRE
 nwZOMkpvyTkgEMnzZHUfg6EEPBF3e25V70XedJpI/MYfrAmHgNsmNhStpYcEqfEEgCPx
 +SX/ZdoZd4U3QGa3Ty0Ywukto+dBRWs4ak2Bw+ND5+F18S3u9buxuUnkzUCjGarFoyhv
 /GDfAqsLWbmrlkCVT9KCNmn84SghecF97jFfwEM6Cg7idXwwruHQ78gAmTdHjavsZ+ig
 OK7xi86tYuDIxNi7B5EcS/pVkO2YkNxcAEYYL5WzNYeqru4hwE0G7uuPlcPCdMX5rkq/ Nw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 35p3f7b6rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 30 Dec 2020 05:23:46 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 30 Dec
 2020 11:23:44 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Wed, 30 Dec 2020 11:23:44 +0000
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.77])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4254145;
        Wed, 30 Dec 2020 11:23:44 +0000 (UTC)
Subject: Re: [PATCH 01/14] mfd: arizona: Add jack pointer to struct arizona
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
CC:     Lee Jones <lee.jones@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
References: <20201227211232.117801-1-hdegoede@redhat.com>
 <20201227211232.117801-2-hdegoede@redhat.com>
 <20201228122138.GA5352@sirena.org.uk>
 <44f84485-8efc-39f9-d0a7-cb8db2ea3faa@redhat.com>
 <20201228162807.GE5352@sirena.org.uk>
 <20201229130657.GN9673@ediswmail.ad.cirrus.com>
 <19c2d056-4f71-2c4c-c243-cdcc0115876c@redhat.com>
 <20201229150635.GP9673@ediswmail.ad.cirrus.com>
 <20201229151548.GG4786@sirena.org.uk>
 <1d982dd1-eb02-e7c7-357e-83cf5003c624@redhat.com>
 <21333e30-1e7a-2c95-9e7c-6325c7e78f9a@opensource.cirrus.com>
 <833781fc-efde-fe98-fded-f81855e54de8@redhat.com>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <53504898-3062-fb9a-3e44-ac0a2ccc86e2@opensource.cirrus.com>
Date:   Wed, 30 Dec 2020 11:23:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <833781fc-efde-fe98-fded-f81855e54de8@redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 adultscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012300070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2020 11:04, Hans de Goede wrote:
> Hi,
> 
> On 12/29/20 5:51 PM, Richard Fitzgerald wrote:
>>
>>
>> On 29/12/2020 15:40, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 12/29/20 4:15 PM, Mark Brown wrote:
>>>> On Tue, Dec 29, 2020 at 03:06:35PM +0000, Charles Keepax wrote:
>>>>
>>>>> There is maybe more argument for porting the Arizona code across
>>>>> anyways, since for a long time Android didn't properly support extcon
>>>>> either. It supported the earlier out of tree switch stuff, extcon
>>>>
>>>> Completely moving the driver doesn't cause the same problems as the
>>>> current proposal (unless it drops functionality I guess, there were
>>>> issues with adding new detection types into the input layer but I can't
>>>> remember if this hardware was impacted by that or not).
>>>
>>> The input-layer supports the following switches:
>>>
>>> SW_HEADPHONE_INSERT
>>> SW_MICROPHONE_INSERT
>>> SW_LINEOUT_INSERT
>>> SW_JACK_PHYSICAL_INSERT
>>>
>>> Which is a 1:1 mapping with the cable-types currently exported by
>>> extcon-arizona.c .
>>>
>>> I'm fine with fully moving extcon-arizona.c over to only using
>>> sound/core/jack.c functionality and it no longer exporting an
>>> extcon device.
>>>
>>> I guess we should move it out of drivers/extcon then though.
>>> I suggest using: sound/soc/cirrus/arizona-jack-detect.c
>>> Note that sound/soc/cirrus is a new dir here. Would that work
>>> for you ?
>>
>> Shouldn't it be sound/soc/codecs/arizona-jack.c so that it is with all
>> the other code for those codecs?
> 
> The arizona codecs use the MFD framework and there is a separate
> platform-device instantiated for the jack-detect functionality, so this

That is because it is an extcon driver. It is a different subsystem to
the other child drivers so has to be a separate child.

> (mostly) a standalone platform-driver which has very little interaction
> with the rest of the codec code.
> 
> It is not a codec driver, or code shared between the codec drivers,
> so putting it under sound/soc/codecs would be a bit weird.
>

In fact it is tied into the codec driver. The code in arizona.c that
handles HP OUT has to synchronize  with the jack detection to avoid one
driver trashing the state of the other. But because they are currently
separate drivers they have to communicate through hp_ena and
hp_clamp in the parent mfd data. See arizona_hp_ev().

> With that said I have no strong preference for putting it under
> a new sound/soc/cirrus dir, if everyone is ok with putting it under
> sound/soc/codecs then that works for me.
> 
> Regards,
> 
> Hans
> 
