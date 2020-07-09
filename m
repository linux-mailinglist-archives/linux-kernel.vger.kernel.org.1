Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FC321AAF8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 00:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgGIWxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 18:53:05 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36701 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgGIWxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 18:53:04 -0400
Received: by mail-io1-f66.google.com with SMTP id y2so4096437ioy.3;
        Thu, 09 Jul 2020 15:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CWctQ+oPsrh2CQ2K8/zJVYpMPZS2KFRjIV9n6HaYQyw=;
        b=ZsFRDwG3FvU40JGROwwspKtHXLSDR7I3NYWn6aa9k+g6LHk4oOn/fy1GDMhreDKYuy
         1jI7YF50J1A41bcB6eNvboYLdGLn2lXJ7VGq4ouBM1z8/qciQn4mmLsh8ETmGrUAZ7/v
         +j3la4XfYpb3WAxd/sYlIMjYTjnET/d3z99KTBIbYV3q2QU7ejJINFCxnXZ68cLbxSZ+
         Ywu1FKOYwACpuK4p8RGtprQ2Sh1gdXYHcO8Y+FOQdOVieJpAU16Wg2jIG4LWr1m89JjG
         7jMDpqsVwgWfX9YCo1ZTgOjmWSoaXocmRUGJmKLP0+S+D4RtjtfNsafpJBYo03KgrPqa
         gsgg==
X-Gm-Message-State: AOAM530sXCN0jmQIOIfz0xHCvDto2NNk3bzBYEeZbiUS+q3ek7JgJX2C
        K6dtj+PCfc4NBubPBdm9jw==
X-Google-Smtp-Source: ABdhPJwwvy7ujm3HQgU+9jDV+5qCjA1bMeOcMV3kTkahbrX+wcOiaHxY+SLssCL00Ow/rjiZmcyoLg==
X-Received: by 2002:a5d:8143:: with SMTP id f3mr28998541ioo.157.1594335183612;
        Thu, 09 Jul 2020 15:53:03 -0700 (PDT)
Received: from xps15 ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id l10sm2525017ilc.52.2020.07.09.15.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 15:53:03 -0700 (PDT)
Received: (nullmailer pid 1039988 invoked by uid 1000);
        Thu, 09 Jul 2020 22:53:02 -0000
Date:   Thu, 9 Jul 2020 16:53:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Suniel Mahesh <sunil@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-amarula <linux-amarula@amarulasolutions.com>,
        linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 2/4] dt-bindings: arm: rockchip: Add Rock Pi N8 binding
Message-ID: <20200709225302.GA1039958@bogus>
References: <20200709100756.42384-1-jagan@amarulasolutions.com>
 <20200709100756.42384-3-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709100756.42384-3-jagan@amarulasolutions.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Jul 2020 15:37:54 +0530, Jagan Teki wrote:
> Rock Pi N8 is a Rockchip RK3288 based SBC, which has
> - VMARC RK3288 SOM (as per SMARC standard) from Vamrs.
> - Compatible carrier board from Radxa.
> 
> VMARC RK3288 SOM need to mount on top of dalang carrier
> board for making Rock PI N8 SBC.
> 
> Add dt-bindings for it.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v5, v4, v3, v2:
> - none
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
