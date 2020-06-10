Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C102C1F5D42
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 22:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgFJUfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 16:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbgFJUfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:35:46 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24155C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 13:35:46 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c19007c73a090adc89193.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:1900:7c73:a090:adc8:9193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 49E3C1EC02AC;
        Wed, 10 Jun 2020 22:35:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591821344;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=V0ulm0L6ba0Bx/c3Wx03Auva+CuUvMkvz9rzbSZmOtg=;
        b=jErH93bSYG7vueCYwcFnyBlQ/vfdS1WV5KxU+Ts7QABXjULkXakH7AOz8zPxtGBGgbL5KE
        oMRfNYAvKt58Ziq++7jORxfBJKjIjPcUGPmFNNWlA20TvMxFgPzLfHmSobeHfS0wl5oWzO
        e9iHioASB6Ghx2WA1flXVRFYMSYh+SM=
Date:   Wed, 10 Jun 2020 22:35:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kyung Min Park <kyung.min.park@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, gregkh@linuxfoundation.org,
        ak@linux.intel.com, dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, ricardo.neri@intel.com
Subject: Re: [RFC PATCH 0/3] Add Documentation for /proc/cpuinfo flags
Message-ID: <20200610203537.GT14118@zn.tnic>
References: <20200610200701.16757-1-kyung.min.park@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200610200701.16757-1-kyung.min.park@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 01:06:58PM -0700, Kyung Min Park wrote:
> Include two instances of features for which there are not implemented
> use cases in the kernel.
> 
> Patch 1 creates a new documentation for /proc/cpuinfo flags bits.
> Patch 2 adds X86_FEATURE_SERIALIZE.
> Patch 3 adds X86_FEATURE_TSXLDTRK.
> 
> This RFC series has been reviewed by Dave Hansen.

Yeah, and he and I talked about this on IRC. If you really want to dump
CPUID to see what's there, we should do a userspace tool in tools/ or
even use the ones which are already out there: x86info, cpuid, ...

Just adding X86_FEATURE_* flags without usage in the kernel makes no
sense and will cause unnecessary bloat and doesn't help one bit because
userspace simply calls CPUID directly.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
