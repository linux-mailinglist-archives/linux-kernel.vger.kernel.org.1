Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD93A2DF700
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 23:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgLTWMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 17:12:39 -0500
Received: from mout.gmx.net ([212.227.17.20]:38585 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728323AbgLTWMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 17:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608502243;
        bh=eI4ISoOrH8j7uXDzoSYv8qN9USEKKYcPmamcCJeVddU=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=j5xpEmJ/r+Xjb1NZmS45ZoB8p76hqgIQc49vmxC/8gw6MGv1Yo7vX4TtSNVbFDEYo
         40Qync4pQ2/6NZoV5GenOTEKY/VbiD0zetskhCqcn5YT4t7eCkrZuQi5uXE8Qedn+Y
         nIB3udhoiSPWUEWYm2AiaD4fTrbJAnlY+i4zaF7Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.14]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjjCF-1kNZVo05pz-00lFWD; Sun, 20
 Dec 2020 23:10:43 +0100
Message-ID: <afa2dee794ae7b2d1f23fed85ff514d43485762b.camel@gmx.de>
Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
From:   Mike Galbraith <efault@gmx.de>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Minchan Kim <minchan@kernel.org>,
        NitinGupta <ngupta@vflare.org>
Date:   Sun, 20 Dec 2020 23:10:41 +0100
In-Reply-To: <44a69faf3ac54b5883a4b0d99d51a0b0@hisilicon.com>
References: <18669bd607ae9efbf4e00e36532c7aa167d0fa12.camel@gmx.de>
         <20201220002228.38697-1-vitaly.wool@konsulko.com>
         <c9c97ae293f5d7321ff30ac6ead49751560dd354.camel@gmx.de>
         <80d3be3d47356bf0bd6c5a9d9dc658ca3da292be.camel@gmx.de>
         <44a69faf3ac54b5883a4b0d99d51a0b0@hisilicon.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zYXuOJz9Zihv9Q5Tnk0nGMwDPYRmKOZf68Yz9gcNyEcGfoZ2jmK
 kgcJncvqi9v6TluUj2nexkTvaPbRUOrRSDVoWRc9SeR4lPuOstWXJaeMCCcN1Is0fruVAFW
 vA5EB2s/ADFthflISnrbB8gsbVrV4C1QBYe88H48phIk0dIs+eHM3yzSTACOkPjriBbprgo
 maubg2mDudCeiTj+JexWA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1kWgq11Q1sQ=:4wYLvFGJQdJul8+iljO6dl
 ZpbGrJnVc2NOCVQWEaToWUq3H/ewj3T0u15ndGrCTlmXzkn4+5OZsWS9sCtL/P6wK6edJIanF
 L+Flq1Fd0K07OW2J8/VB27e26qUuCCnfOSwPtRMe8cMKUckdxzFKuZ2/+8jIcOG88MwNZ84lY
 B0flUkmj43vemgh9xv4c77+4HdndCWPelTQzBaAoqXMVkmOP86BoUAbhXWzSYYxZCd1nTUuuM
 KI0Jlw9hL1sZiEcJqKms9Yu9ba73yLH9PbZ4vZrn8SHdlJzE84L0DveOAbZDG4S7dihQMSKFi
 miCxiu5sZkUI1KCQQ53KZ7c288DXwxfWKantQ05ZQjMJ3suLOCwYTT4pHgPFWZily3SkMLNYg
 wI7KP42PReGZ7AByeiwmDxIi2FwH9tqJO3WBYrbf29F3MeaXCPNajQN+eOw7R/Sw4xAiHJg8j
 mSfcSvpXSsjcSk16jHPWriRNYVB7Eqo8F+O1/f+sniS4T+zxCUg1KN+TsELOyp+rer0cVemQv
 DMZZYYRpwOqTBJsaECYvA9doczEYZMSNRaCBlqajZrnPui4BS1I5aXOFGhdFvy3VczYWeYA0V
 P/W6Up48I63IGilngcliikmQdyTCQ7DFOXub0IgOb+ljocNLw+EgTGdG3+7IHpRueFwVp39t3
 XryJIOZFN56G8AiUx13W/3n/9azbXyH+1KIdw9+WZ1lPxrOOnqd2Q4e7N5Irh596F22EbSj4j
 pOdX+01AbJ3yTTwLcKtqjZlyXKoTeH5ekIgvH3HXm87zQqI4DMY0/bgzS/ozLSF7nwj0mauzD
 cob/hZ65UAiGiby8MOI6ICtLxOmFjJElKorBVRwOg5+gVCkCYIltvH2lVGpHVMrA5iCwnRJLM
 3U/j/VNpxDhGG7WdQiqA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-12-20 at 21:20 +0000, Song Bao Hua (Barry Song) wrote:
>
> > -----Original Message-----
> > From: Mike Galbraith [mailto:efault@gmx.de]
> > Sent: Sunday, December 20, 2020 8:48 PM
> > To: Vitaly Wool <vitaly.wool@konsulko.com>; LKML
> > <linux-kernel@vger.kernel.org>; linux-mm <linux-mm@kvack.org>
> > Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; Sebastian =
Andrzej
> > Siewior <bigeasy@linutronix.de>; Minchan Kim <minchan@kernel.org>; Nit=
inGupta
> > <ngupta@vflare.org>
> > Subject: Re: [PATCH] zsmalloc: do not use bit_spin_lock
> >
> > On Sun, 2020-12-20 at 02:23 +0100, Mike Galbraith wrote:
> > > On Sun, 2020-12-20 at 02:22 +0200, Vitaly Wool wrote:
> > > > zsmalloc takes bit spinlock in its _map() callback and releases it
> > > > only in unmap() which is unsafe and leads to zswap complaining
> > > > about scheduling in atomic context.
> > > >
> > > > To fix that and to improve RT properties of zsmalloc, remove that
> > > > bit spinlock completely and use a bit flag instead.
> > >
> > > It also does get_cpu_var() in map(), put_cpu_var() in unmap().
> >
> > That aside, the bit spinlock removal seems to hold up to beating in RT=
.
> > I stripped out the RT changes to replace the bit spinlocks, applied th=
e
> > still needed atm might_sleep() fix, and ltp zram and zswap test are
> > running in a loop with no signs that it's a bad idea, so I hope that
> > makes it in (minus the preempt disabled spin which I whacked), as it
> > makes zsmalloc markedly more RT friendly.
> >
> > RT changes go from:
> >  1 file changed, 79 insertions(+), 6 deletions(-)
> > to:
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> >
>
> Sorry, would you like to show the change for
> "8 insertions(+), 3 deletions(-)"?

Sure.
=2D--
 mm/zsmalloc.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

=2D-- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -57,6 +57,7 @@
 #include <linux/wait.h>
 #include <linux/pagemap.h>
 #include <linux/fs.h>
+#include <linux/local_lock.h>

 #define ZSPAGE_MAGIC	0x58

@@ -293,6 +294,7 @@ struct zspage {
 };

 struct mapping_area {
+	local_lock_t lock;
 	char *vm_buf; /* copy buffer for objects that span pages */
 	char *vm_addr; /* address of kmap_atomic()'ed pages */
 	enum zs_mapmode vm_mm; /* mapping mode */
@@ -455,7 +457,9 @@ MODULE_ALIAS("zpool-zsmalloc");
 #endif /* CONFIG_ZPOOL */

 /* per-cpu VM mapping areas for zspage accesses that cross page
boundaries */
-static DEFINE_PER_CPU(struct mapping_area, zs_map_area);
+static DEFINE_PER_CPU(struct mapping_area, zs_map_area) =3D {
+	.lock	=3D INIT_LOCAL_LOCK(lock),
+};

 static bool is_zspage_isolated(struct zspage *zspage)
 {
@@ -1276,7 +1280,8 @@ void *zs_map_object(struct zs_pool *pool
 	class =3D pool->size_class[class_idx];
 	off =3D (class->size * obj_idx) & ~PAGE_MASK;

-	area =3D &get_cpu_var(zs_map_area);
+	local_lock(&zs_map_area.lock);
+	area =3D this_cpu_ptr(&zs_map_area);
 	area->vm_mm =3D mm;
 	if (off + class->size <=3D PAGE_SIZE) {
 		/* this object is contained entirely within a page */
@@ -1330,7 +1335,7 @@ void zs_unmap_object(struct zs_pool *poo

 		__zs_unmap_object(area, pages, off, class->size);
 	}
-	put_cpu_var(zs_map_area);
+	local_unlock(&zs_map_area.lock);

 	migrate_read_unlock(zspage);
 	unpin_tag(handle);


> BTW, your original patch looks not right as
> crypto_wait_req(crypto_acomp_decompress()...)
> can sleep too.
>
> [copy from your original patch with comment]
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1258,20 +1258,20 @@ static int zswap_frontswap_load(unsigned
>
>  	/* decompress */
>  	dlen =3D PAGE_SIZE;
> +	acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> +	mutex_lock(acomp_ctx->mutex);
>  	src =3D zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL_MM_R=
O);
>  	if (zpool_evictable(entry->pool->zpool))
>  		src +=3D sizeof(struct zswap_header);
>
> -	acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> -	mutex_lock(acomp_ctx->mutex);
>  	sg_init_one(&input, src, entry->length);
>  	sg_init_table(&output, 1);
>  	sg_set_page(&output, page, PAGE_SIZE, 0);
>  	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->lengt=
h, dlen);
>
> /*!!!!!!!!!!!!!!!!
>  * here crypto could sleep
>  !!!!!!!!!!!!!!*/

Hohum, another one for my Bitmaster-9000 patch shredder.

	-Mike


