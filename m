Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314A52DE09B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 10:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732957AbgLRJvG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Dec 2020 04:51:06 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:55185 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726798AbgLRJvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 04:51:05 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-143--Bu7OKf0MZCbR-3VmakcGw-1; Fri, 18 Dec 2020 09:49:26 +0000
X-MC-Unique: -Bu7OKf0MZCbR-3VmakcGw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 18 Dec 2020 09:49:25 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 18 Dec 2020 09:49:25 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>,
        Daniel West <daniel.west.dev@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "christian.gromm@microchip.com" <christian.gromm@microchip.com>,
        "masahiroy@kernel.org" <masahiroy@kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging: most: video: fixed a parentheses coding style
 issue.
Thread-Topic: [PATCH] staging: most: video: fixed a parentheses coding style
 issue.
Thread-Index: AQHW1NDTd/J3KnGAs0yZSrCCE0TdLqn8mvVQ
Date:   Fri, 18 Dec 2020 09:49:25 +0000
Message-ID: <d5993e314b134e038a1e4eeba32833ce@AcuMS.aculab.com>
References: <20201217234501.351725-1-daniel.west.dev@gmail.com>
 <04c331f6bfce57c253cb86208ebd28f6363e04c0.camel@perches.com>
In-Reply-To: <04c331f6bfce57c253cb86208ebd28f6363e04c0.camel@perches.com>
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

From: Joe Perches
> Sent: 17 December 2020 23:58
> 
> On Thu, 2020-12-17 at 15:45 -0800, Daniel West wrote:
> > Fixed a coding style issue.
> 
> It may pass checkpatch without warning, but it's uncommon kernel coding style.

checkpatch probably shouldn't complain about lines that end in (
if they are function definitions.
Even for function calls you would need to reduce the indentation
rather than move the (.
You need the xxx( to be together to help grep patterns.

> 
> > diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
> []
> > @@ -365,8 +365,8 @@ static const struct video_device comp_videodev_template = {
> >
> >
> >  /**************************************************************************/
> >
> >
> > -static struct most_video_dev *get_comp_dev(
> > -	struct most_interface *iface, int channel_idx)
> > +static struct most_video_dev *get_comp_dev
> > +	(struct most_interface *iface, int channel_idx)
> 
> This would be better using any of:
> 
> (most common)
> 
> static struct most_video_dev *get_comp_dev(struct most_interface *iface,
> 					   int channel_idx)
> 
> or (less common)
> 
> static struct most_video_dev *
> get_comp_dev(struct most_interface *iface, int channel_idx)
> 
> or (> 80 columns)
> 
> static struct most_video_dev *get_comp_dev(struct most_interface *iface, int channel_idx)

Or shorten the variable/type names a bit so it all fits.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

