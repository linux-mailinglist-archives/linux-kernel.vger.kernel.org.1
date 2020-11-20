Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0252BB4F1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 20:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732260AbgKTTMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 14:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732234AbgKTTMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 14:12:21 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE64DC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:12:21 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 131so8774935pfb.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 11:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E/ELgvw+J09vz9vs0q6oZa1VgG1EOYdY7JKuts+v2/4=;
        b=aFVadyz1pX8uk5D4z1Jnv9buWn4SuTyoagqLC6b0/tkDVflrQu7ap+Q+ctQxfpTNwM
         5nLW5eOE1O4tpra4243m/6cBRinRoxKG4IYHFt1+8KZGATUNbHKEsAn2Sj9JRqFc2lpt
         ynovim53KD7OYb2bYWFvDGKhI5nzeXVDkg/R+xqqyyhh/RBAlamy8gFNZ++iLJWw1L57
         ytDIx1PHClses4H4OsoVJZOIXYdnqS+dx3u6Ac0mTTiKynw3tcOZgLHIFYcCFrl6+Pzb
         mRy01oUHGG6Na1BVPWZz3oFW3BAjfhNHfevE1jARulpThk67ufO72BSZfSdAHyQIqeW4
         y06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E/ELgvw+J09vz9vs0q6oZa1VgG1EOYdY7JKuts+v2/4=;
        b=jkIAey60cE7biIIvOe7a93X4N73fOXjvNQa113cDNTsPKvMs0x8SFzsXnvuJmI1BSh
         JTqrR4M04bq7xpeXsiOO6X/KpAzgyj/MO4kxVhaUzdgLZBH3fD0iLKs9/YxO4Ufktz4n
         v2WABtWH8J4RZJ2z4hfHGpzqx86JRTs8XDluXRBaCTRdVsKi+C4eIE+xAZCQLcXpqs0/
         9rzh5p0j3cFnTD4J35g/AYfOiKxfQuIw/qjSYvU+DXkCARZ1ucvtpYcgiU28yx0AA6eI
         TepCghG9qSbKN4meHAsdRZYTUdTuqe0uPm1xj0zTBa6kjN8Ru3ZOYaZX8x8hC4yDRo/o
         /Hkg==
X-Gm-Message-State: AOAM530y2goiLA+wgEL1oUZBjbt0L06bKnW+4BHm5Xf9Z8yZkFX4al9K
        AlhUQo/WRKhA5Qrut1hWBPGp0Q==
X-Google-Smtp-Source: ABdhPJx/EBQG4MqB+geHbSVfeWKms2Gkee+DKW+B14Z2ewvCaTkdRrHShNMzftA1IeeN8zXWp8lg7w==
X-Received: by 2002:a63:5262:: with SMTP id s34mr18391584pgl.382.1605899541288;
        Fri, 20 Nov 2020 11:12:21 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id cv4sm4695636pjb.1.2020.11.20.11.12.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 11:12:20 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: meson-axg-s400: add support for Power Controller & MIPI-DSI PHY
Date:   Fri, 20 Nov 2020 11:12:16 -0800
Message-Id: <160589952950.11499.3353982146380959022.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201120152131.3918814-1-narmstrong@baylibre.com>
References: <20201120152131.3918814-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Nov 2020 16:21:29 +0100, Neil Armstrong wrote:
> This adds the Power Controller and MIPI DSI PHY nodes to AXG, since the corresponding
> driver and dt-bindings had been applied for next release.
> 
> Dependencies:
> - Patch 1: [1] applied for 5.11 in meson-clk tree & [2] merged for 5.10
> - Patch 2: [3] & [4] both applied for 5.11 in phy tree
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: meson-axg: add PWRC node
      commit: 2a51ac31449a19bfb815f21f246134d6518ff781
[2/2] arm64: dts: meson-axg: add MIPI DSI PHY nodes
      commit: 413b63ddf2f85e84b0824770cf9f42ea768adcb4

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
