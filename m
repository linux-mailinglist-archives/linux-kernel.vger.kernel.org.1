Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507BA281B2A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbgJBSvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388265AbgJBSvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:51:42 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE91C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 11:51:40 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d13so1374498pgl.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 11:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q3q5K3L+YoOnrFYFn2V2zaxlwZMcevW9IDjtYQos/JQ=;
        b=E9JJvLMvVOS1W0AlhJ85n78PJzP5/BIKoHNyqHaoa2V8Y+jLVUcK3KYssVUGEMu4oL
         m2NSA3KLlzF1WeWq0iegvthSjOqxSogfcVfjI3VXJ4nKai1v7ZRWtcl7HtZQV+ZUY2SI
         bGAwAYqNydviGjdnGXTuBpQ6tWuqNO3H9GUKzWCyEvEfI1clUW6bSHx0bRKa9UAsKkcV
         cVziU7KCyoB8hVPbSTtxr1z98YSC3YP+EW7jSknzlueTTolL357ddD//DCMAxaNAetTT
         0DbE1IJohoGdT7tFDSlyB2k3Jl60xmLGMywKM2ptmPWxXt2nT3M5WLji7qFJsQRrMo4T
         NxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q3q5K3L+YoOnrFYFn2V2zaxlwZMcevW9IDjtYQos/JQ=;
        b=f7e/rbCkG9+saOYSDd8c3amPon7iEsPOjfmRqNauRsUwDYaGEuh6AQaE8osRFwW/g5
         mrB/2bxKJ5GMDd1OKIJ/YJtALz7kdBX1hjXawO09XgIwK6F+53H106NuzGejp4yFcIXH
         0+YaCCbtsbvxEl/2Jp2Yd5zoK79uqCyu9S0pia+FcAy9Ieky7M42yoPEKJiWYNJNRMc+
         +ETsCbrnxaa7wir1+/oi4Nsw8ZPaz/h25dBK7dsiSH4ymCcYxmKShsBqPNiZ7wISvoeT
         nudkmlmivjQ/EOVB9ZDs8IFpI+zpi/tQXiQ7baAcXORlpaIbJV5+EflLThRs9U5uRzCz
         +lBA==
X-Gm-Message-State: AOAM530OtCn1LqWAyIkMxVZzXmqjanNPf3g7m5fTSVk9lI4/zIzoqtbe
        5BQwO1hYnBll/Fh3K68sFYV4GQ==
X-Google-Smtp-Source: ABdhPJxO048OYeo0qyqo36NDdaDJkIstmnKSpS2FwEASs9UYebeUGxjFE7Az7NnODd3qok+B23segQ==
X-Received: by 2002:a62:7d91:0:b029:13e:d13d:a061 with SMTP id y139-20020a627d910000b029013ed13da061mr4256061pfc.39.1601664699826;
        Fri, 02 Oct 2020 11:51:39 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id n2sm2592796pfa.182.2020.10.02.11.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 11:51:39 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     narmstrong@baylibre.com, linux-kernel@vger.kernel.org,
        jbrunet@baylibre.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: amlogic: meson-g12: use the G12A specific dwmac compatible
Date:   Fri,  2 Oct 2020 11:51:36 -0700
Message-Id: <160166469102.35184.724638054812070881.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925211743.537496-1-martin.blumenstingl@googlemail.com>
References: <20200925211743.537496-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020 23:17:43 +0200, Martin Blumenstingl wrote:
> We have a dedicated "amlogic,meson-g12a-dwmac" compatible string for the
> Ethernet controller since commit 3efdb92426bf4 ("dt-bindings: net:
> dwmac-meson: Add a compatible string for G12A onwards").
> Using the AXG compatible string worked fine so far because the
> dwmac-meson8b driver doesn't handle the newly introduced register bits
> for G12A. However, once that changes the driver must be probed with the
> correct compatible string to manage these new register bits.

Applied, thanks!

[1/1] arm64: dts: amlogic: meson-g12: use the G12A specific dwmac compatible
      commit: c0c6f8e527a652d4785cb38ac82be0c95913349d

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
