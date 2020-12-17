Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D1A2DDC2F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 00:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732138AbgLQXw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 18:52:29 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:44372 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730140AbgLQXw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 18:52:28 -0500
Received: by mail-ot1-f54.google.com with SMTP id f16so293330otl.11;
        Thu, 17 Dec 2020 15:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sP2uAtMd2FBY95dHedMh9WAMZB4JxkSPAuXLTM2nhQE=;
        b=Zykuj2S/70Ipq+KgIiy1znGARXS+gueXLCSWejzHvwkXWHMavFidyPWaULGKmj0xxG
         I6yt0/kSErXUB3r08OVQwUnUk2bbvBn19q8KyEygMrIaRlRjzJCqXdNO95numFLt7YmF
         /TW7jZmn7H9SUHIMfgnt4lm3yGbvi+p+e99dFybBMbb8mS2x7QtLrM3TyngPbDWKgO4t
         ODijVSYbyx+n2e7eeRZnxn2eqjR6LdjpK3QBsHl9brDpBgSmlSIEv9JbqYangHmwuaO1
         sZSr07Bq4bsisUogaCVITEg0CP5G9XDXLhzfuC+FWFiDnDGK9E+P4a2faAHKVJg0WrfM
         WvMA==
X-Gm-Message-State: AOAM533ZgKJeG3VezO2q9eS1Iw6fQpVKoowE/4gpBBVf66b7HVPmutdx
        K5hqFkWxpUH6Dyjbtx7n1w==
X-Google-Smtp-Source: ABdhPJwaF88A4NGCiAmD9lDrmxGwHPv6BZq50PbKUnwc4Wh0hm9SGwuLAcwzgKtJzAaCVl+KjEepNQ==
X-Received: by 2002:a9d:2aaa:: with SMTP id e39mr1016569otb.10.1608249107866;
        Thu, 17 Dec 2020 15:51:47 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o64sm528057oif.43.2020.12.17.15.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 15:51:46 -0800 (PST)
Received: (nullmailer pid 456331 invoked by uid 1000);
        Thu, 17 Dec 2020 23:51:45 -0000
Date:   Thu, 17 Dec 2020 17:51:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     troy.kisky@boundarydevices.com, robh+dt@kernel.org,
        jagan@amarulasolutions.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com
Subject: Re: [PATCH v2 4/7] regulator: dt-bindings: pf8x00: remove
 nxp,ilim-ma property
Message-ID: <20201217235145.GA456282@robh.at.kernel.org>
References: <20201215235639.31516-1-adrien.grassein@gmail.com>
 <20201215235639.31516-5-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215235639.31516-5-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Dec 2020 00:56:36 +0100, Adrien Grassein wrote:
> This property seems useless because we can use the
> regulator-max-microamp generic property to do the same
> and using generic code.
> 
> The only things it changes is the default value. The original
> code was using "2100" (mA) as default one, but I think we should
> keep the value in the OTP memory as the default one. This value
> is automatically loaded in the register by the chip.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  .../bindings/regulator/nxp,pf8x00-regulator.yaml    | 13 -------------
>  1 file changed, 13 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
