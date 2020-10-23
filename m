Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF80297944
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 00:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757087AbgJWWWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 18:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757078AbgJWWWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 18:22:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD214C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 15:22:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f19so2585851pfj.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 15:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C1Ip8+osESeLsCFu90lfDedJ11QjKePQOjL1SbRil8Q=;
        b=j+Quc/So19JFyWFMmmyuYKqEQ6P+WbC4hfNC1Z/QcKB4zKS9jqmHa+ICJha6q5Di0j
         zGfFeNhd55GNNFsa3xuHpufBVaBzFDBy1bjRA46V4JBAwQZ5Jaovo4Rd/T9DVhSk+tPb
         UNKALP7pTXolLPGc2WX6lUZCyRb3g5++5a75p5/ZjaoSqDkIeLv0et7p0l8sXBIP+GEa
         7AgT+JcvgFrL2J5FHGEUKRBnSnLYBOTTcC41whPZcLQRxhBIB3vHzSYlta8U7xHrOlqe
         tt3tP5jZN8fuaFszMDjqVXUk+UrG8kNprpyLPkbeu4b9YtfunRMEsOkY1Q9gPCbYmDXM
         twdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C1Ip8+osESeLsCFu90lfDedJ11QjKePQOjL1SbRil8Q=;
        b=FWBBaPmEaK3AjAFRByeZFiaa1E097QB6H9EZVhr3epgsaY5KAdZtxoHQ8iXvV58AYU
         wcAaSjXeEZV5+mupLGwHS5ggkDh35ByuUHhXWClbjVdhfozU/XR0IItxLhUMYyObZjPX
         RS6v66H7QAdX2T3HZgA8hWKo5iqYFsfwINmmoxb9Fu0DHx5mt7Ke0uIikJdah8dcnrzp
         NyjicDVYpCETGL5EyXfZ1a/lT8161KBP2Y9usXfKNjpdlJjL241he6BDILSrvkt0oUhf
         EsMVUoM/pim/v5Vdq9o5LSmsuYmSRJvlrLWqnCNLMEpM0p4kCan5fvX5Wbzzr+aZqOxd
         i99Q==
X-Gm-Message-State: AOAM533Sk6osZUU6oR7fp/gM11Sxm3xB/Hvm+4Keb4u958UHK/5BCq/D
        dQFFqwRj1W1kViuVQYrG3O3Z1A==
X-Google-Smtp-Source: ABdhPJxFJMZBEAO+yw5bAYSfWaAzwg+iomn89fo5s/GO4gTGSrQMkxnZh6co61LpC956+SMRRVMVXw==
X-Received: by 2002:a65:5606:: with SMTP id l6mr3881479pgs.49.1603491758132;
        Fri, 23 Oct 2020 15:22:38 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id o78sm3068383pfd.105.2020.10.23.15.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 15:22:37 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: meson: odroid-n2 plus: fix vddcpu_a pwm
Date:   Fri, 23 Oct 2020 15:22:36 -0700
Message-Id: <160349175086.30235.13810218277836413722.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023094139.809379-1-jbrunet@baylibre.com>
References: <20201023094139.809379-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Oct 2020 11:41:39 +0200, Jerome Brunet wrote:
> On the odroid N2 plus, cpufreq is not available due to an error on the cpu
> regulators. vddcpu a and b get the same PWM. The one provided to vddcpu A
> is incorrect. Because vddcpu B PWM is busy the regulator cannot register:
> 
> > pwm-regulator regulator-vddcpu-b: Failed to get PWM: -16
> 
> Like on the odroid n2, use PWM A out of GPIOE_2 for vddcpu A to fix the
> problem

Applied, thanks!

[1/1] arm64: dts: meson: odroid-n2 plus: fix vddcpu_a pwm
      (no commit info)

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>
