Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB3B2690ED
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgINP7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:59:03 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:39339 "EHLO
        smtpout1.mo804.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbgINPqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:46:54 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.4.92])
        by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 99160617F1AA;
        Mon, 14 Sep 2020 17:46:32 +0200 (CEST)
Received: from kaod.org (37.59.142.106) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Mon, 14 Sep
 2020 17:46:31 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-106R00607f539b8-6c4b-4c84-ba45-0f0b12b78fa8,
                    33559CD024D4F69900824C14C2AC4808F9346AFD) smtp.auth=groug@kaod.org
Date:   Mon, 14 Sep 2020 17:46:30 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Christian Schoenebeck <qemu_oss@crudebyte.com>
CC:     Jianyong Wu <jianyong.wu@arm.com>, <ericvh@gmail.com>,
        <lucho@ionkov.net>, <asmadeus@codewreck.org>,
        <v9fs-developer@lists.sourceforge.net>, <justin.he@arm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [V9fs-developer] [PATCH RFC 0/4] 9p: fix open-unlink-f*syscall
 bug
Message-ID: <20200914174630.195e816f@bahia.lan>
In-Reply-To: <2037087.W39pGsgtbe@silver>
References: <20200914033754.29188-1-jianyong.wu@arm.com>
        <2828347.d8MXItvaOC@silver>
        <20200914144325.7928dbd3@bahia.lan>
        <2037087.W39pGsgtbe@silver>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: a4e8086c-a59a-4e2b-a409-446354a421de
X-Ovh-Tracer-Id: 10401063342826494316
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudeiiedgleehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeekvdfguefgtddvleefffeuveefgedukeehffdtjeevgfevieelleduffekuedvffenucffohhmrghinhepnhhonhhgnhhurdhorhhgnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 17:19:20 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Montag, 14. September 2020 14:43:25 CEST Greg Kurz wrote:
> > > So yes, looks like this also requires changes to the 9pfs 'local' fs
> > > driver on QEMU side:
> > > https://lists.nongnu.org/archive/html/qemu-devel/2016-06/msg07586.html
> > > 
> > > Eric, Greg, would there be an easy way to establish QEMU test cases
> > > running
> > > the 9pfs 'local' fs driver? Right now we only have 9pfs qtest cases for
> > > QEMU which can only use the 'synth' driver, which is not helpful for such
> > > kind of issues.
> > 
> > I guess it's possible to introduce new qtests that start QEMU with
> > -fsdev local instead of -fsdev synth... I haven't looked in a while
> > though, so I won't comment on "easy way" ;-)
> 
> Makes sense, and I considered that approach as well.
> 
> The question is the following: is there a QEMU policy about test cases that 
> create/write/read/delete *real* files? I.e. should those test files be written 
> to a certain location, and are there measures of sandboxing required?
> 

I don't know. You'll need to figure out by yourself, reading code from
other tests or asking on IRC.

> Best regards,
> Christian Schoenebeck
> 
> 

