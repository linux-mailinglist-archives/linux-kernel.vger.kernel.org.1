Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC6C926C146
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 11:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgIPJ7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 05:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgIPJ7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 05:59:45 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C69C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 02:59:44 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c3e00d3c4597872eea104.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:3e00:d3c4:5978:72ee:a104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CE78B1EC03A0;
        Wed, 16 Sep 2020 11:59:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600250381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=o+kCnCev0H+XIjxPkopyG8aefMR2wGzKgSJQ0+zMG4w=;
        b=dEsDwL6K4CUFj7WzIi9se4YNb+Z0S5vG2j9f32zA7ya7F/NA584SRq7ALvluykqsEuSHkc
        vdKIZYhkByEoe9ADEAgwHqyp5V9cjHOe2i9gYK7wi9blxZRd2IxgyH1rmg0McQSM4LUYMu
        xCf1/L2HztlKhp1Xe8Kee/tjK8Sybw0=
Date:   Wed, 16 Sep 2020 11:59:35 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] x86/mce: Add _ASM_EXTABLE_CPY for copy user access
Message-ID: <20200916095935.GD2643@zn.tnic>
References: <20200908175519.14223-1-tony.luck@intel.com>
 <20200908175519.14223-5-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908175519.14223-5-tony.luck@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 10:55:15AM -0700, Tony Luck wrote:
> diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
> index cf503824529c..6ea141f91163 100644
> --- a/arch/x86/include/asm/mce.h
> +++ b/arch/x86/include/asm/mce.h
> @@ -137,6 +137,7 @@
>  #define	MCE_HANDLED_EDAC	BIT_ULL(4)
>  #define	MCE_HANDLED_MCELOG	BIT_ULL(5)
>  #define MCE_IN_KERNEL_RECOV	BIT_ULL(6)
> +#define MCE_IN_KERNEL_COPYIN	BIT_ULL(7)

That flag needs a comment explaining what it is. And you can do
MCE_IN_KERNEL_RECOV, while you're at it, there's a nice comment above
its use in do_machine_check which you could use.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
