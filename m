Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFE3283115
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 09:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgJEHpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 03:45:40 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:29209 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJEHpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1601883938;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=JI6A9PpIQFNnYPSlFbk1aFwk9N6qbShlSuz0WnZt37Q=;
        b=U3oczptIrcqNUK/Sdc39uV2WTuCkl8Yzic2rXHSG3LotVotGo4uRjMOcrlWLikPrn8
        uQZkmh67FdzT516GT/0vcni/3EZ1OHvwWLaUrBm7hz8Q/XE16SO75g/xos71SQ3nHYkX
        w1WvdpxuOqG4Fo4WQcDdfs3PS+d0F92bG/KcFzx5KVgOQLa9SpgbxZ2qBYESFLGW0ZWB
        LAYljgxJF19kaMeOfJzAnL6W2DZQFT4zr5d16bAholY3o4Le+NEDDgPh9A9vi3syzUP3
        JCnXNzkHeF2vVTRWGKLU8K80SEHPLzGNy50nmu/AxX3zKZuv3mlbMP4s0rie3JHdChFK
        jL2A==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZJfSYkOI="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 47.2.1 DYNA|AUTH)
        with ESMTPSA id C0b627w957jYBRk
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 5 Oct 2020 09:45:34 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Android Kernel Team <kernel-team@android.com>,
        kernel test robot <lkp@intel.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: jitterentropy - bind statically into kernel
Date:   Mon, 05 Oct 2020 09:45:33 +0200
Message-ID: <2961600.L5xXbe6F5v@tauon.chronox.de>
In-Reply-To: <CAMj1kXFL4gfrK1+zRG9sajTk62yRh3WzBG46KfKD=iM=VQMTAQ@mail.gmail.com>
References: <20200930065617.934638-1-palmerdabbelt@google.com> <2588700.mWSkj6HvKX@tauon.chronox.de> <CAMj1kXFL4gfrK1+zRG9sajTk62yRh3WzBG46KfKD=iM=VQMTAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 5. Oktober 2020, 08:44:39 CEST schrieb Ard Biesheuvel:

Hi Ard,

> On Mon, 5 Oct 2020 at 08:40, Stephan Mueller <smueller@chronox.de> wrote:
> > Am Montag, 5. Oktober 2020, 08:24:46 CEST schrieb Ard Biesheuvel:
> > 
> > Hi Ard,
> > 
> > > If jitterentropy is a special case, we could put a alternate
> > > non-'static inline' version of random_get_entropy() in the core
> > > kernel, and only export it if JITTER_ENTROPY is built as a module in
> > > the first place. But I'd prefer it if jitterentropy switches to an API
> > > that is suitable for driver consumption.
> > 
> > Which API do you have in mind? In user space, I use
> > clock_gettime(CLOCK_REALTIME) which also considers the clock source.
> 
> AFAICT, that call is backed by ktime_get_real_ts64(), which is already
> being exported to modules.
> 
> Could you please check whether that works for your driver?

Yes, will do. Thanks.

Ciao
Stephan


