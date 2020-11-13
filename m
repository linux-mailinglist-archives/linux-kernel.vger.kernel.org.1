Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64652B16F4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 09:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgKMIG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 03:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgKMIG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 03:06:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D26B4C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 00:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QggK8DwEmLqdOJ4zDar4KwAw4Fzlba1W/xUK3NW8un4=; b=hkDK0iBtw0v1y8aGgL5+MkPgix
        ZZoy6zjBUHs5SBvOMTqYv9CSRdzx7d+fv5jFpfKhwbr9FwNtq/UqusM7JNUGzyM0BiZ0D0th4ovNS
        nfWknGuq82yDXaeqjkHW2Ycgene9nb6ZqFSECDZ4PB815lgZGwwZnWORrTKFMB+avkColXevbKoiB
        sAr/zkTGm/bL41F2wp4aq2ZimaQzpCf5GXBJmoeCby+Wra7oC4PDGiBx6mKIZx626ediwNp0lsZLh
        Em9mMolMBpopTitWNHh0Gd0OL58u1qiGXR6u3i6KNRX0qi1mMEeIa2gXzASjk85nTuCyQw18jdebs
        +vXB9ALA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdU6U-0006VB-AP; Fri, 13 Nov 2020 08:06:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1C8A13006D0;
        Fri, 13 Nov 2020 09:06:41 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07D992C084CAB; Fri, 13 Nov 2020 09:06:41 +0100 (CET)
Date:   Fri, 13 Nov 2020 09:06:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 5/5] objtool: Rework header include paths
Message-ID: <20201113080640.GY2628@hirez.programming.kicks-ass.net>
References: <cover.thread-1e2854.your-ad-here.call-01605220128-ext-6070@work.hours>
 <patch-5.thread-1e2854.git-1e285422e508.your-ad-here.call-01605220128-ext-6070@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <patch-5.thread-1e2854.git-1e285422e508.your-ad-here.call-01605220128-ext-6070@work.hours>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 12:03:32AM +0100, Vasily Gorbik wrote:
> Currently objtool headers are being included either by their base name
> or included via ../ from a parent directory. In case of a base name usage:
> 
>  #include "warn.h"
>  #include "arch_elf.h"
> 
> it does not make it apparent from which directory the file comes from.
> To make it slightly better, and actually to avoid name clashes some arch
> specific files have "arch_" suffix. And files from an arch folder have
> to revert to including via ../ e.g:
>  #include "../../elf.h"
> 
> With additional architectures support and the code base growth there is
> a need for clearer headers naming scheme for multiple reasons:
> 1. to make it instantly obvious where these files come from (objtool
>    itself / objtool arch|generic folders / some other external files),
> 2. to avoid name clashes of objtool arch specific headers, potential
>    obtool arch generic headers and the system header files (there is
>    /usr/include/elf.h already),
> 3. to avoid ../ includes and improve code readability.
> 4. to give a warm fuzzy feeling to developers who are mostly kernel
>    developers and are accustomed to linux kernel headers arranging
>    scheme.
> 
> Doesn't this make it instantly obvious where are these files come from?
> 
>  #include <objtool/warn.h>
>  #include <arch/elf.h>
> 
> And doesn't it look nicer to avoid ugly ../ includes? Which also
> guarantees this is elf.h from the objtool and not /usr/include/elf.h.
> 
>  #include <objtool/elf.h>
> 
> This patch defines and implements new objtool headers arranging
> scheme. Which is:
> - all generic headers go to include/objtool (similar to include/linux)
> - all arch headers go to arch/$(SRCARCH)/include/arch (to get arch
>   prefix). This is similar to linux arch specific "asm/*" headers but we
>   are not abusing "asm" name and calling it what it is. This also helps
>   to prevent name clashes (arch is not used in system headers or kernel
>   exports).
> 
> To bring objtool to this state the following things are done:
> 1. current top level tools/objtool/ headers are moved into
>    include/objtool/ subdirectory,
> 2. arch specific headers, currently only arch/x86/include/ are moved into
>    arch/x86/include/arch/ and were stripped of "arch_" suffix,
> 3. new -I$(srctree)/tools/objtool/include include path to make
>    includes like <objtool/warn.h> possible,
> 4. rewriting file includes,
> 5. make git not to ignore include/objtool/ subdirectory.
> 
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

Nice!

For the whole series:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

