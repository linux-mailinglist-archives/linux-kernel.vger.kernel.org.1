Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A122AA513
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 13:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgKGMur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 07:50:47 -0500
Received: from relay5.mymailcheap.com ([159.100.248.207]:41085 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgKGMuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 07:50:46 -0500
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.102])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 1A108260EB
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 12:50:44 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay1.mymailcheap.com (Postfix) with ESMTPS id C38343F201;
        Sat,  7 Nov 2020 12:50:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id A6E0E2A2AD;
        Sat,  7 Nov 2020 07:50:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1604753440;
        bh=tmMTxex0xviZTza3yI7H9cx+GnPNw3k52CcnD5Axsfk=;
        h=From:To:Cc:Subject:Date:From;
        b=mYcIM9lGYiLxpeDM5q1T/11JHkGz6YeV6VdTQmS0LjIOITEJl/cyNKhj9ecfUv/Gh
         +/jU3xScDUuU2cV0WWOvpamISbHfYj72Ts9YnDlsVybCu4AimbxpPFZuvVzUjUvvnh
         UmPxaVnbSQzfHA6oAleHbazblAN53tn0sFNYgUxI=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HkuSMHwMp_fS; Sat,  7 Nov 2020 07:50:37 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Sat,  7 Nov 2020 07:50:37 -0500 (EST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 8B3EB4102D;
        Sat,  7 Nov 2020 12:50:36 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="debzbjfK";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.162.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id BDACB40849;
        Sat,  7 Nov 2020 12:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1604753418; bh=tmMTxex0xviZTza3yI7H9cx+GnPNw3k52CcnD5Axsfk=;
        h=From:To:Cc:Subject:Date:From;
        b=debzbjfKpWG513opRkJ4IxUrBZy0PJAK4/h2wEqE+WtWQxh8v5ZPoQl2G3y9b6qIP
         +oml9JSjYvAEXBSkyTgiV3i/Ykuen19DATwhg6evUsf72rzwkcGnxEdbFbwRz63p+q
         T5iSZDGZZ0fHopO34PAL/OMhbruSTn/1dLJ+r8tk=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/3] Switch PineTab DT LCD panel to retail one
Date:   Sat,  7 Nov 2020 20:49:58 +0800
Message-Id: <20201107124958.2222253-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8B3EB4102D
X-Spamd-Result: default: False [6.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.162.181:received];
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
         RCPT_COUNT_SEVEN(0.00)[9];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Retail PineTabs switched to K101-IM2BYL02 panel.

This patchset tries to reflect this change, and add a DT for samples
that still have K101-IM2BA02.

Icenowy Zheng (3):
  arm64: allwinner: dts: a64: pinetab: switch LCD panel to production
    one
  dt-bindings: arm: sunxi: add PineTab developer sample DT binding
  arm64: allwinner: dts: a64: add DT for PineTab developer sample

 .../devicetree/bindings/arm/sunxi.yaml        |  5 ++++
 arch/arm64/boot/dts/allwinner/Makefile        |  1 +
 .../dts/allwinner/sun50i-a64-pinetab-dev.dts  | 28 +++++++++++++++++++
 .../boot/dts/allwinner/sun50i-a64-pinetab.dts |  8 ++----
 4 files changed, 37 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-dev.dts

-- 
2.28.0
