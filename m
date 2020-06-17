Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5D71FD917
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 00:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgFQWla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 18:41:30 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:32991 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbgFQWla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:41:30 -0400
Received: by mail-il1-f194.google.com with SMTP id z2so3962971ilq.0;
        Wed, 17 Jun 2020 15:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ell7jiNP2ad4ewc9/m5zo9VzyaHvMd9lvaN9Obmnl0g=;
        b=mN3Een/K33d+grsl7oh+Cn32kUb9M5BMOovPLoVU1DyZqaFD7x6tuMnOQihQVqgORU
         ZxMj6vNkq3cWBDEuY/ooBllTlBVVwSPPFqW3D+8Y48FL73gr2yuPRu+eCpZkuOWC9d4j
         RN1XRf0p3GWIxyu2xlObcunCqXXBDaAeXhs3BbBbMoIjfn7JEzfYiG/WDDr8Atulx0di
         m1jp+QwfKXVqQNCyCxsTGBQd3tSMhGcryIr8QvZrOJMosEmhD04Mpl2YrCwD3MIJn9sa
         yjsBjmqQLcFEtJ3mbPs1rp9DPD4wCPBZ9LqI9iqE6uRr6HEQ8Gzu7/uBlv8pCvOyBcG2
         yAPQ==
X-Gm-Message-State: AOAM532TEc7uu1a0Y7mLe8L//81h0ehhI2+kmbOdfroTdG5w2dq58yqj
        pEReDmXu5q8RUdUYJhfVag==
X-Google-Smtp-Source: ABdhPJw0hCI5p++1/CP8eVsgrsWGIaVi/lbypn4bUR7hGreLuUwIR7E32EZlueXTudx7WsXVWKCeSQ==
X-Received: by 2002:a92:1b86:: with SMTP id f6mr1287269ill.9.1592433688369;
        Wed, 17 Jun 2020 15:41:28 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k18sm634053ioj.54.2020.06.17.15.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:41:27 -0700 (PDT)
Received: (nullmailer pid 2971783 invoked by uid 1000);
        Wed, 17 Jun 2020 22:41:26 -0000
Date:   Wed, 17 Jun 2020 16:41:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/4] dt-bindings: display: simple: add CDTech
 S070PWS19HP-FC21 and S070SWV29HG-DC44
Message-ID: <20200617224126.GA2971729@bogus>
References: <20200612072219.13669-1-matthias.schiffer@ew.tq-group.com>
 <20200612072219.13669-2-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612072219.13669-2-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020 09:22:16 +0200, Matthias Schiffer wrote:
> Add the CDTech Electronics displays S070PWS19HP-FC21 (7.0" WSVGA) and
> S070SWV29HG-DC44 (7.0" WVGA) to the panel-simple compatible list.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> v2: no changes
> 
>  .../devicetree/bindings/display/panel/panel-simple.yaml       | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
