Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095A71C6092
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 21:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgEETAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 15:00:33 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38264 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbgEETAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 15:00:33 -0400
Received: by mail-oi1-f196.google.com with SMTP id r66so2957658oie.5;
        Tue, 05 May 2020 12:00:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bmNwg7qP1SBbdLMpqATS0EkQNQ8ln6bORoA+Yp7YlU8=;
        b=E1Uo0dDu+Gvp0j+smUIN/8APv3RgAO49fI+Uz/hsxaKFd+zDYrZSQAhfWMv22y4woX
         cG/A/BC126M0uPAvXSAFs+Z6OmDZDP1m+d9HpvGZuXi3qBr6FmMNQ8ee/FSEk1DUpMCO
         L3RVMrsvdv1zOQ2WyO8dkGkBGBBc+uA4J143Fl0nS3GmJB9H4t8ceXwZfBky6hplvNHR
         shrv2FNKSjQuNxXACZxyiAc/1tXjvcN11WbKxFkECWkJyXrSKHwqIlZ2XvVSWsz20Wr+
         h/eIfEXWOoPu++EPYdanL06WuWWRkos+OjE+ZaWawV0MYPD9iQBiobXryiXZ1I/rGrZA
         1p3Q==
X-Gm-Message-State: AGi0PuazHHdgc+TIwe+2fj++KEtYwHaH2RYZR15jMLAJZZ6ShNT/d+uK
        f/jS/+hvJb8oUEOHPoXRAA==
X-Google-Smtp-Source: APiQypJereL2KKpxqNv0a1yG++pdI5i7lA8WFCr9HMbUx7pmg6sJEAPn+1moF9GzYhbzW3m0NFF0WQ==
X-Received: by 2002:aca:f11:: with SMTP id 17mr49265oip.27.1588705232581;
        Tue, 05 May 2020 12:00:32 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q28sm763134oof.42.2020.05.05.12.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 12:00:31 -0700 (PDT)
Received: (nullmailer pid 7289 invoked by uid 1000);
        Tue, 05 May 2020 19:00:31 -0000
Date:   Tue, 5 May 2020 14:00:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 5/5] dt-bindings: arm: fsl: add different Protonic
 boards
Message-ID: <20200505190030.GA7194@bogus>
References: <20200421124057.19238-1-o.rempel@pengutronix.de>
 <20200421124057.19238-6-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421124057.19238-6-o.rempel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 14:40:57 +0200, Oleksij Rempel wrote:
> Add Protonic PRTI6Q, WD2, RVT, VT7 boards.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
