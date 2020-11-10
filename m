Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEA32AD700
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 14:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbgKJNAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 08:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJNAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 08:00:54 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C852C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:00:53 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id s13so2899681wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 05:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ybTfB3rMzNb3Par8rFjgeakZunYZuUZMKJ+Bmz10zcI=;
        b=rmy95vdpdJpdRJEwkEsHwMF2i7Fz09alyS8dBJCzhsq01cijLN8w5esY1ZgkK53FPV
         cSZVG2U0tVWBNACNlF4zAsr53awUP6kvc6EZeub8DlRiqt0DTC+er4HbV1uCeFqiPJ99
         sdFZIsB5B5pl9ED/FsK6NiGe8gsyiW3UxBWgelUOXa/7zqTNhBVRwaNK7nxhA8Gatkxn
         /+OTNzRCmv/uOkcMA5ccEW7f2IWVHoQ1rtZhE6udkHHOnDKmCgXe09q0K1/KcOtILr8t
         KmIvz9YQTbrKfjAl+ynn6ylt/s2TIDhpXNSm3OUNTj+K4rN6JazdW82/S48+Lx5HrrIn
         7q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ybTfB3rMzNb3Par8rFjgeakZunYZuUZMKJ+Bmz10zcI=;
        b=HTE/0bNXX00+dFeqeCz0GR4PxMnUx3Z3MgpF+UL65A+r5eoXVABqGuzCtt3b01q3pg
         ko1ZUOaiA56K+Nz3Shpg8VJ08C0xyxpg2tO2RZELl7WQ7tRzJgjyVPGQMGpak7ztn08x
         G34/AX4qB/HGGG6paOnlskzT9OLyViFefgtSCCNnevyz+pR22jY3QIzNtLW4o4s6Ua3x
         K8B1rUQPnVvqkuI7FnQ9aa+5ocexGM1sQkfsAguZCIIalBEa/xByfAIY9LN2k2Nxusvw
         eREaG0Ql3HzpCD5D+4wcFOEdUZxk9dFj103O3hmGhMoxwKCKgaEgb48kJ2BtcT+0Nj4W
         UTjQ==
X-Gm-Message-State: AOAM533Nm83DRIZtbbD/0QuFgQf7iSnrSxedhNMCj+NjjXmDo6yZ8/zq
        Guv7RyDPc95+XdGDwAvOs+6Ui8+reLhQ3CKA
X-Google-Smtp-Source: ABdhPJwOPtmMtv6OjKVZB2aVxNghBPp9/tnek0StNVDL8wEHHKGQzndhEh0APrbsGcFVBzNIdtfVVQ==
X-Received: by 2002:a1c:2bc3:: with SMTP id r186mr4442378wmr.163.1605013251758;
        Tue, 10 Nov 2020 05:00:51 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:870:7715:aaa1:475e])
        by smtp.gmail.com with ESMTPSA id 35sm15115746wro.71.2020.11.10.05.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 05:00:50 -0800 (PST)
Date:   Tue, 10 Nov 2020 13:00:49 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, kernel-team@android.com,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Walbran <qwandor@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v1 23/24] kvm: arm64: Trap host SMCs in protected mode.
Message-ID: <20201110130049.pwc4ilqy2ue2ydvu@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-24-dbrazdil@google.com>
 <10952bcf24bebd5e317d09ced415bfb1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10952bcf24bebd5e317d09ced415bfb1@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
> > @@ -88,6 +88,12 @@ SYM_CODE_END(__kvm_hyp_init)
> >   * x0: struct kvm_nvhe_init_params PA
> >   */
> >  SYM_CODE_START(___kvm_hyp_init)
> > +alternative_cb kvm_patch_hcr_flags
> > +	mov_q	x1, HCR_HOST_NVHE_FLAGS
> 
> You really want to be careful here: the mov_q macro expands to 2, 3 or 4
> instructions, depending on the input data...
> 
> It is also odd that you have both a static key and a patching alternative.
> Why isn't "protected KVM" a capability that can be evaluated as a a non
> patching alternative? In general, I'd like to reserve patching alternatives
> to values that cannot be evaluated at compile time (VM offsets, for
> example).

Capability was my initial idea as well but it looked tied to CPU features.
Looking at it again, you're right that there is precedent for setting them
from kernel params. Alright, I'll change it and that will get rid of the
custom patching.
