Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4F22B9457
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgKSOPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:15:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:42512 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbgKSOPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:15:20 -0500
Received: from zn.tnic (p200300ec2f0caf00568863aa7ed02326.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:af00:5688:63aa:7ed0:2326])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 71F171EC04D1;
        Thu, 19 Nov 2020 15:15:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1605795318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ekf+AUaJ3paDxpFiCZgS74VrJkyt6cyk/9NBpR/fvyU=;
        b=MV5CpmASljlCO/YUmy8/kf5qcI6xkATuS2O4eC3ZQj5p6yYsvQfVuwzXod7Rr28soYo+vm
        KBmiQ6VLJJHgwtAp357XiE4VCK4f0OkctgXHYFxueSARLR8U8cOddqvZ9j3yl1mizcKXpO
        7Onh/kRnf+CmvoYBWvMVhUjxEN2PV5g=
Date:   Thu, 19 Nov 2020 15:15:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nivedita@alum.mit.edu,
        thomas.lendacky@amd.com, yazen.ghannam@amd.com, wei.huang2@amd.com
Subject: Re: [RFC PATCH v3] tools/x86: add kcpuid tool to show raw CPU
 features
Message-ID: <20201119141512.GB3769@zn.tnic>
References: <1603344083-100742-1-git-send-email-feng.tang@intel.com>
 <20201118191529.GN7472@zn.tnic>
 <20201119072055.GA112648@shbuild999.sh.intel.com>
 <20201119091815.GA3769@zn.tnic>
 <20201119135010.GC112648@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201119135010.GC112648@shbuild999.sh.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 09:50:10PM +0800, Feng Tang wrote:
> That's really odd. I tried on 3 baremetal machines: one Skylake NUC device,
> one Xeon E5-2699 and one Xeon E5-2680.

Ah, sorry, not virt, virt is 0x4000_0000. Yeah, I remember now. It is
function 4 which AMD doesn't implement and I'm running this on AMD:

$ cpuid -1r
CPU:
   0x00000000 0x00: eax=0x0000000d ebx=0x68747541 ecx=0x444d4163 edx=0x69746e65
   0x00000001 0x00: eax=0x00800f82 ebx=0x0c100800 ecx=0x7ed8320b edx=0x178bfbff
   0x00000002 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00000000
   0x00000003 0x00: eax=0x00000000 ebx=0x00000000 ecx=0x00000000 edx=0x00000000

<-- no function 4.

   0x00000005 0x00: eax=0x00000040 ebx=0x00000040 ecx=0x00000003 edx=0x00000011
   ...

That's why.  :-)

Btw, there are other funny ranges on Intel:

./cpuid -1r
CPU:
   0x20000000 0x00: eax=0x00000000 ebx=0x00000001 ecx=0x00000001 edx=0x00000000

That one has 2 bits set.

   0x80860000 0x00: eax=0x00000000 ebx=0x00000001 ecx=0x00000001 edx=0x00000000
   0xc0000000 0x00: eax=0x00000000 ebx=0x00000001 ecx=0x00000001 edx=0x00000000

And those too.

Fun.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
