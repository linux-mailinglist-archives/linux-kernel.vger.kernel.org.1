Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254E12FF80B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 23:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbhAUWgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 17:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbhAUWgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 17:36:45 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3FBC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 14:35:59 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id e9so2139923plh.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 14:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HtagZa2utrgVZ8EO6yL1vWOFCbFLgOv3ljBb8Jq8YdU=;
        b=Om26hhxJRyeJ93IrXhZROKDhjJ435IRJbXSbYJ9gSBnBiQA9i5yA2UijRT0/ySX5PV
         9OPjibb0E9cXZ1Zhi3X8QiU1Ul5O2PnP0PrjmfErqKyNyWnciScr6CNCJCClOA4HNcRn
         pwWXfmVd31iUFZbBBeDsDaPESk6SzLx9Qy0ziyzrOlYYvOkQXZ9aO5qYMcgqFnhmtQ7m
         4BDdXB1qh6TCVbPzDA2iDzKQJpN6MLBZvXwA4QtV4k0QeEJyfgLy6T65ObT1Mgvb5io+
         26m2v0/SGWMvU+XgN6S1ONunh7VjIFofo8yN7WJirTCPGpoQ+PdKn7XRBbMtD2BkgWS0
         tlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HtagZa2utrgVZ8EO6yL1vWOFCbFLgOv3ljBb8Jq8YdU=;
        b=OqkOEbJVtYG3BztG7FjNDwlXQfgOKaBTU1fooCMFe7UFyGr5uHAVNMduWklJ3bupIz
         g5TAbwh+a/rVEoJu8Uvh6aDMPNqs0Jog6ekXRO7tk2vjPotUuwUZQ0DlP+IRbEn4Vpl6
         ViUsoJzzHKBTMKZP1ptGzieXM0hBgMyM87wXkHy4f2xKccK3LROgj7ZqKbweP6Px8twm
         7ItqPjDJu+Hwn6CJyqa16Orjm5UVi2CND2mbz5KQN1sRda6rmqo/omB2K17dg8YsI/B4
         Cdg3sy6kkVkiNPLjSc1C3qQp8V96u+44XIVKBi6BS/xA5+athZH5Sq0D3cVMxJ8E4GBV
         UnsA==
X-Gm-Message-State: AOAM531ZnR9D4P4OcYRq5ehwKqF1DQwL+R2eYacL8JPtTaQq2Pl/7uWc
        eGGhQN7q9eTByJsfoqbP+Tm1uA==
X-Google-Smtp-Source: ABdhPJy9LJ57DCr4V2SGC+Z1NTqWzTbxrQqJBoge5bsU6nlW8rd+uk0CG9BE7uEtO2imrj7na0H7zA==
X-Received: by 2002:a17:903:248b:b029:de:9885:d1fa with SMTP id p11-20020a170903248bb02900de9885d1famr1583550plw.77.1611268559000;
        Thu, 21 Jan 2021 14:35:59 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id j10sm6973556pjy.9.2021.01.21.14.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 14:35:58 -0800 (PST)
Date:   Thu, 21 Jan 2021 14:35:51 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     kernel test robot <lkp@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 11/19] x86/sev-es: Convert to insn_decode()
Message-ID: <YAoBx6VPp/eMWHE8@google.com>
References: <20201223174233.28638-12-bp@alien8.de>
 <202012251838.G6eufP3Q-lkp@intel.com>
 <20201225123334.GA5874@zn.tnic>
 <X+ouv0PN6dmva92i@google.com>
 <20210121165845.GD32060@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121165845.GD32060@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021, Borislav Petkov wrote:
> On Mon, Dec 28, 2020 at 11:15:11AM -0800, Sean Christopherson wrote:
> > Alternatively, could the kernel case use insn_decode_regs()?  If
> > vc_fetch_insn_kernel() were also modified to mirror insn_fetch_from_user(), the
> > two code paths could be unified except for the the fetch and the PFEC.  E.g.
> 
> Personal Firearms Eligibility Check?

Ha, Page Fault Error Code.

> In any case, I prefer simple, easy to follow code at a quick glance.
> Stuff like...
> 
> > 
> > static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
> > 				unsigned char *buffer)
> > {
> > 	if (copy_from_kernel_nofault(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE))
> > 		return 0;
> > 
> > 	return MAX_INSN_SIZE;
> > }
> > 
> > static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
> > {
> > 	char buffer[MAX_INSN_SIZE];
> > 	int nbytes;
> > 
> > 	if (user_mode(ctxt->regs))
> > 		nbytes = insn_fetch_from_user(ctxt->regs, buffer);
> > 	else
> > 		nbytes = vc_fetch_insn_kernel(ctxt, buffer);
> > 
> > 	if (!nbytes) {
> > 		ctxt->fi.vector     = X86_TRAP_PF;
> > 		ctxt->fi.error_code = X86_PF_INSTR;
> > 		if (user_mode(ctxt->regs))
> 
> ... this second repeated check here is not what I would call that.

But then you're stuck maintaining two separate flows that do the same thing.

> But this is my personal preference only so it's up for a vote now.

Rock Paper Scissors?
