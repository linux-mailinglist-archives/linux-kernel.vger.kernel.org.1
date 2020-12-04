Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06552CE9F1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbgLDIgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:36:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727479AbgLDIgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:36:35 -0500
Date:   Fri, 4 Dec 2020 09:36:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607070948;
        bh=xrXVeRA19rHpKc9qsMMpJxvtwCWgsBKzuPRdt9bWhr4=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ftKTOAOd5E3OglR/1sPUwyQ7LkTfzKF3RoOZLWgyMnrvkNAJNMCT4m0TYzT5X02PC
         yJVPUUkZbflsPj6/jVceJODgKY9FoWuFFfzLxfSr0buI2uwZW/gdKPVWfS0mDBJFHB
         5E8aNy1QSi0Y+tFCIfrwNad2M+iN+BXBZ2HA+f6Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: Remove dead termiox code
Message-ID: <X8n1JiDS8ZVA6e6o@kroah.com>
References: <20201203020331.2394754-1-jannh@google.com>
 <5cca5126-60ba-d123-0f7d-47fdbac4c4db@kernel.org>
 <X8nwnXQKOYWBWBZ+@kroah.com>
 <93834a92-b342-aaee-c400-2883d5df0cdc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93834a92-b342-aaee-c400-2883d5df0cdc@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 09:20:39AM +0100, Jiri Slaby wrote:
> On 04. 12. 20, 9:17, Greg Kroah-Hartman wrote:
> > On Fri, Dec 04, 2020 at 08:22:41AM +0100, Jiri Slaby wrote:
> > > On 03. 12. 20, 3:03, Jann Horn wrote:
> > > > set_termiox() and the TCGETX handler bail out with -EINVAL immediately
> > > > if ->termiox is NULL, but there are no code paths that can set
> > > > ->termiox to a non-NULL pointer; and no such code paths seem to have
> > > > existed since the termiox mechanism was introduced back in
> > > > commit 1d65b4a088de ("tty: Add termiox") in v2.6.28.
> > > > Similarly, no driver actually implements .set_termiox; and it looks like
> > > > no driver ever has.
> > > 
> > > Nice!
> > > 
> > > > Delete this dead code; but leave the definition of struct termiox in the
> > > > UAPI headers intact.
> > > 
> > > I am thinking -- can/should we mark the structure as deprecated so that
> > > userspace stops using it eventually?
> > 
> > If it doesn't do anything, how can userspace even use it today?  :)
> 
> Well, right. I am in favor to remove it, BUT: what if someone tries that
> ioctl and bails out if EINVAL is returned. I mean: if they define a local
> var of that struct type and pass it to the ioctl, we would break the build
> by removing the struct completely. Even if the code didn't do anything
> useful, it still could be built. So is this very potential breakage OK?

I'm sorry, but I don't understand.  This is a kernel-internal-only
structure, right?  If someone today tries to call these ioctls, they
will get a -EINVAL error as no serial driver in the tree supports them.

If we remove the structure (i.e. what this patch does), and someone
makes an ioctl call, they will still get the same -EINVAL error they did
before.

So nothing has changed as far as userspace can tell.

Now if they have an out-of-tree serial driver that does implement this
call, then yes, they will have problems, but that's not our problem,
that is theirs for not ever submitting their code.  We don't support
in-kernel apis with no in-kernel users.

Or am I still confused?

thanks,

greg k-h
