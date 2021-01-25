Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E633037EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 09:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390123AbhAZIbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 03:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbhAYSnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:43:04 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5480C061573
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:42:23 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id h15so5723570pli.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tDtRKtyqGRuQ4lrMOTvgY4qxd3EwftJYAalx5ZLkrgw=;
        b=LWMBnxG8unZRG+UvzmG3L24ysojyWa1nwbyH6d5X2gSMoOdo7jRTlPU9f63gUJVVow
         INK6pVue3wFGiqqPvUNILYVDMR1xmvqhJX0AyXN6uwgZlOL6FTpz86FDR9+Z3+/tLnJ8
         STsOPy1cidOwveW/an+09+T76NYMHGv15PXKQgTE8u+q3TKLY4T6POinski4DpBUMDdf
         9EJIZMdS+6DN/fEYdNjzicoxpoxhbV75rwCjJGEo1alCfD3zi5ZGNm2117lnzZYzqO5P
         c6ym1AQyOqX00ZL8F5/Vo8B7pu8VG+oHalQuNPCORjmmvO4Y7m2WCj8fUwENocMamb55
         mEFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tDtRKtyqGRuQ4lrMOTvgY4qxd3EwftJYAalx5ZLkrgw=;
        b=QCCWxnKl5WXWmF0zretdefXmryJt84rMsZ3W6EaSgL745NuTS6t8fCvlKYcTEgod9e
         +/HVFnDSZOzjH+IhYPzdGOu5aHvZN1LZuTJdcV2sIeQIkIrFuih74Z3qCSWXkpVfQ4++
         SP7NERJLYZe7RoTz/fSZhL3iQw9vTiFWmR0gObMyVLvk2H/Jd0xsgD7kM6Lc9o4ack7F
         OgGqsaOruUvFnOqzNN1Qx9BAS+6OjSJYFOjIauZvnp+VQdDdMk4xLqvyXIcZ0ZinYTL8
         DsyKDVFerXvww0e6wQtJXPUGas8Kzz9J5punk9x2DE8TvtYFvO7LIxLm7hjgIYCN8y20
         qm4w==
X-Gm-Message-State: AOAM533+FXOZC0xIZWpdlndqkZdNbbh9Orx58s0xfASvhBqzuWNvzk76
        gsKE3ic0QbsrNjx8Tkgn9I2A1w==
X-Google-Smtp-Source: ABdhPJwnuhy5CNoBbZXzCSs0DAq+D4xeeHPD21j5t4GTJrqcAa4QeqDmuq0iTBqWnk9X5ANO56dv5w==
X-Received: by 2002:a17:90a:4088:: with SMTP id l8mr1607930pjg.106.1611600143332;
        Mon, 25 Jan 2021 10:42:23 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id bj18sm88198pjb.40.2021.01.25.10.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 10:42:22 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: meson: add i2c3/rtc nodes and rtc aliases to ODROID-N2 dtsi
Date:   Mon, 25 Jan 2021 10:42:18 -0800
Message-Id: <161160013614.17631.15998919281170079054.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210111135831.2218-1-christianshewitt@gmail.com>
References: <20210111135831.2218-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jan 2021 13:58:31 +0000, Christian Hewitt wrote:
> Enable the onboard pcf8563 rtc hardware on ODROID N2/N2+ boards via the
> common dtsi. Also add aliases to ensure vrtc does not claim /dev/rtc0.

Applied, thanks!

[1/1] arm64: dts: meson: add i2c3/rtc nodes and rtc aliases to ODROID-N2 dtsi
      commit: 930f424bd8cec154466d7929c10f1ad0525f605f

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
