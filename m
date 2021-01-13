Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC80E2F4311
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 05:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbhAMEWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 23:22:40 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:36458 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbhAMEWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 23:22:39 -0500
Received: by mail-wr1-f49.google.com with SMTP id t16so648417wra.3;
        Tue, 12 Jan 2021 20:22:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t3HagmBJGovu0QvJZ9KkIGiFFpl5tBOZ8sPFd4qVoYI=;
        b=TJFWOML7H/e22DV9zE09on7UBmd9cnPZTozwpOfRZW3gUus0a5+1+RdQ3zZG7FMiNm
         YYrJ2yTT8K8gsevziG+Vja7JAokiO5RCgJAUc+bRgGFZTQ079RrmjLv/UI8OA81cen4D
         pjT4+eR2t6lyaQr0i5o+MtSTD8mMhgwROt449cO0R73NiS7l8td9QX/dgHZvTg6jg5I2
         ZFtJwU5CJw5DoGnz0bYfPVzWg85V99x8ZxbJmUNK7/PtZckVyqRWcMkFy04qexEOWHfk
         /sMlfpZfIwZUNmeWhFmzmBY4iwigSXWeBeaFIPsniWqfZTpJxw2tCphN2pjZ3xlNAMty
         AWXg==
X-Gm-Message-State: AOAM532SW+So3rYC1sImrchQrXoS/JsgCT8Voiti454p6m7uhQFX5IaM
        4qivewMFP27pUckCBq/jXV4=
X-Google-Smtp-Source: ABdhPJzkaHrOeWdlGhY6q6jzcbNwiFHzkRhLH5KAuOzako6cSBOPHauedfAa1PwsFlvx0m3keAHPxw==
X-Received: by 2002:a5d:4101:: with SMTP id l1mr413041wrp.196.1610511717435;
        Tue, 12 Jan 2021 20:21:57 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id y11sm886936wmi.0.2021.01.12.20.21.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 20:21:56 -0800 (PST)
Date:   Wed, 13 Jan 2021 05:21:54 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com, catalin.marinas@arm.com,
        will@kernel.org, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] arm64: dts: Add Librem5 Evergreen
Message-ID: <20210113042154.GA6486@kozik-lap>
References: <20210112095151.4995-1-martin.kepplinger@puri.sm>
 <20210112095151.4995-9-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210112095151.4995-9-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:51:50AM +0100, Martin Kepplinger wrote:
> Add librem5-r4 with specifics to that revision like the near-level,
> battery and charger properties. For schematics and more information,
> see https://developer.puri.sm/Librem5/Hardware_Reference/Evergreen.html
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |  1 +
>  .../boot/dts/freescale/imx8mq-librem5-r4.dts  | 35 +++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dts
>

The bindings go before DTS change using them.

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
