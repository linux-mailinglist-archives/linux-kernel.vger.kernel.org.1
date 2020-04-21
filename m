Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5B3A1B208A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 10:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgDUIAx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Apr 2020 04:00:53 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:57369 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726013AbgDUIAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:00:53 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-250-fgIk9mZoMF6JMJUCrlMd3g-1; Tue, 21 Apr 2020 09:00:48 +0100
X-MC-Unique: fgIk9mZoMF6JMJUCrlMd3g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 21 Apr 2020 09:00:48 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 21 Apr 2020 09:00:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Petko Manolov' <petko.manolov@konsulko.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] WRITE_ONCE_INC() and friends
Thread-Topic: [RFC] WRITE_ONCE_INC() and friends
Thread-Index: AQHWFi8qKt3GQH4qWkGP1JyWbckPg6iAvLKQ///3OoCAAELwsIABP0tugAECeAA=
Date:   Tue, 21 Apr 2020 08:00:48 +0000
Message-ID: <3a6f974efad4453e9af7a3152ca0bbce@AcuMS.aculab.com>
References: <20200419094439.GA32841@carbon>
 <491f0b0bc9e4419d93a78974fd7f44c7@AcuMS.aculab.com>
 <20200419182957.GA36919@carbon>
 <8e5a0283ed76465aac19a2b97a27ff15@AcuMS.aculab.com>
 <20200420150545.GB17661@paulmck-ThinkPad-P72> <20200420163215.GA43378@carbon>
In-Reply-To: <20200420163215.GA43378@carbon>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petko Manolov
> Sent: 20 April 2020 17:32
...
> > But one downside of declaring variables volatile is that it can prevent KCSAN
> > from spotting violations of the concurrency design for those variables.
> 
> Which would be unfortunate.
> 
> I just wish there was C type declaration that would force the compiler to do
> what READ/WRITE_ONCE() does now, but i also know this is too naive... :)

It does, it is called 'volatile'.

All READ_ONCE() does is force the access through a volatile pointer.

The thing to do is mark the structure elements 'volatile'
rather than using a 'pointer to volatile structure'.

I'm sure KASAN could be taught about volatile structure members.

	David.

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

