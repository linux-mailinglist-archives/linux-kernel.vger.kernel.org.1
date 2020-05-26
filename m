Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B08191A442A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 11:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgDJJEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 05:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgDJJEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 05:04:12 -0400
Received: from linux-8ccs.fritz.box (p3EE2C7AC.dip0.t-ipconnect.de [62.226.199.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 699B9206F7;
        Fri, 10 Apr 2020 09:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586509452;
        bh=PM6i/MvjYBnIMWYOUwenrI2lkEvF3wHzVbXEjA64Lqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HFPByOHqwYgKalQLyBud+uG/f/FEDePAJjfr7BE98oDZ7DsvdS1x6o22MzFTaJCZZ
         RdNC6WdIesDt/BQxlLHSarRSX0gU9HEp1CT6Vs+b6Ul5ylwS5xjHiou9UyA+gZcsnU
         ZwRdFFQdoT2esZjRMMxmda3a5yZQT+il8FP0a3Ww=
Date:   Fri, 10 Apr 2020 11:04:08 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        keescook@chromium.org
Subject: Re: [PATCH] module: Harden STRICT_MODULE_RWX
Message-ID: <20200410090407.GA8723@linux-8ccs.fritz.box>
References: <20200403163716.GV20730@hirez.programming.kicks-ass.net>
 <20200403165631.hrxxm3pnzqa4vxln@treble>
 <alpine.LSU.2.21.2004061146590.26870@pobox.suse.cz>
 <20200406104615.GA9629@linux-8ccs>
 <20200406112732.GK20730@hirez.programming.kicks-ass.net>
 <alpine.LSU.2.21.2004070939041.1817@pobox.suse.cz>
 <alpine.LSU.2.21.2004091854280.31635@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2004091854280.31635@pobox.suse.cz>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Miroslav Benes [09/04/20 18:55 +0200]:
>> I am still wondering if there are modules out there with sections flags
>> combination which would cause the same problem with layout_sections() and
>> move_module() logic I described earlier. But that it is a separate issue.
>
>And of course I misread the condition in layout_sections() and all should
>be fine. Oh well...

Me too :-( For some reason I misread it as an exact mask match, ugh.
In any case, it looks like we are fine since we'd catch all SHF_ALLOC
sections at the minimum and they would have sh_entsize set, and we
appropriately ignore non-SHF_ALLOC sections in move_module(), so
the hypothetical problem I described earlier was incorrect.

