Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893EF2B4BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbgKPRAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:00:10 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38958 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730840AbgKPRAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:00:10 -0500
Received: by mail-ot1-f68.google.com with SMTP id z16so16673838otq.6;
        Mon, 16 Nov 2020 09:00:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AcLujU/XcYert0gEatW7givS6gqW+TvLh+BjzpfDdRM=;
        b=ekKRPLaQ1qE20FYBeS3I3RKmdBNTg+nMqkGXXPsGuVgCkC/QLzSQRXFd12ZLYLeCKR
         Do0pVT32hZNZg38x5U86FdvR28vWB1hd2vn/BTJesAnX58BHPVnAXfRYhWztpzhqLmou
         zxs+FzDcab+SPZpMa0amQn7H1XBnwprqwxvb3oEzWQrYxQKiSJPUarODJPI01ZoHQ88w
         0giyRkunf3IUEIzcv0hi3ZaDjh24wmHjK7/KBH/thuNy47tSMchXVQ/WLjN2PXFHpPnO
         mIUO4nce6E/UwiGycv2MMuT2maqnSqQHqXSOZIFqFj/16DOIvRYolR6w1Ejztjak9p79
         RpXg==
X-Gm-Message-State: AOAM531rklBQs0YzkBs2Kkq73RK9cZJAmdfoTSA6eUnFH2l5G4UF3ogp
        6ZIse+76g2ZaNF51ajB0oQ==
X-Google-Smtp-Source: ABdhPJz6z1MX9d1u+yLFna+XLipBPR70Synp9H9LXc/tFdSxPMb7qBzLEPdr3cLM7jo+cGj4l2YgQQ==
X-Received: by 2002:a05:6830:12c2:: with SMTP id a2mr177047otq.162.1605546008236;
        Mon, 16 Nov 2020 09:00:08 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i27sm849915otf.25.2020.11.16.09.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:00:07 -0800 (PST)
Received: (nullmailer pid 1805750 invoked by uid 1000);
        Mon, 16 Nov 2020 17:00:06 -0000
Date:   Mon, 16 Nov 2020 11:00:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Neeraj Dantu <neeraj.dantu@octavosystems.com>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: document Octavo
 Systems oct prefix
Message-ID: <20201116170006.GA1805656@bogus>
References: <20201110102552.7270-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110102552.7270-1-a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 11:25:49 +0100, Ahmad Fatoum wrote:
> Octavo Systems is an American company specializing in design and
> manufacturing of System-in-Package devices.
> 
> The prefix is already in use for the Octavo Systems OSD3358-SM-RED
> device tree, but was so far undocumented. Fix this.
> 
> Cc: Neeraj Dantu <neeraj.dantu@octavosystems.com>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> v1 -> v2:
>   - new patch, suggested by Rob
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
