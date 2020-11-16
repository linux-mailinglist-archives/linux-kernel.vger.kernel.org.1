Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3FC2B4EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388062AbgKPR4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387513AbgKPR4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:56:39 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95E8C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:56:39 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id d142so113098wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 09:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xaNTxNoQPnXnoUb4r3iV3mkFKbHJuRiufvKdd63kC7I=;
        b=sdIhKOXdzOYUd+0zNv8c0adHbCQpoXeesxkjDLAWcVsQPMNDpfluCLKkFw4WfVYV2U
         T4Lz4ZqbN1XalTec7vHfSnyzVHrGMdF7wclbYRmO3LLQfhJopfg2xSZxPgYaf+i2tjPY
         V2TKzLtaYd0cs8iOJ3X1mjjRUUpt+mng4ZKIpkfQ+qHCFS29msT7SFYYx4p7lHs9wOl5
         fv1KQionDArngXPYQxG9i/TfiCd3A2uIbWu9nzce8vKzKcgc9mPpxL8avcoVPIZDkLL7
         QC/2UIKH/WrfxI3/ZMXY/zKHjO5bVHqehzf6TdSeb0koVcSwzq+7la8pSEjEQ6PlwYUr
         DiKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xaNTxNoQPnXnoUb4r3iV3mkFKbHJuRiufvKdd63kC7I=;
        b=mjZ4vZXSyan0YBgVoZ73ZPRCyMFhkxFEUiSwUYeekEH9gaH3mzACOQeAKQSnyu36dK
         Mq901uE0cDrXF1fiQumvyMVSWKQn1XSwFPmqoRoWfINOip4Hd4LzZM0yI0gNvTS4vIDM
         fe5dmOPHPPO/bIz24rg4EQNcVSIQQg5nSFW/rhiwV4BgFSUSyp88ZXRg1QH38TF2nARa
         5gXnRP+JFyYgTdY/5wJ3vshbOCzyFzKfmmE+g0M4peXAJkJdrRqeQKLI8jE6W5CTU8J0
         4WfwatjSGV42pft8peQDaYK45IbWGU14vO1X6UJ8xuF69ItgLqkpluHt/6Hgxr5tAPmI
         BDDQ==
X-Gm-Message-State: AOAM531eures9pwIhwc23dKQvUJUJJhrogwhllYrHo+a5BmVZk7c+zbb
        YFpC0PXtO4EUFkv7DNdVqa2r3Q==
X-Google-Smtp-Source: ABdhPJzq+YhoQ9FGcQcT1hEJKNYAgJc8ZImY4yxRsCLZhalfs1c7PQkN19eo6JoF/FMRMs7CfUQDxw==
X-Received: by 2002:a05:600c:2202:: with SMTP id z2mr43648wml.115.1605549398247;
        Mon, 16 Nov 2020 09:56:38 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:58a8:7836:6672:a072])
        by smtp.gmail.com with ESMTPSA id z189sm69814wme.23.2020.11.16.09.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:56:37 -0800 (PST)
Date:   Mon, 16 Nov 2020 17:56:36 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com
Subject: Re: [PATCH v1 10/24] kvm: arm64: Extract parts of el2_setup into a
 macro
Message-ID: <20201116175636.qmp5iws6gq7a7syi@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-11-dbrazdil@google.com>
 <a6f5d318eb7e7adde2106df068121b48@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6f5d318eb7e7adde2106df068121b48@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> > +	 * Check for VHE being present. x2 being non-zero indicates that we
> > +	 * do have VHE, and that the kernel is intended to run at EL2.
> >  	 */
> >  	mrs	x2, id_aa64mmfr1_el1
> >  	ubfx	x2, x2, #ID_AA64MMFR1_VHE_SHIFT, #4
> > -#else
> > -	mov	x2, xzr
> > -#endif
> > +	cbz	x2, el2_setup_nvhe
> 
> What initialises x2 to zero when CONFIG_VHE is disabled?

There is no need for x2 anymore, the nVHE code just falls through. Basically:

	el2_setup:
		< check CurrentEL >
		b.eq	1f
		ret
	1:
	#ifdef CONFIG_VHE
		< check has VHE >
		cbz	el2_setup_nvhe
		< VHE setup >
		ret
	#endif
	el2_setup_nvhe:
		< nVHE setup >
		eret

-David
