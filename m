Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6D52AB462
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgKIKFp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Nov 2020 05:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729146AbgKIKFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:05:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BCEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 02:05:45 -0800 (PST)
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kc43P-0003ON-5h; Mon, 09 Nov 2020 11:05:39 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1kc43N-0008T4-Py; Mon, 09 Nov 2020 11:05:37 +0100
Message-ID: <64aa1f860bf60ddac7a2015c87896c8a7b13b161.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] reset: brcmstb rescal: implement {de}assert()
 instead of reset()
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jim Quinlan <james.quinlan@broadcom.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
Date:   Mon, 09 Nov 2020 11:05:37 +0100
In-Reply-To: <20201106191743.40457-2-james.quinlan@broadcom.com>
References: <20201106191743.40457-1-james.quinlan@broadcom.com>
         <20201106191743.40457-2-james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jim,

On Fri, 2020-11-06 at 14:17 -0500, Jim Quinlan wrote:
> Before, only control_reset() was implemented.  However, the reset core only
> invokes control_reset() once in its lifetime.  Because we need it to invoke
> control_reset() again after resume out of S2 or S3, we have switched to
> putting the reset functionality into the control_deassert() method and
> having an empty control_assert() method.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

You are switching to the wrong abstraction to work around a deficiency
of the reset controller framework. Instead, it would be better to allow
to "reactivate" shared pulsed resets so they can be triggered again.

Could you please have a look at [1], which tries to implement this with
a new API call, and check if this can fix your problem? If so, it would
be great if you could coordinate with Amjad to see this fixed in the
core.

[1] https://lore.kernel.org/lkml/20201001132758.12280-1-aouledameur@baylibre.com/

regards
Philipp

> ---
>  drivers/reset/reset-brcmstb-rescal.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/reset/reset-brcmstb-rescal.c b/drivers/reset/reset-brcmstb-rescal.c
> index b6f074d6a65f..1f54ae4f91fe 100644
> --- a/drivers/reset/reset-brcmstb-rescal.c
> +++ b/drivers/reset/reset-brcmstb-rescal.c
> @@ -20,8 +20,8 @@ struct brcm_rescal_reset {
>  	struct reset_controller_dev rcdev;
>  };
>  
> -static int brcm_rescal_reset_set(struct reset_controller_dev *rcdev,
> -				 unsigned long id)
> +static int brcm_rescal_reset_deassert(struct reset_controller_dev *rcdev,
> +				unsigned long id)
>  {
>  	struct brcm_rescal_reset *data =
>  		container_of(rcdev, struct brcm_rescal_reset, rcdev);
> @@ -52,6 +52,12 @@ static int brcm_rescal_reset_set(struct reset_controller_dev *rcdev,
>  	return 0;
>  }
>  
> +static int brcm_rescal_reset_assert(struct reset_controller_dev *rcdev,
> +			      unsigned long id)
> +{
> +	return 0;
> +}
> +
>  static int brcm_rescal_reset_xlate(struct reset_controller_dev *rcdev,
>  				   const struct of_phandle_args *reset_spec)
>  {
> @@ -60,7 +66,8 @@ static int brcm_rescal_reset_xlate(struct reset_controller_dev *rcdev,
>  }
>  
>  static const struct reset_control_ops brcm_rescal_reset_ops = {
> -	.reset = brcm_rescal_reset_set,
> +	.deassert = brcm_rescal_reset_deassert,
> +	.assert = brcm_rescal_reset_assert,
>  };
>  
>  static int brcm_rescal_reset_probe(struct platform_device *pdev)
