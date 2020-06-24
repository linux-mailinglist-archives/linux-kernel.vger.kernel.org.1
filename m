Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237732070DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jun 2020 12:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390161AbgFXKLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Jun 2020 06:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390066AbgFXKLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 06:11:33 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35B7C061755
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 03:11:32 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l2so464112wmf.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 03:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=igZtrvoVRESa1OptkNZlf7jr2wxCNuT6tHPjKiqOH2Y=;
        b=xZqQbfz7SczvKrDSaN7j6UnsFBhfXGEAdKPoRtxIkkmU+Fk1A8U0WuWhj5RlUn36gb
         oEdZRYnoMZkHbxbJghWTTAMIJIqMVxEYZTo9Jd5xA6pP5bVkRp2d6HKhFk4dWN1ecwfR
         XjADbrLnuibFwLv4BfXq7ioG8MA7dwNhVp2e3wFZBxzUrmrRUtMTvpNXr7H9G5Ii5M3W
         Nw9o/HnY4pR5O8udEAuE+VEiln7XxBF9FJzVAr1isdys++0iL8KX1oztEPOwhluKnbRC
         03uIWzrzxjOQfBxjxcr5URfZp4vn1+Tx/cNWWKNUfX+EcGUNJc4YeDO0jInCBVgis3V7
         Rbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=igZtrvoVRESa1OptkNZlf7jr2wxCNuT6tHPjKiqOH2Y=;
        b=H09QTLEN3S8PyUK7iV4qq/V9kNdI3y9TSYRDfhev7X/JOJj9o4qMbasXXHYlV2El33
         WfK6La9t5x3DpMVnS9XrSJFEipic7wOcSoU8yY58eNhI75YHR3pBs3IpII68VpQ4vBOg
         prHkMr8p6SftuZ3rYiK+YYjM+kfiQw5e3yJ44ipVBiV5ikarcbJuyzWAzKIj/GGMeosP
         p2YvNhAhWkjTkCyLtxj03hhfckSiGI1ktF0G1bzv8Q4571fVYuZ7ZPoyYLdValtJf9Be
         h76DuZiunO+f26H5OMLNH5dLkhlLJOwyCoXAXvNS25ICn4hTqtfreMPRCWzZP0SogOsL
         EPUA==
X-Gm-Message-State: AOAM532xrnVPHOf7yfiXwzhVk7ioeGAA8UUgKMQyr9bxSn+28AUDc0Ht
        54WeT8hyLXQ0ptjK27+ps8MUcg==
X-Google-Smtp-Source: ABdhPJwgLFr0/kRDRVXP8K8wBpQtcOlMyFUgKez+F/Ly7c+/i/o83wAuC+PTRyhhEUV32a5BV3tn7A==
X-Received: by 2002:a7b:c158:: with SMTP id z24mr30586736wmi.12.1592993491424;
        Wed, 24 Jun 2020 03:11:31 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id 92sm18571397wrr.96.2020.06.24.03.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 03:11:30 -0700 (PDT)
References: <20200610083012.5024-1-narmstrong@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] clk: meson: g12a: Add the NNA source clocks
In-reply-to: <20200610083012.5024-1-narmstrong@baylibre.com>
Date:   Wed, 24 Jun 2020 12:11:29 +0200
Message-ID: <1jpn9oixim.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 10 Jun 2020 at 10:30, Neil Armstrong <narmstrong@baylibre.com> wrote:

> This patchset adds the Neural Network Accelerator source clocks present
> on the Amlogic SM1 SoCs family.
>
> Dmitry Shmidt (2):
>   dt-bindings: clk: g12a-clkc: Add NNA CLK Source clock IDs
>   clk: meson: g12a: Add support for NNA CLK source clocks
>
>  drivers/clk/meson/g12a.c              | 119 ++++++++++++++++++++++++++
>  drivers/clk/meson/g12a.h              |   7 +-
>  include/dt-bindings/clock/g12a-clkc.h |   2 +
>  3 files changed, 127 insertions(+), 1 deletion(-)

Applied, Thx
