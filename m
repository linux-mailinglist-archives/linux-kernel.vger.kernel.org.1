Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05AF2478CE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 23:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgHQV0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 17:26:05 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:42137 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbgHQV0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 17:26:03 -0400
Received: by mail-il1-f195.google.com with SMTP id t13so15772752ile.9;
        Mon, 17 Aug 2020 14:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j6+8ivPskM82OWr42a4LsreFZvgKx1kAB3ys2yCSz8I=;
        b=nf7lKGB3aCZPWwzrBscQa5azzyjZVVt1IYUpvfTnUYY+Gp7qUi1rWwlmuM7ce14Y+m
         aleuCQoF3wYLgZwf/d/oGPWp16bK1SItmdtOudWUoyzIjMxoIkQ9JdQBTq0EqM+Vy15i
         IXW+F7xB+l3tvyfqyqVeYWqc0ttqwlJI4J/mSM4kOmhnnF3Sl+vW37uBH8AI9UprfXtf
         VUITFIY24IWvN5a925mIDBpTKXXWvdn5YJqj27fzzSiHnO3Dm9fAdrR5Ke2/6gEOWNKy
         GJWmE30DxS4I0MVvUyB7CXF/o8MCmIv5tTOz7UYDSEmkrWSj7X+8M0CSQS4z5vKcA9pw
         kVpA==
X-Gm-Message-State: AOAM531q9E8QfAXS5EJAtU3dxUJrehPyhceagcD0bb3Nqr0uLtIaYQJ7
        3JrsI6dfCA9t3/2tHf8GRg==
X-Google-Smtp-Source: ABdhPJxvB4WeLN/KkQ+e8GF34vSz5fvZhjljVBy9I+SbB1N5TWrE1Rg8AU9jto+9BLfxKM00fUxQwg==
X-Received: by 2002:a92:c090:: with SMTP id h16mr9457523ile.103.1597699562741;
        Mon, 17 Aug 2020 14:26:02 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id c76sm10571612ill.63.2020.08.17.14.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:26:02 -0700 (PDT)
Received: (nullmailer pid 1592228 invoked by uid 1000);
        Mon, 17 Aug 2020 21:26:00 -0000
Date:   Mon, 17 Aug 2020 15:26:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org,
        santosh.shilimkar@oracle.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH next 2/3] bindings: soc: ti: soc: ringacc: remove ti,
 dma-ring-reset-quirk
Message-ID: <20200817212600.GA1592198@bogus>
References: <20200804211732.2861-1-grygorii.strashko@ti.com>
 <20200804211732.2861-3-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804211732.2861-3-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Aug 2020 00:17:31 +0300, Grygorii Strashko wrote:
> Remove "ti,dma-ring-reset-quirk" DT property as proper w/a handling is
> implemented now in Ringacc driver using SoC info.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  Documentation/devicetree/bindings/soc/ti/k3-ringacc.yaml | 6 ------
>  1 file changed, 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
