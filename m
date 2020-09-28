Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFCE227AC87
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 13:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgI1LRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 07:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgI1LRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 07:17:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F43C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 04:17:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o5so821711wrn.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 04:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eF74ZFK17+xMyvZFbbKNSS8MJbDDGd1/oidFI6dtPeQ=;
        b=gg1JP4uRsjVTO5ysoyRinZfbru3qcVXq+xS5cIWbUwGxr1C6syaVT1NLFv8sEaKsR3
         bAGqWW8dIq6OUE1cv7esaoDR7pE1Xq1sUQRrk76BH0vh7ktEvuAm4oWTc1ggqcNz1NL2
         BNRtwjBVZHKHzY0gOT9Kju106JXPdHoD/Qd+Rz2Ig5xPXZYyIHUXFw4oqIjNb/P3uA46
         xZeaUTicg/SFRfXDdYEnrL4vgn5EGZV8xh7Aa1ClYnXRHANrth/n10+sqbzpW/MtXlmN
         7UEgMMFgYtXrS+6ogHOmMjx/WiCkgeb02EFYwHfyHPgnsp6oMXmlVxRH77+bQzSUaxET
         UrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eF74ZFK17+xMyvZFbbKNSS8MJbDDGd1/oidFI6dtPeQ=;
        b=ExA0WCYdoP6LCoQgEYXsrPMOvg0FAEQ+Mmx3Kr4y5KvwIvRCoTFFo4y9dMkAO8CeAt
         ghKZz/KEpOSaBB1nVpyT3Wm5mIbu56vfucu196a0fR87DqbvxOv0GXNizUAKB13jVEzC
         Ii77jnX81JL6+i6tn1KNfMGE0a/fB2L3w2abB2AW9pUjLLML5ioaoDuq4yruVzIa9W/x
         Mo9ZxHwWTjOWUsqte91BRRBbxeSLF6VnvAZ8WKm/IfdmiBj6ogtgmHpKlflvV+Y0C9Qw
         1OP6FEQvu6K0lSSrSDx1nya2sLhK2Nc/MLosmVdaO2fgwbDnwyzelSw4X8HFj2JHzz9R
         OKZA==
X-Gm-Message-State: AOAM530Bwbh8dS/pDjEgpNKN1GuKTnhVB46eZVFzIh75B++40rYfopoD
        mpu0qRF4vvpeXNubvajpNs166Q==
X-Google-Smtp-Source: ABdhPJxYnMFBR4He86ej0AcG8HKyVAP+FtnsRyYUT8aR0hp7Rx18E0FIW1v8bd3rqv9adlovXDN4Gw==
X-Received: by 2002:adf:cf01:: with SMTP id o1mr1128621wrj.421.1601291853709;
        Mon, 28 Sep 2020 04:17:33 -0700 (PDT)
Received: from holly.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id d23sm860748wmb.6.2020.09.28.04.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 04:17:33 -0700 (PDT)
Date:   Mon, 28 Sep 2020 12:17:31 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, sumit.garg@linaro.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com, will@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: Re: [PATCH v3 0/3] kgdb: Honour the kprobe blocklist when setting
 breakpoints
Message-ID: <20200928111731.koa7am62uxxaezcz@holly.lan>
References: <20200927211531.1380577-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927211531.1380577-1-daniel.thompson@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 10:15:28PM +0100, Daniel Thompson wrote:
> kgdb has traditionally adopted a no safety rails approach to breakpoint
> placement. If the debugger is commanded to place a breakpoint at an
> address then it will do so even if that breakpoint results in kgdb
> becoming inoperable.
> 
> A stop-the-world debugger with memory peek/poke intrinsically provides
> its operator with the means to hose their system in all manner of
> exciting ways (not least because stopping-the-world is already a DoS
> attack ;-) ). Nevertheless the current no safety rail approach is
> difficult to defend, especially given kprobes can provide us with plenty
> of machinery to mark the parts of the kernel where breakpointing is
> discouraged.
> 
> This patchset introduces some safety rails by using the existing kprobes
> infrastructure and ensures this will be enabled by default on
> architectures that implement kprobes. At present it does not cover
> absolutely all locations where breakpoints can cause trouble but it will
> block off several avenues, including the architecture specific parts
> that are handled by arch_within_kprobe_blacklist().
> 
> v4:
> * Fixed KConfig dependencies for HONOUR_KPROBE_BLOCKLIST on kernels
>   where MODULES=n
> * Add additional debug_core.c functions to the blocklist (thanks Doug)
> * Collected a few tags

Looks like I neglected to bump the version number in the subject.
For the avoidance of doubt, this comment is correct and the subject
line is broken.

Sorry!


Daniel.


> 
> v3:
> * Dropped the single step blocklist checks. It is not proven that the
>   code was actually reachable without triggering the catastrophic
>   failure flag (which inhibits resume already).
> * Update patch description for ("kgdb: Add NOKPROBE labels...") and
>   added symbols that are called during trap exit
> * Added a new patch to push the breakpoint activation later in the
>   flow and ensure the I/O functions are not called with breakpoints
>   activated.
> 
> v2:
> * Reworked after initial RFC to make honouring the blocklist require
>   CONFIG_KPROBES. It is now optional but the blocklist will be enabled
>   by default for architectures that CONFIG_HAVE_KPROBES
> 
> Daniel Thompson (3):
>   kgdb: Honour the kprobe blocklist when setting breakpoints
>   kgdb: Add NOKPROBE labels on the trap handler functions
>   kernel: debug: Centralize dbg_[de]activate_sw_breakpoints
> 
>  include/linux/kgdb.h            | 18 ++++++++++++++++++
>  kernel/debug/debug_core.c       | 22 ++++++++++++++++++++++
>  kernel/debug/gdbstub.c          |  1 -
>  kernel/debug/kdb/kdb_bp.c       |  9 +++++++++
>  kernel/debug/kdb/kdb_debugger.c |  2 --
>  lib/Kconfig.kgdb                | 15 +++++++++++++++
>  6 files changed, 64 insertions(+), 3 deletions(-)
> 
> --
> 2.25.4
> 
