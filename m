Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DC1293050
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 23:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbgJSVOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 17:14:15 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34197 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbgJSVOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 17:14:15 -0400
Received: by mail-ot1-f67.google.com with SMTP id d28so1195199ote.1;
        Mon, 19 Oct 2020 14:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AkXg9ywvkN5UzvdgIWgHzBaGiXjXW0zCY62KlslqE20=;
        b=Uzm4CaN1e9sv9PPDK1ieKVcMxWzJKnv6o7ubGulYx9v1NZt9FLqiEtSCKNDgIWOLpK
         xgxnlu+RBKd+r76t+u0c8Gr977ELYiX5y0CG0lAgmPEWO+KMs/zq5Jg16BuT0f88voE5
         SGwyQDOUkGQdIm41UC6Zrtobo/70AAFFqfQn0rktCiXuCrGt6qlzJmrxT/WvxnpcLl1N
         t3hhUE8TepLC51Yu0JLK7w8sQzpL+q0BwRduZxUNKIHiLoBz1uCXXQrt4S9WYbNWk2EY
         CCziEOQXia6Pe1sU674zHieHY25xQGBSAlPkx2e0Og7w/lbO1V+94LrYiz6gPrbw2qfw
         ua9Q==
X-Gm-Message-State: AOAM5308WXYO+8L9umFhP3xP2HhpHG3AzGZ3M3ClvuyPuM5RZGzmCARO
        ByHNMkoVFmovKWUtNgcXDA==
X-Google-Smtp-Source: ABdhPJySWGj+x0Hi8zbrlVaFg82BBb5KUi35oGG9P+zK3XUXlyw0S3QakYsFzPn0pzs9rO9TYNDsEg==
X-Received: by 2002:a9d:65d7:: with SMTP id z23mr1380659oth.131.1603142054307;
        Mon, 19 Oct 2020 14:14:14 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v11sm221060otj.73.2020.10.19.14.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 14:14:13 -0700 (PDT)
Received: (nullmailer pid 3612712 invoked by uid 1000);
        Mon, 19 Oct 2020 21:14:12 -0000
Date:   Mon, 19 Oct 2020 16:14:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     timur@kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, lgirdwood@gmail.com, tiwai@suse.com,
        alsa-devel@alsa-project.org, robh+dt@kernel.org,
        nicoleotsuka@gmail.com, broonie@kernel.org, festevam@gmail.com,
        Xiubo.Lee@gmail.com, perex@perex.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: fsl_spdif: Add new compatible
 string for i.MX8QM
Message-ID: <20201019211412.GA3612681@bogus>
References: <1602739728-4433-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602739728-4433-1-git-send-email-shengjiu.wang@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 13:28:47 +0800, Shengjiu Wang wrote:
> Add new compatible string "fsl,imx8qm-spdif" for supporting spdif
> module on i.MX8QM.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl,spdif.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
