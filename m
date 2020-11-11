Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF652AE72A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 04:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgKKDos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 22:44:48 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:57591 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725849AbgKKDon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:44:43 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id C45DB168A;
        Tue, 10 Nov 2020 22:44:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 10 Nov 2020 22:44:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=M
        bK62lfa8XqQ5uQpEMNmODTXXUW5ssZlsBtuCAcsjHw=; b=ZQeRRIlu5RRQSjaJV
        DabQsIHjtrX9diTzh1dbhHfKBKg9gxux67QCjj7dvZTlBFLGclnObL3rJkFwIbno
        Pyp+1Dy2Ze8Nq+0Y/t5g+HR5i9lq6S4IQORd1XDBNFrOEi7jtB89TFwZTfxMzOIb
        O+z5SopD5RWMJkue3kXVw795qIySgLDDQRZa0oGh96prI63hm3vg/0up1sKS73i9
        H22zMeK5VrQD9MFWiGLgewjmywnBVxkFEpmErFaC07jK3TloBqAc48LVWQrvJFWF
        cJEtg0VhH16zIPrACcmCodChMVVFGLN23D3CwqLf+u+oU7Ych86WazUVwenz+/SK
        gtnVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=MbK62lfa8XqQ5uQpEMNmODTXXUW5ssZlsBtuCAcsj
        Hw=; b=l9wDrZpxX9ozjQp14/v2qpNp4v3anPxU1/7XiQtzgrH2VMPqHbq6cGM1M
        JtYgroDNJ64e75liN3mIcijWMJtg4G95JuyPr7B4fcGmkG08nnGavjc8hKCf+gHQ
        h3rE0ittFD+q2XPP2bJRMjTNCqrpuVzlDYomelg0TiMRrUt+Av9w7fmJIvR1GIeD
        nXWJFYW4Mb5fU1tx85UjmoG+rIrhuSt/aGhYFPRU5RZBQvTzz1fd/i/aiT16vHCz
        3XP+lfMsJJ1TuUu5kfKnsn7UYiZski9wrc6rp6olO0QLaQxlaCV0ZDP9xXl9iO/P
        2+2g+HjSerHlmjPuYmR5QmYqyHc0g==
X-ME-Sender: <xms:J16rX_dEvsG7ssxpfnkvMFTZzutUoygcWi1IzBNxhTwFKz-QKOswHQ>
    <xme:J16rX1Njo32HIZYVb1ZrxOa2huThT_0lcs3RdsYrH63UiDO8hKIJcDc4w2H9VN7U2
    rV0wUwJYmpOif1xUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudduledggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:J16rX4g0sstrMhbmyH66IYv9DMZZhMELvGxp1XhgkFun5R2qVlqSIg>
    <xmx:J16rXw_6VXg4V-KBwQ8_-wnD5U158vN4ixPZTCc_TeDSUK5_Zv1USQ>
    <xmx:J16rX7u2XD8kYdEyqWkgmmFPpS8XXoVfHUK_PP4UYwTDPLd3xL9z9g>
    <xmx:KV6rX_jVMjm0t2sgDHpgU8RdhPYwf_wMqT7kdjj8h3adFH-3FpnRNg>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id C7E32328005E;
        Tue, 10 Nov 2020 22:44:38 -0500 (EST)
Subject: Re: [PATCH 3/3] phy: sun4i-usb: Use power efficient workqueue for
 debounce and poll
To:     Frank Lee <frank@allwinnertech.com>, vkoul@kernel.org,
        mripard@kernel.org, wens@csie.org, krzk@kernel.org,
        colin.king@canonical.com, tiny.windzz@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20201109121214.19012-1-frank@allwinnertech.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <fba49549-9a78-32ee-a55c-97499f24fe62@sholland.org>
Date:   Tue, 10 Nov 2020 21:44:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201109121214.19012-1-frank@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/20 6:12 AM, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
> 
> The debounce and poll time is generally quite long and the work not
> performance critical so allow the scheduler to run the work anywhere
> rather than in the normal per-CPU workqueue.
> 
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> ---
>  drivers/phy/allwinner/phy-sun4i-usb.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
> index 651d5e2a25ce..4787ad13b255 100644
> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> @@ -326,7 +326,7 @@ static int sun4i_usb_phy_init(struct phy *_phy)
>  		/* Force ISCR and cable state updates */
>  		data->id_det = -1;
>  		data->vbus_det = -1;
> -		queue_delayed_work(system_wq, &data->detect, 0);
> +		queue_delayed_work(system_power_efficient_wq, &data->detect, 0);
>  	}
>  
>  	return 0;
> @@ -444,7 +444,7 @@ static int sun4i_usb_phy_power_on(struct phy *_phy)
>  
>  	/* We must report Vbus high within OTG_TIME_A_WAIT_VRISE msec. */

This doesn't sound like "not performance critical" to me. My understanding is
the debouncing has a deadline from the USB spec. Maybe this is more flexible
than the comment makes it sound?

>  	if (phy->index == 0 && sun4i_usb_phy0_poll(data))
> -		mod_delayed_work(system_wq, &data->detect, DEBOUNCE_TIME);
> +		mod_delayed_work(system_power_efficient_wq, &data->detect, DEBOUNCE_TIME);
>  
>  	return 0;
>  }
> @@ -465,7 +465,7 @@ static int sun4i_usb_phy_power_off(struct phy *_phy)
>  	 * Vbus gpio to not trigger an edge irq on Vbus off, so force a rescan.
>  	 */
>  	if (phy->index == 0 && !sun4i_usb_phy0_poll(data))
> -		mod_delayed_work(system_wq, &data->detect, POLL_TIME);
> +		mod_delayed_work(system_power_efficient_wq, &data->detect, POLL_TIME);
>  
>  	return 0;
>  }
> @@ -504,7 +504,7 @@ static int sun4i_usb_phy_set_mode(struct phy *_phy,
>  
>  	data->id_det = -1; /* Force reprocessing of id */
>  	data->force_session_end = true;
> -	queue_delayed_work(system_wq, &data->detect, 0);
> +	queue_delayed_work(system_power_efficient_wq, &data->detect, 0);
>  
>  	return 0;
>  }
> @@ -616,7 +616,7 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
>  		extcon_set_state_sync(data->extcon, EXTCON_USB, vbus_det);
>  
>  	if (sun4i_usb_phy0_poll(data))
> -		queue_delayed_work(system_wq, &data->detect, POLL_TIME);
> +		queue_delayed_work(system_power_efficient_wq, &data->detect, POLL_TIME);
>  }
>  
>  static irqreturn_t sun4i_usb_phy0_id_vbus_det_irq(int irq, void *dev_id)
> @@ -624,7 +624,7 @@ static irqreturn_t sun4i_usb_phy0_id_vbus_det_irq(int irq, void *dev_id)
>  	struct sun4i_usb_phy_data *data = dev_id;
>  
>  	/* vbus or id changed, let the pins settle and then scan them */
> -	mod_delayed_work(system_wq, &data->detect, DEBOUNCE_TIME);
> +	mod_delayed_work(system_power_efficient_wq, &data->detect, DEBOUNCE_TIME);
>  
>  	return IRQ_HANDLED;
>  }
> @@ -638,7 +638,7 @@ static int sun4i_usb_phy0_vbus_notify(struct notifier_block *nb,
>  
>  	/* Properties on the vbus_power_supply changed, scan vbus_det */
>  	if (val == PSY_EVENT_PROP_CHANGED && psy == data->vbus_power_supply)
> -		mod_delayed_work(system_wq, &data->detect, DEBOUNCE_TIME);
> +		mod_delayed_work(system_power_efficient_wq, &data->detect, DEBOUNCE_TIME);
>  
>  	return NOTIFY_OK;
>  }
> 

