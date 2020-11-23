Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18E12C0E40
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 15:59:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388360AbgKWOyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 09:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732043AbgKWOyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 09:54:25 -0500
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AB0C061A4D
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:54:25 -0800 (PST)
Received: by mail-oo1-xc42.google.com with SMTP id r11so3990497oos.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 06:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ypQOivTTwdFzb+/3Z+R/AYhQITc/BOXMPX6lQujmA4Y=;
        b=UboGT20Ox8squh3d2ZnQggVw2BtXqKOdT/s+tMz0g3csU8VHrONyW5B1YMIwVnvOpJ
         BVhxs2al+NwQ7/SMb4AlCm1HMMGJIkJ4dUHbEsfPSfhv/PIufUJTEUVTBAPFNlUKZ9Zi
         VKFmopTXQh23vKUrupe0vcmMB14nl3Hn7cotKcM8aBbzk456BuyKe5yx9hTMYsX63paI
         4j7Ui6K4z4tm29cT38tR4eWypwKe4Xidf2ELMd1Qpxa2/nRlkTKR0TWiestlDZlqI08W
         sKPIQQJFrEgp6sIsBBB9itZyqPLE01pGzbEgFzuhnLBxKeAzPwL09o/fP2akKmeTbh+d
         TzSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ypQOivTTwdFzb+/3Z+R/AYhQITc/BOXMPX6lQujmA4Y=;
        b=nThiudDII45sz68x89u5pjyfZ+XylSL4l/srlJzvralQPHOf5hq75iXTi5X4vNzWvZ
         2BR1a4HrymIzvELka6I2P05anvBZeF4e1exwmHfKExEMFlrMexasUxq1Uh2dAOPpxQV3
         RWPlvKKRlZav57c6pA/M6brBNauIr8zXOPuUS4suGhc4bHfIM93yvTwlM9ARP7z6E/qF
         /WpzZF/r286C/U72HGQL0T5Y6VQZ7BNAwopNjNoZTXctrafhJKc2ift1fHwmmMeQHqD6
         lqf32WwFpCMLlOZo3aCyT5kDaiXxbEasEvzqPpim6uV4Qr21ohr0/fsY1XNUYyLOCJyF
         QZAA==
X-Gm-Message-State: AOAM530PCqYFXkM+uDSNU1xdEkiWyVIj1WdHYXgPlcQBnk4JbJblJJn4
        HxrrdSEj41y7aw7YXQkbmUZekA==
X-Google-Smtp-Source: ABdhPJzgVQxYNSqFrGNwH41jxDIJClFraR7USL+/G1e6AcGi818QPZSMAXsn1Sq3067Whhx8WgkjEw==
X-Received: by 2002:a4a:eac1:: with SMTP id s1mr23273490ooh.15.1606143264324;
        Mon, 23 Nov 2020 06:54:24 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:acac:b2ef:c7d:fd8a])
        by smtp.gmail.com with ESMTPSA id 43sm6858710otf.28.2020.11.23.06.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 06:54:23 -0800 (PST)
Date:   Mon, 23 Nov 2020 14:54:20 +0000
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
Subject: Re: [RFC PATCH 09/27] KVM: arm64: Allow using kvm_nvhe_sym() in hyp
 code
Message-ID: <20201123145420.hjl24xp6p2nn26u2@google.com>
References: <20201117181607.1761516-1-qperret@google.com>
 <20201117181607.1761516-10-qperret@google.com>
 <20201123125723.4mnodg3tnal4q4v2@google.com>
 <20201123140250.GB490744@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201123140250.GB490744@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 02:02:50PM +0000, 'Quentin Perret' via kernel-team wrote:
> On Monday 23 Nov 2020 at 12:57:23 (+0000), David Brazdil wrote:
> > > diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> > > index 882eb383bd75..391cf6753a13 100644
> > > --- a/arch/arm64/kvm/arm.c
> > > +++ b/arch/arm64/kvm/arm.c
> > > @@ -1369,7 +1369,7 @@ static void cpu_prepare_hyp_mode(int cpu)
> > >  
> > >  	params->vector_hyp_va = kern_hyp_va((unsigned long)kvm_ksym_ref(__kvm_hyp_host_vector));
> > >  	params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
> > > -	params->entry_hyp_va = kern_hyp_va((unsigned long)kvm_ksym_ref(__kvm_hyp_psci_cpu_entry));
> > > +	params->entry_hyp_va = kern_hyp_va((unsigned long)kvm_ksym_ref_nvhe(__kvm_hyp_psci_cpu_entry));
> > 
> > Why is this change needed?
> 
> You mean this line specifically or the whole __kvm_hyp_psci_cpu_entry
> thing?
> 
> For the latter, it is to avoid having the compiler complain about
> __kvm_hyp_psci_cpu_entry being re-defined as a different symbol. If
> there is a better way to solve this problem I'm happy to change it -- I
> must admit I got a little confused with the namespacing along the way.

Yeah, we do need a more robust approach. It's getting out of control.

> 
> Thanks,
> Quentin
> 
> -- 
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 
