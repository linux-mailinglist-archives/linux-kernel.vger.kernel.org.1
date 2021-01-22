Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC0130023A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 12:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbhAVL6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 06:58:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:50684 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbhAVK5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 05:57:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 52E83AF5B;
        Fri, 22 Jan 2021 10:56:32 +0000 (UTC)
Date:   Fri, 22 Jan 2021 11:56:32 +0100
From:   Borislav Petkov <bp@suse.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86-ml <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 05/21] x86/fpu/xstate: Add a new variable to indicate
 dynamic user states
Message-ID: <20210122105632.GA5123@zn.tnic>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-6-chang.seok.bae@intel.com>
 <20210115133924.GE11337@zn.tnic>
 <E7E5BE72-C3AB-4ABB-93B5-EF040595442E@intel.com>
 <20210119155758.GF27634@zn.tnic>
 <EF7FB3DA-868D-4597-B841-F786E094BFCF@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EF7FB3DA-868D-4597-B841-F786E094BFCF@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 06:57:26PM +0000, Bae, Chang Seok wrote:
> This series attempts to save the AMX state in the context switch buffer only

What is the context switch buffer?

I think you mean simply the xstate per-task buffer which is switched on
context switches...

> when needed -- so it is called out ‘dynamic’ user states.
> 
> The LBR state is saved in the perf buffer [1], and this state is named
> 'dynamic' supervisor states [2]. But some naming in the change has ‘dynamic’
> state only.
> 
> So, these two kinds of dynamic states are different and need to be named
> clearly.

Oh well, this is going to be a mess, there's also CET coming but at
least stuff is properly documented with comments - I guess thanks
dhansen :) - so we can fix it up later if something's still amiss.

> How about the changelog message like this:
> 
> "
> The context switch buffer is in preparation to be dynamic for user states.
> Introduce a new mask variable to indicate the 'dynamic' user states. The value
> is determined at boot time.
> 
> The perf subsystem has a separate buffer to save some states only when needed,
> not in every context switch. The states are named as 'dynamic' supervisor
> states. Some define and helper are not named with dynamic supervisor states,
> so rename them.
> 
> No functional change.
> “

Yah, better.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
