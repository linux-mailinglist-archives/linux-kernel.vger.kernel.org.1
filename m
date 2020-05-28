Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3FE1E5A21
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 10:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgE1IAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 04:00:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59372 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgE1IAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:00:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0npeI6eY1T2CI7ZWFHA7J8k1+OIRaMrorW/cS+eT7aU=; b=kvRLyc/kHN8Nkm1VEIl1vFJsWx
        4rXTFCksoOTrIMbxGnzQo0f+mnrMNkLPn84W90YcAhWXCrAG2AknPelIanxSpy+JCLJqvxMoybmOF
        C0F00xhRTNIKnIezaWasFil5bOxmSTWGRCUJ1RDW3H2CJcqbYCpW7/tTO3Hb8JYZ+QYLJVR1z6E3S
        UZN9A4UP+be2j9wj8v6cjoiwx2mfoVrjhzOILXyTdY7u/Uz365mGS2KcjieB+3T7ksGXKnJyjWc81
        voYjjNwolOajZSU55m3TP2loLMVt9UHCO8ACGhgfw9H6Dt0upFVawSEfOGPNBkOji2HAOybOd4K6x
        HNFbQxxw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeDOV-0008JB-76; Thu, 28 May 2020 07:56:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C4C1A301205;
        Thu, 28 May 2020 09:55:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A25EB20D6F3AC; Thu, 28 May 2020 09:55:53 +0200 (CEST)
Date:   Thu, 28 May 2020 09:55:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     kbuild test robot <lkp@intel.com>, Marco Elver <elver@google.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, luc.vanoostenryck@gmail.com
Subject: Re: [tip:locking/kcsan 12/12] /bin/bash: line 1: 61526 Segmentation
 fault  sparse ...
Message-ID: <20200528075553.GC706478@hirez.programming.kicks-ass.net>
References: <202005280727.lXn1VnTw%lkp@intel.com>
 <20200527235442.GC1805@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527235442.GC1805@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 01:54:42AM +0200, Borislav Petkov wrote:
> On Thu, May 28, 2020 at 07:39:31AM +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/kcsan
> > head:   a5dead405f6be1fb80555bdcb77c406bf133fdc8
> > commit: a5dead405f6be1fb80555bdcb77c406bf133fdc8 [12/12] compiler_types.h: Optimize __unqual_scalar_typeof compilation time
> > config: i386-randconfig-s002-20200527 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
> > reproduce:
> >         # apt-get install sparse
> >         # sparse version: v0.6.1-240-gf0fe1cd9-dirty
> >         git checkout a5dead405f6be1fb80555bdcb77c406bf133fdc8
> >         # save the attached .config to linux build tree
> >         make W=1 C=1 ARCH=i386 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> I'll say.
> 
> Looking at the subject, that broke the 0day bot too. :-)
> 
> /me trims it.
> 
> Looks like we need __CHECKER__ ifdeffery somewhere but it is too late
> for me to think straight so tomorrow...

I think the problem is that sparse can't parse the C11 _Generic thing.
Someone needs to teach it new tricks.
