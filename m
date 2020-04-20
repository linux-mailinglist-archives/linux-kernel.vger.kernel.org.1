Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150141B0427
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 10:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgDTIR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 04:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgDTIR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:17:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3ECC061A0C;
        Mon, 20 Apr 2020 01:17:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f13so10924079wrm.13;
        Mon, 20 Apr 2020 01:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=xWWYZZkn96vz28jBPg9E8o7pX7If6HIppr7CMMUHTf0=;
        b=HoKmAI+m6Gfih+/P2892QrRqfWoNJy5kjXoG5RwXaYWlmjp1BKtn4fDgchd3yjso7S
         LY1gCAcTkIYGB11AxDCUhOr5lqsKB2R38eK1bOIFEhSlxnD5LlRijCv9pgub6AG8799y
         Oh6Pfri4EI9/yoyPhZEC9hYFkOZiecIGMiBoeoJchWyv2ZahYuYmAKAMS59JwfLzQthM
         U1PLXrG2Y5RIBAad8IaZeXL6FD0Q6EKPKezGcFUOezBYIPZVyUpunBkiXorxWFmua5Bz
         dxndUCZcvI25fTWslpwQJTGKJJ282lIlj5Y7c7JZJ8r0O9J1H3STV5EOwuSN4dkP3AzH
         KjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=xWWYZZkn96vz28jBPg9E8o7pX7If6HIppr7CMMUHTf0=;
        b=BKIs4lKtrSeAz7ESE1labNr/TOfMsWkDh8qBKmI+FGNBuh8aZB4f3pU5ZOHhDfUd7b
         q866ODgXmWN8wm7guszoKfhpX5xoltK6nMCosHzyMLhI8I9QOjyJGJb5ylnt7UKAAD24
         RGrYrA2X/wgkBlunA9tSUtDzJHD4eTaBYe5tc2exGDtD8ctDzfSe+N7jCp0YxdwlG9LR
         Ort21+LQRX5+rVso+C8LJflhCXllQkxazklNpWY4Djnn/VSo7fZ/TfgMobui9xF/C8YW
         VbIqwGmGONT985ZKJnBtVbrkPFAdBymRs85h4nqxej92UtwXkIAN6B7BHdopylM1hOub
         kuNA==
X-Gm-Message-State: AGi0Puajxh5iaMXXgsnCrrsyr4wipe82+tn4z0xiJutbip4sN+aZCay4
        NM+mt33+4w/WGIztYF0mjHo=
X-Google-Smtp-Source: APiQypJ6u9yKWzd+bgvkeKCApxElgRcILeTrp6Hohbd99rqXgr1wqEbKDV1XZeoPVA/9ScN5Y8riFA==
X-Received: by 2002:a5d:428a:: with SMTP id k10mr17448191wrq.59.1587370646030;
        Mon, 20 Apr 2020 01:17:26 -0700 (PDT)
Received: from felia ([2001:16b8:2d8c:a200:646f:8a6f:3448:4e5a])
        by smtp.gmail.com with ESMTPSA id k3sm141639wru.90.2020.04.20.01.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 01:17:25 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 20 Apr 2020 10:17:18 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Thomas Zimmermann <tzimmermann@suse.de>
cc:     Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Duplicated DMA-BUF HEAPS FRAMEWORK in MAINTAINERS on next-20200420
Message-ID: <alpine.DEB.2.21.2004201003340.7417@felia>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

on next-20200420, ./scripts/checkpatch.pl -f MAINTAINERS and 
./scripts/parse-maintainers.pl report a number of issues:

WARNING: Misordered MAINTAINERS entry - list file patterns in alphabetic 
order
#5059: FILE: MAINTAINERS:5059:
+F:	include/linux/dma-resv.h
+F:	include/linux/*fence.h

WARNING: Misordered MAINTAINERS entry - list file patterns in alphabetic 
order
#5060: FILE: MAINTAINERS:5060:
+F:	include/linux/*fence.h
+F:	Documentation/driver-api/dma-buf.rst

WARNING: Misordered MAINTAINERS entry - list 'T:' before 'K:'
#5062: FILE: MAINTAINERS:5062:
+K:	\bdma_(?:buf|fence|resv)\b
+T:	git git://anongit.freedesktop.org/drm/drm-misc

WARNING: Misordered MAINTAINERS entry - list 'L:' before 'S:'
#5073: FILE: MAINTAINERS:5073:
+S:	Maintained
+L:	linux-media@vger.kernel.org

WARNING: Misordered MAINTAINERS entry - list file patterns in alphabetic 
order
#5077: FILE: MAINTAINERS:5077:
+F:	include/uapi/linux/dma-heap.h
+F:	include/linux/dma-heap.h

WARNING: Misordered MAINTAINERS entry - list file patterns in alphabetic 
order
#5078: FILE: MAINTAINERS:5078:
+F:	include/linux/dma-heap.h
+F:	drivers/dma-buf/dma-heap.c

WARNING: Misordered MAINTAINERS entry - list 'T:' before 'F:'
#5080: FILE: MAINTAINERS:5080:
+F:	drivers/dma-buf/heaps/*
+T:	git git://anongit.freedesktop.org/drm/drm-misc


Header 'DMA-BUF HEAPS FRAMEWORK' already exists at 
./scripts/parse-maintainers.pl line 159, <$file> line 5109.


I tracked this down to commit 08d99b2c23df ("Merge drm/drm-next into 
drm-misc-next") visible in next-20200420.

It seems that this commit adds the DMA-BUF HEAPS FRAMEWORK a second time 
in its state before the reordering into MAINTAINERS through this merge.

Possibly, you can clean this up? I am happy to support with further 
patches if it is clear what we should do here.


Best regards,


Lukas
