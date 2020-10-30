Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628FF2A0DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbgJ3Sm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:42:29 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:35903 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgJ3Sm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:42:28 -0400
Received: by mail-oo1-f67.google.com with SMTP id j6so1824592oot.3;
        Fri, 30 Oct 2020 11:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hVpzN2Y06wbPSBaS0y+ngz3c1r0CShTKe8sn3RB15os=;
        b=Ux5poqlq+MQUTTC4Zb1pZazoj3rOgbDbLKgLc9SHxR02uXp0yDQ/uFzlfmOOCJeVMB
         4gN7stfm6CLgtJ7HvK2jS8NsC9qYK/2Grsly8WAwG6xlzFePhIDDEtsvS2Y8h0SqEVIE
         +KOMdPhTCwJmUQGK+SmTCdxetNw/e4fGpVLYtmknpDmM9OXbAFWjEoc9plSnnRh6xvn1
         HBZRDqP6TuUdMeD3sI/rf3ScWO/1IHlkmt24xvQ/TDPh1cXvPla3VxfJfyYy0UwmFZxj
         CDY1CQVUazDY3Gg4IBnX1F29vbAK3yThf91F6xqQLXVe1Q+oaHSeGUiwY7+Dw0skomgs
         whvQ==
X-Gm-Message-State: AOAM532buPwpe3J4hmAl0KnxNJdxKxBAYxU+jKV0SZqCk8JEAiIXpLsG
        x4eC3813djMA3QrR/gF8pw==
X-Google-Smtp-Source: ABdhPJwuElRorIJ/ryeLFKrkeSnYyHD6uSpDInFB4YcyWH/0aW7YRFBBUvhD92ko8NoOXRBrDuarGQ==
X-Received: by 2002:a4a:8e02:: with SMTP id q2mr2989133ook.60.1604083347817;
        Fri, 30 Oct 2020 11:42:27 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j3sm1590729oij.9.2020.10.30.11.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 11:42:26 -0700 (PDT)
Received: (nullmailer pid 4125177 invoked by uid 1000);
        Fri, 30 Oct 2020 18:42:25 -0000
Date:   Fri, 30 Oct 2020 13:42:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bogdan Togorean <bogdan.togorean@analog.com>
Cc:     Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>, sam@ravnborg.org,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH v2 2/2] drm: dt-bindings: adi: axi-hdmi-tx: Add DT
 bindings for axi-hdmi-tx
Message-ID: <20201030184225.GA4125095@bogus>
References: <20201026064122.2831-1-bogdan.togorean@analog.com>
 <20201026064122.2831-2-bogdan.togorean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026064122.2831-2-bogdan.togorean@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 08:41:06 +0200, Bogdan Togorean wrote:
> Add YAML device tree bindings for Analog Devices Inc. AXI HDMI TX
> IP core DRM driver.
> 
> Signed-off-by: Bogdan Togorean <bogdan.togorean@analog.com>
> ---
>  .../bindings/display/adi/adi,axi-hdmi-tx.yaml | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/adi/adi,axi-hdmi-tx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
