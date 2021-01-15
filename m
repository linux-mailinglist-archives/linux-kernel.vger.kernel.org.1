Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D942F7E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 15:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbhAOOnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 09:43:16 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:48406 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725910AbhAOOnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 09:43:15 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10FEb3p7015653;
        Fri, 15 Jan 2021 08:42:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=PODMain02222019;
 bh=UCqd0nfi3jYn7t3HzDEdBbfO8As7XK0/wje7LItu+eA=;
 b=bf5scJoMYYE1dZUmw8hy4+691YTAfgtufVNSav9wxrPxxPqZoZ524rVHyPL25fh39eMT
 5CKpDc0Qr+MgzlqjVGnYH5ZJhAL8jffASqFQXa3MbxVhXIBqVs+T3pT3T9T5+o5Rr0d4
 AEQKr3pt59eveMg4kI+pFywT3W9kaMwPEmYL5VYrJhhVPGV9eeydUSWFJtJEPgvu+9EF
 dI0PtAiYYKjSCGB4rlgzuM1nBrPrYnwCUKUGjugBAy/njN/kaRb4mqAQJW7tNFHSYdx0
 J0dRrPJvMqsAZBgxLIFWFLUop/2R/aagCQZ5fMU3LYLI7mz9YMXhodIYZh4DUJjUml32 UA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 36156kmu1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 15 Jan 2021 08:42:16 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 15 Jan
 2021 14:42:13 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Fri, 15 Jan 2021 14:42:13 +0000
Received: from [10.0.2.15] (AUSNPC0LSNW1.ad.cirrus.com [198.61.64.57])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4DD0A45;
        Fri, 15 Jan 2021 14:42:13 +0000 (UTC)
Subject: Re: [PATCH v4 2/6] dt-bindings: audio-graph-card: Add plls and
 sysclks properties
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh@kernel.org>, <kuninori.morimoto.gx@renesas.com>,
        <nsaenzjulienne@suse.de>, <f.fainelli@gmail.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210108160501.7638-1-rf@opensource.cirrus.com>
 <20210108160501.7638-3-rf@opensource.cirrus.com>
 <20210113152225.GA2334778@robh.at.kernel.org>
 <20210113160917.GF4641@sirena.org.uk>
 <ee3d0b75-dc2f-9994-19a4-a3c3f21a2c65@opensource.cirrus.com>
 <20210115131142.GA4384@sirena.org.uk>
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
Message-ID: <1ec5e5f4-f672-2c60-23a5-9d985b943379@opensource.cirrus.com>
Date:   Fri, 15 Jan 2021 14:42:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210115131142.GA4384@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101150092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2021 13:11, Mark Brown wrote:
> On Fri, Jan 15, 2021 at 10:35:23AM +0000, Richard Fitzgerald wrote:
>> On 13/01/2021 16:09, Mark Brown wrote:
>>> On Wed, Jan 13, 2021 at 09:22:25AM -0600, Rob Herring wrote:
> 
>> some_codec {
>> 	pll: pll {
>> 		compatible = "fixed-clock";
>> 		clocks = <&audio_mclk>;
>> 		clock-frequency = <98304000>;
>> 	}
> 
> A PLL is not a fixed clock, why would you define a fixed clock here?

It's a fixed clock if you are only setting one configuration. Call it
compatible="any-other-dummy-clock-type" if you like, it doesn't matter
what it is for the purposes of what I was describing.

This isn't a clk driver for a pll, it's just a setting to be passed to
snd_soc_component_set_pll() using a clock binding to specify it.

> Are you confusing the selection of rates on existing clocks with the use
> of the assigned-* properties that the clock binding provides?
> 

I'm not at all sure what you and Rob have in mind here. Perhaps you
could give an example of what you are thinking the .dts would look like
to define some pll/sysclk settings for audio-graph-card to apply. An
example is worth a thousand emails.

>> For this to work the clock binding must be a real clock object (so needs
>> a valid compatible=). But I need to somehow specify the PLL ID and
> 
> That seems like a *very* surprising requirement - why would the clock
> binding have that requirement?  It would seem to create issues for a
> single device providing multiple clocks which should be a pretty common
> coase.
> 

You misunderstand me. What I'm saying is that to do this:

	sound {
		clocks = <&pll>;
	}

The node 'pll' must correspond to a clock provider driver. It can't be
just a bare node with some properties pick-n-mixed from the clock
binding, like this:

	pll1 : pll1 {
		clock-frequency = <98304000>;
	};

which doesn't define a compatible= to match it to a clk driver. An
attempt to bulk_get the machine driver clocks here will fail.

To use a bare node with pick-n-mixed useful clock binding properties,
that doesn't represent a real clk provider driver, it would have to be
pointed to by a custom property that is not treated as a clk framework
object, e.g.:

	sound {
		audio-graph-card,plls = <&pll>;
	}

In this case pll is a node parsed by audio-graph-card that just happens
to use properties from the clock binding.

So the question I'm trying to ask is: when you and Rob said use
the clock binding, did you mean pointing to that binding from
clocks=<...>, or from a custom property like my audio-graph-card,plls
example above.
