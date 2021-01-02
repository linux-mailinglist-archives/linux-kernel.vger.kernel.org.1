Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289432E8830
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jan 2021 19:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbhABSEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jan 2021 13:04:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbhABSEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jan 2021 13:04:42 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC378C061573
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jan 2021 10:04:01 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t30so26873868wrb.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jan 2021 10:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jamieiles-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PWNWWtqjXuhRBofwhd880gtdlxvyGF0Fap+WwqM+hHI=;
        b=eLkwmntFIPeqPFQewS/PKJ6gDMz4HGYh3W6ZYAGXhokmV6sf5ibtMWI5E+2XB+4idI
         uNCCrtDY6C/B8YgiUE/W5pBcfP8N+NIugHE2bpXA6L4YU4RLE+YeF9bfrFH++ywUHreB
         bL44ihJrCPs3Tdmt9c2y0bn+0+kCQ8qz13085qwaN6P2rua1wopu+dK7zcEf/Ybny58R
         oXD962oNTItAx9o+gO++axdhJ9NL3MukKK84laW+nctEdWIW47S5+rTJ4Wpy0A2RdMTq
         f3S2Y7vnDpWljJltpWBs8tekICKFtP5hfYhgqmfjdpjGM6AZrom3HkWnD5HyRkC7mhA0
         eE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PWNWWtqjXuhRBofwhd880gtdlxvyGF0Fap+WwqM+hHI=;
        b=kAMAa1xD0UwzAa//7dDAvaiLdRl451PTsp6XIY0B2O+mz3evL8ePPLx5DVn0iAT4fh
         41EtCBY/2QbS/lTN8PkvlYcWzMe+IzCT0uvZKtou6dgsu60d+b8YfZmHL0x+owiEQKRb
         zQ0R3ikPbLaAos0E2mHGd05CXUsBdpv0ONpBBuvjtaSkiOs/oe3LePCA6GyB5XJaPcml
         13OZyStfAcJ+BjrXkTsdoH19e/COEOq40VdQQ0nELvg+LjwS5G+W68GS5WxBMZP+Pljw
         1Y2wT26JyeVepr6LeFRpTLLNyv4OSRK204M50rBocGHFurgOptecE5/L9i/rhsSPIctw
         WyIw==
X-Gm-Message-State: AOAM532Jy2Nls1+iHgsleKKXCStk28pueH6lSQ9wea7j5iWgRaxz+KPK
        7TTIElMd1XwxYb9VPxZgRHlvuA==
X-Google-Smtp-Source: ABdhPJwRL5VBumv1xxr0bh6v+UMGz68EkeaPJuNuO19pyYUeH9obAVZlMtLxE2oY/yePO+FrdyRXsQ==
X-Received: by 2002:a5d:6909:: with SMTP id t9mr71553849wru.327.1609610640397;
        Sat, 02 Jan 2021 10:04:00 -0800 (PST)
Received: from localhost ([82.44.17.50])
        by smtp.gmail.com with ESMTPSA id b7sm75991272wrv.47.2021.01.02.10.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jan 2021 10:03:59 -0800 (PST)
Date:   Sat, 2 Jan 2021 18:03:58 +0000
From:   Jamie Iles <jamie@jamieiles.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Jamie Iles <jamie@jamieiles.com>, Rob Herring <robh+dt@kernel.org>,
        soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: picoxcell: fix missing interrupt-parent properties
Message-ID: <20210102180358.GA4063852@willow>
References: <20201230152010.3914962-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201230152010.3914962-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 04:20:05PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> dtc points out that the interrupts for some devices are not parsable:
> 
> picoxcell-pc3x2.dtsi:45.19-49.5: Warning (interrupts_property): /paxi/gem@30000: Missing interrupt-parent
> picoxcell-pc3x2.dtsi:51.21-55.5: Warning (interrupts_property): /paxi/dmac@40000: Missing interrupt-parent
> picoxcell-pc3x2.dtsi:57.21-61.5: Warning (interrupts_property): /paxi/dmac@50000: Missing interrupt-parent
> picoxcell-pc3x2.dtsi:233.21-237.5: Warning (interrupts_property): /rwid-axi/axi2pico@c0000000: Missing interrupt-parent
> 
> There are two VIC instances, so it's not clear which one needs to be
> used. I found the BSP sources that reference VIC0, so use that:
> 
> https://github.com/r1mikey/meta-picoxcell/blob/master/recipes-kernel/linux/linux-picochip-3.0/0001-picoxcell-support-for-Picochip-picoXcell-SoC.patch
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Jamie Iles <jamie@jamieiles.com>

Thanks Arnd!

Jamie
