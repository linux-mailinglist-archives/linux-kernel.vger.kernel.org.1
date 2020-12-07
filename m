Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9618E2D1818
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgLGSCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 13:02:36 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45910 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgLGSCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 13:02:36 -0500
Received: by mail-ot1-f66.google.com with SMTP id h18so9328081otq.12;
        Mon, 07 Dec 2020 10:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6yo47xkFd96+1uzbs4hUVtKd9yJftEoZWizCC87Sgzo=;
        b=m8t405D1vF/rtOLXliYgGmfFx9zM4tZhS84KaTaShNk1Ac3GKDNIv0C1gvFGQpakV+
         ZDwf+LTtsMQUabotK79olF7T4Zmt4K/gG09fyue7j20oxkmqyTxo/INJNx1UthvS623c
         DChf79XDmU0SRfVviyoX46V/FM5Q2gHvq0x5Q1wyjdHqwLc4x/NgREESbALUJjffBSp0
         4hL73QfmzXolb1ZmcYeqhl//gjeQJzYH0iBhuAOGjwqGO5gxIM4WToq/+NdeiBP6oPdw
         SX0Hsa5Dxlkte+VS55C6p14B/INXJ3IIog33HZJWs8Qapp4MYphAOlTl6HF/kNq+4JHS
         /riw==
X-Gm-Message-State: AOAM530pSYfyQUNwK7aHkfwNO7oI9hSivhTP0FlSWO8zirNHKhVjpeCN
        s/NGN/Vh8wP6pwEm/mbAUQ==
X-Google-Smtp-Source: ABdhPJw0shJl8ArayE//p46EUlSOU5Q2et7NSHa+5b09oa2VHAR5G6ocG2jPI26JO9CVx8E3MajxdA==
X-Received: by 2002:a9d:3e82:: with SMTP id b2mr5062324otc.329.1607364115404;
        Mon, 07 Dec 2020 10:01:55 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c21sm172554otd.44.2020.12.07.10.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 10:01:54 -0800 (PST)
Received: (nullmailer pid 521529 invoked by uid 1000);
        Mon, 07 Dec 2020 18:01:53 -0000
Date:   Mon, 7 Dec 2020 12:01:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/2] devicetree: phy: rockchip-emmc: pulldown property
Message-ID: <20201207180128.GA520435@robh.at.kernel.org>
References: <20201129054416.3980-1-chris.ruehl@gtsys.com.hk>
 <20201129054416.3980-3-chris.ruehl@gtsys.com.hk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129054416.3980-3-chris.ruehl@gtsys.com.hk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 29, 2020 at 01:44:15PM +0800, Chris Ruehl wrote:
> Update the documentation and add the bool property
> enable-strobe-pulldown used to enable the internal pull-down for the
> strobe line.
> 
> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> ---
>  Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> index e728786f21e0..3e4d2d79a65d 100644
> --- a/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt
> @@ -16,6 +16,8 @@ Optional properties:
>   - drive-impedance-ohm: Specifies the drive impedance in Ohm.
>                          Possible values are 33, 40, 50, 66 and 100.
>                          If not set, the default value of 50 will be applied.
> + - enable-strobe-pulldown: Enable internal pull-down for the strobe line.
> +                           If not set, pull-down is not used.

Needs a vendor prefix.
