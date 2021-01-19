Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A623F2FBBD5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391515AbhASQAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:00:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:54040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391693AbhASP6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:58:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DE34FAE69;
        Tue, 19 Jan 2021 15:58:05 +0000 (UTC)
Date:   Tue, 19 Jan 2021 16:57:58 +0100
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
Message-ID: <20210119155758.GF27634@zn.tnic>
References: <20201223155717.19556-1-chang.seok.bae@intel.com>
 <20201223155717.19556-6-chang.seok.bae@intel.com>
 <20210115133924.GE11337@zn.tnic>
 <E7E5BE72-C3AB-4ABB-93B5-EF040595442E@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E7E5BE72-C3AB-4ABB-93B5-EF040595442E@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 07:47:38PM +0000, Bae, Chang Seok wrote:
> On Jan 15, 2021, at 05:39, Borislav Petkov <bp@suse.de> wrote:
> > On Wed, Dec 23, 2020 at 07:57:01AM -0800, Chang S. Bae wrote:
> >> The perf has a buffer that is allocated on demand. The states saved in the
> > 
> > What's "the perf"? I hope to find out when I countinue reading…
> 
> Maybe it was better to write ‘Linux perf (tools)’ [1] here. Sorry for the
> confusion.

Well, I'm also confused as to what does the perf buffer have to do with
AMX?

> >> -#define XFEATURE_MASK_DYNAMIC (XFEATURE_MASK_LBR)
> >> +#define XFEATURE_MASK_SUPERVISOR_DYNAMIC (XFEATURE_MASK_LBR)
> > 
> > Is XFEATURE_MASK_USER_DYNAMIC coming too?
> 
> Instead of the new define, I thought the new variable --
> xfeatures_mask_user_dynamic, as its value needs to be determined at boot
> time.

Why isn't that in your commit message?

All I see a patch doing a bunch of renames, some unrelated blurb in the
commit message and I have no clue what's going on here and why you're
doing this. Your commit messages should contain simple english sentences
and explain *why* the change is needed - not *what* you're doing. The
*what* I can see from the diff itself, for the *why* I need a crystal
ball which I can't buy in any store.

So how about explaining the *why*?

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
