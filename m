Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E523229DF45
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbgJ2BAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731540AbgJ1WR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:28 -0400
Received: from saruman (88-113-213-94.elisa-laajakaista.fi [88.113.213.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20CD124686;
        Wed, 28 Oct 2020 09:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603876426;
        bh=UqKkjkU3C8hjvC1W+LqFgUbMLuvOs2IpZy0kfqzvfg8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SiqDCILD6wNTBvBAUFBGvQkVhqRg0wHVOhKgBhkS60qwShkLk8DFMALEblRSpnbIB
         EIMNR2fIr0KDGQMRSDqL0H0lp93uxTLXT6T06snFWHAO6V3vHmPO7jE1ac9Bn0pNZG
         FGjdn/lQj0YHUHSMEnp1oumNbtzNms+iXXqFlUqQ=
From:   Felipe Balbi <balbi@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 31/56] usb: dwc3: fix kernel-doc markups
In-Reply-To: <20201028090813.GB1947336@kroah.com>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <0b964be3884def04fcd20ea5c12cb90d0014871c.1603469755.git.mchehab+huawei@kernel.org>
 <87ft60dujc.fsf@kernel.org> <20201028090813.GB1947336@kroah.com>
Date:   Wed, 28 Oct 2020 11:13:34 +0200
Message-ID: <874kmen269.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, Oct 27, 2020 at 08:58:47AM +0200, Felipe Balbi wrote:
>>=20
>> Hi Mauro,
>>=20
>> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>> > There is a common comment marked, instead, with kernel-doc
>> > notation.
>> >
>> > Also, some identifiers have different names between their
>> > prototypes and the kernel-doc markup.
>> >
>> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> > ---
>> >  drivers/usb/dwc3/core.c        | 2 +-
>> >  drivers/usb/dwc3/core.h        | 2 +-
>> >  drivers/usb/gadget/composite.c | 2 +-
>> >  drivers/usb/typec/mux.c        | 2 +-
>> >  include/linux/usb/composite.h  | 2 +-
>>=20
>> mind breaking this into 4 commits? One for dwc3, one for
>> gadget/composite, one for type/mux, and a final for composite.h.
>
> I'll just take these all at once, it's easy enough :)

Sure thing, in that case:

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJFBAEBCAAvFiEElLzh7wn96CXwjh2IzL64meEamQYFAl+ZNj4RHGJhbGJpQGtl
cm5lbC5vcmcACgkQzL64meEamQagOA//eyKwQho8ZS03MJ9gkVjfW8k7drtTAvLv
tlCrKvWoTAD5NkAiTlbrtzZTxY8SHgYMiBItwXv9kKPpC5cLjoH7MbjDzWzQToSp
YkqvksbI5s4RO/+Twl0qly1Nlp2l2pwMh/6iO3sh4rdonqCEg4ByRL2K4D1ALvG4
i06dddOYUym21CX9d8FV6yebrKibdHfr8SAX51NhdyvVaGY2BzUF6qisRygtMzkf
Ry4xkZRYsSBh6L/uGsLYQxtrvoKx5fsLKZHR6Zj8XsGYHA/gAMQ/SNOnl67klBLe
ZriMVILmxRu4kOR8i9TOi7xLrDOkLBczrNCl3ZNaSHpmB86yFprOQVs7USjHjnjl
0rCJYgmgK0zywCZC3FHH7tUL5WcWMR15hp40p56IkjalFd+cleXV1xjIu4kEuorX
vj994var0ZVUariLvM6KuLn7T7pnFAEkhFhcoFDsdOkNHzI6wpBcijFLeKubthlv
8dW3GQquRrOK6/ESE1CQAA6dAIls+QJmaWsMpWlf0Mos+6wZFZwbUjtLA9nFFY7Q
1T0mYQVEgDZEvJIc8muWb8LS10nkQIiiVdRu+GfAqC+Efz+ysDhsqMtkelNHklx+
NfnPcRbJfCngrrvHocL/4xteaDFPRaR2KegjmmIwaaEB4gl/72ZOCwD7A8habtN5
TNXX4XBAyE8=
=x6JJ
-----END PGP SIGNATURE-----
--=-=-=--
