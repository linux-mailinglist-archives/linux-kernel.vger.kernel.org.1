Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCC51E1CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 10:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgEZIMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 04:12:07 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:56944 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726971AbgEZIMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:12:07 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-126-_HU1P0XVP7yJ065bU5Iqnw-1; Tue, 26 May 2020 09:12:03 +0100
X-MC-Unique: _HU1P0XVP7yJ065bU5Iqnw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 26 May 2020 09:12:02 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 26 May 2020 09:12:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Richard Weinberger' <richard.weinberger@gmail.com>,
        Sasha Levin <sashal@kernel.org>
CC:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Porter <porter@cs.unc.edu>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>
Subject: RE: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Thread-Topic: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
Thread-Index: AQHWMgPzfS83L7jCjkmVt+IA3E+z2Ki3rUyAgACxb4CAAacDQA==
Date:   Tue, 26 May 2020 08:12:02 +0000
Message-ID: <a95b490d33624d0e96198ac22d19c029@AcuMS.aculab.com>
References: <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com>
 <20200515164013.GF29995@sasha-vm>
 <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com>
 <20200518153407.GA499505@tassilo.jf.intel.com>
 <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com>
 <87v9ksvoaq.fsf@nanos.tec.linutronix.de>
 <20200519164853.GA19706@linux.intel.com>
 <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu>
 <87h7w7qy18.fsf@nanos.tec.linutronix.de>
 <A9483B8B-C0DD-46CB-AD5D-D12EC61BB331@zytor.com>
 <20200524211945.GX33628@sasha-vm>
 <CAFLxGvxeg6+DY1LMTzvJe3=iW=zLyUj4xTRda99DurKdS6TDWw@mail.gmail.com>
In-Reply-To: <CAFLxGvxeg6+DY1LMTzvJe3=iW=zLyUj4xTRda99DurKdS6TDWw@mail.gmail.com>
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
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUmljaGFyZCBXZWluYmVyZ2VyDQo+IFNlbnQ6IDI1IE1heSAyMDIwIDA4OjU1DQouLi4N
Cj4gUDogU2FkbHkgdG9vLiBNb3N0bHkgYmVjYXVzZSBjdXN0b21lciBoYXMgY3VzdG9tIG1vZHVs
ZSBhbmQgZm9yZ290IHRvIHNldCBpdCBHUEwNCg0KWW91IHdhbnQgdXMgdG8gbGllIHRoYXQgY3Vz
dG9tIG1vZHVsZXMgYXJlIEdQTD8NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

