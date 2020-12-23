Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42252E1AAD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 11:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgLWKA5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Dec 2020 05:00:57 -0500
Received: from lithops.sigma-star.at ([195.201.40.130]:34410 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgLWKA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 05:00:56 -0500
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 00029625DE06;
        Wed, 23 Dec 2020 11:00:13 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PvEedl0pH8YN; Wed, 23 Dec 2020 11:00:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 85EB3625DE07;
        Wed, 23 Dec 2020 11:00:13 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id X7jk5AndnOpC; Wed, 23 Dec 2020 11:00:13 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 591BE625DE06;
        Wed, 23 Dec 2020 11:00:13 +0100 (CET)
Date:   Wed, 23 Dec 2020 11:00:13 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Chengsong Ke <kechengsong@huawei.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wangfangpeng1@huawei.com, chengzhihao1 <chengzhihao1@huawei.com>
Message-ID: <135307670.158287.1608717613022.JavaMail.zimbra@nod.at>
In-Reply-To: <20201223062808.27512-1-kechengsong@huawei.com>
References: <20201223062808.27512-1-kechengsong@huawei.com>
Subject: Re: [PATCH] ubifs: Fix read out-of-bounds in
 ubifs_jnl_write_inode()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Fix read out-of-bounds in ubifs_jnl_write_inode()
Thread-Index: z+tkpY/z0vMi1cpMRZMXcPO+z7DtJw==
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
> 3. cd /root/temp && ls // change atime for link_file
> 4. wait 1~2 minutes
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 1e51764a3c2ac0 ("UBIFS: add new flash file system")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=210865
> 
> Signed-off-by: Chengsong Ke <kechengsong@huawei.com>
> ---
> fs/ubifs/io.c | 11 +++++++++--
> 1 file changed, 9 insertions(+), 2 deletions(-)

Good catch!
Please address the problem in ubifs_jnl_write_inode().
The length there needs to be properly aligned like all other journal
functions do.
I think you managed to trigger the issue because ui->data_len is not aligned.

Thanks,
//richard
