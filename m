Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08E0F2EBCAF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 11:49:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbhAFKtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 05:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbhAFKtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:49:31 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B70C061357
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 02:49:16 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id y23so2236942wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 02:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7BgdPlyabJOHA2iddd/tRY6lBkargL+ou/K0j1Targg=;
        b=MIV3/Y6BnLIx/9BjLqh+9PeknY1k8RcOh14MODBFl5oBOEep+I+ub04YpRltcG3HPM
         McBPg8CIXimIhtDrKu0jPceIN+gXyyPGzqriFdhmvTU8F9N2MWNzr9mQmmuaYWkhbSJa
         /0cg1rNQVNUegt90/xyFlkLhupWsCi3CwNXYFuJPYDpbphNox5HIKYXgQeomjNFM2EeF
         mZwDPZ3nPenMk+u2Z3DhJbrJCeuoFbtWvpRhqPUhtU4luCr/ZINNWd3H2EU4PPUruO6H
         HIdwlZLtClOiTFSBuRGNV5OnAiQIamUwV/tv+3YfN7MEzYrcDoRlnzuWZUnb3s74XbaD
         O6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7BgdPlyabJOHA2iddd/tRY6lBkargL+ou/K0j1Targg=;
        b=grIqj7bOeknb28UKoMW5oIWjnZsw8CazFach3wfX3IUjEiCYoi9M66lLC6OFz4vMR3
         /gqCgKhTYT1HTosDcphFgCH8CtHEanDfK5z7x49s6ZGn/uZIADQCg8LeToBI7RYKwF34
         A69NKUk/FRKYnVl9tfOnxfQxApTfcj3oq8c9jLPFiEdAy5eFYPu6ZDSSo9nHBDY22haF
         Ots/MQMUPJx14vpLbcIAhuFbUTApcb4SGw/z88xl6PNv1q+5HPagR7TwnCo49BMl11bK
         V9U8qlUWDn7UlGn2eQfIzJnbYfVtnRQg/YtfJO4/QKhBL3AR8q/kiPCQ3HjEFUV2OC6X
         /zMA==
X-Gm-Message-State: AOAM530oQvlWOz25kSYktC0FdgtEVaoml35NW1hgh/1QTx7/IQmXyoHG
        0qmN3EHs23dvNdMkFm43fRXeiAfvwjsqyHfx
X-Google-Smtp-Source: ABdhPJxixDY4BCWrLZMAzpZx1eltJSMRKmmYljJPAGn+SwxhFd7ViY1xMp0IB3OIu8r5frvCfnED/A==
X-Received: by 2002:a7b:c24d:: with SMTP id b13mr3089446wmj.151.1609930155127;
        Wed, 06 Jan 2021 02:49:15 -0800 (PST)
Received: from dell ([91.110.221.182])
        by smtp.gmail.com with ESMTPSA id i11sm2237484wmq.10.2021.01.06.02.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 02:49:14 -0800 (PST)
Date:   Wed, 6 Jan 2021 10:49:12 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/1] mfd: Standardise MFD_CELL_* helper names
Message-ID: <20210106104912.GC1592923@dell>
References: <20201217083420.411569-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201217083420.411569-1-lee.jones@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Dec 2020, Lee Jones wrote:

> Start all helpers with "MFD_CELL_".
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Gene Chen <gene_chen@richtek.com>
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/ab8500-core.c  | 42 +++++++++++++++++++-------------------
>  drivers/mfd/db8500-prcmu.c |  6 +++---
>  drivers/mfd/mt6360-core.c  | 12 +++++------
>  include/linux/mfd/core.h   |  6 +++---
>  4 files changed, 33 insertions(+), 33 deletions(-)

What a great patch! ;)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
