Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66571274BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 00:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgIVWPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 18:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgIVWP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 18:15:26 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C038DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 15:15:26 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id d20so20878704qka.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 15:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7k9n/OKHilgdBd4xEN29xdZczBeCe9kTHhEJaWina5I=;
        b=KHzh108T8sbucLuij78e8c4BPMasRVUaXMklA6VdOOqfjOaB997h1VtEm4ewt8WwC1
         R34WqDGPJhaArxi6FQSALt0zcr2S0Mpw6g+DJDQGlS4aqMpWtqU9gn0XUT6MyGuweIcr
         4nBH2fI9nhnq7bPlJSEbNFb8mJQqQgbyZ32BWZi369wS+I/zYt1hwk75S7fwqbeN30NS
         gHWTL7ZjoQq01YLM+s1KvVfdaYg2xCV6/fy/QFxriL4g9a4Bp0wJWifuCkO9CgAKVHCy
         Cum+FGH/+ibJTEt2E2bSW+dl/7YBG8+oM3LayIXieqrlbi6fjI7feKk7D/gdgoi+PphQ
         fnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=7k9n/OKHilgdBd4xEN29xdZczBeCe9kTHhEJaWina5I=;
        b=pXMSyRMhzlA2jrRGDO2vo/u+SR14fCAr2BuRY0v2geIhAH+TKGoZmnEyk9KXKkRdlM
         fFdcijTXkLWMk+OAGKkZb+NZuPBuIQ1nouverJzitXPaF63HcnS+j41s/2arWi1ReKdH
         06lRgJDHX5BJa83ZfmW3wyjia1eZZOVnTAzwSFuz5ZW96OExaPf+eADRvuuUlpEDdeDB
         rHaxup8X2z9EL6vQ0WWW17Sxv4GlekvFRx2wA0gASTSGYqupR9/iZLYuF+QHNY+0bmru
         FlUBXBo8JQ/UsgsFGDoDncHykUc8pCySmuzw3avBEaMfZfshBo6VlyO8sKzqFbKc+xvw
         lDfg==
X-Gm-Message-State: AOAM530W2YQxf3ELwUC18CyP3pGSAR59V0DQsdKzQUThK7ufMKF3Y7To
        9IZecOudg+X9gGVPa+1hQuE=
X-Google-Smtp-Source: ABdhPJzi0nZ7QU6De1fzUSMl0+0ffnqWTuaA1x8ARvlqdBeahIXVGBPQRjZs6LQXuJjO/7I6KEuapQ==
X-Received: by 2002:a05:620a:134f:: with SMTP id c15mr6776628qkl.316.1600812925930;
        Tue, 22 Sep 2020 15:15:25 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r5sm13258806qtd.87.2020.09.22.15.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 15:15:25 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 22 Sep 2020 18:15:23 -0400
To:     Borislav Petkov <bp@alien8.de>
Cc:     Feng Tang <feng.tang@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] tools/x86: add kcpuid tool to show raw CPU
 features
Message-ID: <20200922221523.GA1185357@rani.riverdale.lan>
References: <1600752470-43179-1-git-send-email-feng.tang@intel.com>
 <20200922201024.GS22660@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922201024.GS22660@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 10:10:24PM +0200, Borislav Petkov wrote:
> + AMD folks.
> 
> On Tue, Sep 22, 2020 at 01:27:50PM +0800, Feng Tang wrote:
> > End users frequently want to know what features their processor
> > supports, independent of what the kernel supports.
> > 
> > /proc/cpuinfo is great. It is omnipresent and since it is provided by
> > the kernel it is always as up to date as the kernel. But, it could be
> > ambiguous about processor features which can be disabled by the kernel
> > at boot-time or compile-time.
> > 
> > There are some user space tools showing more raw features, but they are
> > not bound with kernel, and go with distros. Many end users are still
> > using old distros with new kernels (upgraded by themselves), and may
> > not upgrade the distros only to get a newer tool.
> > 
> > So here arise the need for a new tool, which
> >   * Shows raw cpu features got from running cpuid
> >   * Be easier to obtain updates for compared to existing userspace
> >     tooling (perhaps distributed like perf)
> >   * Inherits "modern" kernel development process, in contrast to some
> >     of the existing userspace cpuid tools which are still being developed
> >     without git and distributed in tarballs from non-https sites.
> >   * Can produce output consistent with /proc/cpuinfo to make comparison
> >     easier.

Rather than a tool, would additional file(s) in, say,
/sys/devices/system/cpu/cpu<n> be nicer? They could show the raw CPUID
features, one file per leaf or sub-leaf, maybe even along with whether
they were disabled at boot-time.

> >   * Be in-kernel, could leverage kernel enabling, and even
> >     theoretically consume arch/x86/boot/cpustr.h so it could pick up
> >     new features directly from one-line X86_FEATURE_* definitions.

That's arch/x86/include/asm/cpufeatures.h right -- cpustr.h is generated
from that. The table there already has comments which could be extracted
as the one-line description.

