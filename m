Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1067428276F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 01:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgJCXtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 19:49:18 -0400
Received: from relay-us1.mymailcheap.com ([51.81.35.219]:39862 "EHLO
        relay-us1.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgJCXtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 19:49:18 -0400
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
        by relay-us1.mymailcheap.com (Postfix) with ESMTPS id C774A20DEE;
        Sat,  3 Oct 2020 23:49:16 +0000 (UTC)
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.102])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 056672008F;
        Sat,  3 Oct 2020 23:49:14 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay1.mymailcheap.com (Postfix) with ESMTPS id 910C13F1C5;
        Sat,  3 Oct 2020 23:49:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 75D9D2A361;
        Sat,  3 Oct 2020 19:49:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1601768951;
        bh=qAwEyk8bMnq0oXFGNBT19/TVcG/XHmTLrck2+ZDPto8=;
        h=From:To:Cc:Subject:Date:From;
        b=QOoj+k1P4kYBe5uLUO3B2dH4nvXdj5GvGl2epaKDCDT9C1L4mRxAXtlBBhlFsmCUo
         GnzI6jmy+9RyXFUj8oKHYYVqv5BBBIHvsJ8QWDn2O7s9PrN7RN4HBJKWGT1X/hUOTx
         iIoqsph5TQXmt7bhBifDReqHcicN8yJGh3XWBmPY=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fJ2aTtH-8zU4; Sat,  3 Oct 2020 19:49:10 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Sat,  3 Oct 2020 19:49:10 -0400 (EDT)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 543FC40BFB;
        Sat,  3 Oct 2020 23:49:07 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="bMw4jbMz";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.163.122])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 3359140BFB;
        Sat,  3 Oct 2020 23:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1601768940; bh=qAwEyk8bMnq0oXFGNBT19/TVcG/XHmTLrck2+ZDPto8=;
        h=From:To:Cc:Subject:Date:From;
        b=bMw4jbMz/qJt/gLhl2ScYpLWO0qtQDtqigU+FfNlms19Vy8KhK/rA/ALnJlcFRSxr
         UQZ1dRq8C5s8BuFPL3yuvZ0n5v9LPz1FUdBjkE0xFCabtUYT+3M13s3W/mHT9/yJL8
         nLo7fmXvEXTQl+4F+3RkW2qXMC1xFuZVSuQd1hrU=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/2] Try to fix DT schema problems for V3-series DTs
Date:   Sun,  4 Oct 2020 07:48:42 +0800
Message-Id: <20201003234842.1121077-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 543FC40BFB
X-Spamd-Result: default: False [6.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[9];
         FREEMAIL_TO(0.00)[kernel.org,csie.org,gmail.com];
         RCVD_NO_TLS_LAST(0.10)[];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.163.122:received];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         FROM_HAS_DN(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         MID_CONTAINS_FROM(1.00)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset tries to fix DT schema verification errors that exist in
V3-series device trees.

The first patch drops bogus properties that is not needed in PineCube
DT, and the second one adds compatible to the binding.

Icenowy Zheng (2):
  ARM: dts: sun8i: s3: drop bogus cells for CSI subnode on PineCube
  dt-bindings: sram: sunxi-sram: add V3s compatible string

 .../bindings/sram/allwinner,sun4i-a10-system-control.yaml      | 3 +++
 arch/arm/boot/dts/sun8i-s3-pinecube.dts                        | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.28.0
