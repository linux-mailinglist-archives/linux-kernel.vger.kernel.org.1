Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D46A255C64
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 16:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgH1O1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 10:27:24 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:61075 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgH1O1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:27:22 -0400
X-Originating-IP: 93.34.118.233
Received: from uno.localdomain (93-34-118-233.ip49.fastwebnet.it [93.34.118.233])
        (Authenticated sender: jacopo@jmondi.org)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 8FD584000D;
        Fri, 28 Aug 2020 14:27:17 +0000 (UTC)
Date:   Fri, 28 Aug 2020 16:31:03 +0200
From:   Jacopo Mondi <jacopo@jmondi.org>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        kernel-list@raspberrypi.com, linux-kernel@vger.kernel.org,
        laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        dave.stevenson@raspberrypi.com, naush@raspberrypi.com
Subject: Re: [PATCH v2 28/47] staging: vchi: Get rid of vchiq_shim's message
 callback
Message-ID: <20200828143103.2ljdrxk4py35ecu6@uno.localdomain>
References: <20200629150945.10720-1-nsaenzjulienne@suse.de>
 <20200629150945.10720-29-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200629150945.10720-29-nsaenzjulienne@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

   I'm working on a v2 of the bcm2835-isp support which was sent along
with UNICAM v4l2 driver and some misc changes you have collected in
this series. Reference to v1:
https://lore.kernel.org/linux-media/20200504092611.9798-1-laurent.pinchart@ideasonboard.com/

On Mon, Jun 29, 2020 at 05:09:26PM +0200, Nicolas Saenz Julienne wrote:
> As vchiq_shim's callback does nothing aside from pushing messages into
> the service's queue, let's bypass it and jump directly to the service's
> callbacks, letting them choose whether to use the message queue.

I admit this patch caused me some pain, as after a few days chasing
why the ISP got stuck in importing buffers into the VPU through the vc-sm-cma
driver I realized that this patch removed a significant part of the
process..

>
> It turns out most services don't need to use the message queue, which
> makes for simpler code in the end.
>
> -
> -	if (reason == VCHIQ_MESSAGE_AVAILABLE)
> -		vchiq_msg_queue_push(service->handle, header);

This one '-.-

I wonder if this was intentional and it is expected all services now
handle the message queue (it seems so according to your commit
message).

Fair enough, I could add in the vc-sma-cma callback a call to
vchiq_msg_queue_push() but I wonder if it wouldn't be better to do so
in vchiq_core.c:parse_rx_slots(), just before calling the service's
callback, so that this has not to be re-implemented in all services.

What would you suggest ?

And by the way I see mmal-vchiq.c:service_callback() releasing
messages but never pushing them to the queue. Is this intended as well ?

Thanks
  j

