Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65FD42C116F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 18:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730491AbgKWRFN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Nov 2020 12:05:13 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:49795 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729482AbgKWRFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:05:13 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-221-bItNLEhdNW-xmw5Eq5Xq4Q-1; Mon, 23 Nov 2020 17:05:09 +0000
X-MC-Unique: bItNLEhdNW-xmw5Eq5Xq4Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 23 Nov 2020 17:05:08 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 23 Nov 2020 17:05:08 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Sahitya Tummala' <stummala@codeaurora.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] f2fs: change to use rwsem for cp_mutex
Thread-Topic: [PATCH] f2fs: change to use rwsem for cp_mutex
Thread-Index: AQHWwVm8Sokw4eOdHU6M1bsTH5HkTqnV8p0Q
Date:   Mon, 23 Nov 2020 17:05:08 +0000
Message-ID: <7f5213fb9b334d1290f019ab8ed6ee71@AcuMS.aculab.com>
References: <1606109312-1944-1-git-send-email-stummala@codeaurora.org>
In-Reply-To: <1606109312-1944-1-git-send-email-stummala@codeaurora.org>
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

From: Sahitya Tummala
> Sent: 23 November 2020 05:29
> 
> Use rwsem to ensure serialization of the callers and to avoid
> starvation of high priority tasks, when the system is under
> heavy IO workload.

I can't see any read lock requests.

So why the change?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

