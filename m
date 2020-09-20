Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077522712E8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 10:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgITIgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 04:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgITIgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 04:36:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9B0C061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 01:36:36 -0700 (PDT)
Received: from zn.tnic (p200300ec2f295d00612687364c3aa3ce.dip0.t-ipconnect.de [IPv6:2003:ec:2f29:5d00:6126:8736:4c3a:a3ce])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 72B5C1EC03EA;
        Sun, 20 Sep 2020 10:36:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600590993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=z4ArdGsHu1lItnm9BSdt7a+gByFQ8BVlRUkfS9dAFIE=;
        b=XH0cQGO06+bcmPyHdrCM5/B7LNFk+BnM1qu+MH6F3fTsKyBFnwhLzoJ98sxMJNyaM0TnEl
        B2MdaL8IBlq4svxxvfz+W4W68BwoUeJ8W0m3+vZ80uieF8BfC8Wax4LGAm6BjI1ViiSqKX
        nLy4S5fAbU7nCIcV20PFdCpH0z5icA4=
Date:   Sun, 20 Sep 2020 10:36:26 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Hommey <mh@glandium.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: Delay BSP init until after FPU initialization
Message-ID: <20200920083626.GA7473@zn.tnic>
References: <20200920010310.10961-1-mh@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200920010310.10961-1-mh@glandium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 10:03:10AM +0900, Mike Hommey wrote:
> FPU initialization handles the clearcpuid command line argument. If it
> comes after BSP init, clearcpuid cannot be used to disable features that
> trigger some parts of the BSP init code.
> 
> Signed-off-by: Mike Hommey <mh@glandium.org>
> ---
>  arch/x86/kernel/cpu/common.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> I was trying to use clearcpuid=440 to disable X86_FEATURES_AMD_SSBD to
> reproduce the behavior that happens on Zen/Zen+ on a Zen2 machine, but
> that didn't work because the command line is handled after the setup for
> X86_FEATURE_LS_CFG_SSBD.
> 
> I tought about either moving the command line handling earlier, but it
> seems there wasn't a specific reason for BSP init being earlier than FPU
> initialization so I went with reordering those instead.

Our boot order is fragile and the functionality in
fpu__init_parse_early_param() which does the clearcpuid= parsing should be
independent from FPU, as your use case shows.

So I'd prefer if you moved that function perhaps to right after the call

  setup_force_cpu_cap(X86_FEATURE_CPUID);

in early_identify_cpu() and renamed it to something generic instead.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
