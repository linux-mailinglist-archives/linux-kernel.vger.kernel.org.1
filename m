Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3872A36C4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 23:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgKBWpD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Nov 2020 17:45:03 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:26801 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725807AbgKBWpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 17:45:03 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-60-5ghhhtChNGi9YWJ8nylj6g-1; Mon, 02 Nov 2020 22:44:59 +0000
X-MC-Unique: 5ghhhtChNGi9YWJ8nylj6g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 2 Nov 2020 22:44:58 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 2 Nov 2020 22:44:58 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Tong Zhang' <ztong0001@gmail.com>, Anders Larsen <al@alarsen.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] qnx4: do not interpret -EIO as a correct address
Thread-Topic: [PATCH v2] qnx4: do not interpret -EIO as a correct address
Thread-Index: AQHWsVVIPnKGd7dNBUSmPmr3Stqkv6m1bqTw
Date:   Mon, 2 Nov 2020 22:44:58 +0000
Message-ID: <e457351a04e04aa084902fd5138d4cae@AcuMS.aculab.com>
References: <1966437.kWHqOGhHGQ@alarsen.net>
 <20201102201536.1267680-1-ztong0001@gmail.com>
In-Reply-To: <20201102201536.1267680-1-ztong0001@gmail.com>
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

From: Tong Zhang
> Sent: 02 November 2020 20:16
> 
> qnx4_block_map() may return -EIO on funny qnx4 fs image, in this case do
> not interpret -EIO as a correct address

'Block number' not 'address'.

> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
> v2: also check other callers according to Anders Larsen's<al@alarsen.net> comment
>  fs/qnx4/dir.c   | 2 ++
>  fs/qnx4/inode.c | 2 ++
>  fs/qnx4/namei.c | 3 +++
>  3 files changed, 7 insertions(+)
> 
> diff --git a/fs/qnx4/dir.c b/fs/qnx4/dir.c
> index a6ee23aadd28..11aaf59f0411 100644
> --- a/fs/qnx4/dir.c
> +++ b/fs/qnx4/dir.c
> @@ -31,6 +31,8 @@ static int qnx4_readdir(struct file *file, struct dir_context *ctx)
> 
>  	while (ctx->pos < inode->i_size) {
>  		blknum = qnx4_block_map(inode, ctx->pos >> QNX4_BLOCK_SIZE_BITS);
> +		if (blknum == -EIO)
> +			return -EIO;

Since 'blknum' is 'unsigned long' doesn't this generate a compiler
warning about the condition being always false?
(C requires the -EIO be converted to the equivalent unsigned
bit-pattern - but that doesn't stop the compiler deciding it is
dubious.)
If it doesn't this week, it might next week.

What about other error codes that might get returned.
Someone seeing that EIO is valid might decide an other
error can be returned.

You probably ought to allow for all errno values
or use ~0ull as an error value.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

