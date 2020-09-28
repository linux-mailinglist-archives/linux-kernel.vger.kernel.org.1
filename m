Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F4D27AD90
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgI1MMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgI1MMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:12:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E4BC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 05:12:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z4so1067689wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 05:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WkJ+JQz22FgKhunkX2Eys8prjPDVkhKGpB1odb9GP8s=;
        b=V+A2geqfxmkMfY7Ozcf6qFWf8cwaKHC6uC2YbzNkKkg9K7etSOTIyRWxvmZ+4e4tSZ
         QWoytvAI3ul8dm3Rby2HAddrBVew0ATO1vVz9mpNCe7vl9xAb/6YFufWH8YHoOgknpi5
         PAv50iu9Y2eswRH8U54IlRstZnIO+T9w2IrGWiFeltxFio9ub/1DFIUROq/tVuQTJLqh
         k5nzl4Ki9z9zFimkVFnHCFFdi78UrEyH39Ndom3QFPSVT2oRCbl82CmrmUU5nbud1GVo
         +GLhONWnkRnXpfbIEdG2zcZjZis1cNlqbyslfzyiMk19KoqOvanxXiY3Tp0H88bvSGw8
         x1AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WkJ+JQz22FgKhunkX2Eys8prjPDVkhKGpB1odb9GP8s=;
        b=dBUwOFJs1hiDUzmo8bFYxhdwf9nxH/CIAGj3nwH6BC96nhcsoLyUg3ieGxFaQlWCst
         JGe/EX6aIMDwPIGjm14P7OEpaSriH5CXPUzt9spHQEcntbpeEJKTiKSL0d6theLUU+5u
         +edgXsnH0BaqzkzLS4L1C616Vdh0sbgXhLJViEypuMh84FhJWsHeNmmHGLUq+d7q4ouX
         O+i00UZW+MKAlvVQTpjDSW2NaU8/lZeyUFp6SDpOtuCv1Bjoy7lRrU8Jx0y6ZFZ3l5q4
         tY9xWSTIrPtaTEigT6XLzRodfUbQM4UIwBDix8ZLrVKHTgmk4LIvf09gT9HepGTvSF2V
         X8vA==
X-Gm-Message-State: AOAM533GMIscUvRCBr7LX1grkStmYhHQwPa7+oekvfYkmBD+LEwUL/rr
        XLTRdzuPovO9c6F6hmnGF3h1Fw==
X-Google-Smtp-Source: ABdhPJxfr1ds5iMTGjgHETAfl1Qew67RRVxQWW5Rmg5m3CN9CftRmIzMQbCdpyVjYzUGWOgofV47Dw==
X-Received: by 2002:a5d:61c2:: with SMTP id q2mr1490265wrv.25.1601295150767;
        Mon, 28 Sep 2020 05:12:30 -0700 (PDT)
Received: from dell ([91.110.221.154])
        by smtp.gmail.com with ESMTPSA id d19sm871991wmd.0.2020.09.28.05.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 05:12:30 -0700 (PDT)
Date:   Mon, 28 Sep 2020 13:12:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Keerthy <j-keerthy@ti.com>, Axel Lin <axel.lin@ingics.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] mfd: lp87565: add LP87524-Q1 variant
Message-ID: <20200928121228.GF4637@dell>
References: <20200902142259.28349-1-luca@lucaceresoli.net>
 <20200902142259.28349-4-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200902142259.28349-4-luca@lucaceresoli.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Sep 2020, Luca Ceresoli wrote:

> Add support for the LP87524B/J/P-Q1 Four 4-MHz Buck Converter. This is a
> variant of the LP87565 having 4 single-phase outputs and up to 10 A of
> total output current.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> ---
> 
> Changes in v5: none
> 
> Changes in v4: none
> 
> Changes in v3: none
> 
> Changes in v2:
>  - replace "regulator" -> "mfd" in subject line (Lee Jones)
>  - add Acked-for-MFD-by: from Lee Jones
> ---
>  drivers/mfd/lp87565.c       | 4 ++++
>  include/linux/mfd/lp87565.h | 1 +
>  2 files changed, 5 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
