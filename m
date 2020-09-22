Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955AB2747D8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 19:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgIVRzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 13:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgIVRzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 13:55:06 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC70DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 10:55:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v12so2433896wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qDuqWZC1VW8EQfRTwPy1SQY9Ugia7fQLlUkBJbJw2ug=;
        b=mpb3KRYsHGqaV+XbtgbH5xYHePKnUNApKF+8H80qUiSDOh2I7ZkW6cemtP/OqS4sfa
         O9qNFo6rYWvbfjngVHSQJtV39YfrqDBygii/bNyFKYK/QYQXRapOjGChdBZDONhoYCEw
         C+N5zK4PUScYEiO/iwfysMRi+n0SI+ghafp3hF+D0WgIhsd5ca9O2VlvYGUpdDa/xWY4
         +luI/GJNy0LTakzRhcTqnAbxtl2WCkWQNx/vkTpcb4n4t+vYOrtkcYzzAN+/OuBlOs4d
         HuyPtqS/sy82pht3gov8SpLOvtkriDaLFIXFKpyxddBR485hmSZbKMwY9tm6WQ7AYHm7
         u8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qDuqWZC1VW8EQfRTwPy1SQY9Ugia7fQLlUkBJbJw2ug=;
        b=P0t9uIYDW47cnPnaohBPlaQ4rY3jjrpV4a4rwULBP2H0U66SC5HBkeKRBNUWDuLIsw
         EIOMGPkTXS8AfgJN/sqAVZ4QycBY6VeWE2zS7XdwOG+izvloA+DWLDW6I1g1DNzhmi49
         uj0Eo9UPeyqtaBUSXpGuOk13G9wseE3hIZnpt5ITJP7dqjYClOjdzTQd4lt7YwgyAg3e
         cId8dSgZZOnPClUhmcX46Bgm9B+M7am3VEKqp0/GxxYjg1AffPWr6ivus+oV7FAaS7+X
         QH6P8Vsenqq5AlulqxID2K0avTdshzveSo0xxQ3KPv27liEu31hBYXN6mg65jJFTA+g4
         2nPA==
X-Gm-Message-State: AOAM533mI0dQ6WN49MkDTCOZ+PRUeDwowTD5BH0MIZxk+unGkBUtNkuk
        Is++yn4IA3FuK4LNq0d6IHPH9A==
X-Google-Smtp-Source: ABdhPJzolE/26FKJ6uSxzitqtAryO9MchyZJUE0K1lhB7o+h59fgvoQhUwPcnNYz9fEC4TwM5UIGgQ==
X-Received: by 2002:a7b:c958:: with SMTP id i24mr2379869wml.50.1600797304450;
        Tue, 22 Sep 2020 10:55:04 -0700 (PDT)
Received: from google.com ([2a01:4b00:8523:2d03:55c2:2cdf:ff31:96a3])
        by smtp.gmail.com with ESMTPSA id q4sm26879934wru.65.2020.09.22.10.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 10:55:03 -0700 (PDT)
Date:   Tue, 22 Sep 2020 18:55:02 +0100
From:   David Brazdil <dbrazdil@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 01/11] kvm: arm64: Partially link nVHE hyp code,
 simplify HYPCOPY
Message-ID: <20200922175205.6gacjibejr7mmbgw@google.com>
References: <20200916173439.32265-1-dbrazdil@google.com>
 <20200916173439.32265-2-dbrazdil@google.com>
 <20200918085116.GA30834@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918085116.GA30834@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +#define HYP_SECTION_NAME(NAME)	.hyp##NAME
> > +
> > +/* Defines an ELF hyp section from input section @NAME and its subsections. */
> > +#define HYP_SECTION(NAME) \
> > +	HYP_SECTION_NAME(NAME) : { *(NAME NAME##.[0-9a-zA-Z_]*) }
> 
> I still don't get why we can't just use NAME ## .* for the regex here. That
> matches what we do elsewhere for linker script wildcarding, e.g. .rodata.*,
> .init.text.* ...  in asm-generic/vmlinux.lds.h. Why is it different for
> these sections?

Shouldn't matter. I copied it from a script in the Clang LTO branch. Will align
it with what's in the main arm64 script.

> > +# 2) Compile linker script.
> > +$(obj)/hyp.lds: $(src)/hyp.lds.S FORCE
> > +	$(call if_changed_dep,cpp_lds_S)
> 
> You need a .gitignore file listing hyp.lds, otherwise some idiot will end
> up committing it. I definitely didn't do that when playing around with this
> series. Nope. Not at all.

Thanks for noticing, I never compile in-tree. Added
