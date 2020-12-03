Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 982352CDE1F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 19:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731691AbgLCS4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 13:56:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgLCS4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 13:56:47 -0500
Date:   Thu, 3 Dec 2020 19:57:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607021766;
        bh=OqCtaXAc83XAziJ60WcmvXio5z8n15J9SDIYOmxMMNw=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=yZWojBvM3upIyJEYAEqhlfJx1oaX/XVeJlGhpe8EzP9ADCZqJraYwIy/JtQVMXcaf
         s+iQqCMfjEM48Qkd/tpNLU5l/Y+oc0WJo4G+Fo9egVo8K9uGAeEzAtGu01dYPbGkNp
         tlMtfsCo4K+cxSv774UXAv0FiFJ1jc3QYjRFUJLU=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Aditya <yashsri421@gmail.com>, Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-kernel-mentees] [PATCH -mmots] checkpatch: add fix for
 non-standard signature - co-authored-by
Message-ID: <X8k1CaSlaJpJdmcC@kroah.com>
References: <280235acc0e91365f3fd3b5be5a5244eced1ff61.camel@perches.com>
 <20201202183045.9309-1-yashsri421@gmail.com>
 <5afbcd1423ee8fc2dfad191d94aef6efc17198c8.camel@perches.com>
 <a2c74693-93ae-cd5a-7836-4ffff643fc09@gmail.com>
 <CAKXUXMxPMdGmnOWdYnS0VQXaAH9dTe7uNfUUPp-GLy2xTXuABw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXUXMxPMdGmnOWdYnS0VQXaAH9dTe7uNfUUPp-GLy2xTXuABw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 11:59:54AM +0100, Lukas Bulwahn wrote:
> On Thu, Dec 3, 2020 at 10:59 AM Aditya <yashsri421@gmail.com> wrote:
> >
> > On 3/12/20 12:26 am, Joe Perches wrote:
> > > On Thu, 2020-12-03 at 00:00 +0530, Aditya Srivastava wrote:
> > >> Currently, checkpatch.pl warns us for BAD_SIGN_OFF on the usage of
> > >> non-standard signatures.
> > >>
> > >> An evaluation on v4.13..v5.8 showed that out of 539 warnings due to
> > >> non-standard signatures, 43 are due to the use of 'Co-authored-by'
> > >> tag, which may seem correct, but is not standard.
> > >>
> > >> The standard signature equivalent for 'Co-authored-by' is
> > >> 'Co-developed-by'.
> > >
> > > I'm not going to ack this as I don't mind non-standard signatures.
> > >
> >
> > What do you suggest?
> > Should I drop this patch and move on?
> >
> 
> Joe does not ack this, but he also does not nack it.
> 
> You either move on (which is perfectly fine), or
> 
> you either wait that Andrew Morton reviews it and accepts it because
> he thinks it useful, or
> 
> you reach out to the git committers that have been using
> Co-authored-by in the past and ask them if this kind of feature would
> have been helpful for them and you get an ack from them that convinces
> Andrew Morton to pick this.

co-developed-by is the correct tag for this.  It is documented exactly
for this reason, please do not try to use something that is not already
accepted by the kernel developers for this type of thing.

thanks,

greg k-h
