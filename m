Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A32C2D6BD4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 00:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393764AbgLJXWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 18:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392814AbgLJXWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 18:22:13 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B650DC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 15:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=S1gxQFTvi6k6hBnq3zFZ2pgWF8+3YcPVT49ndIuh08c=; b=IXKilbqqZeR5C3oQIM9RUQAbJj
        KNJwHd52kyleqpOSlIWqyWKJYEHe4VG3VBQD4NTAiYZ91nBCezh1aRJ7TMimGoDKT70yxmNqNwMmp
        cXLEFKhMKnPYIg+NMORG3H3DUwtsr2wC8oG7QT7fh6dXb63SZ1bh7esULxRgyNMN14ihKNX3Db/ap
        2lKJImCCorBADW4ce5rreqi3ySU5jGrZt6UVkK1bteU4B5oJVspblxynahsQl7IWvX7dnFx9MS6d0
        tBdVe1dV0qjPQGaPq4tz2LYDam5LD7Inxu19rLUZDdIl93q7RZsZnuuCzXp+SZgzT3N/XnXOE+jxH
        QCUloXRg==;
Received: from [2601:1c0:6280:3f0::1494]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knVFX-0006W2-F8; Thu, 10 Dec 2020 23:21:27 +0000
Subject: Re: [PATCH 1/2] platform: cros_ec: Call interrupt bottom half in ISH
 or RPMSG mode
To:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org
Cc:     linux-kernel@vger.kernel.org
References: <20201210225839.1212462-1-gwendal@chromium.org>
 <20201210225839.1212462-2-gwendal@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <439e5822-76a0-3ecf-7934-bc6f1f2446c6@infradead.org>
Date:   Thu, 10 Dec 2020 15:21:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201210225839.1212462-2-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

Please use correct kernel-doc notation. See below:


On 12/10/20 2:58 PM, Gwendal Grignou wrote:
> Call the same bottom half for all EC protocols (threaded code).
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/platform/chrome/cros_ec.c           | 26 ++++++++++++++++-----
>  drivers/platform/chrome/cros_ec_ishtp.c     |  6 +----
>  drivers/platform/chrome/cros_ec_rpmsg.c     |  6 +----
>  include/linux/platform_data/cros_ec_proto.h |  3 ++-
>  4 files changed, 24 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
> index 6d6ce86a1408a..4ac33491d0d18 100644
> --- a/drivers/platform/chrome/cros_ec.c
> +++ b/drivers/platform/chrome/cros_ec.c
> @@ -31,7 +31,14 @@ static struct cros_ec_platform pd_p = {
>  	.cmd_offset = EC_CMD_PASSTHRU_OFFSET(CROS_EC_DEV_PD_INDEX),
>  };
>  
> -static irqreturn_t ec_irq_handler(int irq, void *data)
> +/**
> + * cros_ec_irq_handler: top half part of the interrupt handler

 * cros_ec_irq_handler - top half part of the interrupt handler

> + * @irq: IRQ id
> + * @data: (ec_dev) Device with events to process.
> + *
> + * Return: Wakeup the bottom half
> + */
> +static irqreturn_t cros_ec_irq_handler(int irq, void *data)
>  {
>  	struct cros_ec_device *ec_dev = data;
>  

> @@ -72,9 +79,15 @@ bool cros_ec_handle_event(struct cros_ec_device *ec_dev)
>  
>  	return ec_has_more_events;
>  }
> -EXPORT_SYMBOL(cros_ec_handle_event);
>  
> -static irqreturn_t ec_irq_thread(int irq, void *data)
> +/**
> + * cros_ec_irq_thread: bottom half part of the interrupt handler

 * cros_ec_irq_thread - bottom half part of the interrupt handler

> + * @irq: IRQ id
> + * @data: (ec_dev) Device with events to process.
> + *
> + * Return: Interrupt handled.
> + */
> +irqreturn_t cros_ec_irq_thread(int irq, void *data)
>  {
>  	struct cros_ec_device *ec_dev = data;
>  	bool ec_has_more_events;




thanks.
-- 
~Randy

