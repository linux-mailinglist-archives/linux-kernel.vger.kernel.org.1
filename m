Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A236D28EFBA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 11:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389117AbgJOJ65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 05:58:57 -0400
Received: from mail.skyhub.de ([5.9.137.197]:32926 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389050AbgJOJ64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 05:58:56 -0400
Received: from zn.tnic (p200300ec2f0ed200d49a97be428f152e.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d200:d49a:97be:428f:152e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6EADA1EC0284;
        Thu, 15 Oct 2020 11:58:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602755935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=bCadd9tK8gSShkekeE0J7QRxwS0j21HAuFyf4Vequ78=;
        b=pEmD6u20b1YuVXEwX+6Uh97zHU1IJYfVz35VWb/rB2q0YvrWxvheEcv7V2DNO6U4DVLXC1
        HZF3AFb1ZbwRU6pjaI7fRpPH5/HoeUhMnTWK0st2lnVKB5g8CBROIPxI6Wh9Zh3wyRDdR9
        C1VqBKmQsvR0yYOakc/1VP44BHz8l9A=
Date:   Thu, 15 Oct 2020 11:58:51 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: Re: DPTF_POWER and DPTF_PCH_FIVR
Message-ID: <20201015095851.GB11838@zn.tnic>
References: <20201015095311.GA11838@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201015095311.GA11838@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 15, 2020 at 11:53:11AM +0200, Borislav Petkov wrote:
> Dudes,
> 
> what are those new symbols in Kconfig and why do they wanna get enabled
> on my box when doing oldconfig? Depends on X86? Really, that widespread?
> 
> The help text doesn't say why do I need this...

And that thing in sysfs:

"/sys/bus/platform/drivers/DPTF Platform Power"

has spaces in the name. What's going on?!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
