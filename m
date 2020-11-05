Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B64922A7D5E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 12:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbgKELmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 06:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbgKELmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 06:42:13 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4319C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 03:42:12 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id k18so1282136wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 03:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UlBOV3zJkzSNJ5Hx+un+t0ofIXF1FY2bdal7ui3TmrQ=;
        b=JQCvVnUyDY++8EPAK3PltIL4kAc552pzdGG62TSPCpuoWv6lRkoZK00Rj8Kg/Thrlx
         ciFqHvXXCZo2oR816dybbQ3A721s9DtYQQV8egFN9QUS/rilnHKiLgo2g2U9NHvdyqNw
         UcJXT3oVXmPSmJQ+HDdFLPd3rL04HpUr8PNt4UJoUSsIrf/Yo7BIx1Xw9JL3d3uVOj5m
         9EF74NYdK6N/pIdrNVUypnwtr/5CWHMM0IUC1I5Ms5WFb6ocxYElyWwLaBekxm/FN3a1
         XIOMLBHXLr60H2VD66l72onza4y6FSMASR2GhtcrYmeNwYGtb8CpQ1GANwwrhUTIr57u
         VszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UlBOV3zJkzSNJ5Hx+un+t0ofIXF1FY2bdal7ui3TmrQ=;
        b=c9t5dKUC/3cbdDjWHNYftwOnSzVdvwgyOWBfy7DmIcl6hgC2MdbhfNZ5Ss8DIiCsAy
         VORK6idoGrOMCpbx4+VLn6PQu8WxelgMlKBNLXhxbLvLQ8AAJyb4PaCcB2zm/pU9wtR1
         PJUDuDL+p/n7BXHV/dJqDkzixTEnWxqCpBKaixBo9HkvWMTu/0K7svbXdhVPB/0ARQ6E
         JStDzG2zweAFLnNn/r7M+XZYJZMnvcJW9/cJzVU/txluGhFVXtMNftPs3FWGwQMdhSAF
         5blP85KOM/fpzTVZGvz+zn4mvCZZP11zeI4EmQiTdzKoJ3Sjb3m7PbOESx2or2kRPMfN
         Lz0w==
X-Gm-Message-State: AOAM532k8gcSMsM+RSP7Jyy2imxfeCHmY8eo0EWy7uOXnNdBv/E8d/b2
        M/L+52LpHc3ZThc5+xjWojOvNQ==
X-Google-Smtp-Source: ABdhPJxvXeNF5tLA8W/eK+ie2mfT2/1jb7zbngwpSOYKP34eOhwP+mavGJd683gYWozytkAtoWfmnA==
X-Received: by 2002:a1c:f417:: with SMTP id z23mr2181938wma.57.1604576531373;
        Thu, 05 Nov 2020 03:42:11 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:64da:f1d0:8ee7:66f5])
        by smtp.gmail.com with ESMTPSA id n6sm2135503wrj.60.2020.11.05.03.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 03:42:10 -0800 (PST)
Date:   Thu, 5 Nov 2020 11:42:09 +0000
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
        Andrew Scull <ascull@google.com>, kernel-team@android.com
Subject: Re: [RFC PATCH 18/26] kvm: arm64: Intercept PSCI_CPU_OFF host SMC
 calls
Message-ID: <20201105114209.7d3tm2w26r5mzgao@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
 <20201104183630.27513-19-dbrazdil@google.com>
 <0ebade5427b2d9a020cd33da64cb9d13@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ebade5427b2d9a020cd33da64cb9d13@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

> > +static DEFINE_PER_CPU(hyp_spinlock_t, psci_cpu_lock);
> >  DEFINE_PER_CPU(enum kvm_nvhe_psci_state, psci_cpu_state);
> > 
> >  static u64 get_psci_func_id(struct kvm_cpu_context *host_ctxt)
> > @@ -76,9 +79,32 @@ static __noreturn unsigned long
> > psci_forward_noreturn(struct kvm_cpu_context *ho
> >  	hyp_panic(); /* unreachable */
> >  }
> > 
> > +static int psci_cpu_off(u64 func_id, struct kvm_cpu_context *host_ctxt)
> > +{
> > +	hyp_spinlock_t *cpu_lock = this_cpu_ptr(&psci_cpu_lock);
> > +	enum kvm_nvhe_psci_state *cpu_power = this_cpu_ptr(&psci_cpu_state);
> > +	u32 power_state = (u32)host_ctxt->regs.regs[1];
> > +	int ret;
> > +
> > +	/* Change the recorded state to OFF before forwarding the call. */
> > +	hyp_spin_lock(cpu_lock);
> > +	*cpu_power = KVM_NVHE_PSCI_CPU_OFF;
> > +	hyp_spin_unlock(cpu_lock);
> 
> So at this point, another CPU can observe the vcpu being "off", and issue
> a PSCI_ON, which may result in an "already on". I'm not sure this is an
> actual issue, but it is worth documenting.
> 
> What is definitely missing is a rational about *why* we need to track the
> state of the vcpus. I naively imagined that we could directly proxy the
> PSCI calls to EL3, only repainting PC for PSCI_ON.

I think I've solved that particular problem by *not* using cpu_power for
AFFINITY_INFO. It's used only for resolving the race between CPU_ON/OFF.
You are, however, right that perhaps that is not needed either and resolving
the race should be left to the host. In that case the hypervisor would be just
repainting the CPU_ON/SUSPEND args, as you said.

