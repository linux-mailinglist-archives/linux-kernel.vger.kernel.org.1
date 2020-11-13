Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB90A2B2638
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 22:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgKMVHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 16:07:33 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42165 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKMVHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:07:32 -0500
Received: by mail-oi1-f195.google.com with SMTP id w145so11873380oie.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 13:07:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iwy6WHQ4jb1+smPBqfeJOhOOICCweQ/SjDIqw7dg0IU=;
        b=cGebL9mMkqM0OP+pMQZZb0exI7BUZ32D1ujwCFh30Urk36vzz0im2iiaXO41toKp+Y
         i1fwzuqGiAusjRuIZ6rks7otQ5IVoHT8QK03hZr61AHGaJmhfrevLpx4XoqetGvpelbs
         kqi5C2Dvmob5qm0O6c5AVt2GvmSGZcxJdefHmJiGpjJ6Qfq8S2o8S8ts3Es+D2MBEQtk
         +PMiw8giBFWzqSRVBKyMs/myLldhXiJWk4aynUPCXA6Dj/s5mw+FM9iR5fohF5YJ57c/
         MYC3D43Ks/RlTQmlDNp4+L8S2S4ITLfzL/0naQrgh7qNRtzMw/I7dW5hQn4EZbgrOI8I
         WSDA==
X-Gm-Message-State: AOAM5323Fo753GqcalgqLlvOjjNaW5gDnzJcHECp7A7Q2LC2z0W8sgrr
        oTWPtPKMslTSZ0yHCnjm2Q==
X-Google-Smtp-Source: ABdhPJxWQ55PpNhTCoicu/TgNR0ZvT3a2dyXMIjAkfkNV0tnXwF+HEZpXCZfyaMpcgUKzphxugVW8g==
X-Received: by 2002:aca:b689:: with SMTP id g131mr2682785oif.22.1605301652041;
        Fri, 13 Nov 2020 13:07:32 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n1sm2159593oig.20.2020.11.13.13.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 13:07:31 -0800 (PST)
Received: (nullmailer pid 1993932 invoked by uid 1000);
        Fri, 13 Nov 2020 21:07:30 -0000
Date:   Fri, 13 Nov 2020 15:07:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     rkir@google.com
Cc:     paul.walmsley@sifive.com, miodrag.dinic@mips.com,
        linux-kernel@vger.kernel.org, lfy@google.com
Subject: Re: [PATCH] drivers: rtc: retire RTC_DRV_GOLDFISH
Message-ID: <20201113210730.GA1992396@bogus>
References: <20201113205233.827493-1-rkir@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113205233.827493-1-rkir@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:52:33PM -0800, rkir@google.com wrote:
> From: Roman Kiryanov <rkir@google.com>
> 
> The only user of RTC_DRV_GOLDFISH is
> the MIPS flavor of Android Studio Emulator
> (goldfish) which should be also retired.
> 
> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
>  arch/riscv/Kconfig.socs    |   1 -
>  drivers/rtc/Kconfig        |  10 --
>  drivers/rtc/Makefile       |   1 -
>  drivers/rtc/rtc-goldfish.c | 216 -------------------------------------
>  4 files changed, 228 deletions(-)
>  delete mode 100644 drivers/rtc/rtc-goldfish.c

What about the binding and MAINTAINERS?
