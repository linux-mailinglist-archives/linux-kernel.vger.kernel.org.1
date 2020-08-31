Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C99025814B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgHaSqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:46:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:39640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgHaSqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:46:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8B083ADD5;
        Mon, 31 Aug 2020 18:46:36 +0000 (UTC)
Message-ID: <6071c2947095db72f5357f30f932dfa66442294a.camel@suse.de>
Subject: Re: [PATCH v2 28/47] staging: vchi: Get rid of vchiq_shim's message
 callback
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        kernel-list@raspberrypi.com, linux-kernel@vger.kernel.org,
        laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        dave.stevenson@raspberrypi.com, naush@raspberrypi.com
Date:   Mon, 31 Aug 2020 20:46:33 +0200
In-Reply-To: <20200828143103.2ljdrxk4py35ecu6@uno.localdomain>
References: <20200629150945.10720-1-nsaenzjulienne@suse.de>
         <20200629150945.10720-29-nsaenzjulienne@suse.de>
         <20200828143103.2ljdrxk4py35ecu6@uno.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo, sorry if I'm a little late with my replies but I'm on vacation. I'll
be back Sept 7th, but wanted to reply since I don't want to stop your work.

On Fri, 2020-08-28 at 16:31 +0200, Jacopo Mondi wrote:
> Hi Nicolas,
> 
>    I'm working on a v2 of the bcm2835-isp support which was sent along
> with UNICAM v4l2 driver and some misc changes you have collected in
> this series. Reference to v1:
> https://lore.kernel.org/linux-media/20200504092611.9798-1-laurent.pinchart@ideasonboard.com/
> 
> On Mon, Jun 29, 2020 at 05:09:26PM +0200, Nicolas Saenz Julienne wrote:
> > As vchiq_shim's callback does nothing aside from pushing messages into
> > the service's queue, let's bypass it and jump directly to the service's
> > callbacks, letting them choose whether to use the message queue.
> 
> I admit this patch caused me some pain, as after a few days chasing
> why the ISP got stuck in importing buffers into the VPU through the vc-sm-cma
> driver I realized that this patch removed a significant part of the
> process..

Sorry for the pain, I made my best to keep the downstream code in mind, and
also to keep the amount of functional changes needed in the services minimal.
That said, getting rid of VCHI is, IMO, a necessary step towards making VCHIQ
upstreamable.

> > It turns out most services don't need to use the message queue, which
> > makes for simpler code in the end.
> > 
> > -
> > -	if (reason == VCHIQ_MESSAGE_AVAILABLE)
> > -		vchiq_msg_queue_push(service->handle, header);
> 
> This one '-.-
> 
> I wonder if this was intentional and it is expected all services now
> handle the message queue (it seems so according to your commit
> message).

Indeed, it was intentional. Upstream services (mmal & audio) don't need it and
IIRC vchiq's ioctl interface has it's own queue implementation. So I figured it
would be best to keep its usage optional.

> Fair enough, I could add in the vc-sma-cma callback a call to
> vchiq_msg_queue_push() but I wonder if it wouldn't be better to do so
> in vchiq_core.c:parse_rx_slots(), just before calling the service's
> callback, so that this has not to be re-implemented in all services.
> 
> What would you suggest ?

Actually, in hindsight my suggestion would be to get rid of the vchiq message
queue altogether[1], keeping VCHIQ as simple as possible is a must if we want
to get it upstream, and since vc-sma-cma is the only queue user there is little
benefit to having a generic implementation. Let the service do it's own custom
queueing and just force all services to release the messages when they see fit.
It'll make for a simpler VCHIQ usage.

> And by the way I see mmal-vchiq.c:service_callback() releasing
> messages but never pushing them to the queue. Is this intended as well ?

Yes, sorry, it's pretty confusing. That call, vchiq_release_message(), has
nothing to do with the queue. It's the call that really gets the core to
release the message from its slot and the only mandatory thing to do after
receiving a message.

All in all VCHIQ isn't documented an pretty cryptic in its design. I don't
claim to be an expert. So feel free to contradict me anytime, I'll be happy to
work out something that fits all of us.

Regards,
Nicolas

[1] Here I mean vchiq_msg_queue_push() & vchiq_msg_hold()

