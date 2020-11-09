Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50FA82AC7F0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 23:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbgKIWCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 17:02:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46286 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729879AbgKIWCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 17:02:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id g19so10506548otp.13;
        Mon, 09 Nov 2020 14:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1uw5eiYN1bcJjDkOz81gPdSuUo6d58pyaw13AcTAGIs=;
        b=eXRYVRRSQjJKRUFi5Sw6YIq5CZ2cs3ygGSL/0LPRSuLak31gT0epfzvRInP17tkf5t
         JSIeVcUvgCW5vx/fdldWayzVVpHZ1HTuO4iA51rVAxdDS3QnOCmqWKdqZTCKcsSEh9EX
         dCO9C0FWRirrdCLYQoOyzSJ0zGPXuOiJ8XRgiHHgQTaKfBeK4b/AnxSYNov2Sv86M6kJ
         EMdQW9xPzUGcVCi5S3XgVT0ilHkBMOMrtTzYLnl/O1Yj4szlHfaVaD3e9S82QNSbGCQ+
         T9sL09xXMgQ3buPg2jMdxcEMayMgMgDPKUi7AEgvO9yltpKVDWVmV54kw0qQtsngS5Eb
         ABfA==
X-Gm-Message-State: AOAM5338bZy1O6sLp/pIlS7rDmG5DFLPB3CXe8zmDOjuFo8VJXnEozN/
        ohcagu7nZyuX+Lji/kpQBw==
X-Google-Smtp-Source: ABdhPJxJDojkF1yROsgz4U87cGrmgqYRufSbqvtAautF8TMccNQbynJfBqMd+rODRTLtUhZEoldxAw==
X-Received: by 2002:a9d:4f15:: with SMTP id d21mr11849337otl.166.1604959330465;
        Mon, 09 Nov 2020 14:02:10 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d62sm716318oia.6.2020.11.09.14.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 14:02:09 -0800 (PST)
Received: (nullmailer pid 1833916 invoked by uid 1000);
        Mon, 09 Nov 2020 22:02:08 -0000
Date:   Mon, 9 Nov 2020 16:02:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: arm: sunxi: add PineTab developer
 sample DT binding
Message-ID: <20201109220208.GA1833886@bogus>
References: <20201107124958.2222253-1-icenowy@aosc.io>
 <20201107125233.2222754-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107125233.2222754-1-icenowy@aosc.io>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 07 Nov 2020 20:52:33 +0800, Icenowy Zheng wrote:
> Some developer samples of PineTab are distributed with the old and
> incompatible LCD panel.
> 
> Add a device tree binding for this version of PineTab.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
