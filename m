Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9082A368E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 23:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgKBWav convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Nov 2020 17:30:51 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:42979 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725785AbgKBWau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 17:30:50 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-3-j6bXPPu-Nl6LRhxQXu1CQQ-1; Mon, 02 Nov 2020 22:30:46 +0000
X-MC-Unique: j6bXPPu-Nl6LRhxQXu1CQQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 2 Nov 2020 22:30:45 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 2 Nov 2020 22:30:45 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Greg KH' <gregkh@linuxfoundation.org>,
        Alex Deucher <alexdeucher@gmail.com>
CC:     Deepak R Varma <mh12gx2825@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "Maling list - DRI developers" <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Melissa Wen <melissa.srw@gmail.com>,
        "Daniel Vetter" <daniel.vetter@ffwll.ch>
Subject: RE: [PATCH] drm/amdgpu: do not initialise global variables to 0 or
 NULL
Thread-Topic: [PATCH] drm/amdgpu: do not initialise global variables to 0 or
 NULL
Thread-Index: AQHWsVQzuHsYTLqYC0GrzZhKR8oU56m1aalA
Date:   Mon, 2 Nov 2020 22:30:45 +0000
Message-ID: <d415d3297e1e4475adb4e1093fea5aca@AcuMS.aculab.com>
References: <20201102184147.GA42288@localhost>
 <CADnq5_OnA3T_p4pTEOpoqQ=NZyso2VFoDiOHu=+h7dKOeKHq-A@mail.gmail.com>
 <20201102201040.GA2433494@kroah.com>
In-Reply-To: <20201102201040.GA2433494@kroah.com>
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

From: Greg KH
> Sent: 02 November 2020 20:11
> 
> On Mon, Nov 02, 2020 at 02:43:45PM -0500, Alex Deucher wrote:
> > On Mon, Nov 2, 2020 at 1:42 PM Deepak R Varma <mh12gx2825@gmail.com> wrote:
> > >
> > > Initializing global variable to 0 or NULL is not necessary and should
> > > be avoided. Issue reported by checkpatch script as:
> > > ERROR: do not initialise globals to 0 (or NULL).
> >
> > I agree that this is technically correct, but a lot of people don't
> > seem to know that so we get a lot of comments about this code for the
> > variables that are not explicitly set.  Seems less confusing to
> > initialize them even if it not necessary.  I don't have a particularly
> > strong opinion on it however.
> 
> The kernel coding style is to do it this way.  You even save space and
> time by doing it as well :)

Uninitialised globals end up as 'named common' (variables that are
their own code section - from FORTRAN) until the final link puts
them into the .bss.
Globals initialised to 0 go into the .bss of the object file
being created.

So both end up in the final .bss.

If the code goes into a module you aren't allowed 'common' data
in a module to every global must be initialised.

I'm surprised checkpatch complains.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

