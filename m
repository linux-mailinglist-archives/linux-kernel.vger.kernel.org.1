Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609D72D5212
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 04:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbgLJDvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 22:51:33 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33282 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731710AbgLJDvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 22:51:17 -0500
Received: by mail-ot1-f66.google.com with SMTP id b18so3660046ots.0;
        Wed, 09 Dec 2020 19:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wTUKsQsI85r86/4hHQ2dtyPKmWXP2ZvmGt7MBaOH028=;
        b=NlPHTAUQD2SzOzpAMUOBuvxMA/ZZ1olYiZ4F/TXQCOa3+Vjx788zRj7W57h43isvDm
         KYfxUFCoKE27Rd+DwOP5SrZi6bzh6pUIYB6R5TfGfxTSTi7sk1HJXe/9br7dZAkYXj6t
         VbeXTXzRg3FmSgwfZD11YRQV8sTKLJlJUaydWd0ErhY9Naj6+n7JESZ++2hExKSoiMSN
         k3ilebfDeaejy7but5w/V7HAIpLr/qoDmWzmXlkSl/tQXb96NZWoJzMhQPZiVnC3I+i7
         TWe/Nf2OMlixrF2pz1TX4AaS6Do4suykKBMSMe/k1I2sa3ACVR2ogtZ5Mkf7hAXUEGgt
         YWfA==
X-Gm-Message-State: AOAM533ScYK/DPcV8nRpS2nWY6SlkcgOh7lNR6crM0+k/xmSr3rK4S53
        GfWMYHXnAIkeq+UMD+XgQg==
X-Google-Smtp-Source: ABdhPJzyro0TDfjAJJemuxnapS3KeOXJW7vVxsQSlvBdmdYX7hFBfYtY6Rel8ijjf+FAVBOowtVtWg==
X-Received: by 2002:a05:6830:2144:: with SMTP id r4mr3914253otd.180.1607572236096;
        Wed, 09 Dec 2020 19:50:36 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z10sm784921oom.3.2020.12.09.19.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 19:50:35 -0800 (PST)
Received: (nullmailer pid 1625643 invoked by uid 1000);
        Thu, 10 Dec 2020 03:50:34 -0000
Date:   Wed, 9 Dec 2020 21:50:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kevin Tang <kevin3.tang@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        sean@poorly.run, daniel@ffwll.ch, orsonzhai@gmail.com,
        devicetree@vger.kernel.org, mark.rutland@arm.com,
        mripard@kernel.org, robh+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, airlied@linux.ie,
        zhang.lyra@gmail.com
Subject: Re: [PATCH v1 5/6] dt-bindings: display: add Unisoc's mipi dsi
 controller bindings
Message-ID: <20201210035034.GA1625611@robh.at.kernel.org>
References: <1607352626-26088-1-git-send-email-kevin3.tang@gmail.com>
 <1607352626-26088-6-git-send-email-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607352626-26088-6-git-send-email-kevin3.tang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Dec 2020 22:50:25 +0800, Kevin Tang wrote:
> From: Kevin Tang <kevin.tang@unisoc.com>
> 
> Adds MIPI DSI Controller
> support for Unisoc's display subsystem.
> 
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
> ---
>  .../display/sprd/sprd,sharkl3-dsi-host.yaml        | 107 +++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sprd/sprd,sharkl3-dsi-host.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
