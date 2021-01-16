Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3D42F8C3F
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 09:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbhAPIcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 03:32:06 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:43305 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbhAPIcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 03:32:06 -0500
Received: by mail-wr1-f54.google.com with SMTP id y17so11501355wrr.10;
        Sat, 16 Jan 2021 00:31:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C1s6L4p8Sf8kJTcJb4k3ToX2/C1U5xuvZGOPjO3tRUE=;
        b=XmWUOtsar0MVb1IXYldefcS0vd6+MiOUlM/SiNVKXmKGnyejkw4P28rWxSSajef6yK
         dQ7fzonSEo2I28PlUSTG5j89tHlvsOTCE3ImH7+QDxxuhyqVVoV+ZyjN1PFJ+p1vkxWk
         3FKzvub0zrnG+ylGHOJbSyPbUzAAQcRniW/hFJmD0ERC/cAxpPovg8gVAaGni52TVWPW
         AZ4XtNZfHC2evJ5aF1DFeplQTShMIzuzHh3nnU+exADAP3Bi9fKv7gHuX0ibPu1a2S34
         VraSFpSMigDNQGeVBln3MP6q8cAY5tGmcQaM6DxkI6sJ+OSr6F7hgwJNk6dfNLcKqZSi
         EHlw==
X-Gm-Message-State: AOAM530i+rpbNHK0YU4E6QJ0Vav/y+fZBnMWvDSPum9VUTHniGezQHvD
        VNEWtL5kCNq+f7v3kW4WYwE=
X-Google-Smtp-Source: ABdhPJyLXhQ8B8JUo2DBZNeqvGOuQVhMqlQ6OsXwIEdvY6ALpZCs8VgevLL/fpcev/MW+3obP+l79Q==
X-Received: by 2002:adf:a1d5:: with SMTP id v21mr16904404wrv.24.1610785884600;
        Sat, 16 Jan 2021 00:31:24 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id f9sm19807482wrw.81.2021.01.16.00.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 00:31:23 -0800 (PST)
Date:   Sat, 16 Jan 2021 09:31:22 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/3] arm64: dts: imx: Add i.mx8mm nitrogen8mm basic
 dts support
Message-ID: <20210116083122.GA3704@kozik-lap>
References: <20210115210124.507282-1-adrien.grassein@gmail.com>
 <20210115210124.507282-3-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210115210124.507282-3-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 10:01:23PM +0100, Adrien Grassein wrote:
> Tested with a basic Build Root configuration booting from sdcard.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/Makefile        |   1 +
>  .../dts/freescale/imx8mm-nitrogen8mm_rev2.dts | 415 ++++++++++++++++++
>  2 files changed, 416 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-nitrogen8mm_rev2.dts

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
