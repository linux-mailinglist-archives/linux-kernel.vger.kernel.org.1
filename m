Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864EA292460
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 11:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbgJSJJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 05:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgJSJJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 05:09:16 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC34C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 02:09:16 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a17so4986109pju.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 02:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=uZj2/UkGwPHGYRDabmeLYz7fWi97ENwgCaw+/fZnSYg=;
        b=mFffBM5SCEC7HStDzuJnoAlobmVwBD4eyao2JgF0wZnAI/P+Kgnsw4kjjQgpTZQwIs
         YC3iuAxEFovt/87e4fkAD0q4BSMw84jvJsN1k3NiisvYNARvpkGzpPo1cgHuaDCWTeVC
         UmhtsSNm+1ns7HKxuCNUiwmZqTGT+na3z/jRstf2vKu70qwUMvL3onrbMFD+/R5mxJEf
         Xp2eMvNcM0Ze7E5ZT6JOdRJNKhjrtutkH9FWZhddenpL9r35OqVfmceptnGANqCULd5I
         NARjSr/WzyklS1gmtdIbsYVqw3AqUZvzS/49RbqlGA+TzLfMDgr/94wlYsVRpD1F20Gr
         5cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uZj2/UkGwPHGYRDabmeLYz7fWi97ENwgCaw+/fZnSYg=;
        b=eBdqlYownAm45TWLaDdvb0pEDIipo5/lfj4JB1Jk2TO3JieHzGGIHkaB6eeeFGAZ5R
         wP81g5y9aanfUcATOJpF5qsQ0AEyyRtiTbUB1sPZNKzC0sSjVmd2AFkq1d7xMpazLQM9
         QyZ0EG7kJhqvwPp2N6/rRDwpa66pOqq+aqpcG2fY6uTwx5UjN2CJ82KRJft9tY/Bu0OD
         1upTSmugPQvtDkpSnMje80sGoYro1uS7DM73FI2T7Wt+E7JnCByweIABn6AmvLFtohYe
         su0/rMVedBw6RIsL3K0+gUl+U6gPo+kniCGBdJvk+k09qM4R2ddXydrSQgfEfTYhR5cj
         RyWg==
X-Gm-Message-State: AOAM531nzLW6aX5bdkw1CUa2IrGcKkSQGAWKjKcnI10PIaURnmC/SDfF
        8CurC8IsHXz88eLFK9PkdwHl4NQus1s=
X-Google-Smtp-Source: ABdhPJxI4EO/P6d4Q9eq8l1sQFrZJO4zeg7b5XiYAqk9apQxYq/Tm5davUSsCKXQW0INQyia5aTfrA==
X-Received: by 2002:a17:90a:fd0f:: with SMTP id cv15mr16124050pjb.161.1603098555712;
        Mon, 19 Oct 2020 02:09:15 -0700 (PDT)
Received: from cosmos ([103.113.142.250])
        by smtp.gmail.com with ESMTPSA id f15sm11300828pfk.21.2020.10.19.02.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Oct 2020 02:09:14 -0700 (PDT)
Date:   Mon, 19 Oct 2020 14:39:04 +0530
From:   Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
To:     bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/nouveau: fix memory leak in iccsense/base.c
Message-ID: <20201019090854.GA2085@cosmos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak report:
  unreferenced object 0xffff9071c65644e0 (size 96):
  comm "systemd-udevd", pid 347, jiffies 4294898424 (age 810.828s)
  hex dump (first 32 bytes):
    02 01 00 00 00 00 00 00 00 00 10 00 02 04 00 00  ................
    00 00 00 00 00 00 a0 86 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000007c0d0ac3>] __kmalloc+0x337/0x500
    [<00000000551bfaeb>] nvbios_iccsense_parse+0xf7/0x280 [nouveau]
    [<00000000e3e8968b>] nvkm_iccsense_oneinit+0x6c/0x4e0 [nouveau]
    [<00000000287e7701>] nvkm_subdev_init+0x58/0xd0 [nouveau]
    [<0000000008e4793e>] nvkm_device_init+0x118/0x1a0 [nouveau]
    [<000000008cd3afa3>] nvkm_udevice_init+0x48/0x60 [nouveau]
    [<000000007e047aee>] nvkm_object_init+0x43/0x110 [nouveau]
    [<000000006c56b3a4>] nvkm_ioctl_new+0x184/0x210 [nouveau]
    [<0000000080abc890>] nvkm_ioctl+0xf0/0x190 [nouveau]
    [<00000000f35056a2>] nvkm_client_ioctl+0x12/0x20 [nouveau]
    [<000000000f001008>] nvif_object_ioctl+0x4f/0x60 [nouveau]
    [<0000000098d66807>] nvif_object_ctor+0xfb/0x160 [nouveau]
    [<00000000fe24934a>] nvif_device_ctor+0x24/0x70 [nouveau]
    [<00000000878b3286>] nouveau_cli_init+0x1a3/0x460 [nouveau]
    [<00000000a1578335>] nouveau_drm_device_init+0x77/0x740 [nouveau]
    [<00000000faef6b28>] nouveau_drm_probe+0x132/0x1f0 [nouveau]

Fix nvkm_iccsense_oneinit(), to free stbl.rail post iteration.

Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
index fecfa6a..23d91b6 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/iccsense/base.c
@@ -291,6 +291,7 @@ nvkm_iccsense_oneinit(struct nvkm_subdev *subdev)
 			list_add_tail(&rail->head, &iccsense->rails);
 		}
 	}
+	kfree(stbl.rail);
 	return 0;
 }
 
-- 
2.7.4

