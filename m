Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9665627D6B7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgI2TSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:18:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37887 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI2TSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:18:38 -0400
Received: by mail-ot1-f66.google.com with SMTP id o8so5599424otl.4;
        Tue, 29 Sep 2020 12:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=40hh8IQfWNRqHPCW5sa6gIpUFNpap78I4kipBZ1tykA=;
        b=HFxH8HKKZ3wluULAjl0TUP+OrDwzVh0xw0AtIYt5cd6Lv+hR5ZMdu9L0MXy+EpGbf1
         7WEO10KXrgviyvkBdM3O75YMFFIlOpn0cbxRMiP5l5U4MKxIsMlOt2kmliUMrn/U9rHo
         SzT3DYo7DRQBsWLIE0ZUbXmt9Xa/bX6Q427l8l8QCZkBNsk49MBeQAkDC9m5+m+ihlDL
         VfbRimtzfp9ihve4sNcfaDVT9mmA+xZgGRxaRPgvRZW+YAjTVg+x62W8TRMRvp/sgOZ2
         KiHuWL0xfIDdXflHcx6DD2EvboUz5RHe0RB4hnsP7zKyb52HKQjN8vj429XjrqlSQDNc
         fCBw==
X-Gm-Message-State: AOAM532YsGqA4Av4cfs4Lg4Xv8RIKattL/8Wj+fnUEVIksmGeX1nJw47
        3n2fPRaj0P9wqIADff8e2w==
X-Google-Smtp-Source: ABdhPJwlV7uK1dgR+6SZOi39pk7d4hc1FXLPr2jkbumfVgkMzMmHJGB0pU45obgHQO+nBeEqQpHLRQ==
X-Received: by 2002:a05:6830:1f09:: with SMTP id u9mr3529289otg.175.1601407117928;
        Tue, 29 Sep 2020 12:18:37 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k10sm1210057ots.60.2020.09.29.12.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 12:18:37 -0700 (PDT)
Received: (nullmailer pid 998175 invoked by uid 1000);
        Tue, 29 Sep 2020 19:18:36 -0000
Date:   Tue, 29 Sep 2020 14:18:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Stefan Riedmueller <s.riedmueller@phytec.de>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Robert Jones <rjones@gateworks.com>,
        linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 09/14] dt-bindings: arm: fsl: document VF boards
Message-ID: <20200929191836.GA998117@bogus>
References: <20200926162811.5335-1-krzk@kernel.org>
 <20200926162811.5335-9-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200926162811.5335-9-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Sep 2020 18:28:06 +0200, Krzysztof Kozlowski wrote:
> Document and adjust the compatibles for VF500 and VF600 based boards.
> The Toradex Colibri Evaluation Boards use multiple compatibles.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../devicetree/bindings/arm/fsl.yaml          | 24 +++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
