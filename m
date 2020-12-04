Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3745C2CE958
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 09:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgLDIRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 03:17:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:33348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgLDIRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 03:17:08 -0500
Date:   Fri, 4 Dec 2020 09:17:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607069788;
        bh=nH8hYoVi+qYnG9o1LKOwLqM+yBq7lDyRPc4Frhyv9Ek=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=tVOcSkfCVxWnye88dEP2JLb8bDZ+B0AwPy5pfrkYuKMMr/aa4QXcTXN8JJ6ffjdEk
         HYM/QDK5tlrKR+MBmwI3MT6Dj4Cy2Abwd6S1oe3m/r6FY3alVY2iC24Ds/b5UrTYtx
         hx+qR95eVxkIBwSEGJj/bzZYA3qWQHK/PAAMRmgw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: Remove dead termiox code
Message-ID: <X8nwnXQKOYWBWBZ+@kroah.com>
References: <20201203020331.2394754-1-jannh@google.com>
 <5cca5126-60ba-d123-0f7d-47fdbac4c4db@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cca5126-60ba-d123-0f7d-47fdbac4c4db@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 08:22:41AM +0100, Jiri Slaby wrote:
> On 03. 12. 20, 3:03, Jann Horn wrote:
> > set_termiox() and the TCGETX handler bail out with -EINVAL immediately
> > if ->termiox is NULL, but there are no code paths that can set
> > ->termiox to a non-NULL pointer; and no such code paths seem to have
> > existed since the termiox mechanism was introduced back in
> > commit 1d65b4a088de ("tty: Add termiox") in v2.6.28.
> > Similarly, no driver actually implements .set_termiox; and it looks like
> > no driver ever has.
> 
> Nice!
> 
> > Delete this dead code; but leave the definition of struct termiox in the
> > UAPI headers intact.
> 
> I am thinking -- can/should we mark the structure as deprecated so that
> userspace stops using it eventually?

If it doesn't do anything, how can userspace even use it today?  :)


