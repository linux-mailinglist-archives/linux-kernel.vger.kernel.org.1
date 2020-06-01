Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830EF1EAE3F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 20:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbgFASwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 14:52:14 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41974 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728474AbgFASwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:52:07 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id C5C332A2313;
        Mon,  1 Jun 2020 19:52:05 +0100 (BST)
Date:   Mon, 1 Jun 2020 20:52:03 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] i3c: Changes for 5.8
Message-ID: <20200601205203.7677efc1@collabora.com>
In-Reply-To: <CAHk-=whW82ewxKJjaFq=96eEpCMN0=DtaZxX9ZGBH7BTgTkEfQ@mail.gmail.com>
References: <20200601095423.00ffb5e1@collabora.com>
        <CAHk-=whW82ewxKJjaFq=96eEpCMN0=DtaZxX9ZGBH7BTgTkEfQ@mail.gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

On Mon, 1 Jun 2020 11:39:05 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Jun 1, 2020 at 12:54 AM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git i3c/for-5.8  
> 
> Hmm. No such ref..
> 
> I see the "i3c/next" branch that has that top commit, but I don't see
> the signed tag.

Oops, should be here now.

> 
> Forgot to push?

I pushed it, but maybe not to the right repo.

> "git request-pull" _should_ have warned about the
> remote side missing..

Yes, it warned me about that but there used to be a slight delay
between the time I push at tag to the repo and the time it actually
appears there in the past (maybe it's no longer the case), so I didn't
pay attention to that one. I'll try to be more careful next time. Sorry
for the inconvenience.

Regards,

Boris
