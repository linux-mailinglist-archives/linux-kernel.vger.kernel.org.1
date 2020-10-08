Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7258A287583
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgJHN5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgJHN5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:57:48 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44552C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 06:57:47 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s47so5140564qth.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 06:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0UHdNjJU5iuWFKYTh791mf1lQI1mHtEoMfCiwoQKZG8=;
        b=ek9q1XppirpvRcqNNd+8JR5rgsVSI6AuJnbjdaf34zyb3Z06sxfY6IvQga5XxPVhm8
         KODoLO9jOrNUtssEMrOvNeWI4J8P1KlOLrLFTlYSfUGevqCM7CS8WJ5Tu8d/RXfb32/8
         w2zvhfDZ3JglevQHFzrexFGtMBhVlJ8aD+k8LYKA1fXdEyiHe6yhHwop1oj5foISArH7
         v+l/P0GE7q2+pZSgcOj90ydlM3t+0hio3vkPaJ1NUaVpiJ1CQdSXzPy4mOZmdDsQEr87
         WKgnhOVe9Y3SgWwt1Refs5PimigrYmsYPHGXvceqCjBw5o6dGLX4NMXNLWhCK2ua0C1x
         cGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0UHdNjJU5iuWFKYTh791mf1lQI1mHtEoMfCiwoQKZG8=;
        b=f6kpsJlnWLxLQgs4HPgEpoDMdrRu7W6cpeJVJFjLez7G2xt9RHbMULFl8RJNnmFDGX
         63StnSKnn451taip0APpMxTdjb03LhSy751KtoGK2HpoEHGtOtuIeH7ePAtXlleegRvA
         7SV/Y/gNo5UcdZ8t63QQJIMCr4SW/eAy6l83GR3AswaT/aOgDY7ktAjnaiq1RFoK5fBT
         IBLHugXqandraLARzZv/CTtDOYBGsASU32oZGWMufRrVI5rKjoNgK4ogyCVruZR0mZVw
         VQ8/bPPHMWzmE/d4MfYUUU3ybSLiXT0bvXOGNyxAIByklas9r8yrFHyKoip2pnFRo6KJ
         /gWw==
X-Gm-Message-State: AOAM530rqlq4Gei3WShUyeMz54qBua4cORYfCcv4h36dblcHpc5jwTao
        DFU/l6KCJHc3k102a0Tkxos=
X-Google-Smtp-Source: ABdhPJxsZAiBHPqXjRouV4yH7eGuL5CmDecWL6JS1DPer24IxozNaU1S35XXnIs5kk5Bm4kTJ/HHsA==
X-Received: by 2002:ac8:365d:: with SMTP id n29mr8780648qtb.237.1602165466499;
        Thu, 08 Oct 2020 06:57:46 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id v18sm3919664qtq.15.2020.10.08.06.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 06:57:45 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 8 Oct 2020 09:57:44 -0400
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] x86/boot/64: Explicitly map boot_params and command
 line
Message-ID: <20201008135744.GD2429573@rani.riverdale.lan>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
 <20201007195351.776555-5-nivedita@alum.mit.edu>
 <20201008094836.GH3209@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008094836.GH3209@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 11:48:36AM +0200, Joerg Roedel wrote:
> On Wed, Oct 07, 2020 at 03:53:50PM -0400, Arvind Sankar wrote:
> > This is fragile, as boot_params and the command line mappings are
> > required for the main kernel. If EARLY_PRINTK and RANDOMIZE_BASE are
> > disabled, a QEMU/OVMF boot never accesses the command line in the
> > decompressor stub, and so it never gets mapped. The main kernel accesses
> > it from the identity mapping if AMD_MEM_ENCRYPT is enabled, and will
> > crash.
> 
> Looked again, and I think that is wrong for boot_params, which are
> touched unconditionally at the beginning of extract_kernel().

Yes, command line is the only thing that actually breaks, but it is more
robust to explicitly make sure boot_params is mapped as well. There's no
specific alignment requirement for boot_params AFAICT, so at least in
theory it's possible that it would be split across a PMD boundary and
only get half-mapped in the decompressor. It's easier not to have to
worry about it.

> 
> For the cmdline you are right, but one of CONFIG_ACPI,
> CONFIG_RANDOMIZE_BASE, CONFIG_X86_5LEVEL or CONFIG_EARLY_PRINTK is
> sufficient to have it touched during this boot stage.
> 

X86_5LEVEL accesses it before the switch to the new page tables, so that
doesn't help in getting it mapped. ACPI only accesses it if KASLR is
enabled (as well as MEMORY_HOTREMOVE).

Thanks.
