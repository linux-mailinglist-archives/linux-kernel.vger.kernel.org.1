Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C6C3003CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbhAVNHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:07:25 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:16058 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727960AbhAVNFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:05:13 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MD2jtb012226;
        Fri, 22 Jan 2021 07:04:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=yce91SwW/9Sjkp7mVxwKLT9AOFwoVPrBwfeXugarwdQ=;
 b=oYyjIQn7JYs+8M1e5YEKav+d2LTp8eQ3upSenCCJ3xrzFRYAsbbzC3Z0E0xmd8ah1O6G
 cdjwNQeDjij+YBgXLytVRFhNRnm9gzDfbr+agMUAYnoPd39tVDr793s1vztmdjfE9UES
 xe+0NIH8a5JJkiykdB7fgesa6KwBh/nlryYUSdjuEEG2A4a53p3rxQR8K/Jh0rgWxZ8q
 hS/tvtXnHYadGnICCtpFiFgk0o+lni2ULbWfJzoGgSgNi/LUA61W0RRw5fs2OTMMUEcK
 JgVqzLb3H5Co6T+ZDjfwFFiQUtNNVotP1gigqRyFXXYVwqst6P4hkRfOxyQ9aI0iM1xh Zw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36692rbnp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 Jan 2021 07:04:15 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 22 Jan
 2021 13:04:13 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 22 Jan 2021 13:04:13 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A703E45;
        Fri, 22 Jan 2021 13:04:12 +0000 (UTC)
Date:   Fri, 22 Jan 2021 13:04:12 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Hans de Goede <hdegoede@redhat.com>
CC:     Richard Fitzgerald <rf@opensource.cirrus.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 08/12] ASoC: arizona-jack: convert into a helper
 library for codec drivers
Message-ID: <20210122130412.GI106851@ediswmail.ad.cirrus.com>
References: <20210117160555.78376-1-hdegoede@redhat.com>
 <20210117160555.78376-9-hdegoede@redhat.com>
 <CAHp75VeSqVYWE9o-6JwY+pmjU7nfBJwZvaSk0v-ngjeGMMxQAQ@mail.gmail.com>
 <e902dc43-42d1-c90b-98df-d054a72a5558@opensource.cirrus.com>
 <5c1f181f-f074-397d-cdba-d37ab58f9a2b@redhat.com>
 <20210122112607.GH106851@ediswmail.ad.cirrus.com>
 <4274589c-9a52-7f1a-f937-1c5d60b76559@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4274589c-9a52-7f1a-f937-1c5d60b76559@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 mlxlogscore=971 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101220071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 01:23:44PM +0100, Hans de Goede wrote:
> On 1/22/21 12:26 PM, Charles Keepax wrote:
> > On Thu, Jan 21, 2021 at 05:55:00PM +0100, Hans de Goede wrote:
> >> On 1/19/21 10:51 AM, Richard Fitzgerald wrote:
> >>> On 18/01/2021 17:24, Andy Shevchenko wrote:
> >>>> On Sun, Jan 17, 2021 at 6:06 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >> Note there is a pretty big issue with the original code here, if
> >> the MICVDD DAPM pin is on for an internal-mic and then we run through the
> >> jack-detect mic-detect sequence, we end up setting
> >> bypass=true causing the micbias for the internal-mic to no longer
> >> be what was configured. IOW poking the bypass setting underneath the
> >> DAPM code is racy.
> >>
> > 
> > The regulator bypass code keeps an internal reference count. All
> > the users of the regulator need to allow bypass for it to be
> > placed into bypass mode, so I believe this can't happen.
> 
> Ah I did not know that, since the regulator_allow_bypass function
> takes a bool rather then having enable/disable variants I thought
> it would directly set the bypass, but you are right. So this is not
> a problem, good.
> 
> So this has made me look at the problem again and I believe that
> a much better solution is to simply re-use the MICVDD regulator-reference
> which has been regulator_get-ed by the dapm code when instantiating the:
> 
> SND_SOC_DAPM_REGULATOR_SUPPLY("MICVDD", 0, SND_SOC_DAPM_REGULATOR_BYPASS),
> 
> widget. So I plan to have a new patch in v3 of the series which replaces
> the devm_regulator_get with something like this:
> 
> 	/*
>  	 * There is a DAPM widget for the MICVDD regulator, since
> 	 * the button-press detection has special requirements wrt
> 	 * the regulator bypass settings we cannot directly
> 	 * use snd_soc_component_force_enable_pin("MICVDD") /
> 	 * snd_soc_component_disable_pin("MICVDD").
> 	 *
> 	 * Instead we lookup the widget's regulator reference here
> 	 * and use that to directly control the regulator.
> 	 * Both the regulator's enable and bypass settings are
> 	 * ref-counted so this will not interfere with the DAPM use
> 	 * of the regulator.
> 	 */
> 	for_each_card_widgets(dapm->card, w) {
> 		if (!strcmp(w->name, "MICVDD"))
> 			info->micvdd_regulator = w->regulator;
> 			break;
> 		}
> 	}
> 
> (note I've not tested this yet, but I expect this to work fine).
> 

Alas this won't work either. When I say reference count that
isn't quite a totally accurate reflection of the usage of the
function. When you call allow_bypass you are saying as this
consumer of the regulator I don't mind if it goes into bypass.
Then if all consumers agree the regulator will be put into
bypass. So it is comparing the reference count to the number of
consumers the regulator has to make a decision.

If you call allow_bypass independently from the jack detection
code and the ASoC framework on the same consumer, as you
describe here you will get bad effects.  For example the
regulator has two consumers, our CODEC driver and some other
device. If our codec driver calls allow_bypass twice, then
the regulator would go into bypass without the other consumer
having approved it would could be fatal to that device.

Thanks,
Charles
