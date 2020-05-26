Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3BC1DDAEB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 01:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgEUXa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 19:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730558AbgEUXa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 19:30:27 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79503C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 16:30:26 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n11so4076929pgl.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 16:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1gibyxiWx0QNF1j9zPlChAHDNDwaEmxS/M++y57RUrs=;
        b=MpBbNEwcm5wRraAV5OiblA2zPdqD9KNWPoAHUgqKM8Rbst+M/JjT04I9uUUH1EALHs
         lW+yRfivRRJqil+IgM0QapLJey39Kg/2mP1L3qwPliX5LQPUjzvp6TxCDx0umxNp19gB
         nFFRmUzPGKWjr17uv2KuvHYtLQgkR9/n6ZRqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1gibyxiWx0QNF1j9zPlChAHDNDwaEmxS/M++y57RUrs=;
        b=n0l9wDyP+w44DGcSrr+ba7Ebj0EYL0A2yxCHfprVPXFOkVobOal1dTHPPsXPT0hGdg
         97/BBMn3vKag70i/qgd/gPWCg+pp2Y5dzjk3aRfwALF2ZcNyU9BUKSPSq+BSyxhfCCf6
         zkUjBnOqMLLdd2eN7tX+aogeH8t4poM5AtI+YrflcKWi7xi6CacNmPvmdR4OQNEHtRlE
         q7ueWqw+GPn9J2pLub4roZ07UKyBWBU7mbzidvs9ErnIcixSxTMSEoL24BQutk/9cNlT
         xQgZ0aJEqtM34gcPirwDpYvsDy72Y23Gqlc7V57f9CfNrL4L9GM0JJWw0pC8KhaOreaC
         4phA==
X-Gm-Message-State: AOAM531bNqfcRjer/oW8JHPYdGX93DKxd8/6dv/MLGyU4wPHzjm/zEAU
        uBmsyBK3eV7sq4L+pBdVL+iJzA==
X-Google-Smtp-Source: ABdhPJy9tCvODJaSjshfgmC7fdO80oHfJyQWMgbloCJ5mYHG3BMqD79HqFicR3fubN7UfR62DwQKIw==
X-Received: by 2002:a63:546:: with SMTP id 67mr11688886pgf.364.1590103825857;
        Thu, 21 May 2020 16:30:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e19sm5144403pfn.17.2020.05.21.16.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 16:30:24 -0700 (PDT)
Date:   Thu, 21 May 2020 16:30:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, arjan@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com
Subject: Re: [PATCH v2 0/9] Function Granular KASLR
Message-ID: <202005211604.86AE1C2@keescook>
References: <20200521165641.15940-1-kristen@linux.intel.com>
 <87367sudpl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87367sudpl.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 12:26:30AM +0200, Thomas Gleixner wrote:
> I understand how this is supposed to work, but I fail to find an
> explanation how all of this is preserving the text subsections we have,
> i.e. .kprobes.text, .entry.text ...?

I had the same question when I first started looking at earlier versions
of this series! :)

> I assume that the functions in these subsections are reshuffled within
> their own randomized address space so that __xxx_text_start and
> __xxx_text_end markers still make sense, right?

No, but perhaps in the future. Right now, they are entirely ignored and
left untouched. The current series only looks at the sections produced
by -ffunction-sections, which is to say only things named ".text.$thing"
(e.g. ".text.func1", ".text.func2"). Since the "special" text sections
in the kernel are named ".$thing.text" (specifically to avoid other
long-standing linker logic that does similar .text.* pattern matches)
they get ignored by FGKASLR right now too.

Even more specifically, they're ignored because all of these special
_input_ sections are actually manually collected by the linker script
into the ".text" _output_ section, which FGKASLR ignores -- it can only
randomize the final output sections (and has no basic block visibility
into the section contents), so everything in .text is untouched. Because
these special sections are collapsed into the single .text output
section is why we've needed the __$thing_start and __$thing_end symbols
manually constructed by the linker scripts: we lose input section
location/size details once the linker collects them into an output
section.

> I'm surely too tired to figure it out from the patches, but you really
> want to explain that very detailed for mere mortals who are not deep
> into this magic as you are.

Yeah, it's worth calling out, especially since it's an area of future
work -- I think if we can move the special sections out of .text into
their own output sections that can get randomized and we'll have section
position/size information available without the manual ..._start/_end
symbols. But this will require work with the compiler and linker to get
what's needed relative to -ffunction-sections, teach the kernel about
the new way of getting _start/_end, etc etc.

So, before any of that, just .text.* is a good first step, and after
that I think next would be getting .text randomized relative to the other
.text.* sections (IIUC, it is entirely untouched currently, so only the
standard KASLR base offset moves it around). Only after that do we start
poking around trying to munge the special section contents (which
requires use solving a few problems simultaneously). :)

-- 
Kees Cook
