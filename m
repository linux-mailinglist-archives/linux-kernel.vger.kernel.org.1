Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 741E31A4632
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 14:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDJMUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 08:20:20 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45209 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDJMUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 08:20:20 -0400
Received: by mail-qk1-f193.google.com with SMTP id m67so1835840qke.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 05:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j0xq3XxrlNu4Qc4ztwGcIn5i4ud0A4XU61qD7ZOx5Ag=;
        b=TqW0DwOwY4ZE4ujuXB+j46RD9fAxlH6saUZWhwloMR+92dlljvV53EXaZSVkYQRkKt
         RXMfV9++lq3AGwz7gkpUfax15VQm/u2byD4ddmdfGRByv/J9bgLbyPODdRvITXymQ5z0
         j9caCAIeja1c4XlXw2n43Us7FncnisZKjmQv4SwxgKd2vlqTGbSmoMy9V9UV88U2OYRJ
         RXe0qhBOU/m3U2QVvlwNj+mFMnZ8ZYIfQ0VckcTsWfeJC4FANa3/k95pdYOQuobUKIyw
         E9guFRZg4UF9wxfnmAEKgSpJSB4Oh5qJmDYnYAhs4FECpA1QBiX735CyjjLFRyjq51Q3
         lQHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=j0xq3XxrlNu4Qc4ztwGcIn5i4ud0A4XU61qD7ZOx5Ag=;
        b=SDoxMdqxaZFJeFmH6CFIRQxDTmsWzcG8WVzSEZV592dwdLBNwlJuE6wIj2TCjYJN47
         T8V+KlvgnFHwVxXPhMAbqY6T6wO9GlJV8+CNbWXDK4P7XPdhzJViIUO+ezOqGMsH0NAE
         nE8TGHMNBEWYpCZGY7Fkai/ndUPh/HHz90WBP4drcUH2HYCR56LKPRxf393PmNliACpy
         h5tDrwzAMhQM+Pl69W67cUYefqlAZzeHmXp/I0NCL2RJyIw6rhareIkaV1rJ/2hCqFZZ
         UdHI6Do4K6NfaFMW7c+JJH1kj1v33tfOQ15S2dAwGACQtVia4oEGDwUIRtwvfoVxtHW/
         XORg==
X-Gm-Message-State: AGi0PuaIJWc7wdYwcu46XMPZaLznC8wVMUK01gtVvD8nxFGsz7kb7uXi
        N9bmrg28I6Zx7j8xtnsZGgEFWw==
X-Google-Smtp-Source: APiQypJFXmrYehKyrmHS6x/fCnBdKOhdEzQUjMHenMUEYSOOd7PHRRzV9grmABzvA/R5mqzhwY+Bsg==
X-Received: by 2002:a05:620a:782:: with SMTP id 2mr562538qka.444.1586521219343;
        Fri, 10 Apr 2020 05:20:19 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id u13sm1425748qku.92.2020.04.10.05.20.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 05:20:18 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: s390 boot woe due to "block: fix busy device checking in
 blk_drop_partitions"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200410054544.GA17923@lst.de>
Date:   Fri, 10 Apr 2020 08:20:17 -0400
Cc:     Jens Axboe <axboe@kernel.dk>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5CC1C981-47F1-4C4D-A4D7-B6411D716A2F@lca.pw>
References: <AD16A450-794F-4EEA-A7BF-42452F18294A@lca.pw>
 <20200410054544.GA17923@lst.de>
To:     Christoph Hellwig <hch@lst.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 10, 2020, at 1:45 AM, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Please try this patch:

It works fine.

>=20
> ---
> =46rom f42fb98cc627f9b960fd5b9a3a229da5c5dcf54a Mon Sep 17 00:00:00 =
2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 10 Apr 2020 07:14:13 +0200
> Subject: block: fix busy device checking in blk_drop_partitions again
>=20
> The previous fix had an off by one in the bd_openers checking, =
counting
> the callers blkdev_get.
>=20
> Fixes: d3ef5536274f ("block: fix busy device checking in =
blk_drop_partitions")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> block/partitions/core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/block/partitions/core.c b/block/partitions/core.c
> index 1a0a829d8416..bc1ded1331b1 100644
> --- a/block/partitions/core.c
> +++ b/block/partitions/core.c
> @@ -496,7 +496,7 @@ int blk_drop_partitions(struct gendisk *disk, =
struct block_device *bdev)
>=20
> 	if (!disk_part_scan_enabled(disk))
> 		return 0;
> -	if (bdev->bd_part_count || bdev->bd_openers)
> +	if (bdev->bd_part_count || bdev->bd_openers > 1)
> 		return -EBUSY;
> 	res =3D invalidate_partition(disk, 0);
> 	if (res)
> --=20
> 2.25.1
>=20

