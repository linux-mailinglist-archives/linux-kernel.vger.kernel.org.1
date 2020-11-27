Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBC542C66A7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgK0NUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730098AbgK0NUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:20:36 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5776AC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 05:20:36 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id m6so5550170wrg.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 05:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kZQ2jXA1sronPIZs7tF22efqhFjT2ZMAwWM9MANQyoc=;
        b=sJX6lhZwayDWRBVXeFBNRXMs01msGStQU2WsPlWd5B1TUfFxWwkArnDtLWJO2WVtC8
         WGDx8RJ5/pmijcYQJGOELNGfKm3zTrlJP6jA5NZzArQBZDLyeeYhorndtxujmF/6iVBZ
         TvgR9Z0N3Uk4e615qMTWG2TUCTGRHulbiRM3uAtzRFnngsvddYmrrfDzeDYg/ItMr4Ev
         j1MaiQrfcuLDaZW0XTCFoxyTkw+UY10AgawfkGcILmSkmcVptTBdKAEweOXE/fCRf0zq
         VOzMkWxZAMhGVuCcrul4DalHgp76x5a3QR/KIZLQbIGWgEgTPfqHptC+dWMp+rhzeL6u
         Yvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kZQ2jXA1sronPIZs7tF22efqhFjT2ZMAwWM9MANQyoc=;
        b=XAFfN7lgxshb8iti6y0MchzqEhSi6RLUj7dMnQw5RoIYwSeCCKL3RthPt+9xLDEUTW
         PC6c9VQVrZozKHbWfMB3ZAiatjSeBjGH0QPPSKYlwogf6ze6cLiPqfEYRur+EsIfzpyv
         8JUzMclDDKQR8zCHZPj3EWzNdLY+LQRwOJfAewvzhBSHpQeRSjUBFhP/s6lmAvmoUlT/
         5yl4wlcplrZflDz0NJfPOhT+OM+z22IaohD2JHLY8vrXdX1LTBqCec+vayagpfGm7K0E
         UJdt+vn3CdKZu8AAoVvFC9NRQ7qe37kYwL8GqJhY5kN5BbPt/YEKdvEvdEO2zI/5J0ww
         n8kA==
X-Gm-Message-State: AOAM533UOmcVG0J78aclHGHaf51GYUhjcbLJslw9vVNMqtH2Fs2ZSBcr
        6+mXMDxGvzBpQgjG72EBIRieOg==
X-Google-Smtp-Source: ABdhPJzepEdUCkFH7zNVN7RarWGWkfiJvLRn333Ijj9u/bmLO/XqM5lTP8UrsVsaTYMhJH8KmaiwAw==
X-Received: by 2002:a5d:4e87:: with SMTP id e7mr10919578wru.70.1606483235074;
        Fri, 27 Nov 2020 05:20:35 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id j4sm14390527wrn.83.2020.11.27.05.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 05:20:34 -0800 (PST)
Date:   Fri, 27 Nov 2020 13:20:32 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/16] mfd: bcm590xx: drop of_match_ptr from of_device_id
 table
Message-ID: <20201127132032.GU2455276@dell>
References: <20201120162133.472938-1-krzk@kernel.org>
 <20201127080619.GJ2455276@dell>
 <CAJKOXPfdEbax7Z4xpu2QcLSND6fvWK__5hTKOESaO0n2pBMhtA@mail.gmail.com>
 <20201127091759.GM2455276@dell>
 <CANiq72nVBUHU=3qBoWsk4r1L2W1Xuu05y=WXrQoWcSQiscerCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nVBUHU=3qBoWsk4r1L2W1Xuu05y=WXrQoWcSQiscerCw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Nov 2020, Miguel Ojeda wrote:

> On Fri, Nov 27, 2020 at 10:21 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > It's a per-subsystem convention thing.
> 
> I think some allow both, too. For people that send tree-wide patches,
> it would be if we agreed on the convention...

I have no problem with that ... so long as it's mine. ;)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
