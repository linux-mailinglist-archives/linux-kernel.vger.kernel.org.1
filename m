Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F127E2D1E02
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 00:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgLGXB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 18:01:28 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36737 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725969AbgLGXB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:01:27 -0500
Received: by mail-oi1-f194.google.com with SMTP id x16so17405393oic.3;
        Mon, 07 Dec 2020 15:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pOtnxwSjj67drQwIquaFUTWelLm5egSP5rxIl8SU7vE=;
        b=nWWnXsJdv462qPEIOdO6E1jEmqhOOFPARIVg7Jwn4iUCHMP9YiJ6kFgh2+Sd0Sq4RG
         qYFftHW4iko78ae2UKBqjlVQ6VhdxQRlt/8DmMTweeKVQtlMubFlrdB+DuBoyIp75GV7
         nXxls9ZEBmXXJKirsaZj1DAlDicK+sjepzktCjBd47f1KCzy0Mr/s/zMiCupwnrdVlp8
         QJ5zPLyjblwRQzPSUUgyukEctEKuwj9MSpkQA2Bkx53VNq6qs5FOBcig3I0bIpaIRmQB
         fTIdafRsSaw59DDkq7J8gsVBAsFQLcygGDTFeqzFFvBNVQhLZD2aAoFkSyTGTkXlBvsE
         Qhhg==
X-Gm-Message-State: AOAM53159ocHapJcV07fVCb0XlKAKh1vs3EOWcIpXSWzrfVcEt+TAI3N
        xRdgwwxg9+zTo6OQytKP/g==
X-Google-Smtp-Source: ABdhPJzzP5lELAlv2UEEAGXv4tTBLCWDom3PpfzErxjtr7d2lasDJWYeKkDrSw+fq0+Y82sgW/YXPA==
X-Received: by 2002:aca:1110:: with SMTP id 16mr814160oir.12.1607382040321;
        Mon, 07 Dec 2020 15:00:40 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y204sm1866830oiy.38.2020.12.07.15.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 15:00:39 -0800 (PST)
Received: (nullmailer pid 1007513 invoked by uid 1000);
        Mon, 07 Dec 2020 23:00:38 -0000
Date:   Mon, 7 Dec 2020 17:00:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel <alsa-devel@alsa-project.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/1] dt-bindings: mediatek: mt8192: eliminate yamllint
 warnings
Message-ID: <20201207230038.GA1007457@robh.at.kernel.org>
References: <20201207031430.1345-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207031430.1345-1-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Dec 2020 11:14:30 +0800, Zhen Lei wrote:
> Eliminate the following yamllint warnings:
> ./Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
> :10:4: [warning] wrong indentation: expected 2 but found 3 (indentation)
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  .../devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml        | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
