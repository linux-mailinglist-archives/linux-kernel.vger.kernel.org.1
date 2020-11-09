Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3A92AC0A2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 17:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgKIQQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 11:16:18 -0500
Received: from mail-oo1-f68.google.com ([209.85.161.68]:36839 "EHLO
        mail-oo1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgKIQQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 11:16:18 -0500
Received: by mail-oo1-f68.google.com with SMTP id l20so2330287oot.3;
        Mon, 09 Nov 2020 08:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JPZihzKzw8vKNYCHzOG6UMTv6XgWkVVNxGjsWo2eJAI=;
        b=Dbmh9zThRwvjv3V5dLYPJu2lKOWW7fyYvg0/oewVF+VjIWZqc4m357wkOxpCAafZ+0
         0roiCupRJYY5ZtVwKlFzqWPW3dCZ5Euf0ZfI8Z3xEiKSjVJrIEmx2cMIsIy7S/yJ3cOf
         w/5jJwXMjJg4O92tznpwjUAJh6TvNcMwlsEcoAOjb/KmUeQo1NbJIpPjIiyk/xxKoTMN
         j5qmrF/6q0uUSYu6f9+gMt4dy2c8aZEMDVKKsZhWodxwUwjHjEuwoqLYuoTljlsa9Sn4
         EIwKp7L3NNl1XprEOQTXlA/TEJkBXpqYyHaO2+ye+spcpEvU/ZEF1GC/WzyteXm6bFEH
         VlCw==
X-Gm-Message-State: AOAM532OR9mPm9KW+meVkFrSewThIqirn0Q0OhIZQO54gIODTbJEh8RN
        3ZwX1msJr8Uoxt+elXJxrQDkeLsyNg==
X-Google-Smtp-Source: ABdhPJwrCpUwA6ek5NHMV4DoV6/s3kHaBfagkm98NcQnASqVos91j6roKKdsU2nZ6ifywZm6AbJ0Rg==
X-Received: by 2002:a4a:c68d:: with SMTP id m13mr10456818ooq.64.1604938577405;
        Mon, 09 Nov 2020 08:16:17 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p40sm2460762ooi.23.2020.11.09.08.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 08:16:16 -0800 (PST)
Received: (nullmailer pid 1385763 invoked by uid 1000);
        Mon, 09 Nov 2020 16:16:15 -0000
Date:   Mon, 9 Nov 2020 10:16:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <contact@paulk.fr>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: irq: sun7i-nmi: Add binding
 documentation for the V3s NMI
Message-ID: <20201109161615.GA1385663@bogus>
References: <20201103205058.435207-1-contact@paulk.fr>
 <20201103205058.435207-2-contact@paulk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103205058.435207-2-contact@paulk.fr>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Nov 2020 21:50:53 +0100, Paul Kocialkowski wrote:
> Due to a register layout that's different from any other supported
> Allwinner SoC, the NMI interrupt controller takes a specific compatible
> for the V3s. Add it to the device-tree bindings documentation.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  .../interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
