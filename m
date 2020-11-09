Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 926E32AB0D9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 06:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgKIFec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 00:34:32 -0500
Received: from relay3.mymailcheap.com ([217.182.119.155]:40791 "EHLO
        relay3.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbgKIFeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 00:34:31 -0500
X-Greylist: delayed 146424 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Nov 2020 00:34:29 EST
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id BE8963ECDF;
        Mon,  9 Nov 2020 06:34:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 0DFF42A34E;
        Mon,  9 Nov 2020 00:34:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1604900067;
        bh=kezafdLDXkw9ugbI/iH8HxtYMYAGAZ09l+KOu0Rdrf4=;
        h=From:To:Cc:Subject:Date:From;
        b=ZySsbN7E32/eGSN/+WvsFDWqM3wOIg91npbNVENW20Bef+pf5FzfqdMPJDxymtvrU
         6VKX25IZ2YNQsPMqea2CwLjypAtR9ZfaQDWMbKbmQcj8owGByZZlrkEvlzm0Q+/M/X
         +hEhVX8KyblocEl+wmSuzLx/WeKbDA9mj1h4BzxU=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fwhZdbuYE7bk; Mon,  9 Nov 2020 00:34:26 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Mon,  9 Nov 2020 00:34:26 -0500 (EST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 9718341E35;
        Mon,  9 Nov 2020 05:34:24 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="xsZga7Ng";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from ice-e5v2.lan (unknown [59.41.163.164])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 0952E41E32;
        Mon,  9 Nov 2020 05:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1604900053; bh=kezafdLDXkw9ugbI/iH8HxtYMYAGAZ09l+KOu0Rdrf4=;
        h=From:To:Cc:Subject:Date:From;
        b=xsZga7Ng8zIDYchIUW6V+U/0g5fk0/6gq+txyRU3EtqJ2Yj8uVAUUQ8bHe7K1psVs
         qqDiM+ZRq2YdR1kd53Jqsql8+uHEqRluwIFpXOSmvvH9MdY3ew93mpOYTlLbKiuZdi
         2505TmcnUG8RKcfjCX0qGRzdfoO0V1ysFe9nMoJA=
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Ondrej Jirman <megous@megous.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [RFC PATCH 0/2] clk: sunxi-ng: a64: Remove CPUX mux switching
Date:   Mon,  9 Nov 2020 13:33:56 +0800
Message-Id: <20201109053358.54220-1-icenowy@aosc.io>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9718341E35
X-Spamd-Result: default: False [4.90 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.163.164:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[9];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to Ondrej Jirman, switching of the mux of CPUX clock is one of
the sources of timer jumps on A64 (and maybe this will also lead to
timer jump on H3).

This patchset tries to remove this mux by disabling the dividers in
PLL-CPUX. Both the lack of reparent when relocking and the prevention of
PLL-CPUX dividers are behaviors of the BSP kernel.

Icenowy Zheng (2):
  clk: sunxi-ng: a64: disable dividers in PLL-CPUX
  clk: sunxi-ng: a64: disable mux and pll notifiers for CPUX reclocking

 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 93 ++++++++++++++++++++++-----
 1 file changed, 78 insertions(+), 15 deletions(-)

-- 
2.28.0
