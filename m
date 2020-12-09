Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B8D2D43EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 15:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732902AbgLIOHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 09:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732892AbgLIOGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 09:06:52 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79EFC061793
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 06:06:08 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=geraet)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kn06X-0004af-FX; Wed, 09 Dec 2020 15:06:05 +0100
Message-ID: <5856fd28a803a36b36bdb201f2690b837d8b19c2.camel@pengutronix.de>
Subject: Re: [Linux-stm32] [PATCH] remoteproc: stm32: don't print an error
 on probe deferral
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Etienne Carriere <etienne.carriere@st.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Date:   Wed, 09 Dec 2020 15:06:01 +0100
In-Reply-To: <20201209131214.2382-1-arnaud.pouliquen@foss.st.com>
References: <20201209131214.2382-1-arnaud.pouliquen@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnaud,

On Wed, 2020-12-09 at 14:12 +0100, Arnaud Pouliquen wrote:
> From: Etienne Carriere <etienne.carriere@st.com>
> 
> Change stm32 remoteproc driver to not generate an error message
> when device probe operation is deferred for the reset controller.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> ---
>  drivers/remoteproc/stm32_rproc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c
> b/drivers/remoteproc/stm32_rproc.c
> index a180aeae9675..25c916782991 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -614,7 +614,9 @@ static int stm32_rproc_parse_dt(struct
> platform_device *pdev,
>  
>  	ddata->rst = devm_reset_control_get_by_index(dev, 0);
>  	if (IS_ERR(ddata->rst)) {
> -		dev_err(dev, "failed to get mcu reset\n");
> +		if (PTR_ERR(ddata->rst) != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get mcu reset\n");
> +

There is dev_err_probe() now that could be used here instead.
It has the added benefit that it records the reason for the
deferred probe.

>  		return PTR_ERR(ddata->rst);
>  	}
>  

