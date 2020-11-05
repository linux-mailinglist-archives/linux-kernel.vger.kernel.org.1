Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E552A8744
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732131AbgKETcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:32:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgKETcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:32:05 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560E9C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 11:32:04 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id f38so2042496pgm.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 11:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=0G0IXhBucv2N2cTx5Rb2GRJ7etitMG0FuNpN+t25+nc=;
        b=PjLYFotW85Hzzn/mygYTIri8c1tkd/uOrFnfzqsqSVUuWoe3HDI1iYRWT0eOtkDQ+K
         cRblOP2VwhS4JfrXpjcECI4IHFxsQOq5aMJ7hy+IE8Qk+ekDhHGDumhfpkweNhFoi1gN
         cTPs5ZEJt+kKRY1pcEi1TLwj+/dww9T//9bri1uG+Msd2x1VB1ZuZ0RiJftXrbIQyT3t
         MP+40b1yOHArf+N6wTT7JIsMAjOrPrKZDr0+HFf7IqVeHhFJAH8SqPMG4YggeGy6Fefq
         wMPXtBzbDf6Q6wuZoCdekN/8h2r/5eSrm4bev26zT3WPcngpnfD1o0T2sDyqTnVX52ZA
         hrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0G0IXhBucv2N2cTx5Rb2GRJ7etitMG0FuNpN+t25+nc=;
        b=QHrlEv7UmNgFAQB0y0NdTkmiUe4urcJlk+q5N5AaB7ddk8PGJt2d8vxiyBSoelCtnn
         xWJpmYAK3tGxoCNAPWCvpUHK9xpPAjTmmWwqFIC0Tl06640lQUVhmNtGSX6Fy+ANysfL
         QyoovIi9eXtQfOpnP/fqS7bolaXKGuYTOB6BvXdlY91gRUecEpT4hRarDmk2g4e9+ABV
         xfAClYtcFnSb4QsC+nrdtEjDrcBKRCkiDnYXJCkb5+ZBUFMHN0crIsmhWp6OT9JZwIUY
         OC6ZRw+tlhxr1TaK1celUMf3Z7fJz9DaRkySGTbagTuJFCfZAfYBne71NpdriHe9Svs1
         ZY2w==
X-Gm-Message-State: AOAM532MPBObirHrbgtK745mzLNKWqZrDbQltn9YjqAktPunH9TBGTlv
        Bod6A3Fgk5SMjx6wwSZFvFgBQQ==
X-Google-Smtp-Source: ABdhPJwLk25IEr/KbTgbdMV/O/td4Dl2rI/TQyX7dBwcjQ+1lsF952T2of4J8FxwGc57oT+u+sGeeA==
X-Received: by 2002:a17:90a:7303:: with SMTP id m3mr4167317pjk.190.1604604723708;
        Thu, 05 Nov 2020 11:32:03 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id z17sm3184518pga.85.2020.11.05.11.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 11:32:03 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-amlogic@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: add watchdog to g12-common dtsi
Date:   Thu,  5 Nov 2020 11:32:01 -0800
Message-Id: <160460471585.10458.582735384564499478.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201101021012.24519-1-christianshewitt@gmail.com>
References: <20201101021012.24519-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Nov 2020 02:10:12 +0000, Christian Hewitt wrote:
> G12 vendor kernels show the watchdog on the same address as AXG
> so add the node to meson-g12-common.dtsi. GX boards inherit the
> same from meson-gx.dtsi.
> 
> v2 fix typo in node name (s/wtd/wdt)

Applied, thanks!

[1/1] arm64: dts: meson: add watchdog to g12-common dtsi
      commit: 7bd5175918eb4b294c0979c75056f20fd90a50bf

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
