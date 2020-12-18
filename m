Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6228A2DEAF9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 22:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgLRVSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 16:18:48 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:34972 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgLRVSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 16:18:47 -0500
Received: by mail-oi1-f179.google.com with SMTP id s2so4362814oij.2;
        Fri, 18 Dec 2020 13:18:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=03HFPXnAxYNSTh3L20SLd4XBlw3VNwGfa9nRljaVjjk=;
        b=tzlZbSxxgR3tHSMbnw8fbfx0noRM2kjEFF3p+Cd4V8Lrh4zq69FqW3SU+aiPBnd9o1
         EToifXEVESlpOe1863mJQMOpHIK+DIzn7GQgI29400lBH/M+WNYjKzdhvMbMOVzuZlEj
         m1HbMJqQ1LI/JE9lgfUhgPadBT5aWodawsHPLGGvm8D8funu/s2Iv5GvhmjvoK7oXLgJ
         Myw8w88Z9qGsy1zqtb3ocP1S3D20lzT3S1Zv3bgYec1v4B/D+ZoVOZ2L7rgCTGTLCu1W
         bEbUL5bS/9A6nDjHlLhRvPJkvFwJvRwlX8UZrpZ09lmdYu9v+kJvP+Vpwb/rrl/kA2xt
         vNpA==
X-Gm-Message-State: AOAM5301BcQZH0TGCKI6pegmD2R6E87iR0GHkw6BdIAf6MdKp5kNQvI2
        lQcIeaRlk9eFevAT70I9t3ZFnRv2Bw==
X-Google-Smtp-Source: ABdhPJzp2Vn29fMDo1374G2raWeUpRvXsBe5yqSFqZr9o1/LOLXJmn9Q9gnzEAgSqaGpr8bxwrzA+g==
X-Received: by 2002:a05:6808:617:: with SMTP id y23mr4138266oih.84.1608326285997;
        Fri, 18 Dec 2020 13:18:05 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g3sm1761819ooi.28.2020.12.18.13.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 13:18:05 -0800 (PST)
Received: (nullmailer pid 2191933 invoked by uid 1000);
        Fri, 18 Dec 2020 21:18:04 -0000
Date:   Fri, 18 Dec 2020 15:18:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v2 1/1] dt-bindings: display: eliminate yamllint warnings
Message-ID: <20201218211804.GD2190633@robh.at.kernel.org>
References: <20201207044830.1551-1-thunder.leizhen@huawei.com>
 <20201207044830.1551-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207044830.1551-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Dec 2020 12:48:30 +0800, Zhen Lei wrote:
> Eliminate the following yamllint warnings:
> ./Documentation/devicetree/bindings/display/bridge/analogix,anx7625.yaml
> :52:9: [warning] wrong indentation: expected 6 but found 8 (indentation)
> 
> ./Documentation/devicetree/bindings/display/bridge/intel,keembay-dsi.yaml
> :42:8: [warning] wrong indentation: expected 8 but found 7 (indentation)
> :45:8: [warning] wrong indentation: expected 8 but found 7 (indentation)
> 
> ./Documentation/devicetree/bindings/display/intel,keembay-msscam.yaml
> :21:6: [warning] wrong indentation: expected 6 but found 5 (indentation)
> 
> ./Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml
> :25:10: [warning] wrong indentation: expected 10 but found 9 (indentation)
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  .../devicetree/bindings/display/bridge/analogix,anx7625.yaml          | 4 ++--
>  .../devicetree/bindings/display/bridge/intel,keembay-dsi.yaml         | 4 ++--
>  Documentation/devicetree/bindings/display/intel,keembay-msscam.yaml   | 4 ++--
>  Documentation/devicetree/bindings/display/panel/novatek,nt36672a.yaml | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 

Applied, thanks!
