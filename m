Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5A82B58F2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 05:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgKQEsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 23:48:41 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:35821 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726339AbgKQEsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 23:48:41 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D2E4A133C;
        Mon, 16 Nov 2020 23:48:39 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 16 Nov 2020 23:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=U
        664ImZm7nx3wttpQWP2v553YO5GQB0UIUFjQe/fRSE=; b=bjV5VA6ypKU8XqzUf
        3uzwl9UiWxGJj0nondnuYmEEJx7egRCPOZiml3zpv3fSXZILD+nWfxb1hmRmKNFP
        d0d7dU1K/T378nmfhEoXzAoSNySgyP3B+FKGROFkR3u6nTR8bJPHrmwmImjigeWs
        vdJzLy6ShLrjHLLwwqcQbEVogNKL/FRetpvE6/jMSHUrANo/nQwHo2D/8cBtyVuv
        GO2vQ307KF6mljcQVDmwFXharjryfe0uDZPGiol1xIDWHdaw3pckX2u6Tg6PFasV
        7dr/pPaqoHkuFcPO4jvUVs/ZB68rajFaRv34MouQewRP6eFn/7ZX+PlzoKQ33wmG
        ayzHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=U664ImZm7nx3wttpQWP2v553YO5GQB0UIUFjQe/fR
        SE=; b=jxgbeDiHC6UqxHT89BqFAM3uaFrMvjzmpybgOMzfnaHyM6JNgSiB8YLxf
        30f4oF61cCSNxAZES5YvG8UxjLxHMn4fivSR5QPuMuV97Wpug5VtjAV2aRPlaAsj
        DuYmjkC7oEC76bGLggRdgK2o1Mu1Msd5dt1oE++WC1gFppouXfnVkUBvb5DlP4zM
        LiXS9QyZa+jlHI6Da7xPJ7w3zPzLbw/AQTJTHMaDtO9szcw/5fsQIOTc3TtcJvdS
        ojba0/bB6o++mxN+7GoethAt246DXI+vNPilgFknHbahhHctIZdblY70oP7lmFkO
        BkNpfA64AQomNt0fYG8TU0aIMG0qg==
X-ME-Sender: <xms:JlazX5femDJ18hLmukX67eanDrEia-lkvMejW-GVXtXSmgjElkM6ag>
    <xme:JlazX3OMPFDxBPZxxV-PTnJAhsT3H8871cZBdNa3-0disQR39g4o1DipXEFW5-wRt
    XagKucaeL1aGnRd2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudefvddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepjeelteehieekgefgieejueejjeekhfejvddtieevleefjeehleev
    tdejkedtheffnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeejtddrud
    efhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:JlazXyh3W7uL-O1ulx4uXWrDRMpXEIVHksQmWeLUtL86S99R5QdEjA>
    <xmx:JlazXy8Yw8CD8-gE0hzRZO0RA3Pw1xb7qesBiqwAnnu0qnNml9i0sQ>
    <xmx:JlazX1tKY6TvcIdPwOD9y_v3vg-YQd3K8G0QBpsTMYxmmon_uKNp5Q>
    <xmx:J1azX5gXZzLEXGT34I3r8GsnViJ4uBRZYAQ2Ohyjd2Kw6AS_toMnOg>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id C94C43280063;
        Mon, 16 Nov 2020 23:48:37 -0500 (EST)
Subject: Re: [PATCH 3/3] phy: sun4i-usb: Use power efficient workqueue for
 debounce and poll
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Frank Lee <frank@allwinnertech.com>, vkoul@kernel.org,
        wens@csie.org, krzk@kernel.org, colin.king@canonical.com,
        tiny.windzz@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20201109121214.19012-1-frank@allwinnertech.com>
 <fba49549-9a78-32ee-a55c-97499f24fe62@sholland.org>
 <20201112095307.pblcmrn6smyecvqi@gilmour.lan>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <971979a1-a69e-c3fe-6799-805407315885@sholland.org>
Date:   Mon, 16 Nov 2020 22:48:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201112095307.pblcmrn6smyecvqi@gilmour.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/20 3:53 AM, Maxime Ripard wrote:
> On Tue, Nov 10, 2020 at 09:44:37PM -0600, Samuel Holland wrote:
>> On 11/9/20 6:12 AM, Frank Lee wrote:
>>> From: Yangtao Li <frank@allwinnertech.com>
>>>
>>> The debounce and poll time is generally quite long and the work not
>>> performance critical so allow the scheduler to run the work anywhere
>>> rather than in the normal per-CPU workqueue.
>>>
>>> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
>>> ---
>>>  drivers/phy/allwinner/phy-sun4i-usb.c | 14 +++++++-------
>>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
>>> index 651d5e2a25ce..4787ad13b255 100644
>>> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
>>> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
>>> @@ -326,7 +326,7 @@ static int sun4i_usb_phy_init(struct phy *_phy)
>>>  		/* Force ISCR and cable state updates */
>>>  		data->id_det = -1;
>>>  		data->vbus_det = -1;
>>> -		queue_delayed_work(system_wq, &data->detect, 0);
>>> +		queue_delayed_work(system_power_efficient_wq, &data->detect, 0);
>>>  	}
>>>  
>>>  	return 0;
>>> @@ -444,7 +444,7 @@ static int sun4i_usb_phy_power_on(struct phy *_phy)
>>>  
>>>  	/* We must report Vbus high within OTG_TIME_A_WAIT_VRISE msec. */
>>
>> This doesn't sound like "not performance critical" to me. My understanding is
>> the debouncing has a deadline from the USB spec. Maybe this is more flexible
>> than the comment makes it sound?
> 
> It's not really clear to me what the power_efficient workqueue brings to
> the table exactly from the comments on WQ_POWER_EFFICIENT (and the
> associated gmane link is long dead).
> 
> It's only effect seems to be that it sets WQ_UNBOUND when the proper
> command line option is set, and WQ_UNBOUND allows for the scheduled work
> to run on any CPU instead of the local one.
> 
> Given that we don't have any constraint on the CPU here, and the CPU
> locality shouldn't really make any difference, I'm not sure we should
> expect any meaningful difference.
> 
> This is also what the rest of the similar drivers seem to be using:
> https://elixir.bootlin.com/linux/v5.10-rc3/source/drivers/usb/common/usb-conn-gpio.c#L119
> https://elixir.bootlin.com/linux/v5.10-rc3/source/drivers/usb/core/hub.c#L1254

Thanks for the explanation. Then the patch looks fine to me.

Reviewed-by: Samuel Holland <samuel@sholland.org>

Cheers,
Samuel
