Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACA42C7DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 06:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgK3FnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 00:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbgK3FnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 00:43:08 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED35AC0613CF;
        Sun, 29 Nov 2020 21:42:27 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id o4so7148953pgj.0;
        Sun, 29 Nov 2020 21:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Jj7pPkufdJFYA7JXeWZB2rlCobWl5PS1FAuCokbGgj8=;
        b=kDOkCuF1itdYBotj9jMsH/TWY3/i4n5JOv02oy0KFZjgMtZZfQR/z78JA9V8OZfCNh
         xd8Rt6oNmjjCr6RlRX1u6jcGaFRXS+1fZBRSaR8QVMNQZzmeljPeD7v5IzXZoJh6TZfm
         yjYsxi1lVedDKtw+pfTI2AgDH9/mSk4ypHYvgB8wdz4XNEbAMBLZpsWYNPG97taAS67U
         zMH/vCu9mFAcmUGn0qgR/L5aHM/YwmazW5VEnts9dXy8Qs0uVk98VE1zQhfdBI7n37NP
         ZWvOrx+ShTRELF3LWlsBdOPwPCJ06d2ccWpMCyvHOaAD+NFtlsaSxfjvrJQRKaEOGYUS
         5BXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Jj7pPkufdJFYA7JXeWZB2rlCobWl5PS1FAuCokbGgj8=;
        b=omUAjAiK44MTea7JNUUmW6HgSgfDZfvW3FuCjj4NbPCAWy9PMK5j7NEiqvMHhf/uP2
         3l3yXLDsPX6PWTvU8ill1HI3MnJmWAgieuwS+ajzymLKKFeqHichmyn9ja+SCagBii1H
         atQuP2iWX8gt07Bw8UoTJzPzHHyO25EWiQU0lt8dk0MK2TT7W5/10bMCjn6MHd2EJ7XY
         74+P5bR/Tof5MBvVodR0uxG6IMp4032SGDmXzUr0+/T9cRioiDMFnaVAi0HcrRuvTzqH
         SmzKFERCaKZytlBVd1yqw91+zYT430hMK6JjaodPjWkQcyV7QomsulRt5N3ICKSjcyrJ
         Vl1g==
X-Gm-Message-State: AOAM532dkBNaBoyBfe7Hva0QD+n2U0HjFUgZJFAYVJGk2jvAR4QPgfFI
        HoEgzv/bZE0zhqbpMjleBMY=
X-Google-Smtp-Source: ABdhPJyVHngl3g10ZWwcaID/ZsNGS//WYaRR+cw9tRgeUHVYmz8jdEYdgJ+cvGUlxYByyKdtPVBHEw==
X-Received: by 2002:a63:5126:: with SMTP id f38mr16295073pgb.11.1606714947381;
        Sun, 29 Nov 2020 21:42:27 -0800 (PST)
Received: from anyang-linuxfactory-or-kr ([106.250.177.234])
        by smtp.gmail.com with ESMTPSA id nm6sm5966597pjb.25.2020.11.29.21.42.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Nov 2020 21:42:25 -0800 (PST)
Date:   Mon, 30 Nov 2020 14:42:21 +0900
From:   Dongjin Kim <tobetter@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-sm1: fix typo in opp table
Message-ID: <20201130054221.GA25448@anyang-linuxfactory-or-kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The freqency 1500000000 should be 1512000000 in 'opp-1500000000'

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 71317f5aada1..aba1214c4d09 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -131,7 +131,7 @@
 		};
 
 		opp-1512000000 {
-			opp-hz = /bits/ 64 <1500000000>;
+			opp-hz = /bits/ 64 <1512000000>;
 			opp-microvolt = <800000>;
 		};
 
-- 
2.17.1

