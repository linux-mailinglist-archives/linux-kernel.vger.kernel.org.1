Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B148E2DEE1D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 11:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgLSKN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 05:13:58 -0500
Received: from mout.gmx.net ([212.227.17.22]:49533 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbgLSKN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 05:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608372732;
        bh=6Lbh6Y5L+z/nVaTAt2yAOl/p4XTy7MmOdTh62bkdRLc=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=Sc9IcmgWNG3Qf5TTnemIQm4mhDpvQM73/R7EKSm+EDx0V04cC3zjh0c1X3aQLggja
         i7b9PMlpZ22C2b66uQgiSjYHhyLpDOMiXhyFh9vZq0Rfto/zEZGDEx6jgjS6SjnSgw
         Lrjw3ObINbflr1Ndm/vz8te5To/FitfiqKCWg5u8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.14]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdeX-1ktc0f37sT-00Ea16; Sat, 19
 Dec 2020 11:12:12 +0100
Message-ID: <aa9be27f0d247db1b25da55901b975d78537db3d.camel@gmx.de>
Subject: Re: [patch] zswap: fix zswap_frontswap_load() vs
 zsmalloc::map/unmap() might_sleep() splat
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Sat, 19 Dec 2020 11:12:10 +0100
In-Reply-To: <fae85e4440a8ef6f13192476bd33a4826416fc58.camel@gmx.de>
References: <fae85e4440a8ef6f13192476bd33a4826416fc58.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Idz0oKSM/QsVBcDqW56HRXUxdiKTtZgytnkZ1B7Fnhhx+zHUovd
 8PQAE0NulElwTdORx9igmQW89VuEn4Nrff0gP7nfoyNEDyYAS8N9ySv1m1hJEOU1yVaaTEy
 9YxFvwhL2BVVougcR8g/gdPnP39jQY8JFHwLRpgGJBliCodw1++Yc+SSr0rk1lmv0Ou1OZo
 apQhPdmrn8Wv8dIxzguHw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ez/aHxnshM8=:SudlIm4DiRO9TB9rSPQd4J
 ij3HZyc6T7n+FIRt8vliuV5wwuCYkpDSl60D4iKb/5xF5Z3/Drek3r8A26re4iSD3nfbk2muc
 CFlNKCkDZmoTzxLeXjXvMhv6k31ErZu6UX2UGz/CkmLYLWkIs2hQP0JvlcN/1d7vIQXk7BIA6
 2hEHpa/MCXp/kdgST58vVIVeOoc1p44SLJ7JGdQmeWChSaYLEGJG7ZrLsNN825pzr0ZiaYN+n
 NOWoNhlXKXFIlPSUPssfHAdNPJzpwBiBs4gvTzxDlDH5jxFVoYwG9RoW9Py+3ubDLKy6TPQoD
 xXov1pxjNk8gxKp0IWvHCzUG7VapmDY/YC0QEML3ni6qPXMJX+uMRQFp/nY9QD+CaaQdNLNLZ
 S/0ayu4luxFzC+yYIWRU+wGEEt/UGM8mriwRp12I/MawIzQf+ATnyy9wmlLH3lQ8z23ImCU6h
 3F8rWvoCx7iyF/d49V2YKUw/vUhQfBdFLwNut9EILWh46lnzKXRcbIp53qar93NEi3QfIffm9
 J9J8DlCPtn4INGh3PzoTAqlnnII/66Yrp+ij7x+Kx1z6bL7Mv4HcyUaG6yw8lo6A4WT6eifEU
 zjS64j9GjVUa9rF5Rv3hXvE3JwDbl9m8y7vdn4LBA18p/jTrwGpsu6tSrrrHmu+YhEV0t4sJH
 1dKP6qxA5J0U16cwio0UnXpgzlgyLMhDdsAFoQxHHilAKjNAux/XmLL+XHo+3b2T6TuBAAjsp
 mGkiN0tmvHavujXR0FvamYrE3KNanvRguIdWCJK60Zyec+okuXYAaqN8wHTSTXNKVnedj8irY
 e9dC7SkaIQXhz3RJLgY6hynZjL18Di8YMsKktMx+72ZH3z7WhOt2T8qlZ2tmB1OETNT60KEvV
 dKBsK12WNf5e57spHTsQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(mailer partially munged formatting? resend)

mm/zswap: fix zswap_frontswap_load() vs zsmalloc::map/unmap() might_sleep(=
) splat

zsmalloc map/unmap methods use preemption disabling bit spinlocks.  Take t=
he
mutex outside of pool map/unmap methods in zswap_frontswap_load() as is do=
ne
in zswap_frontswap_store().

Signed-off-by: Mike Galbraith <efault@gmx.de>
Fixes: 1ec3b5fe6eec "mm/zswap: move to use crypto_acomp API for hardware a=
cceleration"
=2D--
 mm/zswap.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

=2D-- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1258,20 +1258,20 @@ static int zswap_frontswap_load(unsigned

 	/* decompress */
 	dlen =3D PAGE_SIZE;
+	acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
+	mutex_lock(acomp_ctx->mutex);
 	src =3D zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL_MM_RO)=
;
 	if (zpool_evictable(entry->pool->zpool))
 		src +=3D sizeof(struct zswap_header);

-	acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
-	mutex_lock(acomp_ctx->mutex);
 	sg_init_one(&input, src, entry->length);
 	sg_init_table(&output, 1);
 	sg_set_page(&output, page, PAGE_SIZE, 0);
 	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length,=
 dlen);
 	ret =3D crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_=
ctx->wait);
-	mutex_unlock(acomp_ctx->mutex);

 	zpool_unmap_handle(entry->pool->zpool, entry->handle);
+	mutex_unlock(acomp_ctx->mutex);
 	BUG_ON(ret);

 freeentry:

