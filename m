Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4A02C937F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbgLAAAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:00:08 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:32910 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbgLAAAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:00:08 -0500
Received: by mail-io1-f68.google.com with SMTP id o8so13770825ioh.0;
        Mon, 30 Nov 2020 15:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WJNfzOEQ8T3wBcehY2qskJURbqiKx8Orw4J4b+GZdEs=;
        b=Em2cHNPBqtvExY2B30ISph8MfX4pz08b6RAlGBgi5HZZ9W3nsQ1Qc3aBfGBb3BMckd
         GbG2NvXm41gZWM9rQGtfB19hoj4o1jhhetrVYLKQsTBK+QtFmkTOOhytujiYTEBS0F/2
         JmCjUgpZP/b0BmpY56+UR9PXEV6/jXmUGsQkLsMDGzkpeYK5LsxSV2llXIS7+67A0nch
         U07RNOplsMEl0GMJRl27iQCBfb3WUB4fGhTDSWBH0Gru45Hxh88FOeNwO1/HBoEUPOah
         pI7XKJM5qgvSvmt7azXoEOflKrkMUwAjRt7uWehq/cDpwdmhlwqcMWFGgI3fQTxtEueT
         US9A==
X-Gm-Message-State: AOAM533SCaJg11s/kTVbThUy2ybBIlAV2q+c2jj3NWNDghlGROjW0d7N
        XRhIogNoGNJ96WA+co0iFC+ebCVKGA==
X-Google-Smtp-Source: ABdhPJxHzse2ZFTU+MMgHHw1Xnxr8/g5ZxhJGkgtg4IL3knVu26Eoog2SRsD93KCDYS3O3mGtnA7vw==
X-Received: by 2002:a02:b011:: with SMTP id p17mr259153jah.55.1606780767542;
        Mon, 30 Nov 2020 15:59:27 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m12sm84067ilq.51.2020.11.30.15.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 15:59:26 -0800 (PST)
Received: (nullmailer pid 3292959 invoked by uid 1000);
        Mon, 30 Nov 2020 23:59:25 -0000
Date:   Mon, 30 Nov 2020 16:59:25 -0700
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        David Jander <david@protonic.nl>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: vendor-prefixes: add "virtual" prefix
Message-ID: <20201130235925.GA3292882@robh.at.kernel.org>
References: <20201117131354.30943-1-o.rempel@pengutronix.de>
 <20201117131354.30943-2-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117131354.30943-2-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 14:13:52 +0100, Oleksij Rempel wrote:
> "virtual" is used for vendor-less "devices". For example for the GPIO
> based MDIO bus "virtual,mdio-gpio".
> 
> This patch is needed to fix the checkpatch warning for the Protonic WD3 board.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
