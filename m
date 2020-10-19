Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA095292F05
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 21:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgJST6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 15:58:40 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45347 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgJST6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 15:58:40 -0400
Received: by mail-oi1-f195.google.com with SMTP id j7so1271406oie.12;
        Mon, 19 Oct 2020 12:58:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iMcpjCjjlBEs+GFINxvVleDr5N6Oj32gn5NcfucJpXI=;
        b=PRvGz5Vk0/P4R+K2qnWKWf+iFhT6BahwN7KGf61K6BE4VUl3JBAueoPFkmtYq4/Drc
         Ii3cSW6VUwEsTYB0nc3ZzCBbKvnvRUwxL/VVJIgJ6Z5kawNVW+RiIDdwpQ4/nZTUrMMU
         zRVIBXCykEIJlrq+fcWsZRgxYu1q8wI8uTV+nonXR+3wBaFY9qusaRuu2cXj3y9IyzXy
         XDeTpeocwXzPcz0c9UUynyciBNHOw5Tk8Q1+kSHzuEPmtOkfZoxq2yxPZKP3oGMOQ4il
         zUnKL8/RgnLUAtDkPN9zozaNCb9vyGSvMuIKfp0eSd4Ys860EDREDxbkFsxrpkQIA3xx
         o10g==
X-Gm-Message-State: AOAM533vqeD08upPXLtpeFeGu6miRRqllp4Gm1Lo1cfphUdfoTtdfGq9
        TZWqKIOzkxrpIf1500aKjg==
X-Google-Smtp-Source: ABdhPJxVetBxNF3wbgnA9NSr9IsdFHypWN7ATmupsq8ibMJqkLHVvEhvBI/C96CZZePXbzF7ok4YRw==
X-Received: by 2002:aca:b256:: with SMTP id b83mr700269oif.116.1603137518838;
        Mon, 19 Oct 2020 12:58:38 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y194sm208402oie.22.2020.10.19.12.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:58:38 -0700 (PDT)
Received: (nullmailer pid 3509370 invoked by uid 1000);
        Mon, 19 Oct 2020 19:58:37 -0000
Date:   Mon, 19 Oct 2020 14:58:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     linux-kernel@vger.kernel.org, vigneshr@ti.com, robh+dt@kernel.org,
        linux-rockchip@lists.infradead.org, miquel.raynal@bootlin.com,
        heiko@sntech.de, devicetree@vger.kernel.org,
        linux-mtd@lists.infradead.org, richard@nod.at,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v11 1/8] dt-bindings: mtd: Describe Rockchip RK3xxx NAND
 flash controller
Message-ID: <20201019195837.GA3508930@bogus>
References: <20201019083358.32621-1-yifeng.zhao@rock-chips.com>
 <20201019083358.32621-2-yifeng.zhao@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019083358.32621-2-yifeng.zhao@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Oct 2020 16:33:55 +0800, Yifeng Zhao wrote:
> Documentation support for Rockchip RK3xxx NAND flash controllers
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
> 
> (no changes since v8)
> 
> Changes in v8:
> - Fix make dt_binding_check error
> 
> Changes in v7:
> - Fix some wrong define
> 
> Changes in v6:
> - Fix some wrong define
> - Modified the definition of compatible
> 
> Changes in v5:
> - Fix some wrong define.
> - Add boot-medium define.
> - Remove some compatible define.
> 
> Changes in v4:
> - The compatible define with rkxx_nfc.
> - Add assigned-clocks.
> - Fix some wrong defineChanges in.
> 
> Changes in v3:
> - Change the title for the dt-bindings.
> 
>  .../mtd/rockchip,nand-controller.yaml         | 162 ++++++++++++++++++
>  1 file changed, 162 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

./Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml:92:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml:101:9: [warning] wrong indentation: expected 10 but found 8 (indentation)


See https://patchwork.ozlabs.org/patch/1384067

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

