Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78D22AF647
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgKKQ0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbgKKQ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:26:32 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C93C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:26:32 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id p22so2791910wmg.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 08:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fm6EZWnGMwJx8b20boKF43n6ZzOwlPSgmWw2pTdCxAY=;
        b=pPK+y+NQ+RGrqo4lOV3sklG5kDTKmuAfiaXL+TM0SfcLh2klJnh0dRHNdUvzXI2XKk
         WXpJ+EJx+zN975LDCgxBNJLX5tBezWTYKfUtzmMx7KbkY8/y2vbpN+LPL9hgkeu7Z1pO
         CpGN9omsRgbkCBE0DKbKT4JgT4BELrHcqAFMKbxNHCaDRf6uwrPwHgKMaafp8uXARHE6
         0XknNFTko+NkMAZC9Qfe8WQ8tVmaWRaBXbdplEfBZYa1Y/IGgGIm7mhpZOgowusQucjk
         p4Mf0/m0Y03PDdCvUONYZJu0l0PZ5pOpx2oToAPUTlo/XmyfLDmvU6nYskYr9ZklmjWc
         GgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fm6EZWnGMwJx8b20boKF43n6ZzOwlPSgmWw2pTdCxAY=;
        b=mI+SJwYR077aMOyLG6xD2CRcJJFqqvjm3Rz1/FNRuPtYMEeuoRqAwQG8QZhOq2aL7a
         fNx6vVmY5OcO5uiTifm1u/8T9dFniXgpURUaPWgCSeUeVrf5DaGPqmSOAgPIrfQS6Fw+
         guggYpVWK3a0pRmj1MdwKCEPdxLMmNUTNvBgHd8AdHjJWVIlp2RMzI1lD/qULwP5EZCl
         +nyGxeyk1Cdmg6ryozFTE7dvDmIIMls3c0lNsMomZIwPBIQJbq5h7dBjOXR/DOxcB2+b
         u/Hfhz59UK5dkwaMiFEU0hG7FLVqvjwkpCiZ8gEOMs1n26/Q5f93+yQ6bkWOclHnLGuA
         Uaow==
X-Gm-Message-State: AOAM532Q3BoVfJKKKM8AHaMMbV0Se/dQDp5Wgt/WM6KN2JLDN+pSTWzJ
        fSMvPFp2by1KRUzrONO/sMTxKQ==
X-Google-Smtp-Source: ABdhPJzd+uXAcVfG6Lm3zy4MmhOXDyQFmYVwqXgOC0Z+l5mjr+uH222kiZ5kHT5dn7Olo5RR99RurQ==
X-Received: by 2002:a7b:c0d7:: with SMTP id s23mr5345715wmh.54.1605111991135;
        Wed, 11 Nov 2020 08:26:31 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id z19sm3031467wmk.12.2020.11.11.08.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 08:26:30 -0800 (PST)
Date:   Wed, 11 Nov 2020 16:26:28 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        radu_nicolae.pirea@upb.ro, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com
Subject: Re: [PATCH] mfd: at91-usart: do not use compatible to register child
 devices
Message-ID: <20201111162628.GO2063125@dell>
References: <20201103093246.1288956-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201103093246.1288956-1-codrin.ciubotariu@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Nov 2020, Codrin Ciubotariu wrote:

> There are no separate serial/SPI devices under the at91-usart MFD, but
> actually the MFD is used as a serial or a SPI device. There are no DT
> sub-nodes for the MFD children, so we should use platform device API to
> register the drivers.
> 
> Suggested-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
>  drivers/mfd/at91-usart.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
