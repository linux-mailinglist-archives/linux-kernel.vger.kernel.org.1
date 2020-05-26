Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4ABC1C4B6C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 03:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgEEBOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 21:14:45 -0400
Received: from mga18.intel.com ([134.134.136.126]:39118 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbgEEBOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 21:14:45 -0400
IronPort-SDR: AUBlGI+9GiKnCJY3gE7XFzCulIeFmkQvPmdQfbz8z/jmff0s8QOAhhBN4aBj6P40q5AZhx2lFt
 uen4oye5W+SQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 18:14:44 -0700
IronPort-SDR: d26C27YGcupVoq61tsh2NheD8M+GJHRYiT9Ig7OraRIBT6Gx8MS07v/zvYF9nM/0wkC/b02/4Z
 ToYtlv437uHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="461205749"
Received: from jbrandeb-mobl2.amr.corp.intel.com (HELO localhost) ([10.251.156.122])
  by fmsmga006.fm.intel.com with ESMTP; 04 May 2020 18:14:43 -0700
Date:   Mon, 4 May 2020 18:14:43 -0700
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     <clang-built-linux@googlegroups.com>,
        <andriy.shevchenko@intel.com>, <bp@alien8.de>,
        <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
        <linux@rasmusvillemoes.dk>, <mingo@redhat.com>,
        <peterz@infradead.org>, <tglx@linutronix.de>, <x86@kernel.org>,
        <ilie.halip@gmail.com>, <natechancellor@gmail.com>
Subject: Re: [PATCH v6 1/2] x86: fix bitops.h warning with a moved cast
Message-ID: <20200504181443.00007a3d@intel.com>
In-Reply-To: <20200504193524.GA221287@google.com>
References: <20200310221747.2848474-1-jesse.brandeburg@intel.com>
        <20200504193524.GA221287@google.com>
X-Mailer: Claws Mail 3.12.0 (GTK+ 2.24.28; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 May 2020 12:51:12 -0700
Nick Desaulniers <ndesaulniers@google.com> wrote:

> Sorry for the very late report.  It turns out that if your config
> tickles __builtin_constant_p just right, this now produces invalid
> assembly:
> 
> $ cat foo.c
> long a(long b, long c) {
>   asm("orb\t%1, %0" : "+q"(c): "r"(b));
>   return c;
> }
> $ gcc foo.c
> foo.c: Assembler messages:
> foo.c:2: Error: `%rax' not allowed with `orb'
> 
> The "q" constraint only has meanting on -m32 otherwise is treated as
> "r".
> 
> Since we have the mask (& 0xff), can we drop the `b` suffix from the
> instruction? Or is a revert more appropriate? Or maybe another way to
> skin this cat?

Figures that such a small change can create problems :-( Sorry for the
thrash!

The patches in the link below basically add back the cast, but I'm
interested to see if any others can come up with a better fix that
a) passes the above code generation test
b) still keeps sparse happy
c) passes the test module and the code inspection

If need be I'm OK with a revert of the original patch to fix the issue
in the short term, but it seems to me there must be a way to satisfy
both tools.  We went through several iterations on the way to the final
patch that we might be able to pluck something useful from.

> Link: https://github.com/ClangBuiltLinux/linux/issues/961
> This is blowing up our KernelCI reports.

ASIDE: 
Bummer, how come none of those KernelCI reports are part of
zero-day testing at https://01.org/lkp/documentation/0-day-test-service
I'm interested in your answer but don't want to pollute this thread,
feel free to contact me directly for this one or start a new thread?

