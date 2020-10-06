Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F0F2846BA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 09:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgJFHCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 03:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgJFHCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 03:02:51 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7E3C061755;
        Tue,  6 Oct 2020 00:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=adrY46/H5ldFRjts4EPwmHDoTunggJgvwwqJ+GThmd0=; b=EKc4TPKNowUrkfmhJOEFktI56
        P3kCXKmT66YIOCDrfgOwSTlDM9g4VVdP6aUhHaYRCiLNIRam5yqZI9ochxpp2o1eMsjZs9Tmdo1TD
        IuH6Vd1OOLsgYCtEFPQhaDck/N3qPB98sX+S8+HmSwhrlm+7akJV5lJhbtgLSy/LrvKbI=;
Received: from [2a02:790:ff:919:e2ce:c3ff:fe93:fc31] (helo=localhost)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kPgzg-0001Er-1d; Tue, 06 Oct 2020 09:02:43 +0200
Received: from localhost.lan ([::1] helo=localhost)
        by localhost with esmtp (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1kPgzc-0002Lk-Gy; Tue, 06 Oct 2020 09:02:36 +0200
Date:   Tue, 6 Oct 2020 09:02:26 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, rydberg@bitmath.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com
Subject: Re: [REGRESSION] hwmon: (applesmc) avoid overlong udelay()
Message-ID: <20201006090226.4275c824@kemnade.info>
In-Reply-To: <7543ef85-727d-96c3-947e-5b18e9e6c44d@roeck-us.net>
References: <20200930105442.3f642f6c@aktux>
        <20200930164446.GB219887@roeck-us.net>
        <CAK8P3a2CbhJT+B-F+cnX+uiJep9oiLM28n045-ATaVaU41u2hw@mail.gmail.com>
        <20201002002251.28462e64@aktux>
        <7543ef85-727d-96c3-947e-5b18e9e6c44d@roeck-us.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wnaJC=MAqSjbZrPP_wOohnU"; protocol="application/pgp-signature"
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wnaJC=MAqSjbZrPP_wOohnU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, 1 Oct 2020 21:07:51 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 10/1/20 3:22 PM, Andreas Kemnade wrote:
> > On Wed, 30 Sep 2020 22:00:09 +0200
> > Arnd Bergmann <arnd@arndb.de> wrote:
> >  =20
> >> On Wed, Sep 30, 2020 at 6:44 PM Guenter Roeck <linux@roeck-us.net> wro=
te: =20
> >>>
> >>> On Wed, Sep 30, 2020 at 10:54:42AM +0200, Andreas Kemnade wrote:   =20
> >>>> Hi,
> >>>>
> >>>> after the $subject patch I get lots of errors like this:   =20
> >>>
> >>> For reference, this refers to commit fff2d0f701e6 ("hwmon: (applesmc)
> >>> avoid overlong udelay()").
> >>>   =20
> >>>> [  120.378614] applesmc: send_byte(0x00, 0x0300) fail: 0x40
> >>>> [  120.378621] applesmc: LKSB: write data fail
> >>>> [  120.512782] applesmc: send_byte(0x00, 0x0300) fail: 0x40
> >>>> [  120.512787] applesmc: LKSB: write data fail
> >>>>
> >>>> CPU sticks at low speed and no fan is turning on.
> >>>> Reverting this patch on top of 5.9-rc6 solves this problem.
> >>>>
> >>>> Some information from dmidecode:
> >>>>
> >>>> Base Board Information
> >>>>         Manufacturer: Apple Inc.
> >>>>         Product Name: Mac-7DF21CB3ED6977E5
> >>>>         Version: MacBookAir6,2
> >>>>
> >>>> Handle 0x0020, DMI type 11, 5 bytes OEM Strings         String 1: Ap=
ple ROM Version.  Model:       =E2=80=A6,
> >>>> Handle 0x0020, DMI type 11, 5 bytes
> >>>> OEM Strings
> >>>>         String 1: Apple ROM Version.  Model:        MBA61.  EFI Vers=
ion:  122.0.0
> >>>>         String 2: .0.0.  Built by:     root@saumon.  Date:         W=
ed Jun 10 18:
> >>>>         String 3: 10:36 PDT 2020.  Revision:     122 (B&I).  ROM Ver=
sion:  F000_B
> >>>>         String 4: 00.  Build Type:   Official Build, Release.  Compi=
ler:     Appl
> >>>>         String 5: e clang version 3.0 (tags/Apple/clang-211.10.1) (b=
ased on LLVM
> >>>>         String 6: 3.0svn).
> >>>>
> >>>> Writing to things in /sys/devices/platform/applesmc.768 gives also t=
he
> >>>> said errors.
> >>>> But writing 1 to fan1_maunal and 5000 to fan1_output turns the fan on
> >>>> despite error messages.
> >>>>   =20
> >>> Not really sure what to do here. I could revert the patch, but then w=
e'd gain
> >>> clang compile failures. Arnd, any idea ?   =20
> >>
> >> It seems that either I made a mistake in the conversion and it sleeps =
for
> >> less time than before, or my assumption was wrong that converting a de=
lay to
> >> a sleep is safe here.
> >>
> >> The error message indicates that the write fails, not the read, so that
> >> is what I'd look at first. Right away I can see that the maximum time =
to
> >> retry is only half of what it used to be, as we used to wait for
> >> 0x10, 0x20, 0x40, 0x80, ..., 0x20000 microseconds for a total of
> >> 0x3fff0 microseconds (262ms), while my patch went with the 131ms
> >> total delay based on the comment saying "/* wait up to 128 ms for a
> >> status change. */".
> >> =20
> > Yes, that is also what I read from the code. I just thought there must
> > be something simple, which just needs a short look from another pair of
> > eyes.
> >  =20
> >> Since there is sleeping wait, I see no reason the timeout couldn't
> >> be extended a lot, e.g. to a second, as in
> >>
> >> #define APPLESMC_MAX_WAIT 0x100000
> >>
> >> If that doesn't work, I'd try using mdelay() in place of
> >> usleep_range(), such as
> >>
> >>            mdelay(DIV_ROUND_UP(us, USEC_PER_MSEC)));
> >>
> >> This adds back a really nasty latency, but it should avoid the
> >> compile-time problem.
> >>
> >> Andreas, can you try those two things? (one at a time,
> >> not both) =20
> >=20
> > Ok, I tried. None of them works. I rechecked my work and created real
> > git commits out of them and CONFIG_LOCALVERSION_AUTO is also set so
> > the usual stupid things are rules out.
> > In detail:
> > On top of 5.9-rc6 + *reverted* patch:
> > diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
> > index fd99c9df8a00..2a9bd7f2b71b 100644
> > --- a/drivers/hwmon/applesmc.c
> > +++ b/drivers/hwmon/applesmc.c
> > @@ -45,7 +45,7 @@
> >  /* wait up to 128 ms for a status change. */
> >  #define APPLESMC_MIN_WAIT	0x0010
> >  #define APPLESMC_RETRY_WAIT	0x0100
> > -#define APPLESMC_MAX_WAIT	0x20000
> > +#define APPLESMC_MAX_WAIT	0x8000
> > =20
> >  #define APPLESMC_READ_CMD	0x10
> >  #define APPLESMC_WRITE_CMD	0x11
> >  =20
>=20
> Oh man, that code is so badlys broken.
>=20
> send_byte() repeats sending the data if it was not immediately successful.
> That is done for both data and commands. Effectively that happens if
> the command is not immediately accepted. However, send_argument()
> clearly assumes that each data byte is sent exactly once. Sending
> it more than once will mess up the key that is supposed to be sent.
> The Apple SMC emulation code in qemu confirms that data bytes can not
> be written more than once.
>=20
> Of course, theoretically it may be that the first data byte was not
> accepted (after all, the ACK bit is not set), but the ACK bit is
> not checked again after udelay(APPLESMC_RETRY_WAIT), so it may
> well have been set in the 256 uS between its check and re-writing
> the data.
>=20
> In other words, this entire code only works accidentally to start with.
>=20
> If you like, you could play around with the code and find out if and
> when exactly bit 1 (busy) is set, if and when bit 2 (ack) is set, and
> if and when any other bit is set. We could also try to read port 0x31e
> (the error port). Maybe the we can figure out what the error actually
> is. But then I don't really know what we could do with that information.
>=20
Smoe research results: the second data byte seems to cause problems, not the
command byte.

> Other than that, the only useful idea I have is something crazy like
> 	if (us < 10000)
> 		udelay(us);
> 	else
> 		mdelay(DIV_ROUND_CLOSEST(udelay, 1000));
> in the hope that clang doesn't convert that back into a
> compile-time constant and udelay().
>=20
> Overall it seems like the apple protocol may expect to receive data
> bytes faster than 1ms apart, because that is the only real difference
> between the original code and the new code using mdelay().

Yes, that explanation makes sense. If I am trying something like that, only
the last byte requires more than APPLESMC_MIN_WAIT. I have seen max. 256us.
So we could probably even use msleep for us > 1000 and udelay for anything =
below.

Regards,
Andreas

--Sig_/wnaJC=MAqSjbZrPP_wOohnU
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl98FoIACgkQl4jFM1s/
ye8+KA//YGYtFolaG50snSVDEAfyJQWjKgmrlyPbjQ+t/TItOYe7r8R45gsKKzKg
g5dduys+4ChzbL4lqociSE8cEGcx5GZgdfFH8npFE+rEPzRcgO1i0IpQaA1jR5rH
2des6u3jaFtkOG46Wm/1hDBIlZ+difL5xrqdneFdDm+fdp7kv+vmXVqFcLJeCbMW
r/7Rgcn1ev0eIfGF9k0DmkAkmaf57SFKh33X0sIpqYye70lVAgK1dyyNHBf/7fsG
RyrZ/Bi8yxEsjHxAwpcwXoBk5pJeZVWj0AS4rbXGS2eM8CjdUbXiYHgABIP7c6WH
hFMP4LcHJmc81xHNc5sycCEHS3rJmtaCmXrVKxEoKlbrSWA56hYYamOT1abNZHkr
ReuIvKB39i2/u9aUUib7oguTkw/n431Xc1ke/t+xGsJUKTM1FQToEZ3SV0Oz8ltp
C/k0T3FoMXX+ngHdIRg/qhYkrRl3XgzRUMFwnL58DvaQzrBLsdHqrTXsFi1F6gwB
FHPDcc9/b+uiIRd9d/gXLyzekYqSjO/oHpfcm9GidPUPoj/Bt0hcqIW04L/ZMAQe
UcVCZi9D7xFn5hcU9Us0axuxKLSNY6IgYeS2e+clxAD+/ahA8RbRTUB9K0uW4oDq
PW7AG0lhuBHiuAqjiVQaH9arC+JUZNQDl+7hqA0hb4FuXLQZD8A=
=U87M
-----END PGP SIGNATURE-----

--Sig_/wnaJC=MAqSjbZrPP_wOohnU--
