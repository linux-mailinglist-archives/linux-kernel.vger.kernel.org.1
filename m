Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690EB2DEE1C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Dec 2020 11:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgLSKGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 05:06:50 -0500
Received: from mout.gmx.net ([212.227.17.22]:52217 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgLSKGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 05:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1608372295;
        bh=JgwycT7+eFK6ZdJt1y8niB6LmS4rpZzepP2lexfn6yg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=NqlOkRcVgBYcLRsOYY1zOPSxF64KwREkGuSBOOZXwsEujWa/1onPpo0w7cpv2s6o8
         Y03vNC0UfBh3skEZUc2NCry9xRUAWAZKzavvv0cC0CJxLkk6nBHj/LtcMAfqTyvWdV
         Und2/2iH0Y0JnNyryGMzXbq7JbJn3xowGFjzoQM0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.150.14]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQeU-1kyr6u3PzK-00AY1j; Sat, 19
 Dec 2020 11:04:54 +0100
Message-ID: <fae85e4440a8ef6f13192476bd33a4826416fc58.camel@gmx.de>
Subject: [patch] zswap: fix zswap_frontswap_load() vs zsmalloc::map/unmap()
 might_sleep() splat
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Sat, 19 Dec 2020 11:04:52 +0100
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0JoVJLpktWKtFgulFnddHiZBdDUtN2k1SgDcUU/+eE3CIZZy5+q
 tiooSeDdeQ2yiCxkQLwk1Ewwg0mygS5uw+mQULWRXo5JmYrSD+T+fftIZSCfCImUXOakhMT
 Snr2SJ4At9W0+5pqWt6WEWfeaaBbIuw16jG5hvXIwSwRI6/Vet3/yRktRze7fyRq9qDq5pa
 Yaeagv2CjuLbxT2pveOig==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LtZsJW17/Ak=:EJ2gntUPJTNqJjUOs+bogd
 7PhWCL3poXywbqw1PNdjXf9jqaSZtK6a0577UwFrI0Y5cYFGjLl/nCtKKTwJ3mayY3/rrmLSh
 LHK8Csx1fD04xaRyN8LufMXgbrncCGbAPvGyCoLXmckScBc4jMn+L+7gaEL7HuzCCg90YB6HV
 dFQnWMaB4nbcnBrjQHEtR4Hl7b29ueGTD3ptUJ+QL9Q36lgTdxkOkuvoibBstGnamCvgjFR1u
 rB3vuIP/PP+MKmJGHTFComtnQ8EMfk249CKx/D0LFf5qOqQIvws0AHKSwBTetjhcswVH2Q8sM
 9sU/fmbRfwmNVVoUC16FJh/PmXnrzgy16slVIQPNGxYKCQ8CzIGKlgGE7w0jkinL9d6qqkgbH
 XfxyG56fExiFyIu3fTUS9RoWtbX6zp6gZKb7p6HwqdsHyL7y6GH1QCPV0sfCFnKULEZk6SoaM
 +DOGJNPHvooFYWQ3l2hYEQZgOLtZRB2CEjbd9BWMh5ePFp2KTugmG3+vApNBVkZvPU9+a7AZP
 6FKHu/nUp7ZnhnnplubkDeMiGFYIJVZ4zjvTeXLuxtfbqa1fwcLlfHc1LPCLl08QNWqoudqLP
 XWshcYCRupbtua+aTkcXK732aRvqojqwJJ9uVJUJcp/4nZCkXKknLOaOeRqMT3ykARFQHNGda
 BJDZO907rfSBJLAe4Ycx8G1wmhLbJE4HGyUT+d4ZfRQUBmKAB5jhFC4YFYf0d0JihmIpu0saL
 a0LlrNxu/A5FuO/JyVszsSLN7f0p+eBqEoKtX82/qhffR0VgL6T7WxnqMBJYvKC4sp7oNQbu2
 m4P3g5wGVUyLdGpduV9FQYkB7vmbr9qIueWY+vkJM8Dw2tTpF71mbE+xU0A6S/TtpiHsrGJgf
 YcWqS20VxYBGoRLLvI9A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Beating on zswap+zsmalloc leads to the splat below, possible patch
below that.

[  139.794413] BUG: sleeping function called from invalid context at kerne=
l/locking/mutex.c:935
[  139.794585] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 907,=
 name: avahi-daemon
[  139.794608] 2 locks held by avahi-daemon/907:
[  139.794621]  #0: ffff8881010766d8 (&mm->mmap_lock#2){++++}-{3:3}, at: e=
xc_page_fault+0x15b/0x6e0
[  139.794659]  #1: ffff8881b6b13110 (&zspage->lock){.+.+}-{2:2}, at: zs_m=
ap_object+0x89/0x350
[  139.794691] Preemption disabled at:
[  139.794693] [<ffffffff812763a8>] zs_map_object+0x38/0x350
[  139.794719] CPU: 0 PID: 907 Comm: avahi-daemon Kdump: loaded Tainted: G=
            E     5.10.0.g3644e2d-preempt #4
[  139.794746] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09=
/23/2013
[  139.794766] Call Trace:
[  139.794775]  dump_stack+0x77/0x97
[  139.794788]  ___might_sleep+0x17d/0x260
[  139.794806]  __mutex_lock+0x47/0x9d0
[  139.794823]  ? zswap_frontswap_load+0xcb/0x240
[  139.794841]  ? zs_map_object+0x248/0x350
[  139.794858]  ? zswap_frontswap_load+0xcb/0x240
[  139.794871]  zswap_frontswap_load+0xcb/0x240
[  139.794886]  ? lru_cache_add+0xe9/0x1b0
[  139.794904]  __frontswap_load+0x6e/0xd0
[  139.794921]  swap_readpage+0x70/0x240
[  139.794939]  swap_cluster_readahead+0x1d9/0x280
[  139.794964]  ? swapin_readahead+0x140/0x3e0
[  139.794979]  swapin_readahead+0x140/0x3e0
[  139.794997]  ? lookup_swap_cache+0x5c/0x190
[  139.795016]  ? do_swap_page+0x2f7/0x900
[  139.795030]  do_swap_page+0x2f7/0x900
[  139.795046]  handle_mm_fault+0xa06/0x13b0
[  139.795083]  exc_page_fault+0x2a3/0x6e0
[  139.795110]  ? asm_exc_page_fault+0x1e/0x30
[  139.795139]  ? asm_exc_page_fault+0x8/0x30
[  139.795166]  asm_exc_page_fault+0x1e/0x30
[  139.795191] RIP: 0033:0x560caa4074d0
[  139.795215] Code: 89 05 e4 74 21 00 0f 84 28 06 00 00 e8 d9 13 00 00 e8=
 b4 12 00 00 44 8b 25 b9 75 21 00 45 85 e4 0f 85 ac 04 00 00 41 83 cf ff <=
48> 8b 3d b1 74 21 00 44 89 fe e8 d1 f6 ff ff 85 c0 89 c3 0f 88 d9
[  139.795299] RSP: 002b:00007ffeb4ec5ce0 EFLAGS: 00010246
[  139.795316] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007ff161=
6e4db4
[  139.795336] RDX: 0000000000000001 RSI: 00007ffeb4ec5c5f RDI: 0000000000=
000006
[  139.795356] RBP: 0000560cab63be60 R08: 0000560cab656220 R09: 0000560cab=
670750
[  139.795376] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000=
000000
[  139.795395] R13: 0000560cab63f550 R14: 0000560cab63c000 R15: 00000000ff=
ffffff

(CC Sebastian because RT has the ~same problem at the same spot,
curable the same way, or by fixing the upstream buglet then take
backports+fix, and nuking the associated RT patch)

mm/zswap: fix zswap_frontswap_load() vs zsmalloc::map/unmap() might_sleep(=
) splat

zsmalloc map/unmap methods use preemption disabling bit spinlocks.
Take the
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

