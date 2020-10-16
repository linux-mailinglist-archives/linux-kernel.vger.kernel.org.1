Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D54C29021D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 11:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406213AbgJPJlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 05:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405757AbgJPJlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 05:41:45 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF52C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 02:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kY5/nlPS50tc/QzCJtgtyF62V3ySxVBkZXcvKwpXhxY=; b=a7EzGtcN/BPOAuZcqG2S/jFCG1
        v3d1/Noe9xB9YkHRjuQKiRMY7QH//b7wdBEY0J46pVkEEsvoeyZL7lPJRppbQ5Y4+Z/ZcCHNvjcpa
        1H/ERZMigSiiJ1/7f9jassoFTEkh1LvE1h+qWnmkEvGxvSoRdCcg5OK5K1iSY+aQwu8YsEW3IUWRR
        IIGEj3Dmu0868JTGN55hxYlnTKAx6eo+XiL4PUOSp0trPD4hLYzo1vJSjC1q/xgewVniBBnm/lK8A
        oFVJlSpawpOZf2PIFpkCa4CnWr+Gu09l6c6VU6sHNEkou6oe3Hx7j1cwYuOuaiMJ+2vEnTpKDzmof
        RRD5y8VQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTMEw-0003KL-Bs; Fri, 16 Oct 2020 09:41:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CEF51300DB4;
        Fri, 16 Oct 2020 11:41:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B1F952019D2CA; Fri, 16 Oct 2020 11:41:32 +0200 (CEST)
Date:   Fri, 16 Oct 2020 11:41:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Christopher M. Riedl" <cmr@codefail.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] powerpc: Mark functions called inside uaccess blocks
 w/ 'notrace'
Message-ID: <20201016094132.GI2611@hirez.programming.kicks-ass.net>
References: <20201015150159.28933-1-cmr@codefail.de>
 <20201015150159.28933-4-cmr@codefail.de>
 <20201016065616.GB9343@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016065616.GB9343@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 07:56:16AM +0100, Christoph Hellwig wrote:
> On Thu, Oct 15, 2020 at 10:01:54AM -0500, Christopher M. Riedl wrote:
> > Functions called between user_*_access_begin() and user_*_access_end()
> > should be either inlined or marked 'notrace' to prevent leaving
> > userspace access exposed. Mark any such functions relevant to signal
> > handling so that subsequent patches can call them inside uaccess blocks.
> 
> I don't think running this much code with uaccess enabled is a good
> idea.  Please refactor the code to reduce the criticial sections with
> uaccess enabled.
> 
> Btw, does powerpc already have the objtool validation that we don't
> accidentally jump out of unsafe uaccess critical sections?

It does not, there was some effort on that a while ago, but I suspect
they're waiting for the ARM64 effort to land and build on that.
