Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C972B6EAC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgKQTcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgKQTcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:32:06 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2549C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:32:05 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id q7so11298795qvt.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C1IZO3TidBvZYKM3gtAuU0FLpKg60Lkm/guLU1OMCbw=;
        b=QCHl1LKvfGy4FkAwk+R/lEUdBtWSxkaux81SECaGzBdYki5KH+SA+rb85yGzSpmUBA
         0HRjDNhu16Z2qmwSKghP58Zh47L4YUUy4unwvXWG9exPqDckLJDFBcKg5d3ggyLaxp6a
         od2Rc83bOm/bjVsTo4g6FHdh1j9PMiCmL9oWc+bP8KugXfsXeP1U/BSy/SrUbcIkEJA1
         yV4qrJGC9yVzPCGvaeCmbrEzlXuYla0AcwASkWxXeo4SEBGaZpRmz2lyK+jxJdszBkgn
         pHt9EsQg1LUPAO46EHV1FHzvQBh6sfynK7kESm43yYW+usR73dfYjfkOPIx1NzVrBun5
         7d4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=C1IZO3TidBvZYKM3gtAuU0FLpKg60Lkm/guLU1OMCbw=;
        b=Fz6XFhGyYQXXHctxELF79joM5lvtBrGTz5VEwrx3vdTdm/aI1S99OMrcqKkTG1KW9J
         o20ZapGkCGqSc/4KcGdpo8u133RnpsHfkd9JGmlH8wo8Qgrm/cRCHFviCiRNzPaQMJpM
         uYiDOsAEeIq26VMN+dcOGs6Oo96K/86cFr0+AkHqUppM4FviJu0LuFX35sCJU2MmHQv5
         au7R0LiRJ9Q310mgOG2eQmxqUvbCqaskCToUDt57/WLzsgEJmd6ksfQa4KPqWUV5jk+s
         FzaAKr3UMXK6P/D2H1aJqKoGgGYUOcXBZzo/vnCKdQwOt6ouqNwsqDlNSCzogV91+RTv
         duuA==
X-Gm-Message-State: AOAM532QeLVOP1Sf41bh5vSC0Sl6xZyJ7zUukKwnY9njdUlGl6t4BZ64
        ExaNhkQZ8geDF6dKTvazDDg=
X-Google-Smtp-Source: ABdhPJx9tYxhlmXMpJyarY0CXNXEJ0RSKALOdBnT1znfnNz6t8O1TPQ2VPiUMIPctVdX5+kC7vPnew==
X-Received: by 2002:ad4:5b82:: with SMTP id 2mr925675qvp.28.1605641524963;
        Tue, 17 Nov 2020 11:32:04 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id i4sm3331627qti.78.2020.11.17.11.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 11:32:03 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 17 Nov 2020 14:32:02 -0500
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-riscv@lists.infradead.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH] RISC-V: fix barrier() use in <vdso/processor.h>
Message-ID: <20201117193202.GA1574448@rani.riverdale.lan>
References: <20201117013951.7827-1-rdunlap@infradead.org>
 <CAKwvOdmESwnF14TLjRfzJg8Dau8XW0LgoDvXtdPjPOqdf211SQ@mail.gmail.com>
 <9ab43756-6c48-c5e8-3a5d-e44bba070a97@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9ab43756-6c48-c5e8-3a5d-e44bba070a97@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 11:22:39AM -0800, Randy Dunlap wrote:
> On 11/17/20 11:00 AM, Nick Desaulniers wrote:
> > On Mon, Nov 16, 2020 at 5:40 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> riscv's <vdso/processor.h> uses barrier() so it should
> >> #include <asm/barrier.h> to prevent build errors.
> >>
> >> Fixes this build error:
> >>   CC [M]  drivers/net/ethernet/emulex/benet/be_main.o
> >> In file included from ./include/vdso/processor.h:10,
> >>                  from ./arch/riscv/include/asm/processor.h:11,
> >>                  from ./include/linux/prefetch.h:15,
> >>                  from drivers/net/ethernet/emulex/benet/be_main.c:14:
> >> ./arch/riscv/include/asm/vdso/processor.h: In function 'cpu_relax':
> >> ./arch/riscv/include/asm/vdso/processor.h:14:2: error: implicit declaration of function 'barrier' [-Werror=implicit-function-declaration]
> >>    14 |  barrier();
> >>
> >> This happens with a total of 5 networking drivers -- they all use
> >> <linux/prefetch.h>.
> >>
> >> rv64 allmodconfig now builds cleanly after this patch.
> >>
> >> Fixes fallout from:
> >> 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
> >>
> >> Fixes: ad5d1122b82f ("riscv: use vDSO common flow to reduce the latency of the time-related functions")
> > 
> > Hi Randy,
> > Thanks for the patch, it looks good to me.  I only had a question on
> > the commit message.
> > 
> > Is this also related to:
> > commit 3347acc6fcd4 ("compiler.h: fix barrier_data() on clang")
> 
> Hi Nick,
> Yes, it looks like I tagged the wrong commit in Fixes:
> Thanks for noticing that.
> 

Thanks for the patch!

Acked-by: Arvind Sankar <nivedita@alum.mit.edu>

Generally speaking, should compiler_types.h be considered "internal"?
i.e. everyone should include compiler.h, not compiler_types.h directly?

Eg for another potential case that might bite is that RELOC_HIDE is
defined in compiler_types.h, except for clang, which will only have a
definition if compiler.h is included.
