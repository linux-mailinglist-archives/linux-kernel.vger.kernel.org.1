Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B9027627D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 22:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgIWUun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 16:50:43 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38147 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgIWUun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:50:43 -0400
Received: by mail-il1-f194.google.com with SMTP id z5so334924ilq.5;
        Wed, 23 Sep 2020 13:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G0mfo5tAsK946i3cKX7Oa0WYTXIIps9VuydzHNtJNeE=;
        b=SQ6FbeNru/YXYi3qh2wTgdtMi2ZiPPyhPeQARVEdjLqyi/+z/uVOXlvfIB+aYFw0H8
         GXaZC0Q1loKAkCuUJH9PFEQKJxXYMCBvUibuAGNLb4djbnKqAEi8imwnvdTGem8olmcU
         BZJXGQzfJuuTxmZJqbgfVP2RtA7p/3kU73ubSN6yUUrzHOr1SbGILDHLnNN615fPvGxV
         sgbpX62sbMSbn0bDrSUy+cvKnPmOBT6gVaZw3vQnnBpd4xhs9c46p2kTv86Hy5XENKqX
         3eE8VMaPKdg0vm4VvFSlaknLeyQPz+IQSYZ/yRZabyhsO1tfuRfB0ZRLdu9T4p4TXCsX
         pI7w==
X-Gm-Message-State: AOAM530KxpwqvRhhcGJGRggeaXItsZ1a5IYRiC2yg3Kbi3vYh90FvfzS
        Vc6Rq1ds0z61wxfz69gXAA==
X-Google-Smtp-Source: ABdhPJxA36vD5MpX3Ld8qYNLa+JEK1g4BidN/snqos4zxgZsSv0ZSFVJQlByj3ZYhmHmyn9xiBLXqQ==
X-Received: by 2002:a92:cc87:: with SMTP id x7mr1371284ilo.304.1600894242324;
        Wed, 23 Sep 2020 13:50:42 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q9sm381524ild.4.2020.09.23.13.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:50:41 -0700 (PDT)
Received: (nullmailer pid 1284002 invoked by uid 1000);
        Wed, 23 Sep 2020 20:50:40 -0000
Date:   Wed, 23 Sep 2020 14:50:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH 01/13] dt-bindings: arm: fsl: update TQ-Systems SoMs and
 boards based on i.MX7
Message-ID: <20200923205040.GA1283946@bogus>
References: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918112942.1367-1-matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Sep 2020 13:29:30 +0200, Matthias Schiffer wrote:
> Introduce compatible strings for the TQMa7x SoMs.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
