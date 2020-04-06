Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E94E619F7AE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 16:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgDFOLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 10:11:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60430 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgDFOLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Gn78OX5dA4rdgcRYaQLEv5AA355qt0lzh5/7QwQIWC8=; b=VhN7zopCHz4W+sHJkcX0LbqS3d
        p23mnKNf83ntiQiYUZRVoR3HqQsGRKqxm9Cceeh5vw0SAPOBPsq0QKqMmXolJHbbCsqfvoLDk+YJb
        EA31/1Ke487pd91SI+VWPMYGEEsxQUfoPhLw2VcUHKByDRC5BVeYDOl+sVQF/d89hACy1vP88wHaE
        Lzzq+oa5AKUx2CBFOYb2GY7ISDy0S6IJvN5sg5ceb3+kcIPKU/+hNH8zTo4SFM7fx1qcpAWQB+0rL
        bMAJBd+MgiwZENZVKRsFE3Wa0xDgQReA42uPvBNYK42xVwgjmsIiyG86KVwIxxG8ssh+eGO6l54z2
        y0SHQZZw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLSTL-00066o-GM; Mon, 06 Apr 2020 14:11:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 227913025C3;
        Mon,  6 Apr 2020 16:11:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0FD642BAC7488; Mon,  6 Apr 2020 16:11:30 +0200 (CEST)
Date:   Mon, 6 Apr 2020 16:11:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        keescook@chromium.org
Subject: Re: [PATCH] module: Harden STRICT_MODULE_RWX
Message-ID: <20200406141130.GO20730@hirez.programming.kicks-ass.net>
References: <20200403163716.GV20730@hirez.programming.kicks-ass.net>
 <20200403165631.hrxxm3pnzqa4vxln@treble>
 <alpine.LSU.2.21.2004061146590.26870@pobox.suse.cz>
 <20200406104615.GA9629@linux-8ccs>
 <20200406112732.GK20730@hirez.programming.kicks-ass.net>
 <20200406125336.GA21006@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406125336.GA21006@linux-8ccs>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 02:53:37PM +0200, Jessica Yu wrote:

> > > > > > +	for (i = 0; i < hdr->e_shnum; i++) {
> > > > > > +		if (sechdrs[i].sh_flags & (SHF_EXECINSTR|SHF_WRITE))
> > > > > > +			return -ENOEXEC;

Hehe, I'm well familiar with the brain going funny, as evidenced by the
above... :facepalm:

> Ugh sorry, my brain shorted out and for some reason I mistakenly
> thought the check excluded SHF_WRITE|SHF_EXECINSTR|SHF_ALLOC sections.
> It doesn't obviously. Sorry for the noise.
