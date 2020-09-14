Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20372268B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgINNBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:01:23 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:48385 "EHLO
        smtpout1.mo804.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726581AbgINMne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:43:34 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.141])
        by mo804.mail-out.ovh.net (Postfix) with ESMTPS id D12236169BD3;
        Mon, 14 Sep 2020 14:43:27 +0200 (CEST)
Received: from kaod.org (37.59.142.101) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Mon, 14 Sep
 2020 14:43:27 +0200
Authentication-Results: garm.ovh; auth=pass (GARM-101G004f4779f11-c3c5-46a4-95af-5038877f53f1,
                    33559CD024D4F69900824C14C2AC4808F9346AFD) smtp.auth=groug@kaod.org
Date:   Mon, 14 Sep 2020 14:43:25 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Christian Schoenebeck <qemu_oss@crudebyte.com>
CC:     Jianyong Wu <jianyong.wu@arm.com>, <ericvh@gmail.com>,
        <lucho@ionkov.net>, <asmadeus@codewreck.org>,
        <v9fs-developer@lists.sourceforge.net>, <justin.he@arm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [V9fs-developer] [PATCH RFC 0/4] 9p: fix open-unlink-f*syscall
 bug
Message-ID: <20200914144325.7928dbd3@bahia.lan>
In-Reply-To: <2828347.d8MXItvaOC@silver>
References: <20200914033754.29188-1-jianyong.wu@arm.com>
        <20200914103546.0f775bcd@bahia.lan>
        <2828347.d8MXItvaOC@silver>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 7b3eebd8-3a1a-4ea5-9361-ab98b19bcfee
X-Ovh-Tracer-Id: 7309060721836595564
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudeiiedgheeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeevvdejgeefffejheejkefhveefhfetgeevgfetudejvdevhfdtjefffffgudekkeenucffohhmrghinheplhgruhhntghhphgrugdrnhgvthdpnhhonhhgnhhurdhorhhgnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Sep 2020 13:06:34 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Montag, 14. September 2020 10:35:46 CEST Greg Kurz wrote:
> > On Mon, 14 Sep 2020 11:37:50 +0800
> > 
> > Jianyong Wu <jianyong.wu@arm.com> wrote:
> > > open-unlink-f*syscall bug is a well-known bug in 9p, we try to fix the bug
> > > in this patch set.
> > > I take Eric's and Greg's patches which constiute the 1/4 - 3/4 of this
> > > patch set as the main frame of the solution. In patch 4/4, I fix the fid
> > > race issue exists in Greg's patch.
> > 
> > IIRC some patches were needed on the QEMU side as well... I'm spending
> > less time on 9pfs in QEMU, so Cc'ing the new maintainer:
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com>
> 
> AFAICS this is about this old bug report:
> https://bugs.launchpad.net/qemu/+bug/1336794
> 

Correct.

> So yes, looks like this also requires changes to the 9pfs 'local' fs driver on 
> QEMU side:
> https://lists.nongnu.org/archive/html/qemu-devel/2016-06/msg07586.html
> 
> Eric, Greg, would there be an easy way to establish QEMU test cases running 
> the 9pfs 'local' fs driver? Right now we only have 9pfs qtest cases for QEMU 
> which can only use the 'synth' driver, which is not helpful for such kind of 
> issues.
> 

I guess it's possible to introduce new qtests that start QEMU with
-fsdev local instead of -fsdev synth... I haven't looked in a while
though, so I won't comment on "easy way" ;-)

> Best regards,
> Christian Schoenebeck
> 
> 

