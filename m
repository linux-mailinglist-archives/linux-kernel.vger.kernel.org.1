Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB4502D12B2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgLGN4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:56:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:55280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgLGN4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:56:45 -0500
Date:   Mon, 7 Dec 2020 14:57:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607349365;
        bh=j86uMV4nyGVtSMouy6rinWH1bQBectAHXQddmRlgCYE=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=yvf2FXmbvhSfU3lAlqtKMVjqPy8dj8msx3z87M9FMABLA4qNe1fID7Yb5BSLYmYGr
         MK3qeZTi1wf55JabHQVoST0ArIR/CcOQbHeKEJQCjAbUNMmoGs17QwxrvTVcuBX+4V
         K9n33H95RReOfR/ah0mbNgYtDHqeOt/3V/BufnJc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Jiri Slaby <jirislaby@kernel.org>, Jann Horn <jannh@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: Remove dead termiox code
Message-ID: <X840u5K1Y2kIHnQR@kroah.com>
References: <20201203020331.2394754-1-jannh@google.com>
 <5cca5126-60ba-d123-0f7d-47fdbac4c4db@kernel.org>
 <X8nwnXQKOYWBWBZ+@kroah.com>
 <93834a92-b342-aaee-c400-2883d5df0cdc@kernel.org>
 <X8n1JiDS8ZVA6e6o@kroah.com>
 <8e993706-46e2-cbed-265f-1ba63cc9274d@kernel.org>
 <X8n8+Dhi9RT4bfHk@kroah.com>
 <20201207101904.GC2265@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207101904.GC2265@angband.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 11:19:04AM +0100, Adam Borowski wrote:
> On Fri, Dec 04, 2020 at 10:10:16AM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Dec 04, 2020 at 09:51:07AM +0100, Jiri Slaby wrote:
> > > > > > On Fri, Dec 04, 2020 at 08:22:41AM +0100, Jiri Slaby wrote:
> > > > > > > On 03. 12. 20, 3:03, Jann Horn wrote:
> > > > > > > > Delete this dead code; but leave the definition of struct termiox in the
> > > > > > > > UAPI headers intact.
> [was snipped]
> > > > > > > I am thinking -- can/should we mark the structure as deprecated so that                                 
> > > > > > > userspace stops using it eventually?   
> 
> > > Note this ^^^^^. He is talking about _not_ touching the definition in the
> > > UAPI header. Does the rest below makes more sense now?
> > 
> > No, I'm still confused :)
> > 
> > We can't touch the UAPI definitions, but the fact that this api never
> > did anything still is ok as after this patch it continues to not do
> > anything.
> > 
> > I'm confused as to what you are proposing...
> 
> The UAPI definition can't be removed, but it would be nice to issue a
> compiler _warning_ if it's ever used.
> 
> Like eg. __attribute__ ((deprecated))

Don't add build warnings for no good reasons, that's not nice.  As the
feature just doesn't work, anyone who tries to use it will very quickly
realize that :)

thanks,

greg k-h
