Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BEA269764
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 23:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgINVGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 17:06:55 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:44944 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgINVGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 17:06:53 -0400
Received: by mail-il1-f195.google.com with SMTP id h11so921993ilj.11;
        Mon, 14 Sep 2020 14:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FRJbFV8TtlGV/fuyCW0Lk1ZSMLH7Q700y+hxSQgxsfo=;
        b=sINR7wRD5TT6MDdQilkxCNQCCAXE5L8NSA7OXuuGMONsY80Q+khrVN2oXRVjtMQIu6
         Q0RmJriK6GIXCqA/6qIgHEOd7Pqb0L2Jo3xOAsn55RLtRT8GG+bhJuE5piaDytgjpED3
         gLmxfGe+h0pwNSV4k4o15S1l8yIL5pz2JmFpu+mrstbm/s67xjOmg6bN5neQpa7wXI9Z
         DkkM6jUPIW8Q/oaHe97MX91WgAkJIYm37U/Nx903o1NP8dmPMaHXuI9utUtcTzcPIf/3
         dH5rNRoyRp2WZly2m7AF9UdAwQvK27eBQXgBIQlOgemvBG56KCuyuXHh0cVg6C2RkCjm
         KgQg==
X-Gm-Message-State: AOAM530eQlkAaQSwsEL66Oone7hi+uWOk3JQFrlH1v87+Rp7/r4nwL2b
        LCEKv1jwQ4xw2FgTpw4wPQ==
X-Google-Smtp-Source: ABdhPJy1UZ4bKOaDZXU8JkHivfNSgDajTheO8EfjgjoB1lHsSZqfP+N6vIe6wRPTQ8EPihst8YK4WQ==
X-Received: by 2002:a92:910a:: with SMTP id t10mr13679580ild.256.1600117611352;
        Mon, 14 Sep 2020 14:06:51 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id w15sm7488380ilq.46.2020.09.14.14.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 14:06:50 -0700 (PDT)
Received: (nullmailer pid 249445 invoked by uid 1000);
        Mon, 14 Sep 2020 21:06:48 -0000
Date:   Mon, 14 Sep 2020 15:06:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        srv_heupstream@mediatek.com, Sascha Hauer <kernel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH 1/3] dt-bindings: soc: Add MT8192 power dt-bindings
Message-ID: <20200914210648.GA249407@bogus>
References: <1599201895-11013-1-git-send-email-weiyi.lu@mediatek.com>
 <1599201895-11013-2-git-send-email-weiyi.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1599201895-11013-2-git-send-email-weiyi.lu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Sep 2020 14:44:53 +0800, Weiyi Lu wrote:
> Add power dt-bindings of MT8192
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  .../devicetree/bindings/soc/mediatek/scpsys.txt    |  5 ++++
>  include/dt-bindings/power/mt8192-power.h           | 32 ++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt8192-power.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
