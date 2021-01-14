Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54E3E2F6A95
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbhANTKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:10:23 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:46879 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbhANTKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:10:21 -0500
Received: by mail-ot1-f46.google.com with SMTP id w3so6169826otp.13;
        Thu, 14 Jan 2021 11:10:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LHnv4YBdvdSukhMOpEajJnzBDnb/tm9j26BMAF7scIo=;
        b=dBX2MYyIZExqSIT9xxjM8Vzhm6psyvcGcA9J8ixUlA6dzmwJjfsMzrd5E3/50z/COe
         YFwyyL3QTLU06Migp+Bne41GkI8GdscVIU8LJo08hJ7TyPDLLN5E+sotIzuCsNUJJi57
         yUvjSW0e4SWw1XTdWsbUfJ+qnBDqU+Mo91j12tln5YiV9yqudAjhfNzSlvWFEz8Mu+fM
         vF5oU8qOIK96GB8m7xPca3cj245OVUzcGYdLzOX3jqDgnuSRU01XGrRYSDD0A4zOLg/J
         n8p4rojsLb9sAijAKjilum13Lg9JuJBQWulZowQGv11eVdQC00U8wQDBkEGIvSjuKki8
         aRfQ==
X-Gm-Message-State: AOAM531Z503HBcZtLICy5DovpOQ6XR976el+TTXvtszbpjDAbsw5NtQu
        Rv2krOn21xfLpN10Z7sLhA==
X-Google-Smtp-Source: ABdhPJyXY9ue6QPUzsbYXuR+YT+3/Y46kF6q/lHe43oOwfEA57P9/0c2PVBhldi1Kjbmb/mgV1Fn3A==
X-Received: by 2002:a9d:8ea:: with SMTP id 97mr5456555otf.223.1610651380243;
        Thu, 14 Jan 2021 11:09:40 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v4sm1225950otk.50.2021.01.14.11.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 11:09:39 -0800 (PST)
Received: (nullmailer pid 3390716 invoked by uid 1000);
        Thu, 14 Jan 2021 19:09:38 -0000
Date:   Thu, 14 Jan 2021 13:09:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chen-Yu Tsai <wens@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] dt-bindings: arm: rockchip: Add Radxa ROCK Pi E
Message-ID: <20210114190938.GA3390660@robh.at.kernel.org>
References: <20210110035846.9155-1-wens@kernel.org>
 <20210110035846.9155-3-wens@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210110035846.9155-3-wens@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jan 2021 11:58:45 +0800, Chen-Yu Tsai wrote:
> From: Chen-Yu Tsai <wens@csie.org>
> 
> Radxa ROCK Pi E is a router oriented SBC based on Rockchip's RK3328 SoC.
> As the official wiki page puts it, "E for Ethernets".
> 
> It features the RK3328 SoC, gigabit and fast Ethernet RJ45 ports, both
> directly served by Ethernet controllers in the SoC, a USB 3.0 host port,
> a power-only USB type-C port, a 3.5mm headphone jack for audio output,
> two LEDs, a 40-pin Raspberry Pi style GPIO header, and optional WiFi+BT
> and PoE header.
> 
> The board comes in multiple configurations, differing in the amount of
> onboard RAM, the level of WiFi+BT (none, 802.11n 2.4GHz, or 802.11ac
> 2.4 GHz & 5 GHz), and whether PoE is supported or not. These variants
> can all share the same device tree.
> 
> The USB 2.0 OTG controller is available on the 40-pin header. This is
> not enabled in the device tree, since it is possible to use it in a
> host-only configuration, or in OTG mode with an extra pin from the
> header as the ID pin.
> 
> The device tree is based on the one of the Rock64, with various parts
> modified to match the ROCK Pi E, and some parts updated to newer styles,
> such as the gmac2io node's mdio sub-node.
> 
> Add a compatible string for the new board.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
