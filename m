Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3872C0B47
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 14:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388989AbgKWNWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 08:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733009AbgKWNWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 08:22:30 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBB1C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 05:22:28 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id j15so14302096oih.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 05:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/kdqFZeAVjbR1EcrIlFEOxJOMeoTF+Ogzz6G56OSu8M=;
        b=rTTjlgTIUFSWUW/IC4OxUfYnSqKXdJJ9kqYLU/ZqrJAAi87J+7NiREj6ube4ANvu1g
         LsHbqdqUqsv1WvcxkWTewmx3DHXB3cakd8AOodJlcSbrVphhStsCFNaDA0bWkye3lKjm
         AcQllA7rtoChNr8xdo732cLNI+Hy+0pe5oXbIrBYCjn3BPQmXgi82/O1h35cWJqz9T2/
         edQbz0xLSKOG16+/9MKx49RjIACs+K8INOB7JtBQwPP8geXDKG9gyx9eckuCQ6gpNpdk
         Y9AZ333KWpIZr4Kza7TJAOnmVPkXgStofyfEhZK7IKJCMoly0/9ynQdr/CGbnQIOU6mh
         C0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/kdqFZeAVjbR1EcrIlFEOxJOMeoTF+Ogzz6G56OSu8M=;
        b=q5RS/RD2EqoKrQ7CBLIDrR+yW9+yhGKLgQ2q4o8e7FvtW2WKoP+/wMR+qF81Hfscaz
         sr3/4NpLyiMyjIkRX0WrvK93uxXuX9rlzbmwFkhaVZkojyoa+sE4r++cwAdPxv53q/cp
         pcgkL+8/7xiqxMcMVL77hwC+VeP2X2rx2TpF4CCa4ND8wRRvHjQBcNQWqLqquY5qziN0
         D999mGiVVUdJb17U5ULMiqF28ElEBy6BlBKqt4aGjMW5sPEsaaCp3jU63GWy8il15gmD
         fZVdY4p1VE3CfLT0lSnQxY1v1wpGFn/+DAbvzrtkGg/i0263Ct3LAGe04XqRixwlnWns
         oYiw==
X-Gm-Message-State: AOAM532Srxi8RBDdz6U3siJjuMWic3u/QHYxWJ2YSatNH67UiIUloP/S
        QfGa3z6YPlXRdGuAfJzThxTpiA==
X-Google-Smtp-Source: ABdhPJzEhLvMoLTH89tN1wdaa8/gjQDGQFbkETdg1TT2tpDZ6ILozNTF3nqBtpBt76eWvVSRF6fAZg==
X-Received: by 2002:a05:6808:301:: with SMTP id i1mr15073703oie.49.1606137747765;
        Mon, 23 Nov 2020 05:22:27 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:acac:b2ef:c7d:fd8a])
        by smtp.gmail.com with ESMTPSA id s185sm7344774oia.18.2020.11.23.05.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 05:22:26 -0800 (PST)
Date:   Mon, 23 Nov 2020 13:22:23 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, kernel-team@android.com,
        android-kvm@google.com
Subject: Re: [RFC PATCH 13/27] KVM: arm64: Enable access to sanitized CPU
 features at EL2
Message-ID: <20201123132223.oohevce4izuoaqi3@google.com>
References: <20201117181607.1761516-1-qperret@google.com>
 <20201117181607.1761516-14-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117181607.1761516-14-qperret@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +int copy_ftr_reg(u32 id, struct arm64_ftr_reg *dst)
> +{
> +	struct arm64_ftr_reg *regp = get_arm64_ftr_reg(id);
> +
> +	if (!regp)
> +		return -EINVAL;
> +
> +	memcpy(dst, regp, sizeof(*regp));
> +
> +	return 0;
> +}
> +
>  #define read_sysreg_case(r)	\
>  	case r:		return read_sysreg_s(r)
>  
> diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
> index dd8ccc9efb6a..c35d768672eb 100644
> --- a/arch/arm64/kernel/image-vars.h
> +++ b/arch/arm64/kernel/image-vars.h
> @@ -116,6 +116,8 @@ __kvm_nvhe___memcpy			= __kvm_nvhe___pi_memcpy;
>  __kvm_nvhe___memset			= __kvm_nvhe___pi_memset;
>  #endif
>  
> +_kvm_nvhe___flush_dcache_area		= __kvm_nvhe___pi___flush_dcache_area;
> +

Could you help my understand why we need this?
* Why do we need PI routines in the first place? Would my series that fixes
  relocations in hyp code remove the need?
* You added these aliases for the string routines because you were worried
  somebody would change the implementation in arch/arm64/lib, right? But this
  cache flush function is defined in hyp/nvhe. So why do we need to point to
  the PI alias if we control the implementation?
