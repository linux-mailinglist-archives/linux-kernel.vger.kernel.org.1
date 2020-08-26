Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 770172537EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 21:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgHZTMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 15:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbgHZTMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:12:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90240207BC;
        Wed, 26 Aug 2020 19:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598469173;
        bh=8Zc/chi3NxO+6elc47lH3tAJjLn9eDjGU2FGAXhKkhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yE0LDUHi83oMtbJyjIl8P75e9ikwuBST72n9tjbj70ZamvIXQ8YrwaaPY13cODlFB
         6fJushKd31li5vOpUkPq4qtm/GJLRu0lqCY4oQs/DGyTHfYbVQC86ll3tKq8gdmMzE
         pOdAu7NcCpS0hMnLbZ2hxIQU6wYRSYkqkHH0iTec=
Date:   Wed, 26 Aug 2020 21:13:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: [GIT PULL] USB fixes for 5.9-rc3
Message-ID: <20200826191307.GA71779@kroah.com>
References: <20200826134315.GA3882506@kroah.com>
 <CAHk-=wiMMTpFxd9q7roL+L6dZb3JoQYCF0uP4+7RNHFHbfC29Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiMMTpFxd9q7roL+L6dZb3JoQYCF0uP4+7RNHFHbfC29Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 10:18:23AM -0700, Linus Torvalds wrote:
> On Wed, Aug 26, 2020 at 6:43 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > USB fixes for 5.9-rc3
> 
> I'm dropping this, since it seems to break things more than it fixes.
> 
> I see that the breakage is already figured out, but I'll just wait for
> the next fixes pull with the fix for the problem.

No worries, I'll fix this up and send a new pull request later this
week, sorry for the trouble,

greg k-h
