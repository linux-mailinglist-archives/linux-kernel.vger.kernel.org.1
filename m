Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A522D18EB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 20:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgLGTCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 14:02:11 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40259 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLGTCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 14:02:11 -0500
Received: by mail-oi1-f195.google.com with SMTP id p126so16575400oif.7;
        Mon, 07 Dec 2020 11:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oq0uf3/fLWDZlMwGpgKAvvZ5GOhPZy/p7Susns2+2mQ=;
        b=UOW83FjCl4dTxTILhHahCvhaIjBhhgCpnwXViUPlVrpLmP09JMfZJaEWlAoTpSEpd6
         vBN7XEqWoJ53E8sWopMV3pbvCpolJXr2oNM6HSMq75bbwQxSO2twlUObsUcp+9JIcAi5
         WnrWQ1QiApCFQG5ffhZ1DLCkEsA2sKyTO3QcYv6H2s1nhvWfPY5K3JFnXb5hJVTOK4dv
         AWuLer+DtXp7Kd7PC+1vRB3yTbRzsmDpWUNGWaYo45CTJ5aSsL67LSdqDe1XE0Fqgm3K
         mXgwEAxekbeUGIbSEQxRQMqkjkmU2J9DINfAPFkHHxq0OYkyPgI0wX10ibqdZRdApQju
         TIdQ==
X-Gm-Message-State: AOAM531uJFt/M5NtSXDDtM7Xh+PoZGz+XMSmfR5rMC4R1Fd2oTDmVgG2
        6GNpqpmKkYyk/pklHc1xhIuZOTJZbw==
X-Google-Smtp-Source: ABdhPJzmZ9pkhVdNrTwfLlvsUMHpnMAi4vUiamjBYoNrKM48G/OKOQeZN8CjkCxZYMagcxrYGCTVjw==
X-Received: by 2002:aca:dc56:: with SMTP id t83mr224368oig.110.1607367689832;
        Mon, 07 Dec 2020 11:01:29 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j4sm1533684ota.8.2020.12.07.11.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:01:28 -0800 (PST)
Received: (nullmailer pid 625746 invoked by uid 1000);
        Mon, 07 Dec 2020 19:01:27 -0000
Date:   Mon, 7 Dec 2020 13:01:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        bcm-kernel-feedback-list@broadcom.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: Add optional interrupt to
 smc/hvc SCMI transport
Message-ID: <20201207190127.GA617336@robh.at.kernel.org>
References: <20201112175632.42234-1-james.quinlan@broadcom.com>
 <20201112175632.42234-2-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112175632.42234-2-james.quinlan@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 12:56:26PM -0500, Jim Quinlan wrote:
> In normal use of smc/hvc transport in SCMI the message completion is
> indicated by the return of the SMC call.  This commit provides for an
> optional interrupt named "message-serviced" which is used instead to
> indicate the completion of a message.
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  Documentation/devicetree/bindings/arm/arm,scmi.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> index 55deb68230eb..7cdad11f40b1 100644
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
> +	 be present and have the value "message-serviced".

Don't really need names when only one, but wouldn't 'a2p' be more 
concise and based on SCMI spec (just guessing...).

> +
>  See Documentation/devicetree/bindings/mailbox/mailbox.txt for more details
>  about the generic mailbox controller and client driver bindings.
>  
> -- 
> 2.17.1
> 


