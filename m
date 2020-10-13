Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDCE28CA82
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404002AbgJMItz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:49:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403825AbgJMIty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:49:54 -0400
Received: from coco.lan (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03BD5208D5;
        Tue, 13 Oct 2020 08:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602578994;
        bh=a443CT+7ELJK1HsOHYrEa+FiSjJIehUJ6pQRBBixPnA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xcDaVd70OlpIsITMu6jWrAbXyyZ1bdIxtBoBjzw9zt6ckGGZYLOEYIn0fr54ChD6I
         OhN/eFb0B5T8IxDBimwZvBr7Mj9X5qpfRX7Dh7v5yItbG5GphiXtziW8ivW+3J40gK
         yMe6iO/YZ2w4pu9TDPS7OBNrWB7+mTg8YIe8Cs04=
Date:   Tue, 13 Oct 2020 10:49:50 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] Documentation for 5.10
Message-ID: <20201013104950.25764be1@coco.lan>
In-Reply-To: <20201012133042.688ee6a6@lwn.net>
References: <20201012133042.688ee6a6@lwn.net>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Em Mon, 12 Oct 2020 13:30:42 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> As hoped, things calmed down for docs this cycle; fewer changes and almost
> no conflicts at all.  This pull includes:
> 
>  - A reworked and expanded user-mode Linux document
>  - Some simplifications and improvements for submitting-patches.rst
>  - An emergency fix for (some) problems with Sphinx 3.x
>  - Some welcome automarkup improvements to automatically generate
>    cross-references to struct definitions and other documents
>  - The usual collection of translation updates, typo fixes, etc.
> 
> NOTE that there will be a largish  late-window pull request coming,
> probably directly from Mauro.  Sphinx 3.x has broken a bunch of things,
> which is obnoxious, though the end result is better; fixing the problems
> requires a number of cross-tree documentation tweaks.  These are best done
> toward the end to avoid creating unnecessary conflicts with other trees.

I double-checked: after having both docs and media tree pulled upstream, 
80% of the patches should apply cleanly.

So, I just merged the ones that apply cleanly at my -next tree:

	https://git.linuxtv.org/mchehab/media-next.git/ (master branch)

If everything goes well on tomorrow's next, I'll send you a pull request
with those.

The other ones depend on merges from DRM, hwmon and other
trees. So, I'll keep rebasing them and should be sending you a late
PR by the end of the merge window, fixing the remaining doc issues.

We're aiming to have zero documentation warnings by
the end of the merge window, when built with Sphinx 2.x,
and just a handful set of warnings with Sphinx 3.1+[1].

[1] One of the limitations of Sphinx C cross-reference code,
    up to its latest version, is that it doesn't allow to have
    both a function called "foo" and a struct or enum also called
    "foo".

    With Sphinx < 3, this doesn't generate warnings, but it still
    cause troubles with cross-references. Sphinx 3.x warns
    about name clashes, but the bug was not solved yet upstream.
    They're working on Sphinx to fix that in the future:

	https://github.com/sphinx-doc/sphinx/issues/8241
	https://github.com/sphinx-doc/sphinx/issues/7819

Thanks,
Mauro
