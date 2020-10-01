Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0672809F6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 00:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733098AbgJAWXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 18:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgJAWXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 18:23:03 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F81C0613D0;
        Thu,  1 Oct 2020 15:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Kn8tHnp+vZax4Wuu7+LneX60PasUo3Kjv9tq5QcwMEY=; b=YpQVidtqRrx+AQb9RAD+BS8R1t
        rFcTca5WTmqnHYSWos0wyWqm0e+fOyJAfZaTdag80FnIdsF4SLh/ksDeUdC8wfXW+jfsr7hAjG0Yu
        zaXyY8lnKArQcdEl2pg71YGYzMgpdAJrogD6gBDMO2/8hmhKBbBXT1IIul0eOSNLf/LY=;
Received: from p200300ccff3321001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff33:2100:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kO6yR-0005YF-R1; Fri, 02 Oct 2020 00:22:54 +0200
Date:   Fri, 2 Oct 2020 00:22:51 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guenter Roeck <linux@roeck-us.net>, rydberg@bitmath.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] hwmon: (applesmc) avoid overlong udelay()
Message-ID: <20201002002251.28462e64@aktux>
In-Reply-To: <CAK8P3a2CbhJT+B-F+cnX+uiJep9oiLM28n045-ATaVaU41u2hw@mail.gmail.com>
References: <20200930105442.3f642f6c@aktux>
        <20200930164446.GB219887@roeck-us.net>
        <CAK8P3a2CbhJT+B-F+cnX+uiJep9oiLM28n045-ATaVaU41u2hw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 22:00:09 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> On Wed, Sep 30, 2020 at 6:44 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Wed, Sep 30, 2020 at 10:54:42AM +0200, Andreas Kemnade wrote: =20
> > > Hi,
> > >
> > > after the $subject patch I get lots of errors like this: =20
> >
> > For reference, this refers to commit fff2d0f701e6 ("hwmon: (applesmc)
> > avoid overlong udelay()").
> > =20
> > > [  120.378614] applesmc: send_byte(0x00, 0x0300) fail: 0x40
> > > [  120.378621] applesmc: LKSB: write data fail
> > > [  120.512782] applesmc: send_byte(0x00, 0x0300) fail: 0x40
> > > [  120.512787] applesmc: LKSB: write data fail
> > >
> > > CPU sticks at low speed and no fan is turning on.
> > > Reverting this patch on top of 5.9-rc6 solves this problem.
> > >
> > > Some information from dmidecode:
> > >
> > > Base Board Information
> > >         Manufacturer: Apple Inc.
> > >         Product Name: Mac-7DF21CB3ED6977E5
> > >         Version: MacBookAir6,2
> > >
> > > Handle 0x0020, DMI type 11, 5 bytes OEM Strings         String 1: App=
le ROM Version.  Model:       =E2=80=A6,
> > > Handle 0x0020, DMI type 11, 5 bytes
> > > OEM Strings
> > >         String 1: Apple ROM Version.  Model:        MBA61.  EFI Versi=
on:  122.0.0
> > >         String 2: .0.0.  Built by:     root@saumon.  Date:         We=
d Jun 10 18:
> > >         String 3: 10:36 PDT 2020.  Revision:     122 (B&I).  ROM Vers=
ion:  F000_B
> > >         String 4: 00.  Build Type:   Official Build, Release.  Compil=
er:     Appl
> > >         String 5: e clang version 3.0 (tags/Apple/clang-211.10.1) (ba=
sed on LLVM
> > >         String 6: 3.0svn).
> > >
> > > Writing to things in /sys/devices/platform/applesmc.768 gives also the
> > > said errors.
> > > But writing 1 to fan1_maunal and 5000 to fan1_output turns the fan on
> > > despite error messages.
> > > =20
> > Not really sure what to do here. I could revert the patch, but then we'=
d gain
> > clang compile failures. Arnd, any idea ? =20
>=20
> It seems that either I made a mistake in the conversion and it sleeps for
> less time than before, or my assumption was wrong that converting a delay=
 to
> a sleep is safe here.
>=20
> The error message indicates that the write fails, not the read, so that
> is what I'd look at first. Right away I can see that the maximum time to
> retry is only half of what it used to be, as we used to wait for
> 0x10, 0x20, 0x40, 0x80, ..., 0x20000 microseconds for a total of
> 0x3fff0 microseconds (262ms), while my patch went with the 131ms
> total delay based on the comment saying "/* wait up to 128 ms for a
> status change. */".
>=20
Yes, that is also what I read from the code. I just thought there must
be something simple, which just needs a short look from another pair of
eyes.

> Since there is sleeping wait, I see no reason the timeout couldn't
> be extended a lot, e.g. to a second, as in
>=20
> #define APPLESMC_MAX_WAIT 0x100000
>=20
> If that doesn't work, I'd try using mdelay() in place of
> usleep_range(), such as
>=20
>            mdelay(DIV_ROUND_UP(us, USEC_PER_MSEC)));
>=20
> This adds back a really nasty latency, but it should avoid the
> compile-time problem.
>=20
> Andreas, can you try those two things? (one at a time,
> not both)

Ok, I tried. None of them works. I rechecked my work and created real
git commits out of them and CONFIG_LOCALVERSION_AUTO is also set so
the usual stupid things are rules out.
In detail:
On top of 5.9-rc6 + *reverted* patch:
diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index fd99c9df8a00..2a9bd7f2b71b 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -45,7 +45,7 @@
 /* wait up to 128 ms for a status change. */
 #define APPLESMC_MIN_WAIT	0x0010
 #define APPLESMC_RETRY_WAIT	0x0100
-#define APPLESMC_MAX_WAIT	0x20000
+#define APPLESMC_MAX_WAIT	0x8000
=20
 #define APPLESMC_READ_CMD	0x10
 #define APPLESMC_WRITE_CMD	0x11
--=20
2.20.1

-> no trouble found, but I have not tested very long, just some
sysfs writes.

On top of 5.9-rc6:
diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index a18887990f4a..3b0108b75a24 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -161,7 +161,7 @@ static int wait_read(void)
 	int us;
=20
 	for (us =3D APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<=3D 1) {
-		usleep_range(us, us * 16);
+		mdelay(DIV_ROUND_UP(us, USEC_PER_MSEC));
 		status =3D inb(APPLESMC_CMD_PORT);
 		/* read: wait for smc to settle */
 		if (status & 0x01)
@@ -187,7 +187,7 @@ static int send_byte(u8 cmd, u16 port)
=20
 	outb(cmd, port);
 	for (us =3D APPLESMC_MIN_WAIT; us < APPLESMC_MAX_WAIT; us <<=3D 1) {
-		usleep_range(us, us * 16);
+		mdelay(DIV_ROUND_UP(us, USEC_PER_MSEC));
 		status =3D inb(APPLESMC_CMD_PORT);
 		/* write: wait for smc to settle */
 		if (status & 0x02)
--=20
2.20.1
-> write errors:

[    2.472801] applesmc: key=3D561 fan=3D1 temp=3D33 index=3D33 acc=3D0 lux=
=3D2 kbd=3D1
[    2.472961] applesmc applesmc.768: hwmon_device_register() is deprecated=
. Please convert the driver to use hwmon_device_register_with_info().
[   18.535659] applesmc: send_byte(0x00, 0x0300) fail: 0x40
[   18.538171] applesmc: LKSB: write data fail
[   45.260307] applesmc: send_byte(0x01, 0x0300) fail: 0x40
[   45.260324] applesmc: FS! : write data fail
[   47.870135] applesmc: send_byte(0x20, 0x0300) fail: 0x40
[   47.870193] applesmc: F0Tg: write data fail

On top of 5.9-rc6:
diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index a18887990f4a..f67a25651d03 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -45,7 +45,7 @@
 /* wait up to 128 ms for a status change. */
 #define APPLESMC_MIN_WAIT	0x0010
 #define APPLESMC_RETRY_WAIT	0x0100
-#define APPLESMC_MAX_WAIT	0x20000
+#define APPLESMC_MAX_WAIT	0x100000
=20
 #define APPLESMC_READ_CMD	0x10
 #define APPLESMC_WRITE_CMD	0x11
--=20
2.20.1

-> write errors:

[    1.428726] applesmc: key=3D561 fan=3D1 temp=3D33 index=3D33 acc=3D0 lux=
=3D2 kbd=3D1
[    1.428869] applesmc applesmc.768: hwmon_device_register() is deprecated=
. Please convert the driver to use hwmon_device_register_with_info().
[   19.672561] applesmc: send_byte(0x00, 0x0300) fail: 0x40
[   19.674641] applesmc: LKSB: write data fail
[   34.266216] applesmc: send_byte(0x01, 0x0300) fail: 0x40
[   34.266277] applesmc: FS! : write data fail
[   37.357023] applesmc: send_byte(0x20, 0x0300) fail: 0x40
[   37.357082] applesmc: F0Tg: write data fail

Accessing things in sysfs took longer, so the increase seems to be in effec=
t.
Conclusion:

head->scratch();
So something requires really exact timings.

Regards,
Andreas
