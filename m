Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55E82FA1B2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392199AbhARNdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392208AbhARNaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:30:18 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55258C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:29:38 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id y187so13798931wmd.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=azSUNypoUfXkpBNPZlINL/zcgEf9pXSAwHyqYLVciok=;
        b=Hdiq7ktUglPw2zVeBs7zzB+XtzIcpfitaPaWUCwOh9Lp9grsNlqjNfLEhWzbdqjyLr
         XwhO7yBQNhaa8PVRuXmwzBb4HoBM0FMU2kRFd1BKaZ4uX5qIute8XLIkw7aleByJtYGf
         BXUpgbwE6/LwYO5XnDY7K5pT8zQ7ng+PiUgi2+ewvj/+yl6NJJxZ448sKc8AC8xmExWX
         iyq8MLnxO818KbMz6m0jlISbSB5HOIgfxzwLAjOrQi8IDKamWFVMBQUCoTXjfam8WtZw
         NpPZUO8H3m3DlxZyqJQvFXYlVIjWbYG5/v1nBe7gt5DE1oDYURdCVacMi3U98mL76gyk
         ElPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=azSUNypoUfXkpBNPZlINL/zcgEf9pXSAwHyqYLVciok=;
        b=UkUFnO8ggEXJjiemY4t9wK+24VdMFmAVeiRzpb+zM2mVrianaFqhk77SUyVQzgdT1O
         tEQEcGb6Wa7y7RggMMwf1SJ19h4+wgUISp4vzZ3lv85Mrtm5q40Itl/M+fZzOk5bWV6d
         1f3b/pXcvEF5oRgvJvmprKEiXFgknRZAPhlZ3kLUppBEeLEHk1EtDzN1bLUXIE/jCwxm
         yayrjD1TXIrN8CZETBF9pWyrrQoEPtp59u5cGZ7gycD672lYgp1CzuZfPvBHHFZgID5e
         3qnbSHSa9BkVD1Ry1UI2D3jufquqt47VQP6G4NDzdQhezfkXLrwUlP8lbJCcceJSmMFx
         UkSQ==
X-Gm-Message-State: AOAM532md6AtJNYvdafz6mDO2FpBqV9vv+miJ6NP5OvbG5LrgglMnVWv
        WFOPnMiCVtxM+7tyjhXQ1WdxLiruRJBg3w==
X-Google-Smtp-Source: ABdhPJwuICFtdmLsGWmzfsOVlfdR9kik5BbE6wWl9u1IG/qQD53UckSQXbc/RrHmiYn+JKe9B1+ugg==
X-Received: by 2002:a1c:40d6:: with SMTP id n205mr21244747wma.0.1610976576985;
        Mon, 18 Jan 2021 05:29:36 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:3d4d:985d:87b7:4d55])
        by smtp.gmail.com with ESMTPSA id g5sm30955277wro.60.2021.01.18.05.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 05:29:36 -0800 (PST)
Date:   Mon, 18 Jan 2021 13:29:35 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jing Zhang <jingzhangos@google.com>,
        Ajay Patil <pajay@qti.qualcomm.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Srinivas Ramana <sramana@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kernel-team@android.com
Subject: Re: [PATCH v4 17/21] KVM: arm64: Document HVC_VHE_RESTART stub
 hypercall
Message-ID: <20210118132935.mutemf7j7wtyz7wz@google.com>
References: <20210118094533.2874082-1-maz@kernel.org>
 <20210118094533.2874082-18-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118094533.2874082-18-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 18, 2021 at 09:45:29AM +0000, Marc Zyngier wrote:
> For completeness, let's document the HVC_VHE_RESTART stub.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: David Brazdil <dbrazdil@google.com>

> ---
>  Documentation/virt/kvm/arm/hyp-abi.rst | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/virt/kvm/arm/hyp-abi.rst b/Documentation/virt/kvm/arm/hyp-abi.rst
> index 83cadd8186fa..1ba628baf11b 100644
> --- a/Documentation/virt/kvm/arm/hyp-abi.rst
> +++ b/Documentation/virt/kvm/arm/hyp-abi.rst
> @@ -58,6 +58,15 @@ these functions (see arch/arm{,64}/include/asm/virt.h):
>    into place (arm64 only), and jump to the restart address while at HYP/EL2.
>    This hypercall is not expected to return to its caller.
>  
> +* ::
> +
> +    x0 = HVC_VHE_RESTART (arm64 only)
> +
> +  Attempt to upgrade the kernel's exception level from EL1 to EL2 by enabling
> +  the VHE mode. This is conditioned by the CPU supporting VHE, the EL2 MMU
> +  being off, and VHE not being disabled by any other mean (comment line option,
'means' (both singular and plural), and 'command line'

> +  for example).
> +
>  Any other value of r0/x0 triggers a hypervisor-specific handling,
>  which is not documented here.
>  
> -- 
> 2.29.2
> 
