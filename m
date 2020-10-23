Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6DC296A07
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 09:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375528AbgJWHCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 03:02:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S373766AbgJWHCQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 03:02:16 -0400
Received: from saruman (88-113-213-94.elisa-laajakaista.fi [88.113.213.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F1EA22254;
        Fri, 23 Oct 2020 07:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603436535;
        bh=lzvhj8solcyzZiQrYSitbX0f0SxrRe81UuVGQSTbYM0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CQx2P5Raml8nNiUHJfoXYOpRX5biFmc4Yw/OuYC8alkWrOF2kfgG8MIHCVPxSy7VM
         w40sdMiZ8O3x/w1UzQrKRojM01Yu2AkPg1RSyKBEBI93Edf2naI/kFRHB9NL7rql40
         wwTA1uKXwvexhY1MmjIsbuKWL4vIvk9f0GXS1jSw=
From:   Felipe Balbi <balbi@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Yu Chen <chenyu56@huawei.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Yang Fei <fei.yang@intel.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: Trigger a GCTL soft reset when switching
 modes in DRD
In-Reply-To: <CALAqxLXxG1oHvUhBtu9doc78EwFo2kj=vfk_GDaR760ae+0YBQ@mail.gmail.com>
References: <20201021224619.20796-1-john.stultz@linaro.org>
 <87y2jyelv6.fsf@kernel.org>
 <CALAqxLXxG1oHvUhBtu9doc78EwFo2kj=vfk_GDaR760ae+0YBQ@mail.gmail.com>
Date:   Fri, 23 Oct 2020 10:02:06 +0300
Message-ID: <87o8kte87l.fsf@kernel.org>
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

John Stultz <john.stultz@linaro.org> writes:
> On Thu, Oct 22, 2020 at 12:55 AM Felipe Balbi <balbi@kernel.org> wrote:
>> John Stultz <john.stultz@linaro.org> writes:
>> > From: Yu Chen <chenyu56@huawei.com>
>> >
>> > With the current dwc3 code on the HiKey960 we often see the
>> > COREIDLE flag get stuck off in __dwc3_gadget_start(), which
>> > seems to prevent the reset irq and causes the USB gadget to
>> > fail to initialize.
>> >
>> > We had seen occasional initialization failures with older
>> > kernels but with recent 5.x era kernels it seemed to be becoming
>> > much more common, so I dug back through some older trees and
>> > realized I dropped this quirk from Yu Chen during upstreaming
>> > as I couldn't provide a proper rational for it and it didn't
>> > seem to be necessary. I now realize I was wrong.
>>
>> This keeps coming back every few years. It has never been necessary so
>> far. Why is it necessary now?
>
> Sorry, I'm not totally sure I've got all the context here. If you mean
> with regards to the HiKey960, it's because the HiKey960 had a somewhat

it's a general DWC3 thing. The databook claims that a soft reset is
necessary, but it turns out it isn't :-)

> complicated vendor patch stack that others and I had been carrying
> along and trying to upstream slowly over the last few years.  Since
> that process of upstreaming required lots of rework, the patch set
> changed over time fixing a number of issues and in this case (by
> dropping the quirk) introducing others.
>
> The usb functionality on the board was never perfect.  As I said in
> the patch, we saw initialization issues *very* rarely with older
> kernels - which I suspected was due to the oddball mux/hub driver that
> had to be deeply reworked - so the issue was easy to overlook, except
> the frequency of it had grown to be quite noticeable. So now that all
> but the dts bits are upstream, I've been trying to spend occasional
> free cycles figuring out what's wrong.
>
> That's when I figured out it was the quirk fix I dropped.  But the
> good news is so far with it I've not hit any initialization issues
> (over a few hundred reboots).

That's good :-)

>> The only thing we need to do is verify
>> which registers are shadowed between host and peripheral roles and cache
>> only those registers.
>
> Sorry, could you explain this a bit more? Again, I don't have access
> to the hardware docs, so I'm just working with the source and any
> vendor patches I can find.

Right, initialize it in gadget mode, then take a register dump (I think
our regdump facility in dwc3's debugfs is enough). Then flip to host
mode and take the same register dump. Now diff them. You'll see that
some registers get overwritten. The reason for that is that physically
some host and peripheral registers map to the same block of memory in
the IP. In other words, the address decoder in the Register File decodes
some addresses to the same physical block of memory. This was done, I
believe, to save die area by reducing gate count.

>> A full soft reset will take a while and is likely to create other
>> issues.
>
> I'm also fine with going back to the quirk approach if you think that
> would be lower risk to other devices?

I think the soft reset can have unexpected side effects here.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl+Sf+4RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQbmUA/8D10XDzKeM2fNMkLzE4w19j17W6wPzLUh
WxjyYjrKWiv6+bompUykl5a41XaEUxN0vWUFBqyxiFeOHmrAS+yAcD6SqW/8VWrE
MlgHpuAiCdJuEd/wwFMsKQZLdnnySMWlXZYhuuLy0FjG1CJEBcYjm/QHhWlktKD+
1ufTIUV0YrUzW2QYSZzBUfBo23Z1XvQ/Oy59s6iIKEuWo8K21dOPTNXalmlYw8iY
cmNZ+yxQuP2YEEfxsf7qBs2vTyv6dtT0AAqEa3O2yHSEx7+K/lMW+HFPAHrYCjwc
COB17gaSLOzc6BoDTdnjX30fqPSynuaPy8Uj/4trJp/d+AwMuEhDtDbK60I+krEL
yW6o/WBjrJI+L5h67tuq9du0GYJc+RGm0kd/9c+hfmNAeY+Q/aFabPj5yTHLMwmz
V5pLx9jDFLwZEZBG1YIRFEK7Mx/BwFhAkPAHSI3zBG9WoSf6ZFvBtpB+j745L0jC
xRTASUDyzltT3Gay8I9v7TOBLdgvGfraB48kgknJAgTOkMFbnUll6L7Tbf5wLMAZ
oSl18zg8IVvonDA3LbP10ZD3MTsDeGBM0GCR9vu8DainbtpkzqkrhnIqxZ4q+ssf
/adKC8cn4LrWyPNdckFMOAqrTjk1t1n0LaBeKhX7HpijuglHAuEME+GMo5PY5sF3
5ijnFTDRevo=
=f52/
-----END PGP SIGNATURE-----
--=-=-=--
