Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E7C2ED3E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbhAGQEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:04:36 -0500
Received: from mail-40131.protonmail.ch ([185.70.40.131]:55835 "EHLO
        mail-40131.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbhAGQEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:04:35 -0500
Date:   Thu, 07 Jan 2021 16:03:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1610035434;
        bh=NjLJYtrwGi8fl20fDTPPgaGJm/yzsWtQLjMz/qlJmLk=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=YSQTm42DGqX8ZPXsVtyGVhjqPm5q6vCLEN4Sx7EiO87N1onFud9/81022/13EsdnF
         k2mNEwH75SbWPm4WmpU881Bh1bhkZsZjuiyb/Fi/cvECB2h++QvBkqz8cKVXiY8OrJ
         t7TOyibNkOhB6qtBsgpho1hDLZw3kB2JvV8sXEU0=
To:     Hans de Goede <hdegoede@redhat.com>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     Perry Yuan <Perry.Yuan@dell.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Limonciello Mario <Mario.Limonciello@dell.com>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH v2 1/2] platform/x86: dell-privacy: Add support for Dell hardware privacy
Message-ID: <kt8PP3Pj3sI0-gL28bw5rPCvcv3S8STD0pMFoQUrixarFRv_36In5dPDtrOtSSJk2WhEo4FN9duHO_pNG8kDDPng06mDOX9UvmXeaPNI6sE=@protonmail.com>
In-Reply-To: <d1d31281-d5c8-ea09-9e2d-1c5acb35deef@redhat.com>
References: <20201228132855.17544-1-Perry_Yuan@Dell.com> <d1d31281-d5c8-ea09-9e2d-1c5acb35deef@redhat.com>
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

Hi


2021. janu=C3=A1r 7., cs=C3=BCt=C3=B6rt=C3=B6k 0:43 keltez=C3=A9ssel, Hans =
de Goede =C3=ADrta:

> Hi Perry,
>
> On 12/28/20 2:28 PM, Perry Yuan wrote:
>
> > From: Perry Yuan perry_yuan@dell.com
> > add support for dell privacy driver for the dell units equipped
> > hardware privacy design, which protect users privacy
> > of audio and camera from hardware level. once the audio or camera
> > privacy mode enabled, any applications will not get any audio or
> > video stream.
> > when user pressed ctrl+F4 hotkey, audio privacy mode will be
> > enabled,Micmute led will be also changed accordingly.
> > The micmute led is fully controlled by hardware & EC.
> > and camera mute hotkey is ctrl+F9.currently design only emmit
> > SW_CAMERA_LENS_COVER event while the camera LENS shutter will be
> > changed by EC & HW control.
> > *The flow is like this:
> >
> > 1.  User presses key. HW does stuff with this key (timeout is started)
> > 2.  Event is emitted from FW
> > 3.  Event received by dell-privacy
> > 4.  KEY_MICMUTE emitted from dell-privacy
> > 5.  Userland picks up key and modifies kcontrol for SW mute
> > 6.  Codec kernel driver catches and calls ledtrig_audio_set, like this:
> >     ledtrig_audio_set(LED_AUDIO_MICMUTE,
> >     rt715->micmute_led ? LED_ON :LED_OFF);
> >
> > 7.  If "LED" is set to on dell-privacy notifies ec,
> >     and timeout is cancelled,HW mic mute activated.
> >
> >
> > Signed-off-by: Perry Yuan perry_yuan@dell.com
> > Signed-off-by: Limonciello Mario mario_limonciello@dell.com
>
> Thank you for your patch, please send a new version addressing
> Barnab=C3=A1s' review comment and including the second patch of the
> series.
> [...]

I think first something needs to be figured out regarding
the integration with the rest of the Dell modules. I feel
that list is not a desirable way to do it.


Regards,
Barnab=C3=A1s P=C5=91cze
