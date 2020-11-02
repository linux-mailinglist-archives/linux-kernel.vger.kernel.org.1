Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8292A28D2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 12:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbgKBLM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 06:12:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgKBLM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 06:12:57 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6141C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 03:12:57 -0800 (PST)
Received: from zn.tnic (p200300ec2f086a00ac0ac1fe147e3571.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:6a00:ac0a:c1fe:147e:3571])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 77B211EC03A0;
        Mon,  2 Nov 2020 12:12:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604315575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3ZYZroXKEKRRFpl1USQKUyYSlb1SYVCKd+VpPzBmBEc=;
        b=DymIQ/4Ix2ElAy/sqzE5xmMjMjVFN/gGt0vNn80T9tbXvInOcDqjcsAPjy9c8XZEGD1XLz
        zjaEe/ZJGkUUc8ZE9N4RCb3x0bMWS/De9YTSY/Q8Fp3Ccr1eYDwyROxNAMbzUMROo41pxL
        OnJFa00mbd7reXjCUSLUG5MjUFLk3Uw=
Date:   Mon, 2 Nov 2020 12:12:45 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Philippe Conde <conde.philippe@skynet.be>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mce: Enable additional error logging on certain
 Intel CPUs
Message-ID: <20201102111245.GA15392@zn.tnic>
References: <fcb21490-84a1-8b99-b494-3a6ac2a0e16a@skynet.be>
 <20201029100655.GA31903@zn.tnic>
 <20201029151518.GA23990@agluck-desk2.amr.corp.intel.com>
 <20201029194118.GC31903@zn.tnic>
 <87ft5wo8zn.fsf@nanos.tec.linutronix.de>
 <20201030091056.GA6532@zn.tnic>
 <20201030190400.GA13797@agluck-desk2.amr.corp.intel.com>
 <20201030190807.GA13884@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201030190807.GA13884@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 12:08:07PM -0700, Luck, Tony wrote:
> On Fri, Oct 30, 2020 at 12:04:03PM -0700, Luck, Tony wrote:
> 
> Bah, didn't notice this conversation didn't include LKML.
> 
> > The Xeon versions of Sandy Bridge, Ivy Bridge and Haswell support an
> > optional additional error logging mode which is enabled by an MSR.
> > 
> > Previously this mode was enabled from the mcelog(8) tool via /dev/cpu,
> > but the kernel is now very picky about which MSRs may be written. So
> > move the enabling into the kernel.
> > 
> > Suggested-by: Boris Petkov <bp@alien8.de>
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> > 
> > N.B. I don't have any of these old systems in my lab any more. So
> > this is untested :-(

I do:

# rdmsr 0x0000017f
2

Thx for doing this, queued.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
