Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A832201D5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 03:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgGOB0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 21:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgGOB0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 21:26:33 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEE7C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:26:33 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k4so711506pld.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QcW6VJ7a6fNZ0PIZsgk18a6NvkkANLMdBx3aJx5n2P8=;
        b=LermMRMBuE4iPiQWchn6+Y5pFfVd5MDVGRmaF3jnjgwTdKR/jyEitX2LJuReMi4mm9
         72HL0CcXQKM56+FAnZYuVZPmiR/qQ66O5ltrce83lFbfsyOoE/4E5/KWjnK6n0t8DbHo
         ObrL33Mhy4WP8s4TGuuj8FnCo23Gl7p8aCzuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QcW6VJ7a6fNZ0PIZsgk18a6NvkkANLMdBx3aJx5n2P8=;
        b=QmdPHH3y1j2QnWsxbdyG2W12/V+nI7xSTEkv74ZdM4up10OCYJHJyWTcGEgmX033Wo
         YxliSgldC1fi4Z+WjWjHFRta1n9Gbz+CTUnPN06SLq96fYnhZNoUR5e3uyxA8J5DT97N
         gB9Swk+nmdPVRgcNZagpFG7aG32PdhirWd5am6wdGliFTVI05dAzQtemmZP1HOkkL443
         LGH8YncImzB5M5vllBR7zh4unu6EHtH/6EMkc2zdZRgTkwmf9EOm/IJ2wMoS3aLKij5p
         RN+BZ15GdgAKeL9ybYVd53okSpJMY64Uf3w2Fb06eLRrvrgxWBbVCg1MfUMA5nA07cXl
         gPQw==
X-Gm-Message-State: AOAM530qfGbzwGFlbTmlvDb/Q9grka09IGYyFTpyxM0vBlFYzw7eNuHp
        iYAdVkCFKd7bPAe4rvSoVdJIkw==
X-Google-Smtp-Source: ABdhPJynXpmsAypVInC5Gh/ht68hKi/BQl06Nmv62PrADjPwEOczh3gjFDiDHlExfm6gJO53XV+6qQ==
X-Received: by 2002:a17:90a:2e85:: with SMTP id r5mr7576594pjd.232.1594776393220;
        Tue, 14 Jul 2020 18:26:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cl17sm250287pjb.50.2020.07.14.18.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 18:26:32 -0700 (PDT)
Date:   Tue, 14 Jul 2020 18:26:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 28/75] x86/idt: Split idt_data setup out of
 set_intr_gate()
Message-ID: <202007141826.8BA5C1E@keescook>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-29-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714120917.11253-29-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 02:08:30PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The code to setup idt_data is needed for early exception handling, but
> set_intr_gate() can't be used that early because it has pv-ops in its
> code path, which don't work that early.
> 
> Split out the idt_data initialization part from set_intr_gate() so
> that it can be used separatly.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
