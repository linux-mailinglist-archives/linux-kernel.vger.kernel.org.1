Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D06728D5B5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 22:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgJMUr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 16:47:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:55090 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgJMUr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 16:47:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7F66EACA3;
        Tue, 13 Oct 2020 20:47:56 +0000 (UTC)
Date:   Tue, 13 Oct 2020 22:47:45 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL -v2] x86/asm updates for v5.10
Message-ID: <20201013204745.GL32151@zn.tnic>
References: <20201012110557.GK25311@zn.tnic>
 <20201013094149.GA32151@zn.tnic>
 <CAHk-=wjAQd22+EWBL6TzmOJom_H2TjU5AAOT+ZkxjW3kbYymcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjAQd22+EWBL6TzmOJom_H2TjU5AAOT+ZkxjW3kbYymcQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 13, 2020 at 01:39:01PM -0700, Linus Torvalds wrote:
> Actually, I think you forgot to push out the updated thing, I still
> see the same contents of the pull.

Blergh, that tag is still pointing to the old branch:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/tag/?h=x86_asm_for_v5.10

even though I wrote a new one and pushed it. Otherwise I wouldnt've been
able to create the v2 pull request message.

However, I used the same tag name and force-pushed and perhaps there it
didn't do what I wanted it to do. Sorry about that - I'll recheck stuff
like that in the future.

> Which I guess is ok, since Uros has convinced me that the xorl
> conversion is safe even for the byte cases.
> 
> So I've pulled that unmodified branch.

Aha, ok, sounds good too.

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
-- 
