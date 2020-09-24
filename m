Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1580D276AFB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgIXHje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:39:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgIXHjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:39:32 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E17E23741;
        Thu, 24 Sep 2020 07:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600933171;
        bh=R432kBynnPAWx1zYI6fWcadPGLQdJzoKo88O+ULd65w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OKqG4xyti3BQymzIm4u4/wIFbYQ03BI80cq0NnxtO2R2xM62xM0ktYpRsbap9h0rX
         MRuNOWO8iAKfq1+iytlj1MH/FBB60Dv55VAlaJ9cWsHERRpg/AsDAidxNKoMoK8uFn
         lI9EQ3o/aizrqfiuwbbw743wuBfwbABFaaiPUWAc=
From:   Felipe Balbi <balbi@kernel.org>
To:     Wesley Cheng <wcheng@codeaurora.org>, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        jackp@codeaurora.org
Subject: Re: [PATCH v3] usb: dwc3: Stop active transfers before halting the
 controller
In-Reply-To: <010101746fab2ee1-91b46c27-fef0-4266-94cb-14dea5ca350e-000000@us-west-2.amazonses.com>
References: <20200903210954.24504-1-wcheng@codeaurora.org>
 <87o8mi151l.fsf@kernel.org>
 <010101746fab2ee1-91b46c27-fef0-4266-94cb-14dea5ca350e-000000@us-west-2.amazonses.com>
Date:   Thu, 24 Sep 2020 10:39:24 +0300
Message-ID: <877dsjei8j.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Wesley Cheng <wcheng@codeaurora.org> writes:
> On 9/6/2020 11:20 PM, Felipe Balbi wrote:
>>=20
>> Hi,
>>=20
>> Wesley Cheng <wcheng@codeaurora.org> writes:
>>> diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
>>> index 59f2e8c31bd1..456aa87e8778 100644
>>> --- a/drivers/usb/dwc3/ep0.c
>>> +++ b/drivers/usb/dwc3/ep0.c
>>> @@ -197,7 +197,7 @@ int dwc3_gadget_ep0_queue(struct usb_ep *ep, struct=
 usb_request *request,
>>>  	int				ret;
>>>=20=20
>>>  	spin_lock_irqsave(&dwc->lock, flags);
>>> -	if (!dep->endpoint.desc) {
>>> +	if (!dep->endpoint.desc || !dwc->pullups_connected) {
>>=20
>> this looks odd. If we don't have pullups connected, we shouldn't have a
>> descriptor, likewise if we don't have a a description, we haven't been
>> enumerated, therefore we shouldn't have pullups connected.
>>=20
>> What am I missing here?
>>=20
>
> Hi Felipe,
>
> When we
> echo "" > /sys/kernel/config/usb_gadget/g1/UDC
>
> This triggers the usb_gadget_disconnect() routine to execute.
>
> int usb_gadget_disconnect(struct usb_gadget *gadget)
> {
> ...
> 	ret =3D gadget->ops->pullup(gadget, 0);
> 	if (!ret) {
> 		gadget->connected =3D 0;
> 		gadget->udc->driver->disconnect(gadget);
> 	}
>
> So it is possible that we've already disabled the pullup before running
> the disable() callbacks in the function drivers.  The disable()

we used to have usage counts for those, are they gone? I think they're
still there.

> callbacks usually are the ones responsible for calling usb_ep_disable(),
> where we clear the desc field.  This means there is a brief period where
> the pullups_connected =3D 0, but we still have valid ep desc, as it has
> not been disabled yet.

this is a valid point, though

> Also, for function drivers like mass storage, the fsg_disable() routine
> defers the actual usb_ep_disable() call to the fsg_thread, so its not
> always ensured that the disconnect() execution would result in the
> usb_ep_disable() to occur synchronously.

also a good point.

>>> @@ -1926,6 +1926,21 @@ static int dwc3_gadget_set_selfpowered(struct us=
b_gadget *g,
>>>  	return 0;
>>>  }
>>>=20=20
>>> +static void dwc3_stop_active_transfers(struct dwc3 *dwc)
>>> +{
>>> +	u32 epnum;
>>> +
>>> +	for (epnum =3D 2; epnum < DWC3_ENDPOINTS_NUM; epnum++) {
>>=20
>> dwc3 knows the number of endpoints available in the HW. Use dwc->num_eps
>> instead.
>>=20
>
> Sure, will do.
>
>>> @@ -1971,6 +1986,8 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc,=
 int is_on, int suspend)
>>>  	return 0;
>>>  }
>>>=20=20
>>> +static void __dwc3_gadget_stop(struct dwc3 *dwc);
>>> +
>>>  static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>>  {
>>>  	struct dwc3		*dwc =3D gadget_to_dwc(g);
>>> @@ -1994,9 +2011,37 @@ static int dwc3_gadget_pullup(struct usb_gadget =
*g, int is_on)
>>>  		}
>>>  	}
>>>=20=20
>>> +	/*
>>> +	 * Synchronize and disable any further event handling while controller
>>> +	 * is being enabled/disabled.
>>> +	 */
>>> +	disable_irq(dwc->irq_gadget);
>>=20
>> why isn't dwc3_gadget_disable_irq() enough?
>>=20
>>>  	spin_lock_irqsave(&dwc->lock, flags);
>>=20
>> spin_lock_irqsave() will disable interrupts, why disable_irq() above?
>>=20
>
> In the discussion I had with Thinh, the concern was that with the newly
> added code to override the lpos here, if the interrupt routine
> (dwc3_check_event_buf()) runs, then it will reference the lpos for

that's running in hardirq context. All interrupts are disabled while
that runs, there's no risk of race, right?

> copying the event buffer contents to the event cache, and potentially
> process events.  There is no locking in place, so it could be possible
> to have both run in parallel.

Is this academic or have you actually found a situation where this
could, indeed, happen? The spin_lock_irqsave() should be enough to
synchronize dwc3_gadget_pullup() and the interrupt handler.

> Hence, the reason if there was already a pending IRQ triggered, the
> dwc3_gadget_disable_irq() won't ensure the IRQ is handled.  We can do
> something like:
> if (!is_on)
> 	dwc3_gadget_disable_irq()
> synchronize_irq()
> spin_lock_irqsave()
> if(!is_on) {
> ...
>
> But the logic to only apply this on the pullup removal case is a little
> messy.  Also, from my understanding, the spin_lock_irqsave() will only
> disable the local CPU IRQs, but not the interrupt line on the GIC, which
> means other CPUs can handle it, unless we explicitly set the IRQ
> affinity to CPUX.

Yeah, the way I understand this can't really happen. But I'm open to
being educated. Maybe Alan can explain if this is really possibility?

>>> +		dwc3_stop_active_transfers(dwc);
>>> +		__dwc3_gadget_stop(dwc);
>>> +
>>> +		count =3D dwc3_readl(dwc->regs, DWC3_GEVNTCOUNT(0));
>>> +		count &=3D DWC3_GEVNTCOUNT_MASK;
>>> +		if (count > 0) {
>>> +			dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
>>> +			dwc->ev_buf->lpos =3D (dwc->ev_buf->lpos + count) %
>>> +						dwc->ev_buf->length;
>>> +		}
>>=20
>> don't duplicate code. Add a patch before this extracting this into
>> helper and use it for both irq handler and gadget pullup.
>>=20
>
> We actually removed this call in the IRQ handler, as if we ensure that
> the IRQ routine has fully complete and won't trigger anymore, then this
> sequence will handle clearing of the event count.

oh, makes sense :-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9sTSwRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQa/uw/9FTADnsx/hF2bj5BFAkA9SaPxNg2IbHHC
r7rxAlDr+UH6ySE4/T4Zs91mR0YiI8Qrflu+CN9atHclmYFNqNBWBTXc3/Va7kEM
nHd9sad/t0xOKcdzxs/4gBP3almcIA8a1TpNIfkeDkAHDxPXLk3+klTB2XlDzXll
lof3e5LfdWgC6xjSSUbYM1+QRs4R/1z2GPnHkactmnp7ulQwhFoQJZB2Uul7SNCI
ZRusARaY0zcdclKls4xWH7UB6AnWKPIimR3pnrinCQ0PTfqmCINEc4wstAeGjShY
e/OZgtGcWLsPOWiiSdmVMDbdSADMXm1DGvkSZA86P/YVLhpRWykRscuF80Z6r5tk
yVIwbBESddM61bGQ+m4QmdNwZmeBdztun5UMI+kgVEVligO0oOD6z2vkQovqC7o1
2XEMgrsNUXHGonF0PJsiDehx7oe7tMTxUQB4X0CDnrTnRy4ZSiVp3RvSIta6mzNv
UPQclCp2KmEhsEFg9SmOqM3kw1jdNJJh50GMDhjop7CcZ+pLr/8ioZEwn40/zsbE
4uhgXn9EUsj/P+WSiUDMpFyf0rQ2999z5P7/XlxtwekovDOrHOuBPrAF2WcbuB+a
kPzLemnAFDtuASqR+jvjm/N9QUDuRAbJGO2R2dtrJIiTpG1oyThJwIwFNGSNfkwK
O1SFkVsW+rc=
=hzu1
-----END PGP SIGNATURE-----
--=-=-=--
