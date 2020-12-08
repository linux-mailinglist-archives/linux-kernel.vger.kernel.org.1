Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EBF2D3429
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgLHUbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgLHUbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:31:48 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034F7C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:31:08 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id q16so18937599edv.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=REHA7EmuVy2412k5JBZlHnXSXCITuu5RQOyBaXf28o8=;
        b=DgXW4UZBGLPpi3lT4JKM6pKgI6mSt/dk7wglJitvXIYua+es3r0i9AvLN/NQeGaP5U
         0o39PUgticPGXS/fYZNwS8crslfcVJzP5XqpbflzbNi1WIPQQkwrD8L+PyURTqOQpZXK
         juYMowq4SdzpKYgYEWh9mjAqdMeSmT5AuzeomKp9OBkSwKn/nhgrCcRcloOpBNFyF+LS
         F7QTMAtYzWvCBhMO17hlxIie6tINGAutTZqZ+iA69roa3OxdwFqTXq3aWTLNOU3Nf25h
         h+HiI5SvMkOHNJE2debg9Vgm+45pfSNQ7dCEr+eKCAP0z5nl66gJpg6Khb1Qiev3/hZh
         EtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=REHA7EmuVy2412k5JBZlHnXSXCITuu5RQOyBaXf28o8=;
        b=ix4fCu61ZRvS3gYSmqx0lxt5JyPjADG5Y4u8kgaws4X8at4EPr/RrEnScLdT6KIsNU
         oir7uMEpDO/iPHQ4x6JkVhKmQgBKWevlwAjQKXIl5OqdGiwOLIwUbk2UDM4U1l7MmNky
         eE0h82c1O0+7B9hX4IFSmUvGcPW/g3jWyflchwG8zTfTRLrxEbEAO9GFvDWcxvn7H1Gv
         AXvj07BF4mt2vIJC/Psl7rJtKSMf9U+UVIAp1jC/Aoaq4S5F0V88/5EF/XHdZ9mhdEBD
         diF4UDhWS6jWr40BSJr093V6IizVpzzdahvabySs0bGSYHF+XzdnWcCffgL7d2bpQjsP
         49bg==
X-Gm-Message-State: AOAM532ARkvrrZ+DwU5Rzo+C9gHZe/LZCQ+ezW8NExA68ZaLSvdCCC5Q
        QIQBRIhtDysl0eMTd2FNRBxqV692DVnqaA==
X-Google-Smtp-Source: ABdhPJzMvjijXhKf6UwzlQgGLdXNiyElYjmteXjfB+clUMsCI8Qf7bumNkex70eiOtelbQWNt3aQ2A==
X-Received: by 2002:a5d:51d2:: with SMTP id n18mr19894485wrv.92.1607454888755;
        Tue, 08 Dec 2020 11:14:48 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:258e:cb26:cef:a620])
        by smtp.gmail.com with ESMTPSA id i16sm2846391wrx.89.2020.12.08.11.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 11:14:47 -0800 (PST)
Date:   Tue, 8 Dec 2020 19:14:47 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Tejun Heo <tj@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        Christoph Lameter <cl@linux.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4 00/26] Opt-in always-on nVHE hypervisor
Message-ID: <20201208191447.47idqf7n2v3hvrdg@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
 <160702322202.1501317.9696987088711766533.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160702322202.1501317.9696987088711766533.b4-ty@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Marc,

On Thu, Dec 03, 2020 at 07:23:19PM +0000, Marc Zyngier wrote:
> On Wed, 2 Dec 2020 18:40:56 +0000, David Brazdil wrote:
> > As we progress towards being able to keep guest state private to the
> > host running nVHE hypervisor, this series allows the hypervisor to
> > install itself on newly booted CPUs before the host is allowed to run
> > on them.
> > 
> > All functionality described below is opt-in, guarded by an early param
> > 'kvm-arm.mode=protected'. Future patches specific to the new protected
> > mode should be hidden behind the same param.
> > 
> > [...]
> 
> Applied to kvm-arm64/psci-relay, thanks!
> 
> Note that although I pushed it to -next, I still need people to
> eyeball it and give it some Acks. The commit-IDs below will
> thus change as I apply tags, if any.
> 

I'm looking at -next and I think the merge with Mark Rutland's el2_setup
refactor didn't go as planned.

The `#ifdef CONFIG_ARM64_VHE` section needs to cover everything between
init_el2 and init_el2_nvhe. Currently the code falls through into VHE init
when CONFIG_ARM64_VHE is not set.

Here's the snippet:

SYM_INNER_LABEL(init_el2, SYM_L_LOCAL)
#ifdef CONFIG_ARM64_VHE
	/*
	 * Check for VHE being present. x2 being non-zero indicates that we
	 * do have VHE, and that the kernel is intended to run at EL2.
	 */
	mrs	x2, id_aa64mmfr1_el1
	ubfx	x2, x2, #ID_AA64MMFR1_VHE_SHIFT, #4
	cbz	x2, init_el2_nvhe
#endif						// <--- THIS

	<... initialize VHE ...>
	msr	elr_el2, lr
	mov	w0, #BOOT_CPU_MODE_EL2
	eret
						// <--- NEEDS TO MOVE HERE
SYM_INNER_LABEL(init_el2_nvhe, SYM_L_LOCAL)
	<... initialize nVHE ...>

-David

