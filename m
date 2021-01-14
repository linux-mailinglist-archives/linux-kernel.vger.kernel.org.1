Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4AE2F631D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbhANO2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbhANO2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:28:31 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 212A3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:27:45 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a12so5947455wrv.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=stURBibHeymSTQotO4y7jVW0jLXFO/bJV0OvfHx8/Ow=;
        b=fhyQomvCom1FnwqmnHAbPTCnd0LMPSC1mqIoFA5OZ1Zgg17bwZDLU5KO1gmbEBqcIp
         YXIPhQ0GvJBZ7V4KjAkdpNk8Vbr3fPg1LUcu9POniajMxCP0erZ1u88GCrBaFhiy+FdN
         tVDBg3CRCCKH4azQ0/EPNm434Xan+AeW3X7wmtOgA31CDosXjFEBvXxYcwUw+jT9uHvJ
         /WPpe0HcdoOnSgatKDKfXg1geiL7eYH29nuVy1BmcqevKsMAOEaO5vZnZUnajjI790vs
         9EaGJwjx+uFxrvuvwjVLycDv3gsRr8yowd8eunI72m69qv1qrUNBzpNbP/lFKWbKiSIO
         3yQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=stURBibHeymSTQotO4y7jVW0jLXFO/bJV0OvfHx8/Ow=;
        b=cadRByaSAVlJMN5RyW4JN+NkMqRYNW+SYkBy1KJsXtPhPgp4cjvpFkGmDcMm7Ktynz
         ij4NsDalyupBxvIptB0LHxs3aWO8Fv2K7ou2PW66TN+6ySbfiCLAJj3BJKcr7Hn09qAg
         xzxAbGnvQ+Ez6le219+YifpapgM1EXrXCb4mjCRDgb3lnocSHkfIWf9FDrqvzVAUjyoT
         Z8V4hzB5nMRaC6NOJ7g1L3pIG+ArfJSy5aNVYN/UsPERYySVZ0MkULsxWEfONM54X/IF
         Iil6KMcW6PrAvgG569KSzLz+hTP0F1i3PbQCv5sVnWh2VOmj/HMrHVaDCrhRUZeh663d
         kNaA==
X-Gm-Message-State: AOAM5334zKBqlAdRLCmZ8SC0yDoDyndXIXmeDzC2ObccVE4FbTGmDH6Z
        KCJZvQ+rzAp0EYAPzJNlVwwpJ0+PuGpu5BVu
X-Google-Smtp-Source: ABdhPJyXrFe2m39uAyQy2h7tZOKGTMg+Vg9rbr1bpTyqBQ3zqWU671dcf51KtVjNjgEuIROfT8ikKw==
X-Received: by 2002:a5d:45d0:: with SMTP id b16mr8085208wrs.220.1610634463919;
        Thu, 14 Jan 2021 06:27:43 -0800 (PST)
Received: from dell ([91.110.221.178])
        by smtp.gmail.com with ESMTPSA id l7sm3707755wmg.41.2021.01.14.06.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 06:27:43 -0800 (PST)
Date:   Thu, 14 Jan 2021 14:27:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>,
        Sebastian Reichel <sre@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] dt-bindings: mfd: Add ENE KB930 Embedded
 Controller binding
Message-ID: <20210114142741.GZ3975472@dell>
References: <20201228160547.30562-1-digetx@gmail.com>
 <20201228160547.30562-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201228160547.30562-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Dec 2020, Dmitry Osipenko wrote:

> Add binding document for the ENE KB930 Embedded Controller.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/mfd/ene-kb930.yaml    | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
