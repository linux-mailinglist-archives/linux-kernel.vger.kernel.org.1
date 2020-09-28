Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A5527B47B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgI1SbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:31:07 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40433 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgI1SbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:31:06 -0400
Received: by mail-ot1-f67.google.com with SMTP id c2so1917412otp.7;
        Mon, 28 Sep 2020 11:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NA1YCFDDdCEsWjv2AATed3eNSDGAzCWeWGSA5r8BwCI=;
        b=KsPQisKn5ipgIJVSeZvm1fZv6M5235/k9OsL28RxelEWpVeVshWjHnM9ZqI5LR5azz
         ROYJvdj30DTQUUkHZQhx/4iecwkdjdnqijsJjOEF4d+BbVCYPYjSxAxGbrL5HNc7L7dy
         OfUKGXeidcUkNYNlHbduNypThWW9U+mrWA5h5I1lKLQpgKZE0O7zZNlznJpFl6999vun
         aJ5d8xZSqj30pHNumHZ8dVeSjOwSGq60qA1+9orA2S4qpU6rq+EzS6ssomxLt84olKC7
         cJm6+GezLXJYUofiXHO4ESxdDtJ7BQi4fGBgmU2wjBp5X7+wV11JvTrk5mJ4bLsSd3vk
         qljQ==
X-Gm-Message-State: AOAM5318ghqLISMKMBhqSgJPQ9qeKTaLxeI4ORhGpE34E+q+hqVybXXq
        QghuuRC7y8YWZ4MOStULfw==
X-Google-Smtp-Source: ABdhPJwb0KzKT4QL5i7Qie7W0c22WdIaqMe6nNmjMvl99SvsAi3tfddwsso8nJz4ehynnJHXvdKwLw==
X-Received: by 2002:a9d:4c01:: with SMTP id l1mr183689otf.341.1601317866243;
        Mon, 28 Sep 2020 11:31:06 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m3sm431594otc.72.2020.09.28.11.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:31:05 -0700 (PDT)
Received: (nullmailer pid 3041867 invoked by uid 1000);
        Mon, 28 Sep 2020 18:31:04 -0000
Date:   Mon, 28 Sep 2020 13:31:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     peda@axentia.se, devicetree@vger.kernel.org, nm@ti.com,
        kishon@ti.com, t-kristo@ti.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, nsekhar@ti.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] dt-bindings: ti-serdes-mux: Add defines for J7200
 SoC
Message-ID: <20200928183104.GA3041813@bogus>
References: <20200921143941.13905-1-rogerq@ti.com>
 <20200921143941.13905-2-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921143941.13905-2-rogerq@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Sep 2020 17:39:36 +0300, Roger Quadros wrote:
> There are 4 lanes in each J7200 SERDES. Each SERDES lane mux can
> select upto 4 different IPs. Define all the possible functions.
> 
> Cc: Peter Rosin <peda@axentia.se>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  include/dt-bindings/mux/ti-serdes.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
