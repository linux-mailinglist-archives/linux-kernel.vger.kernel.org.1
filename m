Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333652FC2FC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbhASWHN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 19 Jan 2021 17:07:13 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:41054 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729095AbhASWGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 17:06:09 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-263-n1qHRqPRPkKRjzKewXnsEA-1; Tue, 19 Jan 2021 22:04:22 +0000
X-MC-Unique: n1qHRqPRPkKRjzKewXnsEA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 19 Jan 2021 22:04:21 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 19 Jan 2021 22:04:21 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Adrian Ratiu' <adrian.ratiu@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6
 warning
Thread-Topic: [PATCH v4 1/2] arm: lib: xor-neon: remove unnecessary GCC < 4.6
 warning
Thread-Index: AQHW7mdkBLnG67vUeU6WLdpsKRa/+qovgJKw
Date:   Tue, 19 Jan 2021 22:04:20 +0000
Message-ID: <3dbc2ce713e44e3a9a913db5446506a8@AcuMS.aculab.com>
References: <20210119131724.308884-1-adrian.ratiu@collabora.com>
 <20210119131724.308884-2-adrian.ratiu@collabora.com>
In-Reply-To: <20210119131724.308884-2-adrian.ratiu@collabora.com>
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

From: Adrian Ratiu
> Sent: 19 January 2021 13:17
> To: linux-arm-kernel@lists.infradead.org
> 
> Drop warning because kernel now requires GCC >= v4.9 after
> commit 6ec4476ac825 ("Raise gcc version requirement to 4.9")
> and clarify that -ftree-vectorize now always needs enabling
> for GCC by directly testing the presence of CONFIG_CC_IS_GCC.
...
> -#if __GNUC__ > 4 || (__GNUC__ == 4 && __GNUC_MINOR__ >= 6)
> +#ifdef CONFIG_CC_IS_GCC
>  #pragma GCC optimize "tree-vectorize"
> -#else

I thought that #pragma optimise was very likely to remove
a random subset of the command line parameters leading to
incorrect/unexpected code.

As such the extra option needs to passed in as a per source
file compiler option.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

