Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C546A269680
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgINU07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:26:59 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:43602 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgINU01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:26:27 -0400
Received: by mail-io1-f45.google.com with SMTP id z25so1539256iol.10;
        Mon, 14 Sep 2020 13:26:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pBnFBkWoZFvBeLIVMIY+de1Tgg4+VMrP2i4DNdIGX9U=;
        b=kWa8ehsWlAtLnVB4/59Ys0+l5KpQUH+USeUyPfrzjhCOawIrKeubr0LlTeDJH7YZgj
         liD0ume+SDIXyIgQ1XLZ56LlJVZtOoXVKJhrMVVFrGtXNFyGTwdssVI4fwdN8j1WgdIR
         XslxeEnwRkFLumXqXejW476v0Au4Nihr16jLnp0jswhNJ9OU9c6qb7oZD5XGpAPEn8Th
         oEfZOEzF5h/xYMdO/qfERu/B/bQ0fuPhA4EiUsLGAghSESJ9mE31pNNqlz3teaWPmk1o
         Uh47bxZdoXTe/VHvvP9rtWuYyJx3Fziki7f1pmYY8g1YyCVQj+hmBrFV05o+25I7Wymq
         voIQ==
X-Gm-Message-State: AOAM530TtFv+95HAG9VE1z9PoWdHMJBN9woDlR0N2Tdj+Qs60yltfSlx
        FraqR/X1dHvfUm6Ik/Uyuw==
X-Google-Smtp-Source: ABdhPJzG7fU1g8IWiJZlne66hAGC8Dn0qryW6T3XCfP9dBS3ABXnxukUIIwe8+M6m34CHZdHTDe2uQ==
X-Received: by 2002:a02:9f0d:: with SMTP id z13mr14871940jal.60.1600115186421;
        Mon, 14 Sep 2020 13:26:26 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id i14sm7679165ilb.28.2020.09.14.13.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:26:25 -0700 (PDT)
Received: (nullmailer pid 183633 invoked by uid 1000);
        Mon, 14 Sep 2020 20:26:23 -0000
Date:   Mon, 14 Sep 2020 14:26:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     lindsey.stanpoor@gmail.com
Cc:     devicetree@vger.kernel.org, cnemo@tutanota.com, balbi@kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-rockchip@lists.infradead.org, heiko@sntech.de,
        robh+dt@kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/4] dt-bindings: usb: add rk3328 dwc3 docs
Message-ID: <20200914202623.GA183582@bogus>
References: <20200902181234.13955-1-lindsey.stanpoor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902181234.13955-1-lindsey.stanpoor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Sep 2020 11:12:31 -0700, lindsey.stanpoor@gmail.com wrote:
> From: Cameron Nemo <cnemo@tutanota.com>
> 
> Document compatible for dwc3 on the Rockchip rk3328 platform.
> 
> Signed-off-by: Cameron Nemo <cnemo@tutanota.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc3.txt          | 1 +
>  Documentation/devicetree/bindings/usb/rockchip,dwc3.txt | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
