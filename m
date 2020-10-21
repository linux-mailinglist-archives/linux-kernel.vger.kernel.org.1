Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5B829509D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444519AbgJUQUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:58552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2444499AbgJUQUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:20:39 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCEED2242F;
        Wed, 21 Oct 2020 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603297239;
        bh=lhfpPqHvcC5eAUWdYP2+ywqk1mtGkyfhmXVA+ip8auU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z4oBN7zxnw/M5KTg3l3gJMJe+ZeaqUvDh7+3tkvU9BgiLQ/idyMK4SrOA4y+YOOld
         8VRYnpfJchi/EKrDsaTYEC8hKbQ/Cxh3PUBsunAHrnVIMjP9iRpBQpWXNOWwqXLBPB
         p25ckNbi2aBaj4qIwDqHsO2FEVzknfH4izMxj7hs=
Received: by mail-ot1-f44.google.com with SMTP id n15so2331619otl.8;
        Wed, 21 Oct 2020 09:20:38 -0700 (PDT)
X-Gm-Message-State: AOAM5332LULFUgsWplKkCy31mDEfv/yE56wQs7IKSM0JNrRZ437zGEgu
        i+j+3F5/4mpIF7f6KtBU+/O+FxpJoGjgcIKt7w==
X-Google-Smtp-Source: ABdhPJx5rOhH6XY5C8b3whswSWKHk4RA06ZGRtX/e7EEfcs3f5ba1aiTBg2iHG3FsoyXY5w/XfdPxOKIZS9+E+JpPN0=
X-Received: by 2002:a9d:5e14:: with SMTP id d20mr2949521oti.107.1603297238053;
 Wed, 21 Oct 2020 09:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201020203710.10100-1-sudeep.holla@arm.com>
In-Reply-To: <20201020203710.10100-1-sudeep.holla@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 21 Oct 2020 11:20:27 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKH9pN7E7o+UY7YmOrOKCUigrMTxY3f3AH4PdpQUAaawg@mail.gmail.com>
Message-ID: <CAL_JsqKH9pN7E7o+UY7YmOrOKCUigrMTxY3f3AH4PdpQUAaawg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm,scmi: Do not use clocks for SCMI
 performance domains
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 3:37 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Commit dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return
> -EPROBE_DEFER") handles -EPROBE_DEFER for the clock/interconnects within
> _allocate_opp_table() which is called from dev_pm_opp_add and it
> now propagates the error back to the caller.
>
> SCMI performance domain re-used clock bindings to keep it simple. However
> with the above mentioned change, if clock property is present in a device
> node, opps can't be added until clk_get succeeds. So in order to fix the
> issue, we can register dummy clocks which is completely ugly.
>
> Since there are no upstream users for the SCMI performance domain clock
> bindings, let us introduce separate performance domain bindings for the
> same.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  .../devicetree/bindings/arm/arm,scmi.txt      | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> Hi Rob/Viresh,
>
> This is actually a fix for the regression I reported here[1].
> I am not adding fixes tag as I am targeting in the same release and
> also because it is not directly related.
>
> Regards,
> Sudeep
>
> [1] https://lore.kernel.org/r/20201015180555.gacdzkofpibkdn2e@bogus
>
> P.S.:/me records that this binding needs to be moved to yaml in v5.11
>
> diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> index 55deb68230eb..0a6c1b495403 100644
> --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> @@ -44,7 +44,7 @@ as described in the following sections. If the platform supports dedicated
>  mboxes, mbox-names and shmem shall be present in the sub-node corresponding
>  to that protocol.
>
> -Clock/Performance bindings for the clocks/OPPs based on SCMI Message Protocol
> +Clock bindings for the clocks based on SCMI Message Protocol
>  ------------------------------------------------------------
>
>  This binding uses the common clock binding[1].
> @@ -52,6 +52,19 @@ This binding uses the common clock binding[1].
>  Required properties:
>  - #clock-cells : Should be 1. Contains the Clock ID value used by SCMI commands.
>
> +Performance bindings for the OPPs based on SCMI Message Protocol
> +------------------------------------------------------------
> +
> +Required properties:
> +- #perf-domain-cells: Should be 1. Contains the performance domain ID value
> +                     used by SCMI commands.

When is this not 1 (IOW, you only need this if variable)? How would it
be used outside SCMI (given it has a generic name)?

> +
> +* Property arm,scmi-perf-domain

Yet this doesn't have a generic name. You mentioned on IRC this is
aligned with QCom, but why can't QCom use the same property here?

Really though, why can't you give SCMI a CPUs MPIDR and get its domain?

Rob
