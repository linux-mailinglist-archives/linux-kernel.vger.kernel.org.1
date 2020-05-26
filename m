Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18EAD1A495F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 19:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgDJRjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 13:39:39 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43674 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgDJRjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:39:39 -0400
Received: by mail-ot1-f68.google.com with SMTP id n25so2488590otr.10;
        Fri, 10 Apr 2020 10:39:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iytVfgrKM9/nBa/maJNGlLOjbsAwjoRTVoNFMNUMDVM=;
        b=lKYbnuXA716G2BJWIjVdtuNhALrnHBzERj5dzJzyk6dKcBqq2RHXbB4gULzOHrrjdM
         aZeYjtkj1u2p2PgaPu8zhl+zLrUYCm6S6UOoiHlrQq/qT0ygL6bqT4eWMOyT9SGN2jyd
         3Qh7y4tKHbhzddyE0wh6WMdz5hUwees4BTbPJ4HqwfGUn1ZQkU2KitBr6jqYZTyWNVaZ
         NARqtt3DSoypH8udTOWuYxzVwaPnXi9gJraMg24/zi06Psww1rj3Bpmdlk2ayZVkInjr
         pvsojuJ083h0+SvrTIoowQSf8wPuOXDUtsBtkKksTBVP4Ew7JuLZaYlvlokXv3kFJKut
         5LcA==
X-Gm-Message-State: AGi0PuZxd2Ab7TW4J71RyHb6hg4vlYRIrPTXSVZ17nS1eGPyHZsHehNF
        7/qCbpCI8RQkmjuIGNHoEg==
X-Google-Smtp-Source: APiQypISahzf9z2+5Zt04Heg9ZRvhicW3W2d/thr/l2XJEvMjtsPw6j4ZOj1va2kcWot9pJKA/cSUg==
X-Received: by 2002:a9d:1c8e:: with SMTP id l14mr3657588ota.0.1586540378532;
        Fri, 10 Apr 2020 10:39:38 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.cgn.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id h65sm1494451oth.34.2020.04.10.10.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:39:38 -0700 (PDT)
Received: (nullmailer pid 22016 invoked by uid 1000);
        Fri, 10 Apr 2020 17:21:15 -0000
Date:   Fri, 10 Apr 2020 12:21:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Robin van der Gracht <robin@protonic.nl>,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v4 4/5] ARM: dts: add Protonic VT7 board
Message-ID: <20200410172115.GA21938@bogus>
References: <20200330120640.9810-1-o.rempel@pengutronix.de>
 <20200330120640.9810-5-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330120640.9810-5-o.rempel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 14:06:39 +0200, Oleksij Rempel wrote:
> The Protonic VT7 is a mid-class ISObus Virtual Terminal with a 7 inch
> touchscreen display.
> 
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          |   1 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/imx6dl-prtvt7.dts           | 473 ++++++++++++++++++
>  3 files changed, 475 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-prtvt7.dts
> 

Reviewed-by: Rob Herring <robh@kernel.org>
