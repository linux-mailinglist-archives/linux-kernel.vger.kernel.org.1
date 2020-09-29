Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C8C27D460
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgI2RYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:24:18 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:39047 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbgI2RYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:24:18 -0400
Received: by mail-oo1-f67.google.com with SMTP id c4so1483569oou.6;
        Tue, 29 Sep 2020 10:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J/r/DzejqhON2Zq053Yc7nt4x2QK5WKR7ULtDU5jY6w=;
        b=ntC3R+L4UQO5IZWhruKs7GUrGi6VmGesrAw3u0q5MPxofg4Wka9US2aHVbJeMwNk/K
         rcptakhNK0UGN2G5VZCk44LvAylYgBws/HcQjeZZb/xd6tdz/kKt6Nsuv6tclqeW3muI
         v14PJRymNy6CtcpLXrICQUDNtZY7HMa68UVBbHjQf7dtTzBryKZA7j85guywL2QTBvTG
         ow3s+71JDE/HFza635ppLLKqodPvO3fNaPQXdgxEB/xRYhUHEol6xqXHZNwv6l0RS/wY
         sU7tFYVOM7nWYB4hHRIzGASwqZhCemJM4m7Rq90PaP9x0eE9yvq0ygz7Z9z5FQcvGVPq
         zltw==
X-Gm-Message-State: AOAM531hqObRkhorU4mIDbQHdex/q7X8bsRlPUUMCPXd9nlUI90rMjcg
        KwNe3bSSpUqXu51jCUbNQw==
X-Google-Smtp-Source: ABdhPJztbjs+yImtVzN8jKP+iSikJQluX1X9sQCd6G4NzGHnUKEpnXI/tc6m3rKDbzDNEaVZxNYVAw==
X-Received: by 2002:a4a:e689:: with SMTP id u9mr5463086oot.52.1601400257028;
        Tue, 29 Sep 2020 10:24:17 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r7sm1115415oij.34.2020.09.29.10.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:24:16 -0700 (PDT)
Received: (nullmailer pid 812494 invoked by uid 1000);
        Tue, 29 Sep 2020 17:24:15 -0000
Date:   Tue, 29 Sep 2020 12:24:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     devicetree@vger.kernel.org, kishon@ti.com,
        linux-usb@vger.kernel.org, mgross@linux.intel.com,
        gregkh@linuxfoundation.org, lakshmi.bai.raja.subramanian@intel.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, vkoul@kernel.org,
        andriy.shevchenko@linux.intel.com, balbi@kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: usb: Add Intel Keem Bay USB controller
 bindings
Message-ID: <20200929172415.GA812437@bogus>
References: <20200921024459.20899-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200921024459.20899-4-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921024459.20899-4-wan.ahmad.zainie.wan.mohamad@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Sep 2020 10:44:58 +0800, Wan Ahmad Zainie wrote:
> Binding description for Intel Keem Bay USB controller.
> 
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> ---
>  .../bindings/usb/intel,keembay-dwc3.yaml      | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/intel,keembay-dwc3.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
