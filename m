Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF602AEED8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgKKKhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:37:21 -0500
Received: from foss.arm.com ([217.140.110.172]:46722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgKKKhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:37:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82A78101E;
        Wed, 11 Nov 2020 02:37:19 -0800 (PST)
Received: from bogus (unknown [10.57.15.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7324D3F6CF;
        Wed, 11 Nov 2020 02:37:17 -0800 (PST)
Date:   Wed, 11 Nov 2020 10:37:11 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: arm: Add optional interrupt to
 smc/hvc SCMI transport
Message-ID: <20201111103711.h6hez4d6t3uxat3b@bogus>
References: <20201110183827.19731-1-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110183827.19731-1-james.quinlan@broadcom.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 01:38:18PM -0500, Jim Quinlan wrote:
> This change allows the SCMI "platform" to use the smc/hvc transport and to

Incorrect statement above, it is OSPM using SMC/HVC as transport and not
the "platform" which refers to entity/firmware implementing SCMI
services to OSPM. Also this change is not adding SMC/HVC, just the
interrupt support.

> optionally indicate the completion of an SCMI message with an interrupt.
> This is in contrast to the nominal case where the return of the SMC call
> indicates message completion.
>
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  Documentation/devicetree/bindings/arm/arm,scmi.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> index 55deb68230eb..d3b0c9f387fe 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> @@ -31,6 +31,14 @@ Optional properties:
>
>  - mbox-names: shall be "tx" or "rx" depending on mboxes entries.
>
> +- interrupts : when using smc or hvc transports, this optional
> +	 property indicates that msg completion by the platform is indicated

s/msg/message/

> +	 by an interrupt rather than by the return of the smc call. This
> +	 should not be used except when the platform requires such behavior.
> +
> +- interrupt-names : the name must be "msg-serviced".

Is this mandatory if "interrupts" is present ?

> +
> +

Extra blank line ?

--
Regards,
Sudeep
