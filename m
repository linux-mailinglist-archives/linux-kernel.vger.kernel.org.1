Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622081E6F3F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 00:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437255AbgE1WiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 18:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436945AbgE1WiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:38:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D3EC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5JtCJN4R91Qw51mlPzBtDAjT1k3jMKVe+nsnhQ4R1w8=; b=Dn6j24tf1xQfTci0TdCtf/EDX6
        eWvDSpUR07JtIu6SP/hvQrZkwqMYBCRTsuY8qiWAI/Bd5n++TUb1tqkKftYBDYAkkJuYT1bO51ONf
        aAcIF9nXCrdw8MebTQLNtSy0N26TyK7wqB8XNeUPpsGyOnc7h4EcFm8dvMW/BsazeKPVwKi95JjhQ
        avCEh2vKL0u2pw4LTbAtPUl2Pdnf884bipcMiEI4lbkjKDpSIjSY9TAwzhuTDO/Q7BBQAvyolr1Ns
        iPAHAscUXgGRwEr5IjghVn4JGIOrpdCFzfZdk9lj7OTMg9vS/upHxwS9x+Qi9+irdEk34Mh3ls04U
        xF4uuc6g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeR9o-0006tZ-QD; Thu, 28 May 2020 22:37:48 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4215F9834F3; Fri, 29 May 2020 00:37:46 +0200 (CEST)
Date:   Fri, 29 May 2020 00:37:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        andrew.cooper3@citrix.com, daniel.thompson@linaro.org
Subject: Re: [RFC][PATCH 6/6] x86/entry: Remove DBn stacks
Message-ID: <20200528223746.GT2483@worktop.programming.kicks-ass.net>
References: <20200528201937.038455891@infradead.org>
 <20200528202328.708732152@infradead.org>
 <CAJhGHyBsFgDRGS+kihijgH2MbnULkkUS2xfDJsNF09F782EM5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyBsFgDRGS+kihijgH2MbnULkkUS2xfDJsNF09F782EM5g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 06:35:07AM +0800, Lai Jiangshan wrote:
> There will be a compile error about N_EXCEPTION_STACKS
> in arch/x86/kernel/dumpstack_64.c. It should have
> 
> - BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
> + BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);

Yeah, I actually have that, but forgot to refresh before sending :/
