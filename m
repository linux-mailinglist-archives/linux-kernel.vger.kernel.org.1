Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0862BC21A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 21:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgKUUqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 15:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgKUUqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 15:46:32 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E681C0613CF
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 12:46:32 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id 10so14244490wml.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Nov 2020 12:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7wS3kdSR65IlFtOolDLVBXI5oumbFV3Gfqst8d2FUck=;
        b=FFQgnNmMGY+sIs7hjUrr+VOpxcPKGZKuOBcUY7VdxlKcY9vGTdZhaEYPuuCbE9AzXn
         lW6BPQfOTbX5NioUgyZDwvvm5HJSOGYig5GXshWJNG+dROLbC7T7AqMEOoCkKau+BR9a
         gbRfizr6Rz3VIShg9KJI3LSww9ZLE0XLwUtv5tqh7h3S9wH1vkcsXWD3OqNTfk834e+D
         e9i6NuBClCBb5NKSK4MZy+1HnOP9OnDgchHymoljOr2mNTRsfIsyyVod9kXmcguBJCRR
         j4ZBMxZq89BQCbiuhJnQPAItcD685c5ko9H/AY0B2+H4gJz5a/LcvWPr7HokyVwtobEQ
         dXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7wS3kdSR65IlFtOolDLVBXI5oumbFV3Gfqst8d2FUck=;
        b=thmLtvYEaUzKUp9BgZojwBX5K+eT0Y89tZR0dZpFmC2q3TNyve8tUCcDWAwupg/nrF
         o9PtpiftZ4DAMrhkqqokASHGeKzFPHCKLKo7FJiIbKmT94xx53kXGlmF1lzsPkuDvN99
         r2NqwGE6xcsU8bI1o34O694I+1xJlg2AYP+6OrwmJw8sx3jbDRgGF3myemZOtE+xQ8g9
         ZSKgdpu26g23u4XaIYXN9wWgBl9TLyBnT/crWpvNYlw4uem5yYEvnjJDAMEybjFhTrl3
         rm+nySnB9Y+34D2HT41PXK6dymvqM3dtVA0CruaHtZ4/W2ykv34VdiTdWv5zyzGwfJi1
         Ok1Q==
X-Gm-Message-State: AOAM530s2hjc7Soxl0+YxNQS2WWo4ICAEpEifER9tNGkVvbpRwJcLQMT
        62JjPXyk3e83qOSqX99IxjM3PPCfz/M=
X-Google-Smtp-Source: ABdhPJwkkbgYsAySxoPulG0ZVcOumh850UGp3YCgXACCkEJ8CmtCOzEcKAxgHndS+G9Acaan1AnoXQ==
X-Received: by 2002:a1c:e442:: with SMTP id b63mr16883437wmh.10.1605991590882;
        Sat, 21 Nov 2020 12:46:30 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:dcb6:7e9c:ccbf:c450])
        by smtp.gmail.com with ESMTPSA id h17sm12762072wrp.54.2020.11.21.12.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2020 12:46:30 -0800 (PST)
Date:   Sat, 21 Nov 2020 21:46:26 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, christophe.leroy@csgroup.eu,
        rdunlap@infradead.org
Subject: Re: [PATCH] ilog2: Improve ilog2 for constant arguments
Message-ID: <20201121204626.tw3jribsz326e3ag@ltop.local>
References: <20201120125154.GB3040@hirez.programming.kicks-ass.net>
 <20201121202310.lx2iqqebal3fmmmo@ltop.local>
 <20201121202954.GW3788@tucnak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121202954.GW3788@tucnak>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 21, 2020 at 09:29:54PM +0100, Jakub Jelinek wrote:
> On Sat, Nov 21, 2020 at 09:23:10PM +0100, Luc Van Oostenryck wrote:
> > On Fri, Nov 20, 2020 at 01:51:54PM +0100, Peter Zijlstra wrote:
> > > 
> > > Other option would be to change the const_ilog2 macro, though as the
> > > description says it is meant to be used also in C constant expressions,
> > > and while GCC will fold it to constant with constant argument even in
> > > those, perhaps it is better to avoid using extensions in that case.
> > 
> > Just for info, the description is outdated and Sparse is just fine with
> > __builtin_clzll() and friends in constant expressions (since Feb 2017)
> 
> Why is the description outdated?  It is still an extension that not every
> compiler might fold in constant expressions.  And, the large expressions
> aren't really a problem in constant expressions, they will be folded there
> to constant or error.
> The problem the patch was trying to solve is that the large expressions are
> a problem at least for GCC in runtime code when guarded by
> __builtin_constant_p, because __builtin_constant_p is folded quite late
> (intentionally so, so that more constants can be propagated into it, e.g.
> after inlining etc.), and the large expressions might confuse inliner
> heuristics.

I was only talking about the part "Use this where *sparse* expects a true
constant expression, e.g. for array 75 indices." and wanted to say that 
__builtin_clzll() with a constant argument is now also expanded to a
constant, like GCC does (it wasn't the case before 2017 and I think
it was the main reason why const_ilog2() is written as it is).

-- Luc
