Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C432C919E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388753AbgK3WxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:53:00 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34739 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388678AbgK3WxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:53:00 -0500
Received: by mail-io1-f66.google.com with SMTP id d7so4745978iok.1;
        Mon, 30 Nov 2020 14:52:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wWycfNfrJ5ZK6TZY8fbaI347ZRv8m3YTXMAovYgi++c=;
        b=ez9RQ7PgmCU9/D1Kfh03ibDErL2NXXFsZD5xowMYjF1UyhnUnRJJVfZ7/A3dHa0kAY
         938/wpKwVpWZoemyC1finzWzuG815JkHKpyqLFldzkyHSNse+GmTXlzuWSv9Kb8PO14Y
         x3/nl3lJqXVSPjyjeqkyLAGY6FydXvxFTppW6reBQzk144WZ8grcjOp5D2fQr8doXu/V
         W+C2pmokAiqE841aGYqb6ylWeHQdkDCdZ1LeXHvnYfPSKHBMUjtjgC4SOCyh4E4O1Zmb
         lPcDcbg2WTtopJjFqqwRcCbhCopyRtlSh/GxH14+DSaR4U2gb/MY0gOlHqojpyOEr4GX
         0rHg==
X-Gm-Message-State: AOAM530qh1HDTUKpAvBgO1l88yzJev3+jSC6os5jeuE8rRH+ahz9vp+s
        9KwMYMv9nRTCl9JA7famBA==
X-Google-Smtp-Source: ABdhPJyQ1ZXqiV4yaJOC93Dr0wDJ5SFdMvFloAIEDZChWTL3f24lm2l3O11BGfrAT5ZegOdzKjQzGQ==
X-Received: by 2002:a05:6638:c4c:: with SMTP id g12mr57222jal.82.1606776739239;
        Mon, 30 Nov 2020 14:52:19 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id d7sm1248765iod.45.2020.11.30.14.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 14:52:18 -0800 (PST)
Received: (nullmailer pid 3187439 invoked by uid 1000);
        Mon, 30 Nov 2020 22:52:16 -0000
Date:   Mon, 30 Nov 2020 15:52:16 -0700
From:   Rob Herring <robh@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen.Hegelund@microchip.com, Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v5 1/6] dt-bindings: interrupt-controller: convert icpu
 intr bindings to json-schema
Message-ID: <20201130225216.GA3187386@robh.at.kernel.org>
References: <20201125103206.136498-1-gregory.clement@bootlin.com>
 <20201125103206.136498-2-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125103206.136498-2-gregory.clement@bootlin.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 11:32:01 +0100, Gregory CLEMENT wrote:
> Convert device tree bindings for Microsemi Ocelot SoC ICPU Interrupt
> Controller to YAML format
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  .../mscc,ocelot-icpu-intr.txt                 | 21 -------
>  .../mscc,ocelot-icpu-intr.yaml                | 60 +++++++++++++++++++
>  2 files changed, 60 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
