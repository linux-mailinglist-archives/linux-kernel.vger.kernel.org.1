Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3C9302A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 19:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbhAYSqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 13:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbhAYSnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:43:06 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889F1C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:42:26 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id 31so8190613plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Q1SeF2s/DOLhyrOyKgBakT7b/doGN2Q3Ae7/R3HebVk=;
        b=o+tw8sjX0uJ14bRLrUXrIfbNecZ0kkQ+N/BxD4ZeO4jVV3Znvyq5q5Yl/uTUTTljS1
         478N/0lEuiof0nTnC0w37vPwmZgwIciGZkYgCLBhkW8frsQtI/4Sf/+iu4rOD99wsP4u
         KdziPrhQgzsWwy8nryVzz2dsYQKt3hCMfjLE0BTybUhhoLlB17Q1/azYDIve2iEqqOp6
         e+3qaUGBQuXiu0+cK5aqQgQ8cCdWH3KYIvUvKyd4db3nXMNayV8VSiQftrfG/Kj9MF8t
         z3NYTtuSCuAItS4AoSZTsRf58wxnRMC1R61Uvb3Yc/JBwYOTv32h/O79X8m+HUdH8rmK
         zQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q1SeF2s/DOLhyrOyKgBakT7b/doGN2Q3Ae7/R3HebVk=;
        b=E0RdhqRAShgmslfrhQ1FyRUmRN5RZOkSw2OXgNu0Jae1QBEiqvFcf4rJM9MKEMd6eQ
         oil0IwxxABHJJJJTqenSV3C+rRKMRNIpVwkm//RbmRIiX5PcUKTA87C5CvrLSUVbIzvu
         t+xj46YcpzPNUmrZHSO7CcW5QXJuH9mAMY5tFbv8/7Z3pJaLI9fg2pMoWQt9c+ZLaevv
         nmjD44IpKPi/RPGNiHiV1SeUAwisSpRdQ59G/un+Bw5AdSt5xmF4ygnufUXjW1etBO05
         SxIHSnMdlLzNUglQCDT7GhZ9e2aVpXc7EoaBhuYphzbxll0ilk6DnMf+dk99i5e/fS6R
         M5iw==
X-Gm-Message-State: AOAM5333MjYGwGmiyzGXTsJ/D6BHKPg25w2TX9rIMKu5qlSdpfACSyEt
        1BSi/FZsHhdB5x376TZmZ29elH5esHY+n9KY/gg=
X-Google-Smtp-Source: ABdhPJwjCcv4RRP9CigW3gQV1lycuRcJwmMDSLYrsymwEU6kAYy+01iyMr5Zb7AiKWIUwTUT9ji2gQ==
X-Received: by 2002:a17:90a:7d08:: with SMTP id g8mr1623836pjl.180.1611600146133;
        Mon, 25 Jan 2021 10:42:26 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id w20sm18981643pga.90.2021.01.25.10.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 10:42:25 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/2] arm64: dts: meson: add support for Beelink GS-King-X
Date:   Mon, 25 Jan 2021 10:42:20 -0800
Message-Id: <161160013614.17631.15425630960344817638.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210119145734.12675-1-christianshewitt@gmail.com>
References: <20210119145734.12675-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jan 2021 14:57:32 +0000, Christian Hewitt wrote:
> This series adds bindings and device-tree for the Beelink (AZW) GS-King-X,
> which like GT-King and GT-King Pro is based on the W400 reference design.
> 
> Changes since v2:
> - shorten audio card name to GSKING-X
> - add Neil's tested-by
> - add Martin's reviews
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: amlogic: add support for the Beelink GS-King-X
      commit: 39f5e36d5d2b5cae17cfac1f2cd038f0f8bc834b
[2/2] arm64: dts: meson: add initial Beelink GS-King-X device-tree
      commit: f3d4ad4f106e21161d232c41a6676416e2498ae4

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
