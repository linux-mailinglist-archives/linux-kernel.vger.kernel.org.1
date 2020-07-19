Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8042C2252E8
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jul 2020 19:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgGSREr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jul 2020 13:04:47 -0400
Received: from relay5.mymailcheap.com ([159.100.248.207]:40753 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgGSREq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 13:04:46 -0400
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.66.162])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 926B226207;
        Sun, 19 Jul 2020 17:04:43 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id 40EBE3EDEC;
        Sun, 19 Jul 2020 19:04:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 209F12A6D5;
        Sun, 19 Jul 2020 19:04:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1595178281;
        bh=osOYVWjBgvnZfBvRnCBhngvsXrIwFrLGFgseB6Kbr8M=;
        h=From:To:Cc:Subject:Date:From;
        b=YSp5HYd2xSeFOyiw9Clx6R1EP3lQBKhlSLfh7SW6fMLcyeo58Cb1R9lZqnVNjjfdt
         w+lvjHIzwCA0tZorz1p8cNOw2ezplhdlTEp1QX4zn1Enu8z5iQyLgHs4ciEwi6zlVU
         dHlE5DlqApjYe55n6EODr+5V46TEAE76kRZZ9UnI=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id h4fQaNZ63w1v; Sun, 19 Jul 2020 19:04:40 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Sun, 19 Jul 2020 19:04:40 +0200 (CEST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 35FA840856;
        Sun, 19 Jul 2020 17:04:39 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="dELVP1rf";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.163.116])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 726D240856;
        Sun, 19 Jul 2020 17:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1595178270; bh=osOYVWjBgvnZfBvRnCBhngvsXrIwFrLGFgseB6Kbr8M=;
        h=From:To:Cc:Subject:Date:From;
        b=dELVP1rfpxCKnJXBbSFQScCMFzIyvjoVyNtU4cGpk/qFe/70Cve2OT83eNeyS0As/
         0cWAwLEIUa8uFIK3OQTMUZ5Ek4baF7IObNp8wLO2w0mHxE976aGMjMIF3q3oRFrDKK
         TkUfnhONd1bvQmVTrNOXrDHCNHhABB8I9XOBF9vo=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 0/4] Add support for Feixin K101-IM2BYL02 panel
Date:   Mon, 20 Jul 2020 01:04:06 +0800
Message-Id: <20200719170411.275812-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 35FA840856
X-Spamd-Result: default: False [6.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[8];
         FREEMAIL_TO(0.00)[gmail.com,ravnborg.org,kernel.org];
         RCVD_NO_TLS_LAST(0.10)[];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.163.116:received];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         FROM_HAS_DN(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_IN_DNSWL_NONE(0.00)[213.133.102.83:from];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[]
X-Rspamd-Server: mail20.mymailcheap.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The controller chip of Feixin K101-IM2BA02 is going to be discontinued,
so Feixin start to provide K101-IM2BYL02 panel as a replacement, which
utilizes Ilitek ILI9881C controller.

Add support for K101-IM2BYL02 panel.

By the way, is there a way that can try both kind of panels in the same
kernel/DTB combo? K101-IM2BYL02 has the same pinout with K101-IM2BA02,
and PineTab schedule to switch to it w/o modifying the mainboard.

Icenowy Zheng (4):
  drm/panel: ilitek-ili9881c: prepare for adding support for extra
    panels
  dt-bindings: ili9881c: add compatible string for Feixin K101-IM2BYL02
  drm/panel: ilitek-ili9881c: add support for Feixin K101-IM2BYL02 panel
  [DO NOT MERGE] arm64: allwinner: dts: a64: enable K101-IM2BYL02 panel
    for PineTab

 .../display/panel/ilitek,ili9881c.yaml        |   1 +
 .../boot/dts/allwinner/sun50i-a64-pinetab.dts |  10 +
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 273 ++++++++++++++++--
 3 files changed, 265 insertions(+), 19 deletions(-)

-- 
2.27.0
