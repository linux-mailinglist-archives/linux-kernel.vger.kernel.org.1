Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD592B6D57
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbgKQS2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:28:10 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54698 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgKQS2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:28:10 -0500
Received: from zn.tnic (p200300ec2f101300378e6ae0a1a779ec.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:1300:378e:6ae0:a1a7:79ec])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E864D1EC0402;
        Tue, 17 Nov 2020 19:28:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605637689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Iv/oL4ZsWEgCGT0FNKjRrZW4WXNcn8Mky6gXuPvvyGE=;
        b=l9Od5R41YU4mUUa8RhDTgtegthh9VlqpQA2w1err2WGyBufdx+6aOD8Rsyt71j1rfRiiqH
        dsioFyo0Bg/PZgPkIuPg9qn+hxAggQy4i/z1c82OYk+h+ouxN2xKUwQhJgT7XvjmO0RB1T
        LVjhaj10H/o7WaYNfwlUdXhqitnnxDQ=
Date:   Tue, 17 Nov 2020 19:28:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        thomas.lendacky@amd.com, jroedel@suse.de, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, junaids@google.com, oweisse@google.com,
        rppt@linux.vnet.ibm.com, graf@amazon.de, mgross@linux.intel.com,
        kuzuno@gmail.com
Subject: Re: [RFC][PATCH v2 00/21] x86/pti: Defer CR3 switch to C code
Message-ID: <20201117182809.GK5719@zn.tnic>
References: <20201116144757.1920077-1-alexandre.chartre@oracle.com>
 <20201116201711.GE1131@zn.tnic>
 <44a88648-738a-4a4b-9c25-6b70000e037c@oracle.com>
 <20201117165539.GG5719@zn.tnic>
 <890f6b7e-a268-2257-edcb-5eacc7db3d8e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <890f6b7e-a268-2257-edcb-5eacc7db3d8e@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 07:12:07PM +0100, Alexandre Chartre wrote:
> Yes. L1TF/MDS allow some inter cpu-thread attacks which are not mitigated at
> the moment. In particular, this allows a guest VM to attack another guest VM
> or the host kernel running on a sibling cpu-thread. Core Scheduling will
> mitigate the guest-to-guest attack but not the guest-to-host attack.

I see in vmx_vcpu_enter_exit():

        /* L1D Flush includes CPU buffer clear to mitigate MDS */
        if (static_branch_unlikely(&vmx_l1d_should_flush))
                vmx_l1d_flush(vcpu);
        else if (static_branch_unlikely(&mds_user_clear))
                mds_clear_cpu_buffers();

Is that not enough?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
