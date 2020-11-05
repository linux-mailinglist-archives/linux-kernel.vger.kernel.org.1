Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3AC2A83BC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730990AbgKEQnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKEQnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:43:16 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B392C0613CF;
        Thu,  5 Nov 2020 08:43:16 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id 7so3578659ejm.0;
        Thu, 05 Nov 2020 08:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MUHzt/aOMzvK34CeKWSITVow97AJX9O5o2+ty65sZIk=;
        b=LzA+1vr63D780w720C5xZvA6vEEXiF1QiiLbCBtFLJ/T69ol+ZbfzE8R6UgitXPesU
         3dbPnImS5XLmMs5e6s5ZzGAwXBTS6z2X5kz817q0fybvy48YHdEtVPoW7758q7DOtLJZ
         vn85gLnkhQS8pgLR41hNwW+2op1ZvgVKNWn/vIukp3BgReSBXDsFgmevewq8WaheRX8L
         6ndc6DVy+qaqHZ4oJpQrOPFgUZowIh5Td4/wfiazY1bEKws2LUWfWjc/3iAdHBh8bvVw
         ma3/H4jWNHZq+tNEjfwhcUJdsfBajTgGXyb2KI/LhjiHLM1GEjmwiLBBOJCY9wbkUA/4
         tuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MUHzt/aOMzvK34CeKWSITVow97AJX9O5o2+ty65sZIk=;
        b=m4G8xTH53Eh8NKC9ooeJNkC0IN3PNuHDWBESv//0Ao4qa8dj+4DW0Ki+xBEaTsoKDc
         X+/YhHBe3F+Sus7ttuvi7lYZdbfAZOehD3+umSX1ozq1ries3O8fEBrad78vhlA8yuZH
         3nQ/spoINlXQxP2iL0qM836axVXkXftUUUA7KVROkxN+zjuOeKz7VsskNKOkUHYZlWxh
         0xkkR8spWZMn9Mtrm+dWtqAFl3wZ95xk9nBRjrSXMZwXguCK5n46lWq9MOtUUZYOnsK/
         QCAdiwGOxeIWWmIJngrHf5818jckIX5IWfMwaT9+q+Y6VohReorsx5g0Dk4Fu3lRJ3pn
         9KEw==
X-Gm-Message-State: AOAM532z4qJ8JRLQQqdzrWALKcnMunnf7BIht2HlNFj9r7jIWt5nlyot
        RIYRtmdwM69sInZsIKiBwM4=
X-Google-Smtp-Source: ABdhPJw9nKZC/lQ95xHQXgLopBGxHmIZY9X3EaQNx6ZcDBIE+Emx0vsEUm6/ERUu1rdLbov8m9SUow==
X-Received: by 2002:a17:906:b292:: with SMTP id q18mr3057756ejz.93.1604594595067;
        Thu, 05 Nov 2020 08:43:15 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id w3sm1218882edt.84.2020.11.05.08.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:43:13 -0800 (PST)
Date:   Thu, 5 Nov 2020 17:43:12 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: reserved-memory: Document "active"
 property
Message-ID: <20201105164312.GD485884@ulmo>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
 <20200914220829.GA330122@bogus>
 <20200915123648.GA3496938@ulmo>
 <20200924112725.GA2486709@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rz+pwK2yUstbofK6"
Content-Disposition: inline
In-Reply-To: <20200924112725.GA2486709@ulmo>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rz+pwK2yUstbofK6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 01:27:25PM +0200, Thierry Reding wrote:
> On Tue, Sep 15, 2020 at 02:36:48PM +0200, Thierry Reding wrote:
> > On Mon, Sep 14, 2020 at 04:08:29PM -0600, Rob Herring wrote:
> > > On Fri, Sep 04, 2020 at 02:59:57PM +0200, Thierry Reding wrote:
> > > > From: Thierry Reding <treding@nvidia.com>
> > > >=20
> > > > Reserved memory regions can be marked as "active" if hardware is
> > > > expected to access the regions during boot and before the operating
> > > > system can take control. One example where this is useful is for the
> > > > operating system to infer whether the region needs to be identity-
> > > > mapped through an IOMMU.
> > >=20
> > > I like simple solutions, but this hardly seems adequate to solve the=
=20
> > > problem of passing IOMMU setup from bootloader/firmware to the OS. Li=
ke=20
> > > what is the IOVA that's supposed to be used if identity mapping is no=
t=20
> > > used?
> >=20
> > The assumption here is that if the region is not active there is no need
> > for the IOVA to be specified because the kernel will allocate memory and
> > assign any IOVA of its choosing.
> >=20
> > Also, note that this is not meant as a way of passing IOMMU setup from
> > the bootloader or firmware to the OS. The purpose of this is to specify
> > that some region of memory is actively being accessed during boot. The
> > particular case that I'm looking at is where the bootloader set up a
> > splash screen and keeps it on during boot. The bootloader has not set up
> > an IOMMU mapping and the identity mapping serves as a way of keeping the
> > accesses by the display hardware working during the transitional period
> > after the IOMMU translations have been enabled by the kernel but before
> > the kernel display driver has had a chance to set up its own IOMMU
> > mappings.
> >=20
> > > If you know enough about the regions to assume identity mapping, then=
=20
> > > can't you know if active or not?
> >=20
> > We could alternatively add some property that describes the region as
> > requiring an identity mapping. But note that we can't make any
> > assumptions here about the usage of these regions because the IOMMU
> > driver simply has no way of knowing what they are being used for.
> >=20
> > Some additional information is required in device tree for the IOMMU
> > driver to be able to make that decision.
>=20
> Rob, can you provide any hints on exactly how you want to move this
> forward? I don't know in what direction you'd like to proceed.

Hi Rob,

do you have any suggestions on how to proceed with this? I'd like to get
this moving again because it's something that's been nagging me for some
months now. It also requires changes across two levels in the bootloader
stack as well as Linux and it takes quite a bit of work to make all the
changes, so before I go and rewrite everything I'd like to get the DT
bindings sorted out first.

So just to summarize why I think this simple solution is good enough: it
tries to solve a very narrow and simple problem. This is not an attempt
at describing the firmware's full IOMMU setup to the kernel. In fact, it
is primarily targetted at cases where the firmware hasn't setup an IOMMU
at all, and we just want to make sure that when the kernel takes over
and does want to enable the IOMMU, that all the regions that are
actively being accessed by non-quiesced hardware (the most typical
example would be a framebuffer scanning out a splat screen or animation,
but it could equally well be some sort of welcoming tone or music being
played back) are described in device tree.

In other words, and this is perhaps better answering your second
question: in addition to describing reserved memory regions, we want to
add a bit of information here about the usage of these memory regions.
Some memory regions may contain information that the kernel may want to
use (such an external memory frequency scaling tables) and those I would
describe as "inactive" memory because it isn't being accessed by
hardware. The framebuffer in this case is the opposite and it is being
actively accessed (hence it is marked "active") by hardware while the
kernel is busy setting everything up so that it can reconfigure that
hardware and take over with its own framebuffer (for the console, for
example). It's also not so much that we know enough about the region to
assume it needs identity mapping. We don't really care about that from
the DT point of view. In fact, depending on the rest of the system
configuration, we may not need identity mapping (i.e. if none of the
users of the reserved memory region are behind an IOMMU). But the point
here is that the IOMMU drivers can use this "active" property to
determine that if a device is using an "active" region and it is behind
an IOMMU, then it must identity map that region in order for the
hardware, which is not under the kernel's control yet, to be able to
continue to access that memory through an IOMMU mapping.

Thanks,
Thierry

--rz+pwK2yUstbofK6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+kK50ACgkQ3SOs138+
s6GeshAAqujd/b1kLpQk6DvCmgw/6tYbgtWCapP2KRJqZFZeWZYElnYi+AWsHY2+
OlIHPL3tQo8vK7xIJnbHp+rWwRCdjqNnGHwO4A1uyBoCDzJbfGPZVbnz9v4o4O6t
IbFbaxLneZ251xxmx3KcyaqYQfdbRMU5/ArctUSRk6VAExQxDwNZadR4hqAKrMBM
yzT3+wW+tGCsRIDAJLeKoOI7NYic+HwMHk91yWuUWI/NNePxq9V++pIQpCNxhr00
ktihG5/k9Wov78J0GLWJAg+CjxPme93T0Py9RuETpDL9Et0LyFwy82G/vkXt6JnI
a9LzA63ZHpKINDIeEd3r9S660PNRV4C1saD6UU7i+zqbhT62S1usav/+b6WJPpVF
rp34hsTY0oz76EsFxmh/rvfhwmrcIxdhOd893jk0HDVzeQc9eanzBfzB7o6Y0I2P
FPFmCjzP3oDeo7AohBO6/iSNmr2h2u14i4iys8wEnfgmeLEtQjCxnRFo7CoDaUZl
TKi84ghNvQ4FavUvgTH5xbR2YChhc6UgdGdIhzIENwTyPAcs/bqP3ncdk7e+UlDU
B4KQUtPrpIVexJqTN/gI+xjNqHII35RzJc1Z4/8ChA2RaX22NAXtEAVyDzUkw0VH
zAo8H7hCRhKrz9Vnl3WCy+27X/klOri8V86Vh4F5yYh5WP9SJhw=
=xlxf
-----END PGP SIGNATURE-----

--rz+pwK2yUstbofK6--
