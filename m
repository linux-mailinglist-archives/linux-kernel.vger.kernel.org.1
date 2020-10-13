Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C152128D240
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 18:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgJMQ3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 12:29:44 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37777 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgJMQ3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:29:44 -0400
Received: by mail-ot1-f66.google.com with SMTP id m22so592614ots.4;
        Tue, 13 Oct 2020 09:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=laJM2L1uBgP77wn1bT8fgnfJFI4ffCUqcKE64d2ZO08=;
        b=oyfLYXWjyT4LJF0yYs9hvoFP2D6BQf79nj7yKT4GptYHjxeBE8glcHlRys9YZYft3W
         RFWkR3RVhGVfsanQ4371L/tzijbCz3v/RNkd+Pc6+kaXjW5jg5pqqmmManwQQoYFIgiR
         z0YB1+tZ7JS9tUiYFs/GQDJIczanTSYncmHXsVLzdO9o9ADW9TupEsKC1CJr1AUu4dRY
         +qMVoxSi3t9s2umOH88JR0Zohvdffh8vjmKuTA3kfq4Fo99QAM7yZ80MQkQJDteamhKS
         joAgDCL/VlibWwPAOAwAaN0OloZf2qV950lh+16HvVG89Qyiac4cJewTxLFVDjXzbLu+
         mabw==
X-Gm-Message-State: AOAM530X/p4+COgoSdyJL0+yNVgM6wEDNd0s6WIR7DS8YWCxQcdIslsq
        O7cPrLBHG7marE5NzbXqFw==
X-Google-Smtp-Source: ABdhPJw1umL41OogTc+lWeSyqNwmxOWTkeRQMui5cqhPyuDMcpaLF19yWloP4Chm5rTJ/+BlHDxnfA==
X-Received: by 2002:a05:6830:1aca:: with SMTP id r10mr331505otc.336.1602606582458;
        Tue, 13 Oct 2020 09:29:42 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b1sm62548otq.80.2020.10.13.09.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 09:29:41 -0700 (PDT)
Received: (nullmailer pid 3645074 invoked by uid 1000);
        Tue, 13 Oct 2020 16:29:41 -0000
Date:   Tue, 13 Oct 2020 11:29:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 1/3] dt-bindings: vendor-prefixes: Add an entry for
 Altus-Escon-Company
Message-ID: <20201013162941.GA3644145@bogus>
References: <20201012072452.14021-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012072452.14021-1-o.rempel@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 09:24:50AM +0200, Oleksij Rempel wrote:
> Add "alt" entry for Altus-Escon-Company BV: https://www.altus-escon.com/
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
