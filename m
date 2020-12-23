Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E362E22A2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 00:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727712AbgLWXIE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Dec 2020 18:08:04 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:53396 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbgLWXIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 18:08:04 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CAD8A627AFD1;
        Thu, 24 Dec 2020 00:07:21 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SGMQu-kVD2FX; Thu, 24 Dec 2020 00:07:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 350BF6074003;
        Thu, 24 Dec 2020 00:07:21 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TI0iMxNtLuLf; Thu, 24 Dec 2020 00:07:21 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 05DAD627AFD1;
        Thu, 24 Dec 2020 00:07:21 +0100 (CET)
Date:   Thu, 24 Dec 2020 00:07:20 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Chengsong Ke <kechengsong@huawei.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wangfangpeng1 <wangfangpeng1@huawei.com>,
        chengzhihao1 <chengzhihao1@huawei.com>
Message-ID: <244303467.160590.1608764840819.JavaMail.zimbra@nod.at>
In-Reply-To: <20201223121536.6244-1-kechengsong@huawei.com>
References: <20201223121536.6244-1-kechengsong@huawei.com>
Subject: Re: [PATCH v2] ubifs: Fix read out-of-bounds in
 ubifs_jnl_write_inode()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Fix read out-of-bounds in ubifs_jnl_write_inode()
Thread-Index: 0xc6wfczRyckhgf1Nz6eomypQ1IBQg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chengsong Ke,

----- Ursprüngliche Mail -----
> The memory area allocated in ubifs_jnl_write_inode() is not aligned with 8
> bytes:
> ino_start = ino = kmalloc(write_len, GFP_NOFS);
> 
> When ino_start passed into write_head -> ubifs_wbuf_write_nolock:
>    n = aligned_len >> c->max_write_shift;
>    if (n) {
>      n <<= c->max_write_shift;
>      err = ubifs_leb_write(c, wbuf->lnum, buf + written, wbuf->offs, n);
>      // Read oob occurs here, read n bytes from buf, and buf is passed from
>      @ino_start which is
>      // not 8 bytes aligned(write_len < n). Program read (n - write_len) more bytes.
>    }
> 
> Reproducer:
> 0. config KASAN && apply print.patch
> 1. mount ubifs on /root/temp
> 2. run test.sh

What does test.sh do?

> 3. cd /root/temp && ls // change atime for link_file
> 4. wait 1~2 minutes
> 
> In order to solve the read oob problem in ubifs_wbuf_write_nolock, just align
> the write_len to
> 8 bytes when alloc the memory. So that this patch will not affect the use of
> write_len in other
> functions, such as ubifs_jnl_write_inode->make_reservation and
> ubifs_jnl_write_inode->ubifs_node_calc_hash.

I gave this a second thought and I'm not so sure anymore what exactly is going on.
The problem is real, I fully agree with you but I need to dig deeper into
the journal and wbuf code to double check that we really fix the right thing
and not just paper other something.

Thanks,
//richard
