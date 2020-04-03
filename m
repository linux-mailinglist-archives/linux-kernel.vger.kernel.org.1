Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D3419D1D4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 10:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390403AbgDCIJJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Apr 2020 04:09:09 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:23780 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727431AbgDCIJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 04:09:09 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-216-2nJT-0BSNJKCaNUE6rLCiQ-1; Fri, 03 Apr 2020 09:09:04 +0100
X-MC-Unique: 2nJT-0BSNJKCaNUE6rLCiQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 3 Apr 2020 09:09:03 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 3 Apr 2020 09:09:03 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Peter Zijlstra' <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Steven Rostedt" <rostedt@goodmis.org>
Subject: RE: [patch v2 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Thread-Topic: [patch v2 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Thread-Index: AQHWCQK4i0gO2diBOkK6XKhOFlCL2qhnC2Fg
Date:   Fri, 3 Apr 2020 08:09:03 +0000
Message-ID: <9b95fe9e81c14370859e19f081cc23e4@AcuMS.aculab.com>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <20200402152340.GL20713@hirez.programming.kicks-ass.net>
In-Reply-To: <20200402152340.GL20713@hirez.programming.kicks-ass.net>
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

From: Peter Zijlstra
> Sent: 02 April 2020 16:24
> 
> I picked VMXOFF (which also appears in vmmon.ko) instead of VMXON
> because that latter takes an argument is therefore more difficult to
> decode.
...
> +	while (text < text_end) {
> +		kernel_insn_init(&insn, text, text_end - text);
> +		insn_get_length(&insn);
> +
> +		if (WARN_ON_ONCE(!insn_complete(&insn)))
> +			break;
> +
> +		if (insn.length == 3 &&
> +		    (!memcmp(text, vmlaunch, sizeof(vmlaunch)) ||
> +		     !memcmp(text, vmxoff, sizeof(vmxoff))))
> +				goto bad_module;
> +
> +		text += insn.length;
> +	}

How long is that going to take on a module with (say) 400k of text?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

