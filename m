Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8980626A4D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 14:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgIOMPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 08:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgIOMOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 08:14:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58352C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 05:14:41 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0e420013f677fd615296f5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:4200:13f6:77fd:6152:96f5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5C4741EC0246;
        Tue, 15 Sep 2020 14:14:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1600172079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sf+N3DjTXNX+/Y1SaTgc6vaD7NslOjhQyZHJsNOcXA4=;
        b=a6HjlCYhilz99tMpcAAU2I6Mg1lgwXRFwlFGXnQ48126gCij4K0uGS0R6QVMViXHOFRtln
        l+Bwm+NUBQourmcBkizyzwbZKyM+Ldw7s/yoGC8XWzRvka32xPj79isBKuNXp7t6q+vme4
        zvF8N3Pz8SDhJW46P3keQcZnJeoSidw=
Date:   Tue, 15 Sep 2020 14:14:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     peterz@infradead.org,
        Abhishek Jaiantilal <abhishek.jaiantilal@colorado.edu>,
        raininja <daniel.mclellan@gmail.com>,
        Richard Hull <rm_hull@yahoo.co.uk>
Cc:     Roman Stingler <roman.stingler@symvaro.com>, x86@kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: msr: Write to unrecognized MSR 0x38d by i7z
Message-ID: <20200915121433.GF14436@zn.tnic>
References: <c38cf5d6-1b6f-7b21-0179-c2849f75e8de@symvaro.com>
 <20200915111012.GZ2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200915111012.GZ2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 01:10:12PM +0200, peterz@infradead.org wrote:
> On Tue, Sep 15, 2020 at 12:59:53PM +0200, Roman Stingler wrote:
> > Hi, when I open i7z I get following message in dmesg
> > 
> > [17548.541965] msr: Write to unrecognized MSR 0x38f by i7z
> >                Please report to x86@kernel.org
> > [17548.542030] msr: Write to unrecognized MSR 0x38d by i7z
> >                Please report to x86@kernel.org
> 
> That's PERF_GLOBAL_CTRL and PERF_FIXED_CTR_CTRL, userspace doesn't get
> to prod at those. Use the perf syscall.

Adding the authors/contributors of/to i7z.

Guys please consider converting your tool off of straight poking at MSRs
and to using proper kernel interfaces. If there are none for your use
case, feel free to define some and we'll help review them and get them
upstream. Poking at MSRs behind the kernel's back is a very very bad
idea.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
