Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF8F302E5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 22:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732506AbhAYVvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 16:51:36 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:42140 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732807AbhAYVsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 16:48:33 -0500
Received: by mail-oi1-f177.google.com with SMTP id x71so16376153oia.9;
        Mon, 25 Jan 2021 13:48:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4U5Iaql8VOgM/DLTY8lNymZH+MQ4mAZ9WR6+DIkahZ8=;
        b=AFsMEDHKy2yaSk0RL1ZOMebDhHKUVUHHx02/ImghijJP6CLHH+i4Hl5GeqL4fpocoU
         IH8H7QONg+i/P8mDUbueUJhSYTP+dnZdZA7K5C2Z2xyTmSEoDutznRrgsA6snmIgng8B
         8UhLiqPUaCzx+8KL19Xer8HnIRQJiyOnX28liiIdCdqT4+xpPDurlbjrQICiRSBvjO0W
         4vwXgLZ3G6mlN/17CgZxdzKQf+igulH4XH/mMSmt7PK1x7akmkAyWDy2nKw0wecxMZmH
         ygqD1Tj+8Oe1vbHIXZmwaEc7dNawzuYt9ML1fBCUQhH/Uhgp2oQE/abIkuqsxWq+IQc2
         2Agw==
X-Gm-Message-State: AOAM532qU4ZqrUjST7aSM+ZvjBjtAikUv2nnZ48NST5+4Y4KQPEegkE1
        0HIJqCx51eCVAzrUepDjcu4UYaQ73Q==
X-Google-Smtp-Source: ABdhPJybxOVVFOS3NkAAEC/AR9Y5/4kVSK2OgYDipCWcKbf9Z7GreQV5ccgTMO22ZvTm5DoLFx1oaQ==
X-Received: by 2002:a05:6808:3b1:: with SMTP id n17mr1330058oie.41.1611611269620;
        Mon, 25 Jan 2021 13:47:49 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p23sm3758067otk.51.2021.01.25.13.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 13:47:48 -0800 (PST)
Received: (nullmailer pid 1065810 invoked by uid 1000);
        Mon, 25 Jan 2021 21:47:47 -0000
Date:   Mon, 25 Jan 2021 15:47:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        marijn.suijten@somainline.org, dri-devel@lists.freedesktop.org,
        thierry.reding@gmail.com, airlied@linux.ie,
        martin.botka@somainline.org, phone-devel@vger.kernel.org,
        robh+dt@kernel.org, konrad.dybcio@somainline.org, sam@ravnborg.org
Subject: Re: [PATCH 2/2] dt-bindings: display: Document BOE BF060Y8M-AJ0
 panel compatible
Message-ID: <20210125214747.GA1065748@robh.at.kernel.org>
References: <20210114175024.399756-1-angelogioacchino.delregno@somainline.org>
 <20210114175024.399756-2-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114175024.399756-2-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 18:50:24 +0100, AngeloGioacchino Del Regno wrote:
> Document the boe,bf060y8m-aj0 panel.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  .../display/panel/boe,bf060y8m-aj0.yaml       | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/boe,bf060y8m-aj0.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
