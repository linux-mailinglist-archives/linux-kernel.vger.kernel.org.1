Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448BB2D558D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388057AbgLJIj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:39:26 -0500
Received: from relay4.mymailcheap.com ([137.74.80.154]:51184 "EHLO
        relay4.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729351AbgLJIj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:39:26 -0500
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 7A20F3F1CF;
        Thu, 10 Dec 2020 09:37:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 974082A36D;
        Thu, 10 Dec 2020 03:37:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1607589471;
        bh=HrD7qhc1OoOzSJpP+kvA7JwyCtX8S/S3JfM3s9uS++M=;
        h=From:To:Cc:Subject:Date:From;
        b=n3fOsxEoCY3nMwK5EsRCREZgB2vZOatYxTXlHpNYfoIg1fYrUsXrqJmmk4vfHEVqn
         yrW7MaIH7D/KaMJTj/3nA4Eu1Rnv5IW6nBkg8f5fcgmBnThHZ/nUKLcNHZ8ZOPl9vq
         Ux40iszzm5rLwS5kYUfCsrHBHvK+A0ksJcbVf7xk=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y-zySdsHOGaz; Thu, 10 Dec 2020 03:37:50 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Thu, 10 Dec 2020 03:37:50 -0500 (EST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 1236040AA1;
        Thu, 10 Dec 2020 08:37:49 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="blumhc1d";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.161.121])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 539724119A;
        Thu, 10 Dec 2020 08:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1607589463; bh=HrD7qhc1OoOzSJpP+kvA7JwyCtX8S/S3JfM3s9uS++M=;
        h=From:To:Cc:Subject:Date:From;
        b=blumhc1dmI7Lp/XoWIpWvbr4oa+6uyYhG8y3CEA0ooYNcCYygcUYCdEv5/xrqZ6NX
         oSw1gQTqBxpAejB25qlg1sx0ZwZl49+VBBx5fq4zpZQBlwZZtvGKWIfo9xMv1Oir2d
         jNkENrgIAr4jX0/+fgJOr163tVPKRPddGJR3n58E=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/3] PineTab with new panel DT
Date:   Thu, 10 Dec 2020 16:37:22 +0800
Message-Id: <20201210083722.1912981-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [6.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.161.121:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all];
         DMARC_NA(0.00)[aosc.io];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[10];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Queue-Id: 1236040AA1
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed on the mailing list, here introduces a new DT for new
PineTabs.

Icenowy Zheng (3):
  dt-bindings: arm: sunxi: add PineTab new panel DT binding
  arm64: allwinner: dts: a64: add DT for PineTab with new LCD panel
  dt-bindings: arm: sunxi: note that old PineTab compatible has old
    panel

 .../devicetree/bindings/arm/sunxi.yaml        |  7 ++++-
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../sun50i-a64-pinetab-new-panel.dts          | 26 +++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-new-panel.dts

-- 
2.28.0
