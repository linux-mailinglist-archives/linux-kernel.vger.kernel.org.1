Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 356A62DF6E2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 22:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgLTVVV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 20 Dec 2020 16:21:21 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2403 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgLTVVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 16:21:20 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Czb8c4J4kz53dn;
        Mon, 21 Dec 2020 05:19:44 +0800 (CST)
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 21 Dec 2020 05:20:36 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi761-chm.china.huawei.com (10.1.198.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 21 Dec 2020 05:20:36 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.002;
 Mon, 21 Dec 2020 05:20:36 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Mike Galbraith <efault@gmx.de>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Minchan Kim <minchan@kernel.org>,
        NitinGupta <ngupta@vflare.org>
Subject: RE: [PATCH] zsmalloc: do not use bit_spin_lock
Thread-Topic: [PATCH] zsmalloc: do not use bit_spin_lock
Thread-Index: AQHW1mZAeBjE5clI7UKUuMSOCQsyuqn+qqCAgABrOwCAAWYo8A==
Date:   Sun, 20 Dec 2020 21:20:36 +0000
Message-ID: <44a69faf3ac54b5883a4b0d99d51a0b0@hisilicon.com>
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
         <20201220002228.38697-1-vitaly.wool@konsulko.com>
         <c9c97ae293f5d7321ff30ac6ead49751560dd354.camel@gmx.de>
 <80d3be3d47356bf0bd6c5a9d9dc658ca3da292be.camel@gmx.de>
In-Reply-To: <80d3be3d47356bf0bd6c5a9d9dc658ca3da292be.camel@gmx.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.121]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Mike Galbraith [mailto:efault@gmx.de]
> Sent: Sunday, December 20, 2020 8:48 PM
> To: Vitaly Wool <vitaly.wool@konsulko.com>; LKML
> <linux-kernel@vger.kernel.org>; linux-mm <linux-mm@kvack.org>
> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Sebastian Andrzej
> Siewior <bigeasy@linutronix.de>; Minchan Kim <minchan@kernel.org>; NitinGupta
> <ngupta@vflare.org>
> Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
> 
> On Sun, 2020-12-20 at 02:23 +0100, Mike Galbraith wrote:
> > On Sun, 2020-12-20 at 02:22 +0200, Vitaly Wool wrote:
> > > zsmalloc takes bit spinlock in its _map() callback and releases it
> > > only in unmap() which is unsafe and leads to zswap complaining
> > > about scheduling in atomic context.
> > >
> > > To fix that and to improve RT properties of zsmalloc, remove that
> > > bit spinlock completely and use a bit flag instead.
> >
> > It also does get_cpu_var() in map(), put_cpu_var() in unmap().
> 
> That aside, the bit spinlock removal seems to hold up to beating in RT.
> I stripped out the RT changes to replace the bit spinlocks, applied the
> still needed atm might_sleep() fix, and ltp zram and zswap test are
> running in a loop with no signs that it's a bad idea, so I hope that
> makes it in (minus the preempt disabled spin which I whacked), as it
> makes zsmalloc markedly more RT friendly.
> 
> RT changes go from:
>  1 file changed, 79 insertions(+), 6 deletions(-)
> to:
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

Sorry, would you like to show the change for 
"8 insertions(+), 3 deletions(-)"?

BTW, your original patch looks not right as 
crypto_wait_req(crypto_acomp_decompress()...)
can sleep too.

[copy from your original patch with comment]
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1258,20 +1258,20 @@ static int zswap_frontswap_load(unsigned

 	/* decompress */
 	dlen = PAGE_SIZE;
+	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
+	mutex_lock(acomp_ctx->mutex);
 	src = zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL_MM_RO);
 	if (zpool_evictable(entry->pool->zpool))
 		src += sizeof(struct zswap_header);

-	acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
-	mutex_lock(acomp_ctx->mutex);
 	sg_init_one(&input, src, entry->length);
 	sg_init_table(&output, 1);
 	sg_set_page(&output, page, PAGE_SIZE, 0);
 	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, dlen);

/*!!!!!!!!!!!!!!!!
 * here crypto could sleep
 !!!!!!!!!!!!!!*/

 	ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
-	mutex_unlock(acomp_ctx->mutex);

 	zpool_unmap_handle(entry->pool->zpool, entry->handle);
+	mutex_unlock(acomp_ctx->mutex);
 	BUG_ON(ret);

 freeentry:

[end]

so I guess we have to fix zsmalloc.


> 	-Mike

Thanks
Barry

