Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BAC2CEA80
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 10:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgLDJJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 04:09:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:43416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbgLDJJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 04:09:52 -0500
Date:   Fri, 4 Dec 2020 10:10:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607072952;
        bh=dHN4FrfyhpfVhI7AQNwFreA2S92urqF4EB45O0yPO2c=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=y+BhaWZ4BYpQtbC69d3vUykCKS0B0k4JDFj8oSvIoDVK/cpOVI+VEOylIVjmQ5YyS
         +mqi4KulEy6w0qUsUK5dsjDv2JzxmqEoGeJroxxv642zCq5JQiMX2czt5JhcFtB81y
         3okgAkDoxvL5kV5BAuwuez+Jj5jKiqpkIahaDBTY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: Remove dead termiox code
Message-ID: <X8n8+Dhi9RT4bfHk@kroah.com>
References: <20201203020331.2394754-1-jannh@google.com>
 <5cca5126-60ba-d123-0f7d-47fdbac4c4db@kernel.org>
 <X8nwnXQKOYWBWBZ+@kroah.com>
 <93834a92-b342-aaee-c400-2883d5df0cdc@kernel.org>
 <X8n1JiDS8ZVA6e6o@kroah.com>
 <8e993706-46e2-cbed-265f-1ba63cc9274d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e993706-46e2-cbed-265f-1ba63cc9274d@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 04, 2020 at 09:51:07AM +0100, Jiri Slaby wrote:
> On 04. 12. 20, 9:36, Greg Kroah-Hartman wrote:
> > On Fri, Dec 04, 2020 at 09:20:39AM +0100, Jiri Slaby wrote:
> > > On 04. 12. 20, 9:17, Greg Kroah-Hartman wrote:
> > > > On Fri, Dec 04, 2020 at 08:22:41AM +0100, Jiri Slaby wrote:
> > > > > On 03. 12. 20, 3:03, Jann Horn wrote:
> > > > > > set_termiox() and the TCGETX handler bail out with -EINVAL immediately
> > > > > > if ->termiox is NULL, but there are no code paths that can set
> > > > > > ->termiox to a non-NULL pointer; and no such code paths seem to have
> > > > > > existed since the termiox mechanism was introduced back in
> > > > > > commit 1d65b4a088de ("tty: Add termiox") in v2.6.28.
> > > > > > Similarly, no driver actually implements .set_termiox; and it looks like
> > > > > > no driver ever has.
> > > > > 
> > > > > Nice!
> > > > > 
> > > > > > Delete this dead code; but leave the definition of struct termiox in the
> > > > > > UAPI headers intact.
> 
> Note this ^^^^^. He is talking about _not_ touching the definition in the
> UAPI header. Does the rest below makes more sense now?

No, I'm still confused :)

We can't touch the UAPI definitions, but the fact that this api never
did anything still is ok as after this patch it continues to not do
anything.

I'm confused as to what you are proposing...

greg k-h
