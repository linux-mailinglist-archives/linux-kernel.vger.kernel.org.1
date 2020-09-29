Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B03727C1CE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 12:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgI2KAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 06:00:12 -0400
Received: from mail-41103.protonmail.ch ([185.70.41.103]:26374 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI2KAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 06:00:09 -0400
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com [51.89.119.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 8C92F200A0CF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:00:07 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="KK+owFak"
Date:   Tue, 29 Sep 2020 09:59:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1601373603;
        bh=WA0yMmzyA19KdGBc4XfL7+euocv+YVM4+4ufHMI+Rww=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=KK+owFakOjcmI2opGzX3SWkF8gsHgYUFDPVoXKphMPe5vQORUPGbYnm2On92zgxLd
         h5gckuGoRMB4XTuPLXcHD0IVU23xnnznnIDtjBDEVi7+ZL1k37B5C5bzjQiv3koDCb
         XMP7hmWy3LPCgI5vZgU8ETBN6j8FUahKwvXhf2TQ=
To:     Takashi Iwai <tiwai@suse.de>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: Keyboard regression by intel-vbtn
Message-ID: <-ICwwoAndae7T9i-Ymr7Nx9jnXVd7H54dnkMmCWUcApM1S0FUPplPWhg8DVXkphN0L4DoTy24robhTiBzMmSBKZRl-P8VEXIX5r6ttceA_8=@protonmail.com>
In-Reply-To: <s5h8sctkk2b.wl-tiwai@suse.de>
References: <s5hft71klxl.wl-tiwai@suse.de> <bedb9d1b-3cca-43e2-ee44-1aac0e09a605@redhat.com> <s5h8sctkk2b.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2020. szeptember 29., kedd 11:29 keltez=C3=A9ssel, Takashi Iwai =C3=ADrta:

> On Tue, 29 Sep 2020 11:21:27 +0200,
> Hans de Goede wrote:
>
> > Hi,
> > On 9/29/20 10:48 AM, Takashi Iwai wrote:
> >
> > > Hi Hans,
> > > it seems that the recent update of intel-vtn broke the keyboard input
> > > on some laptops with libinput:
> > > https://bugzilla.opensuse.org/show_bug.cgi?id=3D1175599
> > > Blacklisting intel-vtn fixes the issue, so it's likely the falsely
> > > reported tablet mode switch that leads libinput misbehaving. The
> > > affected machines are Acer E5-511 and ASUS X756UX laptops, and they
> > > shouldn't have the tablet mode at all, AFAIK.
> > > Could you take a look? I guess it's the commit cfae58ed681c that
> > > broke. The chassis type is Notebook on those, and this type should be
> > > excluded as well as Laptop.
> > > The dmidecode outputs and other info are found in the bugzilla above:
> > > https://bugzilla.opensuse.org/attachment.cgi?id=3D841999
> > > https://bugzilla.opensuse.org/attachment.cgi?id=3D842039
> > > The one for ASUS is embedded in hwinfo outpt:
> > > https://bugzilla.opensuse.org/attachment.cgi?id=3D841157
> >
> > Ugh. What a mess, sorry about this.
> > So as the commit message from commit cfae58ed681c
> > ("platform/x86: intel-vbtn: Only blacklist SW_TABLET_MODE on the 9 / "L=
aptop" chasis-type")
> > explains the reason to NOT NOT report SW_TABLET_MODE on devices
> > with a chassis type of 10 ("Notebook") is that at least
> > some HP ... 360 ... models use that chassis type and do
> > report a correct SW_TABLET_MODE through the intel-vbtn driver.
> > The SW_TABLET_MODE on these actually got regressed by
> > de9647efeaa9 ("platform/x86: intel-vbtn: Only activate tablet mode swit=
ch on 2-in-1's")
> > which first introduced the chassis-type check.
> > And to complicate things further even though some
> > HP ... 360 ... models use that chassis type and from the DSDT
> > it seems that they do report a correct SW_TABLET_MODE through the
> > intel-vbtn driver. In practice it is also broken on some
> > HP ... 360 ... models, see:
> > https://forum.manjaro.org/t/keyboard-and-touchpad-only-work-on-kernel-5=
-6/22668
> > http://git.infradead.org/linux-platform-drivers-x86.git/commit/d8233468=
76a970522ff9e4d2b323c9b734dcc4de
> > "platform/x86: intel-vbtn: Fix SW_TABLET_MODE always reporting 1 on the=
 HP Pavilion 11 x360"
>
> Oohoo, what a wonderful world :)
>


Splendid world, indeed. I'm wondering, however, why the incorrect state
is reported? Is it similar to the linked issue on the Manjaro forum, where =
a
different bit is seemingly used to report the tablet mode state, or somethi=
ng else?
I'm also wondering why it was chosen that a *set* bit means that the tablet
mode is *off*. All these problems could've been easily avoided... (given th=
at
I'm not missing anything obvious).

> [...]


Regards,
Barnab=C3=A1s P=C5=91cze
