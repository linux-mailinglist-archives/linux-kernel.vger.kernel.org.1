Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E9D247A40
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 00:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgHQWMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 18:12:32 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:36242 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730328AbgHQWMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:12:13 -0400
Received: by mail-il1-f193.google.com with SMTP id z3so15921998ilh.3;
        Mon, 17 Aug 2020 15:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eqARiGNwhWeaZVOhEsppjcqmVGZGsngOhSrvXhX8++U=;
        b=aYj4+6w+bM6Z/Y//E5hynvkqAfgCf4Q8KDBidX7piFagXy6eLjbFD0HTewPRPYiqFU
         uAqdKiZ8IUCHlhVxq+mUBWlHWmyX3mJy1VtI3YdkexaX8jE+I9xnv598cpvQ7+DbSeTl
         SBtHUry/4FUjbxGWRFEEC66qVBvxUhZ43BqtLjN7hgPLUK6qZrCK/L7T0gSVBWHoORh8
         DNFMbjzkXBCiplU12gRTZArbaGN0wUZMO/6Thp6S1GKIMam4aiB6dxbcFjgaED41CEWf
         iAFX8GYmLP0Cv69N2sOoII91Wvh+2kfRQKvjq+ZR/2nKaGrKqzv/htVYOxVrZPuocdyV
         m46Q==
X-Gm-Message-State: AOAM532rry5OIav3IadAiqtXUP16qoyg/EIunHZz0Xom7SBXMsp/y09o
        wGgHJgEm51RuXceFucuH6w==
X-Google-Smtp-Source: ABdhPJxaHQDdK5l+Zbg9OPKnsIxZnS0CqZGdDbP8dVEYrKCCDob0+3+2jw+s/ERzC5b99XKCqt4QQw==
X-Received: by 2002:a92:c008:: with SMTP id q8mr10609818ild.106.1597702332693;
        Mon, 17 Aug 2020 15:12:12 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id d125sm9693070iof.32.2020.08.17.15.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 15:12:12 -0700 (PDT)
Received: (nullmailer pid 1667141 invoked by uid 1000);
        Mon, 17 Aug 2020 22:12:09 -0000
Date:   Mon, 17 Aug 2020 16:12:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: arm: rockchip: Update ROCKPi 4
 binding
Message-ID: <20200817221209.GA1667089@bogus>
References: <20200807094826.12019-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807094826.12019-1-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Aug 2020 15:18:23 +0530, Jagan Teki wrote:
> ROCKPi 4 has 3 variants of hardware platforms called
> ROCKPi 4A, 4B, and 4C.
> 
> - ROCKPi 4A has no Wif/BT.
> - ROCKPi 4B has AP6256 Wifi/BT, PoE.
> - ROCKPi 4C has AP6256 Wifi/BT, PoE, miniDP, USB Host enabled
>   GPIO pin change compared to 4B, 4C
> 
> So, update the existing ROCKPi 4 binding to support
> ROCKPi 4A/B/C hardware platforms.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v4:
> - update binding to satisfy dt_binding_check.
> Changes for v3:
> - new patch
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
