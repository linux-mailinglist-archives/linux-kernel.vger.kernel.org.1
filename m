Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C2525B40F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 20:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgIBSoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 14:44:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbgIBSox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:44:53 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE8722083B;
        Wed,  2 Sep 2020 18:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599072293;
        bh=JGk7LSAU5LH/dw5N8RtShtpaM2nsX5tomgXsw1xzhz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0t8EmjCocLj/y/w/pyEuLpfdjthKFB5AmS4vj6xjX92yI7Sxg7Rc7ujVrjwx7hVBb
         Mt2UlXTqg3x5ffhTDTf4lbEvOYYGwp3rg/CqW8CKucZqobgAIh21xxtKaQ7sjJvAal
         c8UgCHHDkVsW6cmEnrv+e/y5IJTcteHaRhEZqujU=
Date:   Wed, 2 Sep 2020 21:44:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH rdma-next 1/4] gcov: Open-code kmemdup() to work
 correctly with kernel and user space pointers
Message-ID: <20200902184449.GN59010@unreal>
References: <20200902085513.748149-1-leon@kernel.org>
 <20200902085513.748149-2-leon@kernel.org>
 <CAHk-=wiOJ4H=YFO8+EumOcrciQgeKXY1Z92jdqY8OQdprPXkbg@mail.gmail.com>
 <20200902174600.GK59010@unreal>
 <CAHk-=whG7MPx0_6S8ATd4yRPtwKTThDNtbKQDQARHbaPp2H1Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whG7MPx0_6S8ATd4yRPtwKTThDNtbKQDQARHbaPp2H1Wg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 11:27:14AM -0700, Linus Torvalds wrote:
> On Wed, Sep 2, 2020 at 10:46 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > Definitely my explanation is wrong, but it was my interpretation of
> > "BUG: KASAN: global-out-of-bounds in kmemdup+0x43/0x70" line. I saw
> > that the failure was in memcpy() inside of kmemdup(), so I changed
> > from memcpy to be copy_from_user() and it solved the KASAN warning.
>
> But the actual patch attached to that explanation *doesn't* use
> copy_from_user().
>
> So your "changed from memcpy to be copy_from_user() solved the KASAN
> warning" explanation makes even less sense. Because that's not at all
> what the patch does.

I already don't remember why, but copy_from_user() caused to second flow
of gcov_info_dup() through gcov_event() to generate another set of warnings.

As a summary, I have a workaround, but I don't know why it works and not
proud about it.

Thanks

>
>              Linus
