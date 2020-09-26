Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27AB27983D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 12:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgIZKME convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 26 Sep 2020 06:12:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:35208 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgIZKME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 06:12:04 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-64-PSRh-TBCNJOepc9cDIXbnQ-1; Sat, 26 Sep 2020 11:12:00 +0100
X-MC-Unique: PSRh-TBCNJOepc9cDIXbnQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 26 Sep 2020 11:11:59 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 26 Sep 2020 11:11:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Coiby Xu' <coiby.xu@gmail.com>
CC:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:GREYBUS SUBSYSTEM" <greybus-dev@lists.linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>
Subject: RE: [PATCH 3/3] [PATCH] staging: greybus: __u8 is sufficient for
 snd_ctl_elem_type_t and snd_ctl_elem_iface_t
Thread-Topic: [PATCH 3/3] [PATCH] staging: greybus: __u8 is sufficient for
 snd_ctl_elem_type_t and snd_ctl_elem_iface_t
Thread-Index: AQHWklx17fnZOC5vd0GG3zjgQ4eUS6l3nRcQgAG47oCAAV+6oA==
Date:   Sat, 26 Sep 2020 10:11:59 +0000
Message-ID: <cd09e7c7abaa4700bf9a0245d5844c44@AcuMS.aculab.com>
References: <20200924102039.43895-1-coiby.xu@gmail.com>
 <20200924102039.43895-3-coiby.xu@gmail.com>
 <0175c477851243baa8a92177667d6312@AcuMS.aculab.com>
 <20200925141125.vfm5sjnsfvxo2ras@Rk>
In-Reply-To: <20200925141125.vfm5sjnsfvxo2ras@Rk>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Coiby Xu
> Sent: 25 September 2020 15:11
> 
> On Thu, Sep 24, 2020 at 10:54:50AM +0000, David Laight wrote:
> >From: Coiby Xu
> >> Sent: 24 September 2020 11:21
> >> Use __8 to replace int and remove the unnecessary __bitwise type attribute.
> >>
> >> Found by sparse,
> >...
> >> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> >> index 535a7229e1d9..8e71a95644ab 100644
> >> --- a/include/uapi/sound/asound.h
> >> +++ b/include/uapi/sound/asound.h
> >> @@ -950,7 +950,7 @@ struct snd_ctl_card_info {
> >>  	unsigned char components[128];	/* card components / fine identification, delimited with one
> >> space (AC97 etc..) */
> >>  };
> >>
> >> -typedef int __bitwise snd_ctl_elem_type_t;
> >> +typedef __u8 snd_ctl_elem_type_t;
> >>  #define	SNDRV_CTL_ELEM_TYPE_NONE	((__force snd_ctl_elem_type_t) 0) /* invalid */
> >>  #define	SNDRV_CTL_ELEM_TYPE_BOOLEAN	((__force snd_ctl_elem_type_t) 1) /* boolean type */
> >>  #define	SNDRV_CTL_ELEM_TYPE_INTEGER	((__force snd_ctl_elem_type_t) 2) /* integer type */
> >
> >WTF is all that about anyway??
> >What is wrong with:
> >#define	SNDRV_CTL_ELEM_TYPE_NONE	0u /* invalid */
> 
> I'm sorry I don't quite understand you. Are you suggesting SNDRV_CTL_ELEM_TYPE_NONE
> isn't needed in the first place?

No, just remove all the casts from the constants.
Are the types even used anywhere else?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

