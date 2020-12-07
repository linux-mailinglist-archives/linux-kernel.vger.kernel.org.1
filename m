Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6195D2D0D1A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgLGJgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgLGJgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:36:02 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4283C0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 01:35:15 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id x22so10834002wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 01:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9PYE9KK2hNkqZloDwkkFxf3duX2sPrFnfUoAdgHMchw=;
        b=Nt7fV3V0jbR3OliNl8oJoF56RWzct3Ev31IpjP3MLRtTb5BjEum/saf713LHRGyenz
         JwmXUW917Rm1z4z+IQnKnkqzW3QmGrFXuPj+J21sjKyWWr5prJfPMS3W/w4Cq9JCpurO
         nQ4VlxRw86Mw+7SpF9Y0jBhP8nitjsI15ChBSS95I2sfBZHFlx0s8Dn/pFOHMBBfqxql
         QSXL3nkLnOndX+H49U8xwJorPUYmrV5jJBUF4CKHKgxwNRqFhRB+QmViKxSzY/NWjjYZ
         hCfhpbhfRPom5C1hCZO74w4uC3tOWAts5bukIL94wfhlgcbmy/xrUffj+1GYAV+wJ669
         KTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9PYE9KK2hNkqZloDwkkFxf3duX2sPrFnfUoAdgHMchw=;
        b=Ukx0Zl3cY9JcKXNzbXtD30XdWreZTbie2AbVwzcM/9CsMJ1njiedr75N4D9nyJhWCg
         E5zHr+Tn1akA+6fbDZC+KjZeLITQD16Wj5k9g2pbjNqOrRbWjLS6knWsPAsmeLjlJu8m
         zvWiuJucc+Xk3HLmTrlfGymsX1RAknIEHPwF6SeyXGQfBuHqmUq3GElpVJzKDqw0+2Cf
         +flc8U1FQkQFl5EQv0u6Z98EJ6C3O2BaUnncmwJ2JEwVk5R6kECGJAIDsDRZxYxpaB26
         LJCVUlWGmGqFkI04kGnhkeB1fZ+fgjHRclr5tHcEGH4RpZl0nTkQ79eb+y/y5hlSyr8x
         of1A==
X-Gm-Message-State: AOAM532HTYOjlW5Y1z+JqGTDHdJcvX3RrzD5RNJYE93IaXoQxhjX5iYr
        r3YhddyoXF7MyE4lYR1VYWhkwJyGQzDGWRvq
X-Google-Smtp-Source: ABdhPJyHwexfChpJ2roX9zkSp0a+3493699HdlntEG9nfIpUbjQtSploJA0NBLJMV/ej3qc/6q+zMg==
X-Received: by 2002:a1c:1bc9:: with SMTP id b192mr17389655wmb.136.1607333714544;
        Mon, 07 Dec 2020 01:35:14 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id v20sm13182527wml.34.2020.12.07.01.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 01:35:13 -0800 (PST)
Date:   Mon, 7 Dec 2020 09:35:12 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: ab8500: Remove unused platform data
Message-ID: <20201207093512.GR4801@dell>
References: <20201204140342.1640941-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201204140342.1640941-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Dec 2020, Linus Walleij wrote:

> The struct ab8500_regulator_platform_data was a leftover
> since the days before we probed all regulators from the
> device tree. The ab8500-ext regulator was the only used,
> defining platform data and register intialization that
> was never used for anything, a copy of a boardfile no
> longer in use.
> 
> Delete the ab8500_regulator_platform_data and make the
> ab8500-ext regulator reference the regulator init data
> in the local file directly. We are 100% device tree
> these days.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Lee: would be nice if you could ACK this, I do not plan
> any other changes to the AB8500 headers for this kernel
> cycle so there should not be any conflicts.
> ---
>  drivers/regulator/ab8500-ext.c    | 417 +-----------------------------
>  include/linux/mfd/abx500/ab8500.h |   3 -
>  include/linux/regulator/ab8500.h  |  10 -
>  3 files changed, 2 insertions(+), 428 deletions(-)

Look at all those '-'s!  Fine by me.

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
