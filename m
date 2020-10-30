Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B872A0D6B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727220AbgJ3Sar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:30:47 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36972 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgJ3Sar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:30:47 -0400
Received: by mail-oi1-f193.google.com with SMTP id f7so7615980oib.4;
        Fri, 30 Oct 2020 11:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QrmnJIsZek+6v0j51YfZGHsJ+9KRVg/TT4Jzj75T2uA=;
        b=ccSQxBT1YIXCEuEMhVL5U55w7OyBjNIedRPZWXngxYp2zWDI+m65YDm4M7TO9LMRH1
         naTFIyFzLra2ALXKFaSt52GLpmWbPkVhr/02c5bvTs6t8pOX4sukVA3C3Bod9pcOHYkw
         wGKY9BGQdMoB/tjsONLVGspTEum6YDqz7+YMRwwxNiwWCTOKD2NUyD+iATTt3u4UBjYP
         is7tXlt2JnCNjRB14nk/GOxqaqZdjcg7pubL26qmh4OrTEVxm01uHoc4Tl049FQd828h
         rZA9d5PHULln266L2KKifrDnARfdrjvRhHTvMLYRLx0zon895cyDBCSJojlIi/H0lmny
         2CGQ==
X-Gm-Message-State: AOAM532qaBIoLlvgpLTy2xk+cf9e6OyjE7vMpk2A8qGMRWg7ibGsZO8Q
        UjVg+R7526oXpOt/uObGJQ==
X-Google-Smtp-Source: ABdhPJyZwJ+Fonq1rApuq37boJzzXKMkdyr4H7SFDycPxA4yKjYT/6HrwVUk1PRhyUO6NNBjY6mjLw==
X-Received: by 2002:aca:e185:: with SMTP id y127mr2636104oig.57.1604082646098;
        Fri, 30 Oct 2020 11:30:46 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m10sm1556836oon.27.2020.10.30.11.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 11:30:45 -0700 (PDT)
Received: (nullmailer pid 4108748 invoked by uid 1000);
        Fri, 30 Oct 2020 18:30:44 -0000
Date:   Fri, 30 Oct 2020 13:30:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, marex@denx.de,
        devicetree@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>, abel.vesa@nxp.com,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [RFC 2/3] dt-bindings: reset: imx8mn: Add media blk_ctl reset IDs
Message-ID: <20201030183044.GA4108700@bogus>
References: <20201024162016.1003041-1-aford173@gmail.com>
 <20201024162016.1003041-3-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201024162016.1003041-3-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Oct 2020 11:20:14 -0500, Adam Ford wrote:
> These will be used by the imx8mn for blk_ctl driver.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  include/dt-bindings/reset/imx8mn-reset.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
