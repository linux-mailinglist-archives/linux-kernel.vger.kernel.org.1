Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9142A3322
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 19:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbgKBSjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 13:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKBSjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:39:45 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001A8C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 10:39:44 -0800 (PST)
Received: from zn.tnic (p200300ec2f086a00fa513bf50e741c79.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:6a00:fa51:3bf5:e74:1c79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC75C1EC03E3;
        Mon,  2 Nov 2020 19:39:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1604342383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FLP70qoh5kAmrF/6KuJfhAOFXzyl2bzl5a8ANq8xUcw=;
        b=apXaaFrUnh9TxIUo+HZFvSLhb3h+/yifgZDEqYrXVDGaI+Oj34+jd5NXyLS0wiUPLvEuop
        a5LJAvXx28+fzLzZvl2GXD1iSRrg/OoJTjk9pT2OJZbBbwjkqjyHuh5Qjf/RvdqlVkDQ8d
        YtGk9YxD+OjkYWC5m7nkO1RAG3N3qL8=
Date:   Mon, 2 Nov 2020 19:39:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: How should we handle illegal task FPU state?
Message-ID: <20201102183938.GA10749@zn.tnic>
References: <CALCETrXENKF9iVXaQrQcbgFq7fksC2pGz86tr9YGgDdeP3uR-Q@mail.gmail.com>
 <71682bce-a925-d3bd-18ef-d2e4eb8ebc8e@intel.com>
 <20201001205857.GH7474@linux.intel.com>
 <f1835c1f-31bc-16a9-ffa5-896b1aeb895a@intel.com>
 <CALCETrWswWdgXO2J6nRjXW_4JRsK1TzzVZ62EDsF+d_79O+6Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrWswWdgXO2J6nRjXW_4JRsK1TzzVZ62EDsF+d_79O+6Sw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 03:04:48PM -0700, Andy Lutomirski wrote:
> On Thu, Oct 1, 2020 at 2:50 PM Dave Hansen <dave.hansen@intel.com> wrote:
> > I'm not sure we should ever keep running userspace after an XRSTOR*
> > failure.  For MPX, this might have provided a nice, additional vector
> > for an attacker to turn off MPX.  Same for pkeys if we didn't correctly
> > differentiate between the hardware init state versus the "software init"
> > state that we keep in init_task.
> >
> > What's the advantage of letting userspace keep running after we init its
> > state?  That it _might_ be able to recover?
> 
> I suppose we can kill userspace and change that behavior only if
> someone complains.  I still think it would be polite to try to dump
> core, but that could be tricky with the current code structure.  I'll
> try to whip up a patch.  Maybe I'll add a debugfs file to trash MXCSR
> for testing.

Just for the record, I like this: safe and simple. We can always do
smarter shenanigans later, if at all needed, that is.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
