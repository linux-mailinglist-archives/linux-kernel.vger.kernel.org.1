Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D084B2E0178
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 21:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgLUUSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 15:18:21 -0500
Received: from mail-oo1-f47.google.com ([209.85.161.47]:36737 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgLUUSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 15:18:21 -0500
Received: by mail-oo1-f47.google.com with SMTP id j8so2495436oon.3;
        Mon, 21 Dec 2020 12:18:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1VBFeKX6QPZo7kjxsbDjx2WtBpAZOKJDM3ozSLJzv0s=;
        b=pQHnRIXV6dvwlOgkyrnxgcF8G+ObBUweJHHxORo9Tmq7SH/FJcLV751vvBE8J0emfh
         LXprtrto9VbI0/+jNkbfFH61EqogUPU8fgUKivJbKDbSvNJPYNLkYY/ViT8koPjntVtr
         0yFGj2xhanha5KN71/EEJEDbmlLq9jeEiNS4c9A7oWBk/rXZNjz+0LF/QlFypJX12nZb
         bBKdCL6y/G8+WSY/PPAX5oJ40EuND58zRANBhIIJmDQGMQakK9xUskJEXoUehFNnveiq
         ijiSrPch1x+dqEbJIwMVC6drzW6iDHWbrKpVLqUFFBIjQVeoEI1lnxPl1SQCKt8UtQbG
         LtUg==
X-Gm-Message-State: AOAM533JkAKMrkP+hO/Hyw/tYHPiFqhUBj1ebaTxZ9BExedKZqkk6g1a
        IVmtgFDBtup1nGSewr+erPd+eisGpw==
X-Google-Smtp-Source: ABdhPJxcog/s6WXnkBAxv6eoEp3z29bPS/QlHG7BeEqmJYYAu1XICPb6cln5rhvlgdNefbmgh+yBqA==
X-Received: by 2002:a4a:9873:: with SMTP id z48mr12747207ooi.44.1608581860043;
        Mon, 21 Dec 2020 12:17:40 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id o21sm4025126otj.1.2020.12.21.12.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 12:17:38 -0800 (PST)
Received: (nullmailer pid 483803 invoked by uid 1000);
        Mon, 21 Dec 2020 20:17:37 -0000
Date:   Mon, 21 Dec 2020 13:17:37 -0700
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: Add optional interrupt to
 smc/hvc SCMI transport
Message-ID: <20201221201737.GA481116@robh.at.kernel.org>
References: <20201216205805.4221-1-james.quinlan@broadcom.com>
 <20201216205805.4221-2-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216205805.4221-2-james.quinlan@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 03:58:01PM -0500, Jim Quinlan wrote:
> In normal use of smc/hvc transport in SCMI the message completion is
> indicated by the return of the SMC call.  This commit provides for an
> optional interrupt named "message-serviced" which is used instead to

s/message-serviced/a2p/

> indicate the completion of a message.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>

checkpatch.pl reports your author and Sob emails don't match.

> ---
>  Documentation/devicetree/bindings/arm/arm,scmi.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> index b5ce5b39bb9c..667d58e0a659 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> @@ -31,6 +31,14 @@ Optional properties:
>  
>  - mbox-names: shall be "tx" or "rx" depending on mboxes entries.
>  
> +- interrupts : when using smc or hvc transports, this optional
> +	 property indicates that msg completion by the platform is indicated
> +	 by an interrupt rather than by the return of the smc call. This
> +	 should not be used except when the platform requires such behavior.
> +
> +- interrupt-names : if "interrupts" is present, interrupt-names must also
> +	 be present and have the value "a2p".
> +
>  See Documentation/devicetree/bindings/mailbox/mailbox.txt for more details
>  about the generic mailbox controller and client driver bindings.
>  
> -- 
> 2.17.1
> 
