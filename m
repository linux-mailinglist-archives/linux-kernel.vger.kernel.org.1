Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C4F28D01F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgJMOWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:22:46 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33509 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbgJMOWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:22:45 -0400
Received: by mail-ot1-f66.google.com with SMTP id t15so166524otk.0;
        Tue, 13 Oct 2020 07:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X2OPUF6hLvyo2zbCRQtk4GShfyN48+lkdnulYVh78p0=;
        b=h0P9nSrS9YiEzSjS1fagP9qiVty9VuKBjSv9Fu8aOuRhf62k48xHibAzqgXw48D9S2
         sJG8V7BXdzNm6RtvENEV2WBWduWwr9qwAU+c4tHSiBu6XzJ4HigX8Ej1WGyheKgL0mxw
         SV6DITcaaNZUYoBgdh/OJJgEioSTwYRG7dZ5JOKuFRM7omlQF2Epj+U4vngxN/wv/T+w
         rEPywlBnB2jExlNW4zmWWqi5iJtISKJWuhWujpnPEhQm2f44BTwbPKk5TiuGaEOFgRWs
         pt1nbGNwcXWesXr/nF90kkIpXjhywtlpRwos94Vza1T7HEsk3jlHyzMs7/tsyfTL7zti
         qfyA==
X-Gm-Message-State: AOAM531kxViOeJ19k6NT8cuXn0r9B1Zst4bDQJkmFtrkOxKAI6IDTYT7
        J6+AxTRKkwOJ/wvioX+k9g==
X-Google-Smtp-Source: ABdhPJxx9u6/kZVY8K22eqdOb8C41IRPu74rOUg09vn74HyLEKIVhnueMVZw5SBfmuk1ASMt6aBa1A==
X-Received: by 2002:a9d:5547:: with SMTP id h7mr23056541oti.248.1602598964628;
        Tue, 13 Oct 2020 07:22:44 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d11sm2366320oti.69.2020.10.13.07.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 07:22:43 -0700 (PDT)
Received: (nullmailer pid 3448875 invoked by uid 1000);
        Tue, 13 Oct 2020 14:22:43 -0000
Date:   Tue, 13 Oct 2020 09:22:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     devicetree@vger.kernel.org, git@xilinx.com, p.zabel@pengutronix.de,
        linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, balbi@kernel.org,
        linux-arm-kernel@lists.infradead.org, michal.simek@xilinx.com
Subject: Re: [PATCH v3 1/2] dt-bindings: usb: dwc3-xilinx: Add documentation
 for Versal DWC3 Controller
Message-ID: <20201013142243.GA3448825@bogus>
References: <1602162416-28058-1-git-send-email-manish.narani@xilinx.com>
 <1602162416-28058-2-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602162416-28058-2-git-send-email-manish.narani@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Oct 2020 18:36:55 +0530, Manish Narani wrote:
> Add documentation for Versal DWC3 controller. Add required property
> 'reg' for the same. Also add optional properties for snps,dwc3.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  .../devicetree/bindings/usb/dwc3-xilinx.txt     | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
