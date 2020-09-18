Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAF6270195
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgIRQGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgIRQGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:06:03 -0400
Received: from [10.20.113.185] (unknown [12.97.180.36])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55424206A4;
        Fri, 18 Sep 2020 16:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600445163;
        bh=1pPWI3tGqdE3sjl7n8Nkm/Du5Ii/JiP1sJP58en8Fy8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=sMuOUFRpKhNx62cOeLq8r3XiweG3+oH+HQ5ARJFYrqRwI0rtwsXirIB8NlHDGu75P
         e/thqMV7HSpbh5YQpTfErTaxp2vvG3jgp5HhHsesYWxbd2rtaHY0RNKn6qtsVW1U4X
         2OUqEA6d7Wt97I57tgwnc5CC2ttU5meMjx3RzqU0=
Subject: Re: [PATCH 1/2] ASoC: fsl_xcvr: Add XCVR ASoC CPU DAI driver
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Cosmin-Gabriel Samoila <cosmin.samoila@nxp.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@gmail.com>
References: <1600247876-8013-1-git-send-email-viorel.suman@oss.nxp.com>
 <1600247876-8013-2-git-send-email-viorel.suman@oss.nxp.com>
 <20200917071431.GA17970@Asurada-Nvidia>
 <VI1PR0401MB2272659A8126D01D9A53F7C5923F0@VI1PR0401MB2272.eurprd04.prod.outlook.com>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <f4d4cd9d-b716-cd7b-da55-7d1a2d003344@kernel.org>
Date:   Fri, 18 Sep 2020 11:06:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <VI1PR0401MB2272659A8126D01D9A53F7C5923F0@VI1PR0401MB2272.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/20 9:21 AM, Viorel Suman (OSS) wrote:
>>> +static const u32 fsl_xcvr_earc_channels[] = { 1, 2, 8, 16, 32, }; /*
>>> +one bit 6, 12 ? */
>> What's the meaning of the comments?
> Just a thought noted as comment. HDMI2.1 spec defines 6- and 12-channels layout when
> one bit audio stream is transmitted - I was wandering how can this be enforced. Is a @todo like of comment.

Please don't add comments that other developers could never understand.

The text that you just wrote here would be a great starting point for a 
better comment.
