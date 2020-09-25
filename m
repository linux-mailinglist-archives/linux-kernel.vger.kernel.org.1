Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A95B4278047
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 08:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgIYGG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 02:06:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgIYGG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 02:06:56 -0400
Received: from saruman (91-155-214-58.elisa-laajakaista.fi [91.155.214.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D9A52176B;
        Fri, 25 Sep 2020 06:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601014015;
        bh=NmXTUfeqEpWKO1bYkARZrODb72CLx/IetDUxlEPr9PM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=gIdtInM1z4FSMnWTkjPtj6j8BHMDMbM3ZIXw+NPtOYI6moXA8AVBxyP8hIVX4vyl8
         NA48EN+qZN/EqJkXZyveg5FYLSWGnijl/HwftO67KcRM/VIkPdZ1wa+nzq50GRJM9R
         pFfVfGb3cKHCiXQ2gfEjLxDDYeQHc4GGQ/2G7XdQ=
From:   Felipe Balbi <balbi@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Wesley Cheng <wcheng@codeaurora.org>, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, jackp@codeaurora.org
Subject: Re: [PATCH v3] usb: dwc3: Stop active transfers before halting the
 controller
In-Reply-To: <20200924155005.GB1337044@rowland.harvard.edu>
References: <20200903210954.24504-1-wcheng@codeaurora.org>
 <87o8mi151l.fsf@kernel.org>
 <010101746fab2ee1-91b46c27-fef0-4266-94cb-14dea5ca350e-000000@us-west-2.amazonses.com>
 <877dsjei8j.fsf@kernel.org> <20200924155005.GB1337044@rowland.harvard.edu>
Date:   Fri, 25 Sep 2020 09:06:47 +0300
Message-ID: <87mu1ecruw.fsf@kernel.org>
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

Alan Stern <stern@rowland.harvard.edu> writes:
>> > Hence, the reason if there was already a pending IRQ triggered, the
>> > dwc3_gadget_disable_irq() won't ensure the IRQ is handled.  We can do
>> > something like:
>> > if (!is_on)
>> > 	dwc3_gadget_disable_irq()
>> > synchronize_irq()
>> > spin_lock_irqsave()
>> > if(!is_on) {
>> > ...
>> >
>> > But the logic to only apply this on the pullup removal case is a little
>> > messy.  Also, from my understanding, the spin_lock_irqsave() will only
>> > disable the local CPU IRQs, but not the interrupt line on the GIC, whi=
ch
>> > means other CPUs can handle it, unless we explicitly set the IRQ
>> > affinity to CPUX.
>>=20
>> Yeah, the way I understand this can't really happen. But I'm open to
>> being educated. Maybe Alan can explain if this is really possibility?
>
> It depends on the details of the hardware, but yes, it is possible in
> general for an interrupt handler to run after you have turned off the
> device's interrupt-request line.  For example:
>
> 	CPU A				CPU B
> 	---------------------------	----------------------
> 	Gets an IRQ from the device
> 	Calls handler routine		spin_lock_irq
> 	  spin_lock_irq			Turns off the IRQ line
> 	  ...spins...			spin_unlock_irq
> 	  Rest of handler runs
> 	  spin_unlock_irq
>
> That's why we have synchronize_irq().  The usual pattern is something
> like this:
>
> 	spin_lock_irq(&priv->lock);
> 	priv->disconnected =3D true;
> 	my_disable_irq(priv);
> 	spin_unlock_irq(&priv->lock);
> 	synchronize_irq(priv->irq);
>
> And of course this has to be done in a context that can sleep.
>
> Does this answer your question?

It does, thank you Alan. It seems like we don't need a call to
disable_irq(), only synchronize_irq() is enough, however it should be
called with spinlocks released, not held.

Thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl9tiPcRHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQZfdxAApnRbGmIOi28zoJvXWSZqilmlahT4YZqL
mejMmx74c1/7NkfXf6WBzLAN3tz+vkJ8Z7phk9CrwXHX/vEzCbcujRWKEzUNXJ2k
zz5CzbO+clwlH2RNFBuwzrw7zODVdYgXmpuaAnFTlQD8/FkWxlf4JMEyF6EYtfhW
7yG+j9wdrSWhwRcfnfUmul7D7FLKrUndvYe6BN13P4cHD2Rlvkh5GLiCUrHlslnO
X0bWKSCn2bDMcXgYq5l/4WI5DK0+nEs8zYj6vO2wF1OZNKFTthGJICVDln5pM/lJ
qvJ/35y4HPDHeDHN6XnhCkEG5OaxvQ4uMgYCJzCOkpOA3K1xu74lKdDLa9W2UR/2
d0sm0nIdAafmW3F0QlLNVoc6SWbo+4sh7DqD2pN6yvzLsyRvqIHOEZbAK5cp5YiP
ejYzMQTeUGF7COy11CLqu0XR7W+G96ZYk9ky4jA318IYQwaRf5GG8XPCn/WSN76L
EI5RwXuaMDfRWmoq6FIMlYdQ7wvWBtGpjbyLjCHV1d44ZgasaVvmxZfV1WQEqlal
GVAswPw8TXq5US9j1xyetsuHogIskJY+ZrFldpiCp2t+gcYKAedmJclMnPPwRho/
vl740drNX28dE7/Z7El1+J6v1aL0sDgQYB/XFLBvHdPhh1wd1vsdlYVE/h7LFJG8
1pX0r5E8V14=
=5NUt
-----END PGP SIGNATURE-----
--=-=-=--
