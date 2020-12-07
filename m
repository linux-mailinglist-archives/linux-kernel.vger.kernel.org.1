Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A802D0E04
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgLGK3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:29:40 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:47688 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726023AbgLGK3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:29:40 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B7AS8LC006807;
        Mon, 7 Dec 2020 04:28:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=JUbfJjz4AGPwf9hQdds0f883dZueNLcW4UKMQzpl9l8=;
 b=aOOduUhPJ8venksBSXuuai+y1pi/0ejpzlmTStUYFP70X9VX6GCsfth9Ycxz5/wnY79b
 rCG5JkZQ0hVAgjyMaISOc3MSFQ94FrGJMvvoMgWFQL3whn+8ph72zztFKjUw3O9ny9DW
 9evmSY3pExUeCn1ulGxNYdm5Pe9Eyl1671Q0+8SHNE1KbbOzADUY+Po8pcKb1kdS+tmt
 0WXd2cw9WJmAB6WkSsNu9PFhfLNmlscRCTHpHV0/Kf3x9I8EU7l0name1nABP4+tPY8V
 X1EQSv3ym1rd+ywCVFnf+a91a793XKgEavlxx210HPcRBjzfbdL3EnLXuasb7zPMeToO WQ== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 3588g79s8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 07 Dec 2020 04:28:08 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 7 Dec 2020
 10:28:05 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Mon, 7 Dec 2020 10:28:05 +0000
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D6EA145;
        Mon,  7 Dec 2020 10:28:05 +0000 (UTC)
Date:   Mon, 7 Dec 2020 10:28:05 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     "Lukas F. Hartmann" <lukas@mntre.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: Re: wm8960: add DAC Slope switch
Message-ID: <20201207102805.GH10899@ediswmail.ad.cirrus.com>
References: <20201124172313.981552-1-lukas@mntre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201124172313.981552-1-lukas@mntre.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 mlxscore=0 bulkscore=0
 clxscore=1011 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=711 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012070066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 06:23:13PM +0100, Lukas F. Hartmann wrote:
> The WM8960 DAC has a "DAC Slope" switch that can toggle between two
> different output filter curves. This patch adds support for it.
> 
> Signed-off-by: Lukas F. Hartmann <lukas@mntre.com>
> ---
> +static int wm8960_put_dacslope(struct snd_kcontrol *kcontrol,
> +			       struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	struct wm8960_priv *wm8960 = snd_soc_component_get_drvdata(component);
> +	unsigned int val = ucontrol->value.integer.value[0];
> +
> +	if (val > 1)
> +		return -EINVAL;
> +
> +	wm8960->dacslope = val;
> +
> +	return snd_soc_component_update_bits(component, WM8960_DACCTL1,
> +				   0x2, val<<1);

Is the DAC Slope switch not in DACCTL2?

Thanks,
Charles
