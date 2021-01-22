Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE6273001AB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbhAVLdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:33:53 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:50400 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728286AbhAVL1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 06:27:07 -0500
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10MBMBcx017201;
        Fri, 22 Jan 2021 05:26:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=PODMain02222019;
 bh=wONTplmEtArXIXGBmM/MvGOvAqdP7lnI1xWMVD0p/AU=;
 b=F9vcwXRWJruS8GwUHzmoDRbVe5r0awteeHzoFMJvZyT+4LRihGv5BLv2fyC9ua7scDRQ
 XgJCuOo1Yqe9EWqXByj0Fm2oXBfYi6WTsfASw/qhzFS6ZUR/FuO3rIBuwQKRZ6K9WgHc
 mWsTMd7CaBWlBfVf70CG802Hem+gpXj98ZwphmNc74abS76IKwpCoI0+A6kt690ACa9q
 Qj73vw8Qsb3A2dCgkpzzydtcBjRmr3XiV7AIj/aY80+J0AnrBC6eqiv5H02JatXF3nBS
 NvJpiDEqlULAmWIoNQz75N0mP+703JBe3VIEuADtmpwRphcPQ5YfVXiGRImW9m1Y2wBM Jg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 3668pdugyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 Jan 2021 05:26:09 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 22 Jan
 2021 11:26:08 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 22 Jan 2021 11:26:08 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A9D4F45;
        Fri, 22 Jan 2021 11:26:07 +0000 (UTC)
Date:   Fri, 22 Jan 2021 11:26:07 +0000
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
Message-ID: <20210122112607.GH106851@ediswmail.ad.cirrus.com>
References: <20210117160555.78376-1-hdegoede@redhat.com>
 <20210117160555.78376-9-hdegoede@redhat.com>
 <CAHp75VeSqVYWE9o-6JwY+pmjU7nfBJwZvaSk0v-ngjeGMMxQAQ@mail.gmail.com>
 <e902dc43-42d1-c90b-98df-d054a72a5558@opensource.cirrus.com>
 <5c1f181f-f074-397d-cdba-d37ab58f9a2b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c1f181f-f074-397d-cdba-d37ab58f9a2b@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101220063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 05:55:00PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 1/19/21 10:51 AM, Richard Fitzgerald wrote:
> > On 18/01/2021 17:24, Andy Shevchenko wrote:
> >> On Sun, Jan 17, 2021 at 6:06 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >>>
> >>> Convert the arizona extcon driver into a helper library for direct use
> >>> from the arizona codec-drivers, rather then being bound to a separate
> >>> MFD cell.
> >>>
> >>> Note the probe (and remove) sequence is split into 2 parts:
> >>>
> >>> 1. The arizona_jack_codec_dev_probe() function inits a bunch of
> >>> jack-detect specific variables in struct arizona_priv and tries to get
> >>> a number of resources where getting them may fail with -EPROBE_DEFER.
> >>>
> >>> 2. Then once the machine driver has create a snd_sock_jack through
> >>> snd_soc_card_jack_new() it calls snd_soc_component_set_jack() on
> >>> the codec component, which will call the new arizona_jack_set_jack(),
> >>> which sets up jack-detection and requests the IRQs.
> >>>
> >>> This split is necessary, because the IRQ handlers need access to the
> >>> arizona->dapm pointer and the snd_sock_jack which are not available
> >>> when the codec-driver's probe function runs.
> >>>
> >>> Note this requires that machine-drivers for codecs which are converted
> >>> to use the new helper functions from arizona-jack.c are modified to
> >>> create a snd_soc_jack through snd_soc_card_jack_new() and register
> >>> this jack with the codec through snd_soc_component_set_jack().
> >>
> >> ...
> >>
> >>> +int arizona_jack_codec_dev_probe(struct arizona_priv *info, struct device *dev)
> >>>   {
> >>> -       struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
> >>> +       struct arizona *arizona = info->arizona;
> >>>          struct arizona_pdata *pdata = &arizona->pdata;
> >>
> >>> +       int ret, mode;
> >>>
> >>>          if (!dev_get_platdata(arizona->dev))
> >>> -               arizona_extcon_device_get_pdata(&pdev->dev, arizona);
> >>> +               arizona_extcon_device_get_pdata(dev, arizona);
> >>>
> >>> -       info->micvdd = devm_regulator_get(&pdev->dev, "MICVDD");
> >>> +       info->micvdd = devm_regulator_get(arizona->dev, "MICVDD");
> >>
> >> I'm wondering if arizona->dev == dev here. if no, can this function
> >> get a comment / kernel-doc explaining what dev is?
> >>
> > 
> > pdev->dev would be *this* driver.
> > arizona->dev should be the MFD parent driver.
> > 
> > I think these gets should be against the dev passed in as argument
> > (I assume that is the caller's pdev->dev). So they are owned by this
> > driver, not its parent.
> 
> Right, this is all correct.
> 
> The reason why I used arizona->dev instead of dev for the devm_regulator_get()
> is because the codec code already does a regulator_get for MICVDD through:
> 
> SND_SOC_DAPM_REGULATOR_SUPPLY("MICVDD", 0, SND_SOC_DAPM_REGULATOR_BYPASS),
> 
> And doing it again leads to an error being logged about trying to
> create a file in debugs with a name which already exists, because now
> we do a regulator_get("MICVDD") with the same consumer twice.
> 
> But I now see that I overlooked the devm part, turning my "fix" from
> a cute hack to just being outright wrong.
> 

Aye we should definitely drop the devm here.

> So there are a number of solutions here:
> 
> 
> 1. Keep the code as is, live with the debugfs error. This might be
> best for now, as I don't want to grow the scope of this series too much.
> I will go with this for the next version of this series (unless
> I receive feedback otherwise before I get around to posting the next
> version).
> 

Not ideal but as you say might be the best thing for now.

> 
> 2. Switch the arizona-jack code from directly poking the regulator
> to using snd_soc_component_force_enable_pin("MICVDD") and
> snd_soc_component_disable_pin("MICVDD"). I like this, but there is
> one downside, the dapm code assumes that when the regulator is
> enabled the bypass must be disabled:
> 
...
> 
> When enabling MIC-current / button-press IRQs.
> 
> If we switch to using snd_soc_component_force_enable_pin("MICVDD") and
> snd_soc_component_disable_pin("MICVDD") we loose the power-saving
> of using the bypass when we only need MICVDD for button-press
> detection.
> 

Yeah we really don't want to force the micbias's to be regulated
during button detect, so I think this option has to go.

> Note there is a pretty big issue with the original code here, if
> the MICVDD DAPM pin is on for an internal-mic and then we run through the
> jack-detect mic-detect sequence, we end up setting
> bypass=true causing the micbias for the internal-mic to no longer
> be what was configured. IOW poking the bypass setting underneath the
> DAPM code is racy.
> 

The regulator bypass code keeps an internal reference count. All
the users of the regulator need to allow bypass for it to be
placed into bypass mode, so I believe this can't happen.

> Keeping in mind that switching to force_enable fixes the current racy code,
> as well as the KISS-ness of this solution, I personally prefer this option
> over option 1 as it makes the code cleaner and more correct.
> I could easily do this in a next version of this series if people agree
> with going this route.
> 

It is pretty problematic to loose the power benefits of the
button detect, for the sake of making the code a little cleaner.

Thanks,
Charles
