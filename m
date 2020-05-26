Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4C21AFCF7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 20:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgDSSCy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Apr 2020 14:02:54 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:50073 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726572AbgDSSCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 14:02:54 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-48-86ACGi07OCCkYT-YdAJJpA-1; Sun, 19 Apr 2020 19:02:51 +0100
X-MC-Unique: 86ACGi07OCCkYT-YdAJJpA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 19 Apr 2020 19:02:50 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 19 Apr 2020 19:02:50 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Petko Manolov' <petko.manolov@konsulko.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] WRITE_ONCE_INC() and friends
Thread-Topic: [RFC] WRITE_ONCE_INC() and friends
Thread-Index: AQHWFi8qKt3GQH4qWkGP1JyWbckPg6iAvLKQ
Date:   Sun, 19 Apr 2020 18:02:50 +0000
Message-ID: <491f0b0bc9e4419d93a78974fd7f44c7@AcuMS.aculab.com>
References: <20200419094439.GA32841@carbon>
In-Reply-To: <20200419094439.GA32841@carbon>
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
> Sent: 19 April 2020 10:45
> Recently I started reading up on KCSAN and at some point I ran into stuff like:
> 
> WRITE_ONCE(ssp->srcu_lock_nesting[idx], ssp->srcu_lock_nesting[idx] + 1);
> WRITE_ONCE(p->mm->numa_scan_seq, READ_ONCE(p->mm->numa_scan_seq) + 1);

If all the accesses use READ/WRITE_ONCE() why not just mark the
structure field 'volatile'?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

