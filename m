Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A6123FD17
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Aug 2020 09:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgHIHQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Aug 2020 03:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgHIHQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 03:16:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FD562065C;
        Sun,  9 Aug 2020 07:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596957389;
        bh=kdmLQTT1+ZfSRaikynsl/nezDlKC4eIbb3+p1+WV0KU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yHCmq0RdIm8d1QbXtgmJbLtweXAuWLsRH++kWTh3I+VJDrFAze0rHbbH2wlF8dOTy
         lMdxQV9TKZ424GW8KAXM2WeWMxZZs95sR3L4bMQBhjFshoqEUxLvIoP5pDaZzdYj0j
         CnhKtgDeVxv50uWqcq6F+iMHxXJrOC68ZbPYQc18=
Date:   Sun, 9 Aug 2020 09:16:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rustam Kovhaev <rkovhaev@gmail.com>
Cc:     xujialu <xujialu@vimux.org>, masahiroy@kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: realpath "No such file or directory" warnings when building
Message-ID: <20200809071627.GC1098830@kroah.com>
References: <20200808202822.GA597061@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808202822.GA597061@thinkpad>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 08, 2020 at 01:28:22PM -0700, Rustam Kovhaev wrote:
> tags from KBUILD_OUTPUT directory
> Reply-To: 
> 
> running 'make ARCH=x86_64 COMPILED_SOURCE=1 cscope tags' in
> KBUILD_OUTPUT directory produces lots of "No such file or directory"
> warnings from realpath
> 
> it seems like commit 4f491bb6ea2a greatly improved tags generation when
> COMPILED_SOURCE=1 is set, but should we add "-q" flag for realpath in 
> all_compiled_sources() or probably it would be better to fix root cause
> and make sure that for example we don't try to find objtool sources and
> exclude other similar dirs during tags generation? what do you think?
> 
> ...
> realpath: special.h: No such file or directory
> realpath: warn.h: No such file or directory
> realpath: sigchain.c: No such file or directory
> realpath: sigchain.h: No such file or directory
> realpath: orc_gen.c: No such file or directory
> realpath: objtool.c: No such file or directory
> ...

Care to send a patch for this?

thanks,

greg k-h
