Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F782C411E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 14:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729382AbgKYN0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 08:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbgKYN0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 08:26:21 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F18C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 05:26:21 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id e7so1916449wrv.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 05:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AlYFyy65mMJrzPAF8ZbtQbw2MzAGfUKKDzhurYImYTg=;
        b=BTfJiOV5Qs1kwbPh75cNnFXtGarY+41MnAH0XZ7Mmi0dqbPtd7shBqFXYDymd3GNkm
         lkdahn66M2LPzI/Td7gXSvJfiKph5rGOimnUJgajkNXfkGkhhnIPA4RRxMk2LTmgHb2Q
         mbfd5dzmX33uNWJIDA46LqcFUM6xlfPDAVQeq/+zCLfloZMl84wadxqfD6mgdQKXCrlr
         eGZ2McF9rUgTkshK/YzShcNErO8yEsGhUGj12eZkY5cV2c8xFalXfd5xEWQbClJkdz0P
         G41tzHEcWP3iwW4szgurd8J3PnWzv6UR7faQVwqid6zeIaZATYdS3BwjRTDbasQ+w/uK
         72DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AlYFyy65mMJrzPAF8ZbtQbw2MzAGfUKKDzhurYImYTg=;
        b=uOC78eLqxew73Tk5ozk+95ZsDHLm1cbHQBuVQ+GpB1o+pSMaESDrOpI9bHLkM9U8SA
         csmNl0tqdIsFGjdZI619RR8JNRYLdE9DUDOgTMke0IUegJr1yDLLuRvINCgxtHM0k0B1
         cHmFmgKWHYVTyfjHOXPdumYhwrG8w5QAVbOv+MZnI89oxBOwg8VgBFNS6jOmdN1FUCDC
         Qxi6rb8vTCFdRcBrL2WRnNxJRGV4VTfsV6B2Lc/yngqbkGgCxDhP4Pme8q/UbJXyCMQQ
         GcOxYv7JyERj57EeiFsh+w/aow7yyGqF8KFzASL5MfKThQWbLCUd0gFbyR95TwxAN6Yk
         sF1A==
X-Gm-Message-State: AOAM530GOPTZqJe1YiZ57FiAO/SGBAg6GA+j/vkk10kKnmvZi/Ra/KXK
        xyMkLFrw/L1VQP6xZU0WAaGX5Q==
X-Google-Smtp-Source: ABdhPJy2QWZ+aTIexoqvjYkDzVR7TA/T3I3OJCD/3ABMXhMh9WhgGwr7tT6EW53IiAEKwTAmTr5PnA==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr4022419wrm.44.1606310779648;
        Wed, 25 Nov 2020 05:26:19 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:38bf:5817:e665:9b9b])
        by smtp.gmail.com with ESMTPSA id 90sm5059825wra.95.2020.11.25.05.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 05:26:18 -0800 (PST)
Date:   Wed, 25 Nov 2020 13:26:17 +0000
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
Subject: Re: [PATCH v2 04/24] arm64: Move MAIR_EL1_SET to asm/memory.h
Message-ID: <20201125132617.qf6vd752dtfasyi7@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
 <20201116204318.63987-5-dbrazdil@google.com>
 <87mtz85geh.wl-maz@kernel.org>
 <20201125103137.iml7mqpzhylldvqy@google.com>
 <e6c9184c6ee986d134625932b4fa8e89@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6c9184c6ee986d134625932b4fa8e89@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > +/*
> > > > + * Memory types available.
> > > > + *
> > > > + * IMPORTANT: MT_NORMAL must be index 0 since vm_get_page_prot() may 'or' in
> > > > + *	      the MT_NORMAL_TAGGED memory type for PROT_MTE mappings. Note
> > > > + *	      that protection_map[] only contains MT_NORMAL attributes.
> > > > + */
> > > > +#define MT_NORMAL		0
> > > > +#define MT_NORMAL_TAGGED	1
> > > > +#define MT_NORMAL_NC		2
> > > > +#define MT_NORMAL_WT		3
> > > > +#define MT_DEVICE_nGnRnE	4
> > > > +#define MT_DEVICE_nGnRE		5
> > > > +#define MT_DEVICE_GRE		6
> > > > +
> > > > +/*
> > > > + * Default MAIR_ELx. MT_NORMAL_TAGGED is initially mapped as Normal memory and
> > > > + * changed during __cpu_setup to Normal Tagged if the system supports MTE.
> > > > + */
> > > > +#define MAIR_ELx_SET							\
> > > > +	(MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRnE, MT_DEVICE_nGnRnE) |	\
> > > > +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_nGnRE, MT_DEVICE_nGnRE) |	\
> > > > +	 MAIR_ATTRIDX(MAIR_ATTR_DEVICE_GRE, MT_DEVICE_GRE) |		\
> > > > +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_NC, MT_NORMAL_NC) |		\
> > > > +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL) |			\
> > > > +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL_WT, MT_NORMAL_WT) |		\
> > > > +	 MAIR_ATTRIDX(MAIR_ATTR_NORMAL, MT_NORMAL_TAGGED))
> > > > +
> 
> Wait: You now have MAIR_ELx_SET defined at two locations. Surely that's
> one too many.
> 

Oops, told you I tried different things...

> > > >  /* id_aa64isar0 */
> > > >  #define ID_AA64ISAR0_RNDR_SHIFT		60
> > > >  #define ID_AA64ISAR0_TLB_SHIFT		56
> > > > @@ -992,6 +1020,7 @@
> > > >  /* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:0 */
> > > >  #define SYS_MPIDR_SAFE_VAL	(BIT(31))
> > > >
> > > > +#ifndef LINKER_SCRIPT
> > > 
> > > This is terribly ugly. Why is this included by the linker script? Does
> > > it actually define __ASSEMBLY__?
> > 
> > vmlinux.lds.S includes memory.h for PAGE_SIZE. And yes, linker scripts
> > are
> > built with this rule:
> > 
> >       cmd_cpp_lds_S = $(CPP) $(cpp_flags) -P -U$(ARCH) \
> > 	                     -D__ASSEMBLY__ -DLINKER_SCRIPT -o $@ $<
> > 
> > I tried a few things and wasn't completely happy with any of them. I
> > think in
> > the previous spin you suggested moving this constant to sysreg.h. That
> > works
> > too but sysreg.h seems to have only architecture constants, memory.h
> > about a
> > Linux-specific configuration, so I wanted to keep it here.
> 
> MAIR_ELx_SET isn't really Linux specific. Or rather, not more specific than
> any of the other configurations we have. On the other hand, the S1 MT_*
> stuff
> is totally arbitrary, and does fit in memory.h, together with the rest of
> the indexes for the memory types.
> 
> I came up with the following patch on top of this series that seems to
> compile without issue.

That seems to have an implicit dependency of sysreg.h on memory.h, doesn't it?
I had it the other way round initially. I also tried including memory.h in
sysreg.h. That creates a circular dependency mmdebug.h -> bug.h -> ... ->
sysreg.h -> memory.h -> mmdebug.h. Pretty annoying. I could try to fix that,
or create a new header file... :(

