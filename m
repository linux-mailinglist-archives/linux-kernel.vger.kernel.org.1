Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E835D2A64F5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 14:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgKDNVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 08:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgKDNVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 08:21:42 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A866C0613D3;
        Wed,  4 Nov 2020 05:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=L5Sp8yv4XVh4jBgjORaZ7Ijor6kyCTS5Y9KdAFYyr5c=; b=gfV+qyr4NT0Fv18UFUzLTT93G9
        jCSW7cb6DkobyE5UQ4+uEWl1VX4aSZfx3bZrSAwPvLxnGo5NLgwRzyB9tc5fezuR4HVeIwsGoi9k/
        tCG5+aV1mHi2uZ1NBfLsijPe/G8LNh6DFydow3bbQEXzMoYjN7acVHXlb3lf0nIH3ATI=;
Received: from p200300ccff08bb001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff08:bb00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1kaIil-0007wd-R6; Wed, 04 Nov 2020 14:21:04 +0100
Date:   Wed, 4 Nov 2020 14:20:57 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Brad Campbell <brad@fnarfbargle.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>,
        rydberg@bitmath.org, Jean Delvare <jdelvare@suse.com>,
        linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com
Subject: Re: [REGRESSION] hwmon: (applesmc) avoid overlong udelay()
Message-ID: <20201104142057.62493c12@aktux>
In-Reply-To: <68467f1b-cea1-47ea-a4d4-8319214b072a@fnarfbargle.com>
References: <20200930105442.3f642f6c@aktux>
        <20200930164446.GB219887@roeck-us.net>
        <CAK8P3a2CbhJT+B-F+cnX+uiJep9oiLM28n045-ATaVaU41u2hw@mail.gmail.com>
        <20201002002251.28462e64@aktux>
        <7543ef85-727d-96c3-947e-5b18e9e6c44d@roeck-us.net>
        <20201006090226.4275c824@kemnade.info>
        <db042e9b-be41-11b1-7059-3881b1da5c8b@fnarfbargle.com>
        <68467f1b-cea1-47ea-a4d4-8319214b072a@fnarfbargle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Nov 2020 16:56:32 +1100
Brad Campbell <brad@fnarfbargle.com> wrote:

> On 3/11/20 10:56 am, Brad Campbell wrote:
>=20
> >=20
> > I've examined the code in VirtualSMC and I'm not convinced we were not =
waiting on the wrong bits.
> >=20
> > #define SMC_STATUS_AWAITING_DATA=C2=A0 BIT0=C2=A0 ///< Ready to read da=
ta.
> > #define SMC_STATUS_IB_CLOSED=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT1=C2=A0 /=
// A write is pending.
> > #define SMC_STATUS_BUSY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 BIT2=C2=A0 ///< Busy processing a command.
> > #define SMC_STATUS_GOT_COMMAND=C2=A0=C2=A0=C2=A0 BIT3=C2=A0 ///< The la=
st input was a command.
> > #define SMC_STATUS_UKN_0x16=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT4
> > #define SMC_STATUS_KEY_DONE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT5
> > #define SMC_STATUS_READY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 BIT6=C2=A0 // Ready to work
> > #define SMC_STATUS_UKN_0x80=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT7=C2=
=A0 // error
> >=20
> > Any chance you could try this patch? It's ugly, hacked together and cur=
rently fairly undocumented, but if it works I'll figure out how to clean it=
 up (suggestions welcome).
> > It works on my MacbookPro 11,1. =20
>=20
> I had some time so I spent a bit of time refactoring and trying to clarif=
y the magic numbers.
>=20
> I also did some fuzzing of the SMC and figured out where we can loosen th=
e masks.
> This has some debug code in it to identify if any wait loops exceed 1 loo=
p and if the SMC is reporting anything other than a clear "I'm waiting" pri=
or to each command.
>=20
> You might see some of these :
> [   51.316202] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
> [   60.002547] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
> [   60.130754] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
>=20
> I did some heavy tests and found that with the delays at the bottom of th=
e loop about 50% of calls required no delay at all before a read or write a=
nd the other 50% require a single delay.
> I can count on one hand the number of times it's exceeded 1 loop, and the=
 max thus far has been 5 loops.
>=20
That matches my experience. The only delay is at the end of the
command. Critcal seems to be that there is not too much delay in between.

[...]
> If anyone with a Mac having a conventional SMC and seeing issues on 5.9 c=
ould test this it'd be appreciated. I'm not saying this code is "correct", =
but it "works for me".
>=20
Seems to work here.
 dmesg  | grep applesmc

[    1.350782] applesmc: key=3D561 fan=3D1 temp=3D33 index=3D33 acc=3D0 lux=
=3D2 kbd=3D1
[    1.350922] applesmc applesmc.768: hwmon_device_register() is deprecated=
. Please convert the driver to use hwmon_device_register_with_info().
[   17.748504] applesmc: wait_status looping 2: 0x4a, 0x4c, 0x4f
[  212.008952] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
[  213.033930] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
[  213.167908] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e
[  219.087854] applesmc: wait_status looping 2: 0x44, 0x40, 0x4e

Tested it on top of 5.9

Regards,
Andreas
