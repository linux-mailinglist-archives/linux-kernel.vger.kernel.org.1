Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE6C290950
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 18:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409117AbgJPQHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 12:07:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34356 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405432AbgJPQH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:07:29 -0400
Received: by mail-oi1-f194.google.com with SMTP id w204so3014274oiw.1;
        Fri, 16 Oct 2020 09:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FdAnypayCNAEHSt2e5tstCFOMa3BUpSuCuXAQeatv68=;
        b=A1ThBdD7D5p4MoiJUxd7H4ViG1/G3cwgrQJrrBZvkQKgKcs+tOPTPO5ORR5zY45em4
         mw2BiN2nT/gg1iSWdREL0OG7CeN7MoWu0uQN3I4fjqQoSlD/sj+NiFPX8qcth1c3Jyqy
         U87jN0FxGZG/Gvzy19oLwXYhy//mQ2oDjzDotludNfCVnpr4iiydoYwaFQthL9sWXzkY
         ykwt76/dQF7P1V45Euu0mDnTHR0ymdX7yYJqafYo0lKzaNx6tfX+xn9qFx63qcD7Mc5Q
         QHPsFjK0Qq+jl4pT9FQrALk3jHSirYmm+AbUQOxDDKa5NerjGYVXIHm+wU6QmzUz0LrA
         jpHQ==
X-Gm-Message-State: AOAM532EV9ewNwE3lQjbqg4o7ETU4ekHGJDv0/BTj6GwV6gCNlgCMdPH
        Yqg86thr2uucfXas5NZ7Jg==
X-Google-Smtp-Source: ABdhPJyueM8m+wzO38JzNm013LzdtBhgW4tkYxr+nxNYXJKypyowhgl+vsWfboUwF6MtrbhNisZWeg==
X-Received: by 2002:aca:c54e:: with SMTP id v75mr2984866oif.134.1602864448669;
        Fri, 16 Oct 2020 09:07:28 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t29sm1088993otd.51.2020.10.16.09.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 09:07:28 -0700 (PDT)
Received: (nullmailer pid 1499812 invoked by uid 1000);
        Fri, 16 Oct 2020 16:07:27 -0000
Date:   Fri, 16 Oct 2020 11:07:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        linux-rockchip@lists.infradead.org,
        Caesar Wang <wxt@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        heiko@sntech.de, dianders@chromium.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4] dt-bindings: power: rockchip: Convert to json-schema
Message-ID: <20201016160727.GA1499240@bogus>
References: <20201015101944.407487-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015101944.407487-1-enric.balletbo@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 12:19:44 +0200, Enric Balletbo i Serra wrote:
> Convert the soc/rockchip/power_domain.txt binding document to json-schema
> and move to the power bindings directory.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> Rob, I didn't add a number of clocks neither a number of pm_qos because will
> be a finger in the air number. If you still want I add it, I can add a
> number based on the actual users of this binding but no guarantee that
> we don't need to change that number in the future.
> 
> Changes in v4:
> - Use hex for unit-addresses.
> - Use space between compatibles in the example.
> - Define child nodes for nested power domains even are duplicated but
>   more clear that adding a regex scaped to be a valid URI.
> 
> Changes in v3:
> - Fixed tab errors found by bot
> 
> Changes in v2:
> - Fixed a warning that says that 'syscon' should not be used alone.
> - Use patternProperties to define a new level for power-domains.
> - Add const values for power-domain-cells, address-cells, etc.
> 
>  .../power/rockchip,power-controller.yaml      | 283 ++++++++++++++++++
>  .../bindings/soc/rockchip/power_domain.txt    | 136 ---------
>  2 files changed, 283 insertions(+), 136 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt

With the indentation fixed, 

Reviewed-by: Rob Herring <robh@kernel.org>
