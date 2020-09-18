Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 887DA270730
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 22:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgIRUkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 16:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgIRUj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 16:39:59 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6A5C0613D0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:39:59 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f18so4170364pfa.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 13:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0fmRn2g5BrFJHO9DbWyRy8DsUXY0bsMT/zVu/iCfx28=;
        b=C3FMMHryX4w/Eoq3d71K/IbeMCK+8a4DuC/vM88BYodyxLOnc+wAYGfIerEO8KBjf1
         f1RINcWhWEQDkAF+HvOzymCJYGNHb0o/zzYsHmp4bC90sa2uwRERZaU8MX+7Fz1OrYcW
         R6++RCw1ms3Pvbn84yh0bbtGol9/3oOh+gpvdt2pWI4x1D6qzDQfn2si/fdQSK1mEExe
         0uH0/xaOWG9/7bk2fm6SLGuD6EXcHK+mfiR24jq4N0ogdBjdZpdSw6VEQfmMYzKE8uYW
         9OZqQVZp9wo10gaj8cv2w1KAoWc+NJaWzlVR09lxmqx5yTlZsIQPI6qddvPw41SdBBsC
         JIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0fmRn2g5BrFJHO9DbWyRy8DsUXY0bsMT/zVu/iCfx28=;
        b=BnXdz7g1EPkeMH8AWvV0e64Tt3+laitbaYTHpjeBSzmWzdEauAsm25IY8S+uK4Npmc
         OuWYrV3vwjUH/gZdnf6h/Zl2mc3MksNwFZjzqpN8nuknX+btB3mGXuya1s/rbiTQfJoP
         t7Wo8F7E3ZzZn98TQFCAAV4o9f2z8CY3OClNjG10OmCboiarJebbfhfIXh+JLB09X9Jw
         StT3crXw9taUma2/to0LWiMuR8ZYuHi7gRU8qReNMbhecSJ/5DbksfrdFlmR78vb+dGq
         56F+uRAtDpfIsemidzx8T9ondF56jzwK3SpmW+pvqu92QlHA00SRNLJqIwhLa0a37455
         ngvg==
X-Gm-Message-State: AOAM5329SIiV8uUgQQGvG5pNpi3z6Fgo23JqjnLlCWzeOLKgunnd4BRa
        nj0GBOJcdtqVce+axrJ4Wc/SNA==
X-Google-Smtp-Source: ABdhPJxf7pw4SsIj98qaw2E1WmIktjbeW77TUqAefjrsz31jaQx0Qwe98HQKFmjlYBU1hBtpf29vUg==
X-Received: by 2002:aa7:8249:0:b029:142:2501:39dd with SMTP id e9-20020aa782490000b0290142250139ddmr17389707pfn.44.1600461599016;
        Fri, 18 Sep 2020 13:39:59 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id j18sm3979209pgm.30.2020.09.18.13.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 13:39:58 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     christianshewitt@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        tobetter@hardkernel.com
Subject: Re: [PATCH v2 0/3] arm64: dts: meson: add support for ODROID-N2+
Date:   Fri, 18 Sep 2020 13:39:56 -0700
Message-Id: <160046158476.39596.3643985967347076144.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200915152432.30616-1-narmstrong@baylibre.com>
References: <20200915152432.30616-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020 17:24:29 +0200, Neil Armstrong wrote:
> This series splits the existing meson-g12b-odroid-n2.dts into a common
> dtsi and dts, and then adds new bindings and dts for the ODROID-N2+
> which uses an Amlogic S922X rev.C chip that Hardkernel supports with
> the same OPPs as the A311D.
> 
> Changes since v1 at [1]:
> - rebase on khilman's v5.10/dt64
> - get all review tags from v1
> - use the A311D OPPs, after review of Vendor kernel, the Rev, C uses the same OPPs (freq + voltage)
> 	as the A311D SoC of the same family
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: meson: convert ODROID-N2 to dtsi
      commit: ef599f5f3e10bf1979d8ece29fd7fa511fedd59d
[2/3] dt-bindings: arm: amlogic: add support for the ODROID-N2+
      commit: 88ba71cdc5497390350c87e68ce35688e88be3e8
[3/3] arm64: dts: meson: add support for the ODROID-N2+
      commit: 98d24896ee117b1f0969405476c943e9307e30d4

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
