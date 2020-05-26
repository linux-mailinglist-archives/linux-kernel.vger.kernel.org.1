Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3C641DDB43
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 01:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgEUXoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 19:44:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:39943 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbgEUXoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 19:44:16 -0400
IronPort-SDR: eWok/4OKyfebVvYXBafPF0P+dqRI69LicDPbeOBfHnpvJH0QdAXbs14DqivfcrDAXpclbVor7b
 xnbe8d+GDIRg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 16:44:15 -0700
IronPort-SDR: 0Ms5Qy+jno190pF+/VTAi0QhFUMONNvfXaCA2V4ASdMuxWdGUsEUQ+7ZP1RgIq5Zf8SXnKN58n
 zUjnknN4USiA==
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; 
   d="scan'208";a="255448928"
Received: from kcaccard-mobl.amr.corp.intel.com (HELO kcaccard-mobl1.jf.intel.com) ([10.212.147.236])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 16:44:14 -0700
Message-ID: <7540b2c7b5b037922bd235203d406acd27a9bd7f.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/9] Function Granular KASLR
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, arjan@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com
Date:   Thu, 21 May 2020 16:44:12 -0700
In-Reply-To: <202005211604.86AE1C2@keescook>
References: <20200521165641.15940-1-kristen@linux.intel.com>
         <87367sudpl.fsf@nanos.tec.linutronix.de> <202005211604.86AE1C2@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-21 at 16:30 -0700, Kees Cook wrote:
> On Fri, May 22, 2020 at 12:26:30AM +0200, Thomas Gleixner wrote:
> > I understand how this is supposed to work, but I fail to find an
> > explanation how all of this is preserving the text subsections we
> > have,
> > i.e. .kprobes.text, .entry.text ...?
> 
> I had the same question when I first started looking at earlier
> versions
> of this series! :)

Thanks for responding - clearly I do need to update the cover letter
and documentation.

> 
> > I assume that the functions in these subsections are reshuffled
> > within
> > their own randomized address space so that __xxx_text_start and
> > __xxx_text_end markers still make sense, right?
> 
> No, but perhaps in the future. Right now, they are entirely ignored
> and
> left untouched. The current series only looks at the sections
> produced
> by -ffunction-sections, which is to say only things named
> ".text.$thing"
> (e.g. ".text.func1", ".text.func2"). Since the "special" text
> sections
> in the kernel are named ".$thing.text" (specifically to avoid other
> long-standing linker logic that does similar .text.* pattern matches)
> they get ignored by FGKASLR right now too.
> 
> Even more specifically, they're ignored because all of these special
> _input_ sections are actually manually collected by the linker script
> into the ".text" _output_ section, which FGKASLR ignores -- it can
> only
> randomize the final output sections (and has no basic block
> visibility
> into the section contents), so everything in .text is untouched.
> Because
> these special sections are collapsed into the single .text output
> section is why we've needed the __$thing_start and __$thing_end
> symbols
> manually constructed by the linker scripts: we lose input section
> location/size details once the linker collects them into an output
> section.
> 
> > I'm surely too tired to figure it out from the patches, but you
> > really
> > want to explain that very detailed for mere mortals who are not
> > deep
> > into this magic as you are.
> 
> Yeah, it's worth calling out, especially since it's an area of future
> work -- I think if we can move the special sections out of .text into
> their own output sections that can get randomized and we'll have
> section
> position/size information available without the manual ..._start/_end
> symbols. But this will require work with the compiler and linker to
> get
> what's needed relative to -ffunction-sections, teach the kernel about
> the new way of getting _start/_end, etc etc.
> 
> So, before any of that, just .text.* is a good first step, and after
> that I think next would be getting .text randomized relative to the
> other
> .text.* sections (IIUC, it is entirely untouched currently, so only
> the
> standard KASLR base offset moves it around). Only after that do we
> start
> poking around trying to munge the special section contents (which
> requires use solving a few problems simultaneously). :)
> 

That's right - we keep .text unrandomized, so any special sections that
are collected into .text are still in their original layout. Like you
said, they still get to take advantage of normal KASLR (base address
randomization).


