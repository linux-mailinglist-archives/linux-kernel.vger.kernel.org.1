Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A45081A495C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 19:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDJRjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 13:39:31 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40213 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgDJRjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 13:39:31 -0400
Received: by mail-ot1-f68.google.com with SMTP id q2so2496432otk.7;
        Fri, 10 Apr 2020 10:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PrxNLugD3AgqUIYRVagUZqMyr4O+BINFn4HTbSjFd9A=;
        b=aAocXhIWp4bMzfTPWMIa60YTf3Am/23hMUSGUOanPWg+8ummbVi3LBWZKzQvWEe2KP
         EWUbMiO0YrKtRp7Gl8LZwZ/hL25Eipr/0I1IXqf7QwfipqH+KsnVRLmF5m4DR1WpybTp
         lTqXN7ZzmKsXcKDtcgbcql2PlBA2foKmvAp3H6azlJaUTEAD3PoXJ3CWcNLIRwKn6SxQ
         88rQJC4G55i+eb6FlHRnXLTSylWvCN/SDUV8E3x4CNp5RR7KzZ3kzAso/iFmJy6ZIsFO
         1KRCVUTNoRP8OPbnDbUmY3si48U7EZ68/NlM7fBsuc1Vxqhqdb6rpdVQHhNJoHd6GXXU
         BbOA==
X-Gm-Message-State: AGi0PuaLX9vRS5ihtfQgwd9owOZ6goU5cz7X6Wi2LjqU59NnkwCV7gI7
        EbZGztQ5yAYh1el1mHxyUg==
X-Google-Smtp-Source: APiQypJF0eQ8X+7TC7Fkb4legMcTFdHBhmQgkuNTyMXpSh0rMHGvjq0EqP+unhp8RP3f+8RHjMsb6A==
X-Received: by 2002:a05:6830:1350:: with SMTP id r16mr3255212otq.140.1586540370592;
        Fri, 10 Apr 2020 10:39:30 -0700 (PDT)
Received: from rob-hp-laptop (ip-99-203-29-27.pools.spcsdns.net. [99.203.29.27])
        by smtp.gmail.com with ESMTPSA id a5sm1676295oot.5.2020.04.10.10.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 10:39:30 -0700 (PDT)
Received: (nullmailer pid 24513 invoked by uid 1000);
        Fri, 10 Apr 2020 17:23:00 -0000
Date:   Fri, 10 Apr 2020 12:23:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v4 5/5] ARM: dts: add Protonic RVT board
Message-ID: <20200410172300.GA24406@bogus>
References: <20200330120640.9810-1-o.rempel@pengutronix.de>
 <20200330120640.9810-6-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330120640.9810-6-o.rempel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Mar 2020 14:06:40 +0200, Oleksij Rempel wrote:
> Protonic RVT is an internal development platform for a wireless ISObus
> Virtual Terminal based on COTS tablets, and the predecessor of the WD2
> platform.
> 
> Signed-off-by: David Jander <david@protonic.nl>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          |   1 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/imx6dl-prtrvt.dts           | 203 ++++++++++++++++++
>  3 files changed, 205 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-prtrvt.dts
> 

Reviewed-by: Rob Herring <robh@kernel.org>
