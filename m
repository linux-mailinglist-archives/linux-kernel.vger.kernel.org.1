Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD732E6A64
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 20:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbgL1TQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 14:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgL1TP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 14:15:59 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C40C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:15:19 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id s21so6723422pfu.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 11:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dHeCf8u1kCKbyNn5Y3Ab2K3Prk73t7dYCKJ4U5bk5mY=;
        b=mwWB2wmAXbVaif+qgz5KbyzLJgwgX4AKLDrPzjqjy2xC9sN4gszjAIzM9iG5rSE4v7
         F34rHAX0HoomHOMONzkC+hkTkDr1I+X819iLbYWcFRCLsdrLb2fqiXUWWSEcW5GAAFmU
         mKU00va7UowFOgU54oj57OPxF3ESz4VjunalFYccqyel1U4yuLzvWZwXHbZi2fQtif2w
         a2pKiFnRqWcj5uBvK87q3PGR5Xl2U/80BGwwUhcY6vYKFEImqO3M9knBXAbEkd6v35QN
         f37mrguF99sKWBr7FA6cV5XLAGCuLrDNSdIS0ZpuUwMGKJoKq57RRdnnm9zx9Bs+8kWU
         uc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dHeCf8u1kCKbyNn5Y3Ab2K3Prk73t7dYCKJ4U5bk5mY=;
        b=q1A2iuDLHmcBOdprMiszjpsMU40ahOaqJO6bufnVspYPzdj5To4MsC4gjeEKt0g9WL
         olh+9RyjcmXfpbeyzB1hrgf1lZSTtYNqwv6iIMF6Cp5TavcF3Op0INgI1GjwgI6UQ3j/
         3vSzrOgQQavR6QtEGOsoG9XiNxIJePkNGUM9C8wPdRZMcZjui/pncUx7AWDq4usKM/rx
         aoVpbq54MWGosHOKFTlqkU1JvEgeS0gK1u0z6HN1DcZpldjj633LQOqkrMoM5btGLbSl
         wjHXbIrXYmLCFsT3MuZ12SJlb8mNWN/n9t0MO/pWCbCmPWyLrXYmfUPBEIghcY6h2+gX
         2pTw==
X-Gm-Message-State: AOAM531tNMNVEhw6XMqD06MqZxH5qYope3MUCz+IA4CcxuwWVA2NTtIw
        +5tI/EQCFbswm7mViFmohsOcbA==
X-Google-Smtp-Source: ABdhPJyVZ8ZFWqN1fhk+9rjIzNooZfqCl5c/hbj36SAoln35h/HbESlR5jAnqk+8zLNob8kWGFS5Rg==
X-Received: by 2002:a63:6e45:: with SMTP id j66mr45424795pgc.238.1609182918866;
        Mon, 28 Dec 2020 11:15:18 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id f7sm171551pjs.25.2020.12.28.11.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 11:15:18 -0800 (PST)
Date:   Mon, 28 Dec 2020 11:15:11 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     kernel test robot <lkp@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 11/19] x86/sev-es: Convert to insn_decode()
Message-ID: <X+ouv0PN6dmva92i@google.com>
References: <20201223174233.28638-12-bp@alien8.de>
 <202012251838.G6eufP3Q-lkp@intel.com>
 <20201225123334.GA5874@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201225123334.GA5874@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 25, 2020, Borislav Petkov wrote:
> On Fri, Dec 25, 2020 at 06:50:33PM +0800, kernel test robot wrote:
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>):
> > 
> > >> arch/x86/kernel/sev-es.c:258:7: warning: variable 'ret' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> >                    if (!insn_decode_regs(&ctxt->insn, ctxt->regs, buffer, res))
> >                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Yeah, good catch, thanks for reporting.
> 
> Frankly, the readability and "extensiblity" of that function can be
> improved by splitting the two cases (diff ontop):

Alternatively, could the kernel case use insn_decode_regs()?  If
vc_fetch_insn_kernel() were also modified to mirror insn_fetch_from_user(), the
two code paths could be unified except for the the fetch and the PFEC.  E.g.

static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
				unsigned char *buffer)
{
	if (copy_from_kernel_nofault(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE))
		return 0;

	return MAX_INSN_SIZE;
}

static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
{
	char buffer[MAX_INSN_SIZE];
	int nbytes;

	if (user_mode(ctxt->regs))
		nbytes = insn_fetch_from_user(ctxt->regs, buffer);
	else
		nbytes = vc_fetch_insn_kernel(ctxt, buffer);

	if (!nbytes) {
		ctxt->fi.vector     = X86_TRAP_PF;
		ctxt->fi.error_code = X86_PF_INSTR;
		if (user_mode(ctxt->regs))
			ctxt->fi.error_code |= X86_PF_USER;
		ctxt->fi.cr2        = ctxt->regs->ip;
		return ES_EXCEPTION;
	}

	if (!insn_decode_regs(&ctxt->insn, ctxt->regs, buffer, nbytes))
		return ES_DECODE_FAILED;

	return ctxt->insn.immediate.got ? ES_OK : ES_DECODE_FAILED;
}
