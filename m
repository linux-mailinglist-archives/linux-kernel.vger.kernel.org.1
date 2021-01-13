Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 255DA2F4EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 16:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbhAMP3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 10:29:25 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:42593 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbhAMP3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 10:29:23 -0500
Received: by mail-oi1-f180.google.com with SMTP id l200so2473398oig.9;
        Wed, 13 Jan 2021 07:29:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h8hXqRRk++9NDE653QaONRW6uqUoBWwqg4Di3V2OUm0=;
        b=MZLopDF+0+EL9bLGZEWoMdlaTqmTiWS7LshS8zWcgtM4W+qdJ5/oQDCA29quFeBoly
         vKLe8plmbdWB0NnfIY6XfsDgWVMDcc/fvO/vsrk1Nwb3nNm7r98X9SfoFwTBYB2w3bps
         +ePKV80gPKtacOApT+R06fqwOyzj7K87Q3z3oHWruQqwv/Nf6+PNpeohRYF7R/dAai11
         pwHd9s6qM4kRqRvqd9yoHPKDmHD2qkf8D6vUiH1co1ls4pMuiOqFim+5DcnXwGltUL8+
         ps8QjIl3sGyhVdTpmActexG3GLKKRu4kV4qBpS8xzklsA5RjNyQ7W2Jj2DkbMV6RbrvU
         fyyw==
X-Gm-Message-State: AOAM533xc0kNSx8dtTqCY79XiPgi0SmGw+gAyACMtopk4DgmtfhzRX2Q
        HoPxvCElz9ncNx/zM6ZHgQ==
X-Google-Smtp-Source: ABdhPJzCd43jLwbdMhQ1erq9DqNkk22l14VdoWTkVWmVh1igWCQTHjWMbNY5Cr19dCK3iI4QevK/6Q==
X-Received: by 2002:aca:f5d3:: with SMTP id t202mr1553691oih.25.1610551722988;
        Wed, 13 Jan 2021 07:28:42 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u24sm458808otj.27.2021.01.13.07.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 07:28:42 -0800 (PST)
Received: (nullmailer pid 2480536 invoked by uid 1000);
        Wed, 13 Jan 2021 15:28:41 -0000
Date:   Wed, 13 Jan 2021 09:28:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, jagan@amarulasolutions.com, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/6] regulator: dt-bindings: pf8x00: fix
 nxp,phase-shift doc
Message-ID: <20210113152841.GA2480475@robh.at.kernel.org>
References: <20210108225006.153700-1-adrien.grassein@gmail.com>
 <20210108225006.153700-3-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210108225006.153700-3-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Jan 2021 23:50:02 +0100, Adrien Grassein wrote:
> nxp,phase-shift is an enum so use enum format to describe it.
> Minimum and maximum values are also wrong.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../bindings/regulator/nxp,pf8x00-regulator.yaml   | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
