Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689252E20EA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 20:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgLWTdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 14:33:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55928 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbgLWTdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 14:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608751915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IMMzliPJltnJSKAXZOaKlHE4t3zwiI7ZHw+YJUrquL4=;
        b=NhA6RvYjmlaKmL2I4shcyZFCCtDfI9g/jpYlosqlFKBLCkWBw8LNJ2rqAPIm5b+v75x8U/
        fryysQwDhgidU8x41bS5YXAqQ29bguDYRlIf0ntnl3YA7k2J5/nZMv2zNRpMXYbUtc4HsU
        WHwbjl4yY/It0RAW7m5ZgufkN15LSzY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-ynUmLhVwPf-VA3rlvsqF2A-1; Wed, 23 Dec 2020 14:31:53 -0500
X-MC-Unique: ynUmLhVwPf-VA3rlvsqF2A-1
Received: by mail-qt1-f197.google.com with SMTP id t7so14534qtn.19
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 11:31:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IMMzliPJltnJSKAXZOaKlHE4t3zwiI7ZHw+YJUrquL4=;
        b=stRU/N226NIs+ETi9LrdnGDyq6fp5ndcKVJHscpfgqdk270xnu2CngdBglcM8GJMzR
         EbBspt66qkT8usptNQGpc+h58gdwL9WsrW+4sf4uBUzqbJXiO4LK1ds21FdxXGHMH2N3
         NE45ENaKa/i0/n5g8rLvQcoxp4NcCTLFO7Yc2f1+V8ckDpnczhmR9TQxyq4xsDBzWw6a
         ujqQHfPqr/JgD0ycnCCiUlNqGiRQbmEeTfaaraFzpXdjpgQL7Oo92Jvelj0jkWVe7s6/
         LU+W63sSU7NeNG21VIaVEGzABg3UqEclp0ptUYFMh1X+X9S0S9HilWnEXiR5fgKzrwMl
         QsJg==
X-Gm-Message-State: AOAM5302EeK4c4Rd9iY4endCMHNt/95nmTvMxHn3RZKUHTO1Z5rAL7SS
        OZqIX2/IQQrtFHPeZ5PTYXxW173PHyUB2PymYZn5VFL20g6bhSxXveJng4EqDoix5duY0bIDdvT
        Zu/ehv2DFExkOikFMmCKHnhAg
X-Received: by 2002:a37:9f82:: with SMTP id i124mr28376820qke.264.1608751913032;
        Wed, 23 Dec 2020 11:31:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwi/OMM/MITqjGQW17zbEfqi8WbAkgk/usV9HUq/eBvDm1TbQeVMU4ddfCjtHUaIjfIMqO1sg==
X-Received: by 2002:a37:9f82:: with SMTP id i124mr28376790qke.264.1608751912830;
        Wed, 23 Dec 2020 11:31:52 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f6sm15956912qkh.2.2020.12.23.11.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 11:31:52 -0800 (PST)
From:   trix@redhat.com
To:     netanel@amazon.com, akiyano@amazon.com, gtzalik@amazon.com,
        saeedb@amazon.com, zorik@amazon.com, davem@davemloft.net,
        kuba@kernel.org, sameehj@amazon.com, shayagr@amazon.com,
        amitbern@amazon.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] net: ena: remove h from printk format specifier
Date:   Wed, 23 Dec 2020 11:31:44 -0800
Message-Id: <20201223193144.123521-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

This change fixes the checkpatch warning described in this commit
commit cbacb5ab0aa0 ("docs: printk-formats: Stop encouraging use of unnecessary %h[xudi] and %hh[xudi]")

Standard integer promotion is already done and %hx and %hhx is useless
so do not encourage the use of %hh[xudi] or %h[xudi].

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index 02087d443e73..764852ead1d6 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -863,7 +863,7 @@ static u32 ena_com_reg_bar_read32(struct ena_com_dev *ena_dev, u16 offset)
 
 	if (unlikely(i == timeout)) {
 		netdev_err(ena_dev->net_device,
-			   "Reading reg failed for timeout. expected: req id[%hu] offset[%hu] actual: req id[%hu] offset[%hu]\n",
+			   "Reading reg failed for timeout. expected: req id[%u] offset[%u] actual: req id[%u] offset[%u]\n",
 			   mmio_read->seq_num, offset, read_resp->req_id,
 			   read_resp->reg_off);
 		ret = ENA_MMIO_READ_TIMEOUT;
@@ -2396,7 +2396,7 @@ int ena_com_fill_hash_function(struct ena_com_dev *ena_dev,
 		if (key) {
 			if (key_len != sizeof(hash_key->key)) {
 				netdev_err(ena_dev->net_device,
-					   "key len (%hu) doesn't equal the supported size (%zu)\n",
+					   "key len (%u) doesn't equal the supported size (%zu)\n",
 					   key_len, sizeof(hash_key->key));
 				return -EINVAL;
 			}
-- 
2.27.0

