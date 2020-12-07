Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9992D1944
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgLGTQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgLGTQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:16:56 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68636C0611C5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 11:15:40 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id w4so9710622pgg.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 11:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LnJzU6WP+ovepSLXSSQvICT4T9pkTHcxFgl83M2eeOM=;
        b=WDZfW2GGW+OwwLdd1mDkLVpMquOO8r743tRXy7ZZx/quMtJTLjP1xxInmvFCGkdkdg
         CEVoivd1pwV7Td0TdrK3UceODWN1H7f8coh6Awe7qEIUMfUoDdl17IYqUomTr6EzN4t8
         iwghmAA1EfXEsoQhUbf8ttWm5oLb752zdBua8CJrdvxtmrvJbV9erktjUXVpqveb7f0x
         QQjW/AfZ3WGeztUfUxFEvlnCbuRORF7KKcbYUbSg6uUo37BTa3k7tlrAVhszVv3KN7FB
         MbEpsmF3aQdJXXe2Ljd8/F8TGzg+/5PhT2P6bFGxvIorFNCaXRMH+Ds8XqFCgVzHAQ+v
         gCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LnJzU6WP+ovepSLXSSQvICT4T9pkTHcxFgl83M2eeOM=;
        b=O3InyNzvBYutwVn4/R8QiFwH4mQCviRPG3Q8jUhG/PI3/iR4q3HJSE4BlCXO4bRW/f
         Uq3m3bsm3MALHjnbXk+jGxTH3WJkb4smQMLIS7NoJjl6jiLOcTP+DWj7LhSnFxz99/Yj
         sNn7Q2PcVQ0vBHlRlC0A3FUdbKmXTcZQ1LySE6STCXG1B9I5KjlkDH+kzWMFozVtr/Sx
         2xxyEghesQU3BYw7e55wCabkmD6Zehk/LViTueNjZz5//zA6gN+IhcJVDW6wWpJqlC1q
         dSYU6u/zthv1xETdI7gGcN2Eq2H9AdXKpkMI87HOUd4Y4804r2uIYJOPtDbrHmDkSC41
         JudQ==
X-Gm-Message-State: AOAM533HJbp6dS8abRd3OH8v2g+s22sNhy3MzxTg50xGdIQrw22gqg23
        rZyduPcP7tboXd6RIpjIGtUS4Q==
X-Google-Smtp-Source: ABdhPJzcpr2y042rE0RmoiIswrfb+gUUuUmyMfvbFPBdRSUxNrwCtJfF9J7y0zFe46jVLKJc7R+LZg==
X-Received: by 2002:a17:90a:6287:: with SMTP id d7mr303715pjj.80.1607368539904;
        Mon, 07 Dec 2020 11:15:39 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id k21sm14429457pfu.77.2020.12.07.11.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:15:39 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     martin.blumenstingl@googlemail.com,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        jbrunet@baylibre.com, christianshewitt@gmail.com,
        jian.hu@amlogic.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, narmstrong@baylibre.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v3 1/5] arm64: dts: meson: g12b: odroid-n2: fix PHY deassert timing requirements
Date:   Mon,  7 Dec 2020 11:15:34 -0800
Message-Id: <160736852894.39684.3406899524817191739.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <df3f5c4fc6e43c55429fd3662a636036a21eed49.1607363522.git.stefan@agner.ch>
References: <df3f5c4fc6e43c55429fd3662a636036a21eed49.1607363522.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Dec 2020 18:57:59 +0100, Stefan Agner wrote:
> According to the datasheet (Rev. 1.9) the RTL8211F requires at least
> 72ms "for internal circuits settling time" before accessing the PHY
> registers. This fixes an issue where the Ethernet link doesn't come up
> when using ip link set down/up:
>   [   29.360965] meson8b-dwmac ff3f0000.ethernet eth0: Link is Down
>   [   34.569012] meson8b-dwmac ff3f0000.ethernet eth0: PHY [0.0:00] driver [RTL8211F Gigabit Ethernet] (irq=31)
>   [   34.676732] meson8b-dwmac ff3f0000.ethernet: Failed to reset the dma
>   [   34.678874] meson8b-dwmac ff3f0000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
>   [   34.687850] meson8b-dwmac ff3f0000.ethernet eth0: stmmac_open: Hw setup failed

Applied, thanks!

[1/5] arm64: dts: meson: g12b: odroid-n2: fix PHY deassert timing requirements
      commit: 1c7412530d5d0e0a0b27f1642f5c13c8b9f36f05
[2/5] arm64: dts: meson: fix PHY deassert timing requirements
      commit: c183c406c4321002fe85b345b51bc1a3a04b6d33
[3/5] ARM: dts: meson: fix PHY deassert timing requirements
      commit: 656ab1bdcd2b755dc161a9774201100d5bf74b8d
[4/5] arm64: dts: meson: g12a: x96-max: fix PHY deassert timing requirements
      commit: 3d07c3b3a886fefd583c1b485b5e4e3c4e2da493
[5/5] arm64: dts: meson: g12b: w400: fix PHY deassert timing requirements
      commit: 9e454e37dc7c0ee9e108d70b983e7a71332aedff

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
