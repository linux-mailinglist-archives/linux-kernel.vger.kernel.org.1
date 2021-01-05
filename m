Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86DC12EA8EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbhAEKhM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Jan 2021 05:37:12 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:41935 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728291AbhAEKhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:37:11 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-78-7QYeCnYBNmqiCO7SySjlkg-1; Tue, 05 Jan 2021 10:35:32 +0000
X-MC-Unique: 7QYeCnYBNmqiCO7SySjlkg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 5 Jan 2021 10:35:31 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 5 Jan 2021 10:35:31 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
CC:     "linux-kernel-mentees@lists.linuxfoundation.org" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>
Subject: RE: [PATCH] checkpatch: fix unescaped left braces
Thread-Topic: [PATCH] checkpatch: fix unescaped left braces
Thread-Index: AQHW40n3I32sBUugtEWF3xXGRvsfoqoY1Xyw
Date:   Tue, 5 Jan 2021 10:35:31 +0000
Message-ID: <027501cb2506426d9c05adf56d002781@AcuMS.aculab.com>
References: <20210105093507.29297-1-dwaipayanray1@gmail.com>
 <cf102ac77eb1f9e6424f30aef835f6c61dd03407.camel@perches.com>
In-Reply-To: <cf102ac77eb1f9e6424f30aef835f6c61dd03407.camel@perches.com>
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
> Sent: 05 January 2021 10:01
> 
> On Tue, 2021-01-05 at 15:05 +0530, Dwaipayan Ray wrote:
> > Perl 5.22 onwards require that "A literal "{" should now be
> > escaped in a pattern".

Sounds like a good reason to never use perl :-)

> Not quite correct.
> 
> > checkpatch contains several literal "{". Fix such instances
> > by preceding them with a backslash.
> 
> Not all literal left braces need to be escaped.
> https://www.perlmonks.org/?node_id=1191981
> 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -2036,7 +2036,7 @@ sub annotate_values {
> >  			print "ASSIGN($1)\n" if ($dbg_values > 1);
> >  			$type = 'N';
> >
> >
> > -		} elsif ($cur =~/^(;|{|})/) {
> > +		} elsif ($cur =~ /^(;|\{|\})/) {

isn't (;|{|}) much the same as [;{}] ??

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

