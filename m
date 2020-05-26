Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B361CD38F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 10:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgEKINy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 04:13:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:41456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgEKINx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 04:13:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 50000AD5D;
        Mon, 11 May 2020 08:13:55 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] RISC-V Fixes for 5.7-rc5
References: <mhng-81c83c19-6f5d-4ed1-a0bb-26accf4b7d3a@palmerdabbelt-glaptop1>
        <CAHk-=win0EVU_GuO=GuJu3Ck0WG1B3+ub-CjncM3B1G9x5d9cw@mail.gmail.com>
X-Yow:  The FALAFEL SANDWICH lands on my HEAD and I become a VEGETARIAN...
Date:   Mon, 11 May 2020 10:13:52 +0200
In-Reply-To: <CAHk-=win0EVU_GuO=GuJu3Ck0WG1B3+ub-CjncM3B1G9x5d9cw@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 9 May 2020 16:26:53 -0700")
Message-ID: <mvmr1vqkhxb.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mai 09 2020, Linus Torvalds wrote:

> glibc depending on kernel version is WRONG. It's bogus. You can't do
> feature detection based on kernel version, it's fundamentally broken.
>
> So I really would prefer to see glibc fixed not to do that stupid
> thing, instead of adding pointless vdso notes to the kernel.

I'm not aware of any discussion or bug report on this issue.  Any
pointer?

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
