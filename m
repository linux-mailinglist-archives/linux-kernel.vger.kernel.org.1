Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191A52F42FB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 05:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbhAMEQy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Jan 2021 23:16:54 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:36011 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbhAMEQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 23:16:54 -0500
Received: by mail-ed1-f54.google.com with SMTP id b2so445509edm.3;
        Tue, 12 Jan 2021 20:16:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aZQU5TTp8WmB5JcdthK5Ea6GRsreOA1AnbF1mdWFvaY=;
        b=aBse3I+4U2FSTLIrPBw4djiYOYjqvkd12k7bpjS7VUszUg3oGler6x3yl24nUofLht
         QYmKgX1cyzXngfLFqMUR51g3M6xOJFcgwNWcTXrCO+BaSWPqSMoSrLLnspkTS7I6+IN6
         AErR7JegBEqEdHgziTvsKnlO4s7+BGijBgak+EwlQX4GPFCn8kiQsa+x3p3Bc2JeDokV
         btqXArf7gm8/nk7llh4l5c+yAPJaSL/YkUoqAsKZz0qHJI3Mp+eJHTNVNJ+kDq1rVwMQ
         VJS4jS/j03gvAooVugdnuFx0rWcA1QGnbOkbli7lDqZllTY4e4tuwigWKm61NmyE1TCB
         8C8Q==
X-Gm-Message-State: AOAM531PnNwVrPLoNuSM/iO7ticx0LfQtpkbdSfVTRkp8S5m8QB24bif
        iw0DjX5oJ84QUkmFKI+JU2JdPC485vc=
X-Google-Smtp-Source: ABdhPJyF2tN+lhjlmlMAFGu5UdSf28cdAJuWzyGKTbaL4NGbvdOsy2YaaZ5PokUGEvXGrjqfCy/ZCg==
X-Received: by 2002:a05:6402:17cb:: with SMTP id s11mr236559edy.119.1610511371857;
        Tue, 12 Jan 2021 20:16:11 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id n16sm266798edq.62.2021.01.12.20.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 20:16:11 -0800 (PST)
Date:   Wed, 13 Jan 2021 05:16:07 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com, catalin.marinas@arm.com,
        will@kernel.org, kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Subject: Re: [PATCH 2/9] arm64: dts: imx8mq-librem5: Mark charger IRQ as
 High-Z
Message-ID: <20210113041607.GC5974@kozik-lap>
References: <20210112095151.4995-1-martin.kepplinger@puri.sm>
 <20210112095151.4995-3-martin.kepplinger@puri.sm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20210112095151.4995-3-martin.kepplinger@puri.sm>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:51:44AM +0100, Martin Kepplinger wrote:
> From: Guido Günther <agx@sigxcpu.org>
> 
> This is consistent with other IRQs and makes keeps currents low.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>
> Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
> ---
>  arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
