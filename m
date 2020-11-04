Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED632A62C5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbgKDK6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbgKDK6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:58:43 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57065C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 02:58:43 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id n18so21537154wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 02:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=K5kGjJgq41cgHa9mbHu2qDDUb9+DTH+gsEgTKKnHypw=;
        b=Qr+Q22nHH7dfWUg8Ym0TTd+J5aX5LwDo85DMggbJQ8boP9NBrHWI0wmNyeaTBGNkrA
         FH6a2QfkjaZZqOz6TqXAd0QRR6M9J5kHyxSmzlu60xzrVvL1XQcaIT9+9nXej9psdiNq
         lvBShMrmbRMBzOfZ40tFuRXOBLhQMj0QTSa+Mdsl+0XbeKQEwWX+07YAbiwmL9HPoaNG
         vzX4YNtxeROvfOr3DZOFm5uqQ9sfkXB/aGovNXDx36vkS7aguMv5HrBluhhn5Ph+K9cG
         Cax9A/0U4UaztgRpoRQf2WAtPVuw7THTWPYNTh1/fFZ128xPrH4kXGwisbD6OhV7cvW5
         aqUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=K5kGjJgq41cgHa9mbHu2qDDUb9+DTH+gsEgTKKnHypw=;
        b=rL9aEULINCbqWFcO958WhCSrVGTKsPJK5cuVJp53QbhaM8VxATBDU2TS/tjZU/GT8Q
         meG0Cx8hc+gnMDsY+rY2UFUTX//sHDUjOtxnBeEMPa/+vKHbI+3kIATySb+ccNEKJXSX
         HSmXtutksos8uFO2jdUXJKqjtmTATxJhZkoIoq6BxHge8z9sRUsf5dpmroff/JDPMNnu
         HFxC1cPR4ZuQMQ8x08P2L69EwKp5lWxAkOpypMM8a4N6TZDWFLx9ehlIpKy7ZlNPsQ8B
         hq5oX1WStrXEQ7ZlC7GTPhkMz833rEtidneFoinPMX9hrjF1wrNTu8D2LHBQkjP6EKN+
         LhMQ==
X-Gm-Message-State: AOAM533oLeVvgGCyLL6gh2X67j7SDo7hmC96m+TYOtWSjpOGvF53ZLNQ
        lyRiCqat6YfkXuA3QWoVyKqDbw==
X-Google-Smtp-Source: ABdhPJxZpBJzRmkpiFeoF7/rQKVJpSRhYGv0xh2AuwT70dKipd5ymSuSJKDDJ4P3E/Gumjnr9ucm/A==
X-Received: by 2002:adf:84a5:: with SMTP id 34mr31107584wrg.8.1604487522128;
        Wed, 04 Nov 2020 02:58:42 -0800 (PST)
Received: from dell ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id o3sm1877894wru.15.2020.11.04.02.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 02:58:41 -0800 (PST)
Date:   Wed, 4 Nov 2020 10:58:39 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/8] mfd: stmpe: Constify static struct resource
Message-ID: <20201104105839.GX4488@dell>
References: <20200922192659.14535-1-rikard.falkeborn@gmail.com>
 <20200922192659.14535-7-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922192659.14535-7-rikard.falkeborn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020, Rikard Falkeborn wrote:

> Constify a couple of static struct resource. The only usage of the
> structs is to assign their address to the resources field in the
> mfd_cell struct. This allows the compiler to put them in read-only
> memory. Done with the help of Coccinelle.
> 
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> ---
>  drivers/mfd/stmpe.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
