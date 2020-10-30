Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FE72A09FB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgJ3PgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:36:15 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35246 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgJ3PgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:36:14 -0400
Received: by mail-ot1-f67.google.com with SMTP id n11so5917842ota.2;
        Fri, 30 Oct 2020 08:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=92s747J6IRpxpYVQZqLdFOF8fVJSb/XdZJ87JQunE3Y=;
        b=Ke1i9Yl2Y2poTo7i7rOCQIxK6pLMpIEHI6OP+snBzAGG6rST4GvDpduU3j2AnGFKsf
         fkWHkXApSYHGBfxKPqEZE6FeRMT2I4rHlIyGtK6gBYm239Ij2+SBwND+e4txJ2q8LlcF
         GX+CqYJ+tPjCtyvwBDVy9xifUFm9RuFC5tUG6IZMi8R38f3JDNpxn794IJtU8e+xudaG
         k6YIcdvnWcbn69zLrq6GIoVLKV0b0TsuFbd4dtcxGGqHbIGcwjjSQYF/4cbYI+C8etNl
         boL7468FIglz1WLr7vS9Ex+Vvw2AwEof82XOICOM5YXziRUgSA6OrpWdVYb6lAmt3D1X
         1+dg==
X-Gm-Message-State: AOAM532i48Y2dt9OgwXigLVI+BYnDs7D/9LAOVJxB4q5x0KVG9jkYUkZ
        DLO0Kb0Md5llUTdBmQoP9Q==
X-Google-Smtp-Source: ABdhPJyc8p0oDrpJMsSgBPJAyXyhhIaLF5f6V4OFEmTWxJA5BbAttyEcXzmt2zTc8NmAj7NiL/200Q==
X-Received: by 2002:a05:6830:22eb:: with SMTP id t11mr2118729otc.114.1604072170772;
        Fri, 30 Oct 2020 08:36:10 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z22sm1475805ooe.21.2020.10.30.08.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 08:36:10 -0700 (PDT)
Received: (nullmailer pid 3887428 invoked by uid 1000);
        Fri, 30 Oct 2020 15:36:09 -0000
Date:   Fri, 30 Oct 2020 10:36:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, marex@denx.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, aford@beaconembedded.com,
        l.stach@pengutronix.de
Subject: Re: [PATCH 1/4] dt-bindings: add defines for i.MX8MN power domains
Message-ID: <20201030153609.GA3887398@bogus>
References: <20201022150808.763082-1-aford173@gmail.com>
 <20201022150808.763082-2-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022150808.763082-2-aford173@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 10:08:04 -0500, Adam Ford wrote:
> The i.MX8M Nano has a similar power domain controller to that of the
> mini, but it isn't fully compatible, so it needs a separate binding
> and power domain tables.
> 
> Add the bindings and tables.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> 

Acked-by: Rob Herring <robh@kernel.org>
