Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57962DFE23
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 17:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgLUQoG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Dec 2020 11:44:06 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:54377 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725777AbgLUQoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:44:05 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-5-b9x0mQY4PWebkGD87-Qp8A-1; Mon, 21 Dec 2020 16:42:26 +0000
X-MC-Unique: b9x0mQY4PWebkGD87-Qp8A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 21 Dec 2020 16:42:23 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 21 Dec 2020 16:42:23 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Segher Boessenkool' <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
CC:     Xiaoming Ni <nixiaoming@huawei.com>,
        "ravi.bangoria@linux.ibm.com" <ravi.bangoria@linux.ibm.com>,
        "mikey@neuling.org" <mikey@neuling.org>,
        "yanaijie@huawei.com" <yanaijie@huawei.com>,
        "haren@linux.ibm.com" <haren@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "wangle6@huawei.com" <wangle6@huawei.com>,
        "paulus@samba.org" <paulus@samba.org>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] powerpc:Don't print raw EIP/LR hex values in dump_stack()
 and show_regs()
Thread-Topic: [PATCH] powerpc:Don't print raw EIP/LR hex values in
 dump_stack() and show_regs()
Thread-Index: AQHW17dukx+1atuJ10yi7rVw0MWNE6oBwFGw
Date:   Mon, 21 Dec 2020 16:42:23 +0000
Message-ID: <ad814ccf34c14c76b45e50b6e7741c3a@AcuMS.aculab.com>
References: <20201221032758.12143-1-nixiaoming@huawei.com>
 <2279fc96-1f10-0c3f-64d9-734f18758620@csgroup.eu>
 <20201221163130.GZ2672@gate.crashing.org>
In-Reply-To: <20201221163130.GZ2672@gate.crashing.org>
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

From: Segher Boessenkool
> Sent: 21 December 2020 16:32
> 
> On Mon, Dec 21, 2020 at 04:17:21PM +0100, Christophe Leroy wrote:
> > Le 21/12/2020 à 04:27, Xiaoming Ni a écrit :
> > >Since the commit 2b0e86cc5de6 ("powerpc/fsl_booke/32: implement KASLR
> > >infrastructure"), the powerpc system is ready to support KASLR.
> > >To reduces the risk of invalidating address randomization, don't print the
> > >EIP/LR hex values in dump_stack() and show_regs().
> 
> > I think your change is not enough to hide EIP address, see below a dump
> > with you patch, you get "Faulting instruction address: 0xc03a0c14"
> 
> As far as I can see the patch does nothing to the GPR printout.  Often
> GPRs contain code addresses.  As one example, the LR is moved via a GPR
> (often GPR0, but not always) for storing on the stack.
> 
> So this needs more work.

If the dump_stack() is from an oops you need the real EIP value
on order to stand any chance of making headway.

Otherwise you might just as well just print 'borked - tough luck'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

