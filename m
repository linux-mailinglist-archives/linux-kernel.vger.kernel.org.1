Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41DFE293054
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 23:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732729AbgJSVP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 17:15:27 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36391 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732720AbgJSVP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 17:15:27 -0400
Received: by mail-oi1-f193.google.com with SMTP id u17so1635495oie.3;
        Mon, 19 Oct 2020 14:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NqvEnwvfWgKl8gNu89FqG5p98N1st79qPP50wL2V/0c=;
        b=qt9npN54iewYWHCCj8GQ1SO6PsJSMmi7BGTXYSCikC9sOmmM1HV1ku+QL+51rgkD3I
         riTxKCiXz9BMmdOdh983FpTvH7Mzt3c/Lq8XlyBKmSFS5sD4nZlgFdVDXRwCopxXlDwt
         DTjUUby3Oag8VDB60iLrogNbkjQ0SZGrGUkB3InO5VOupChOSh0Suf3aIUTVcYrJfAuI
         lNWxZsjIO4UmDZLCwkS3v6wSS+VRo87zj6wDr/RWi+9u+Q5P6Y3pyJytcRaRQHrivaZc
         Fb7QPHKFl7cMI0E4Dr7ev1W68nMxjbRZiHRXk+i7J+4cY6noG9SddusrhY5mkDlH6q8X
         GaZw==
X-Gm-Message-State: AOAM533GnccLp5o82U2I+TG6bGjZbsRGSFaoET/ylWr+roPjYfD9oyly
        dcTB6/GCtbdUIhheAo+hpw==
X-Google-Smtp-Source: ABdhPJwCBTMfLtPpM8hx5uxJyvWqvvc/P6dFMMAVCIeM+azZHLZbyaqXUodzheO2H2gAg1q86xgHUQ==
X-Received: by 2002:aca:5652:: with SMTP id k79mr995335oib.76.1603142126862;
        Mon, 19 Oct 2020 14:15:26 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j34sm232390otc.15.2020.10.19.14.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 14:15:26 -0700 (PDT)
Received: (nullmailer pid 3614465 invoked by uid 1000);
        Mon, 19 Oct 2020 21:15:25 -0000
Date:   Mon, 19 Oct 2020 16:15:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: fsl: add Van der Laan LANMCU
 board
Message-ID: <20201019211525.GA3614422@bogus>
References: <20201015090924.6185-1-o.rempel@pengutronix.de>
 <20201015090924.6185-3-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015090924.6185-3-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 11:09:23 +0200, Oleksij Rempel wrote:
> Add Van der Laan LANMCU iMX6dl based board
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
