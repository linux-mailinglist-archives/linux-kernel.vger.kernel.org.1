Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CF1269688
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgINU13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:27:29 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:46062 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgINUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:20:42 -0400
Received: by mail-il1-f196.google.com with SMTP id h2so796959ilo.12;
        Mon, 14 Sep 2020 13:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rUyPHCHQEwPP/UDzdYJFMAZiINJSksvQiqUhUUenKjc=;
        b=XoU7Cts/ELDYceZ4+lQkqtDbMmL/w1MRN2aqkoEBjq0WAHP7GWewuhCww4E692Oroh
         8w0sOX1x27VH/Bd/K2pxPZV+twe98SMdh+kfI4p3EBKQYDmuPcySBufmeZR6eHaUzsG6
         TGX7RoujtQJ/06iEt1JfFXiclPzvP7uGbcZ7B2YBCsO1QxeTugqT3QMAOQs2TUg62BLn
         PnUddJ1JQjFNw0AzBar7koLQh1vSUieZmHkRDR4TfRw+TATBxEDeVW1JizGOfHaegT3G
         H+Sfjx9ejAznyzbFQ8W+BcCImU9V5qXQvUc6xtvLXmMYqiNhlFGjB9HuXwyqqFo6Dd5m
         u3SA==
X-Gm-Message-State: AOAM533tRYKbBvGyUGR+ACpylc9wTSbgpmSF0lpmBPZlO2bZ4p5SRApf
        qYXPlnGYMAZ/wDoneP14LH30oLQFn797
X-Google-Smtp-Source: ABdhPJz9ptvMqoc8d/p3+5vlGGVvOKt7rZJyyR98uWDlpicTHg4KwGw+aFbOr33BBIGvLMG6DDT0HA==
X-Received: by 2002:a92:910a:: with SMTP id t10mr13542078ild.256.1600114841074;
        Mon, 14 Sep 2020 13:20:41 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id d23sm6489497ioh.22.2020.09.14.13.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 13:20:40 -0700 (PDT)
Received: (nullmailer pid 173854 invoked by uid 1000);
        Mon, 14 Sep 2020 20:20:38 -0000
Date:   Mon, 14 Sep 2020 14:20:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@ti.com>
Cc:     pawell@cadence.com, vigneshr@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, nsekhar@ti.com,
        devicetree@vger.kernel.org, balbi@kernel.org, kurahul@cadence.com,
        robh+dt@kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: usb: cdns,usb3: Add
 cdns,phyrst-a-enable property
Message-ID: <20200914202038.GA173798@bogus>
References: <20200902133543.17222-1-rogerq@ti.com>
 <20200902133543.17222-3-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902133543.17222-3-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Sep 2020 16:35:42 +0300, Roger Quadros wrote:
> Controller version 0x0002450D has USB2 PHY RX sensitivity issues
> that needs to be worked around by enabling phyrst-a-enable bit
> in PHYRST_CFG register.
> 
> There is no way to know controller version before device controller
> is started and the workaround needs to be applied for both host and
> device modes, so we add this DT property.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  Documentation/devicetree/bindings/usb/cdns,usb3.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
