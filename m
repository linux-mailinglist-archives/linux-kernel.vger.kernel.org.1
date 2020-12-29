Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E16F2E7502
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 23:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgL2WeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 17:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgL2WeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 17:34:15 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB0DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 14:33:35 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z12so2144755pjn.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 14:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GkyE8LbEEVHxy2CefSeYkkl16YrbDYCmT2Fd0SUPzw4=;
        b=UVBWYgTKbE2/khVyuxEmmeEnea2wHbJ8CU/QZoRuDgulV+M8EF/8sKV5ArBqZbJ2tU
         PBVlvmoXOYCTCenfdsbD6fZ/AgsdjkWjGp89pZI9Ujkqu+TBnRpfeII2OjeUNZmTt03P
         BwlSoalZ7f09msNNCnkVTYp2yx+XxuNu9B1JM0WI83E3sEA7B+nnTzbPeCVikkTqUC8p
         N7L1AEcPVJi7CCzajME8xn82q6yMacLJir4nKLqTNzseYBPiFMnu1RvisrnTzlkH/1w1
         Qm1tQMItkc05HqXNvcmHCCRRfHdz/edzxWlOBL9cJs3vmvGJ5GEZv9jXK28KX9iESuSB
         qKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GkyE8LbEEVHxy2CefSeYkkl16YrbDYCmT2Fd0SUPzw4=;
        b=h02FUqRoSG5Asr0dmLkK1GGU9puF8egwfzPrOJ4DFvLUi2bFu8KzAHCoYM8cMdayuZ
         Gi1bgoCuiaLQU/zNa0GtDodzvRGvltszeTopxGBZ0AsjnnXq5Y7YVYl6mf+ZzudUP5t4
         M7PwCNYOkVzmzlAsIyRFxfJ0N71wLYu3/ni2Ik+s0sBDzDaStq8haVqOXEqYcZHuXHVP
         DzOXofpZiJChPl7k1Nq9MSrta2+N2VRwv0n3KXhi28iuY8RFQvn5VaSFJeMt3TEM1UAV
         EDOsg2u7klcYvioO+tqOMwTq9WFAraDDjkOF1fraxsjYphh54htUTqgJPrgeUUNRm0py
         me8Q==
X-Gm-Message-State: AOAM530Fq7bvfN0tYk2yZAkhOKQ6ARzeHPF55y/rBnOsCP0Ts++lC7cv
        ONRFyw+VmTxXtiiKE7Czqns=
X-Google-Smtp-Source: ABdhPJzWfsuoOOQdYJzhN3RMoSpW8gv2xP1t3iR2LTYbbXm4GATIPF4MTrOww6Wg8mRqcVYYcs14Nw==
X-Received: by 2002:a17:90a:c20b:: with SMTP id e11mr5784720pjt.43.1609281214864;
        Tue, 29 Dec 2020 14:33:34 -0800 (PST)
Received: from Ryzen-9-3900X.localdomain (ip68-104-204-241.ph.ph.cox.net. [68.104.204.241])
        by smtp.gmail.com with ESMTPSA id 77sm41028915pfx.156.2020.12.29.14.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Dec 2020 14:33:34 -0800 (PST)
Date:   Tue, 29 Dec 2020 15:33:31 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Fix section mismatches around
 hyp_cpu_pm_{init,exit}
Message-ID: <20201229223331.GA212@Ryzen-9-3900X.localdomain>
References: <20201229214336.4098955-1-natechancellor@gmail.com>
 <49e9d2e2e7103c49882b54c18c567667@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49e9d2e2e7103c49882b54c18c567667@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 10:11:07PM +0000, Marc Zyngier wrote:
> On 2020-12-29 21:43, Nathan Chancellor wrote:
> > Commit fa8c3d65538a ("KVM: arm64: Keep nVHE EL2 vector installed")
> > inadvertently changed clang's inlining decisions around
> > hyp_cpu_pm_{init,exit}, causing the following section mismatch warnings:
> > 
> > WARNING: modpost: vmlinux.o(.text+0x95c6c): Section mismatch in
> > reference from the function kvm_arch_init() to the function
> > .init.text:hyp_cpu_pm_exit()
> > The function kvm_arch_init() references
> > the function __init hyp_cpu_pm_exit().
> > This is often because kvm_arch_init lacks a __init
> > annotation or the annotation of hyp_cpu_pm_exit is wrong.
> > 
> > WARNING: modpost: vmlinux.o(.text+0x97054): Section mismatch in
> > reference from the function init_subsystems() to the function
> > .init.text:hyp_cpu_pm_init()
> > The function init_subsystems() references
> > the function __init hyp_cpu_pm_init().
> > This is often because init_subsystems lacks a __init
> > annotation or the annotation of hyp_cpu_pm_init is wrong.
> > 
> > Remove the __init annotation so that there are no warnings regardless of
> > how functions are inlined.
> > 
> > Fixes: 1fcf7ce0c602 ("arm: kvm: implement CPU PM notifier")
> > Fixes: 06a71a24bae5 ("arm64: KVM: unregister notifiers in hyp mode
> > teardown path")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1230
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> Hi Nathan,
> 
> Already posted[1] last week.
> 
> Thanks,
> 
>         M.
> 
> [1] htps://lore.kernel.org/r/20201223120854.255347-1-maz@kernel.org
> -- 
> Jazz is not dead. It just smells funny...

Sorry for the duplicate, I am usually good at spotting that :(

Cheers,
Nathan
