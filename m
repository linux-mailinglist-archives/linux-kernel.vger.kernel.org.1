Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D2142FB76C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404578AbhASKxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389212AbhASKlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:41:21 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0640DC061573
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 02:40:14 -0800 (PST)
Received: from zn.tnic (p200300ec2f0bca00c2aa0e949335efb7.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:ca00:c2aa:e94:9335:efb7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C19F1EC05DD;
        Tue, 19 Jan 2021 11:40:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1611052813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iDFwGIcQPnMopYu+OH7oLQlopHvKPf6mFKRQgATdpdE=;
        b=N/J3cbYK5bqF73UtFDywBSYyl/p0TMxFncjtfCSY216HieNkodQw0EDXvNM/3Be2fXwJTs
        /QaC6WCpGUj9ZpWggbugzctFuyhL8zLStaa9LI3KSmVqzsiZT0I/hqno+5c8xoifrcxPXG
        dbcwaov+hcV6OZVKPHsnM6oZoqTaem4=
Date:   Tue, 19 Jan 2021 11:40:07 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 06/19] perf/x86/intel/ds: Check insn_get_length()
 retval
Message-ID: <20210119104007.GE27433@zn.tnic>
References: <20201223174233.28638-1-bp@alien8.de>
 <20201223174233.28638-7-bp@alien8.de>
 <20210104131919.GN3021@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210104131919.GN3021@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 04, 2021 at 02:19:19PM +0100, Peter Zijlstra wrote:
> Do we really still need the !insn.length? That is, it *should* be
> impossible to not fail insn_get_length() and still have a 0 length,
> seeing how x86 doesn't have 0 length instructions.

I was responding to the "doubly important" thing in the comment scarying
me about an infinite loop and thus left the length check in, in case
the insn decoder would have a bug and return success but still have
insn.length 0.

With the length check the endless loop won't happen but let's be
brave here ... :-)

So removed.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
