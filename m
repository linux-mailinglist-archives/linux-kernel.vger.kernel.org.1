Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48ED0290996
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 18:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410015AbgJPQUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 12:20:33 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:33190 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408124AbgJPQUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:20:32 -0400
Received: by mail-oo1-f65.google.com with SMTP id r7so755654ool.0;
        Fri, 16 Oct 2020 09:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Y1bxWF9bKlm4bzAXq9oJbXEMMHEa8XKOqRPUUn+E+G4=;
        b=HZh+Yha/9mv+IWRhZKzgk9pfItoaUfz5/uW3IPJVFYMpsiE1A3C3A8oBsdAGWkwXha
         VwozfSj8thE60fI4tMPs6MA61EDZXXOCn6shpxmjfz7ILNwRzsRWJXaK0vfoYjlmnNjz
         HtWlZ3bQ8wLCrxoMk9aLWB9g+3HCVIGEanHjWTu5MlWhq2S6Alhnva9kqlm/DzpPb/Lf
         E7yh5t4wiRQZ0GhLe9WZJZY/lJ9nhgsyoW2UxUjrme/jlUCGnpczdmH3ctT4Mva2W2Ju
         4knv2k8gOcep4umQEfhMqRjCbCQ5p7QO9vnn/0Jsg8Loicq9R7ryw8kaPluPt42N0Dp3
         EHoA==
X-Gm-Message-State: AOAM532kzQE1PlfJ636nyVemWEArduNMWVUJl/16FDYViyGb+QmpVi5Q
        XOTRKr+s1NOVLjXJvedyKQ==
X-Google-Smtp-Source: ABdhPJwG7Nzd21eBnGvGJTHk+IufoaTer5Y9f8lUE4gmMU4zXfejWHoQPthlAuPNfSZuaEiyo62L/Q==
X-Received: by 2002:a4a:c813:: with SMTP id s19mr3296744ooq.29.1602865231944;
        Fri, 16 Oct 2020 09:20:31 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i5sm1146927otj.19.2020.10.16.09.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 09:20:31 -0700 (PDT)
Received: (nullmailer pid 1521236 invoked by uid 1000);
        Fri, 16 Oct 2020 16:20:30 -0000
Date:   Fri, 16 Oct 2020 11:20:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Aditya Prayoga <aditya@kobol.io>
Subject: Re: [PATCH v4 1/2] dt-bindings: vendor-prefixes: Add kobol prefix
Message-ID: <20201016162030.GA1520851@bogus>
References: <20201014200030.845759-1-uwe@kleine-koenig.org>
 <20201014200030.845759-2-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201014200030.845759-2-uwe@kleine-koenig.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Oct 2020 22:00:29 +0200, Uwe Kleine-König wrote:
> The prefix is already used in arm/armada-388-helios4.dts.
> 
> Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

