Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144CD2AE0D8
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 21:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731227AbgKJUmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 15:42:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:55296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKJUmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 15:42:00 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDCC22064B;
        Tue, 10 Nov 2020 20:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605040920;
        bh=vQgHP6egw+Md3Vr6n6YyK1fyvE/8NWCrMT/RqbKjRfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HuP5yW2pvELmkCto0fgddsx6Y+qMD5fMjwAmzuNd+5oW/r6sk4JfkZWwFw/CerZVG
         aGvc6Jk/vVK83wMT6lWJGXdQfaqaL2DZZxRWDkQRYUDXLK/u5Gg94vwI9kCnKHBmAl
         1/U1G07GGwKHlpdLxyOVCV5NHgs0m6oUMt1d/6qs=
Date:   Tue, 10 Nov 2020 21:43:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, keescook@chromium.org, peterz@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] seqnum_ops: Introduce Sequence Number Ops
Message-ID: <X6r7Vl45bgGQiAD2@kroah.com>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
 <X6r7BIG8JTUOLcY0@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X6r7BIG8JTUOLcY0@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 09:41:40PM +0100, Greg KH wrote:
> On Tue, Nov 10, 2020 at 12:53:27PM -0700, Shuah Khan wrote:
> > +Decrement interface
> > +-------------------
> > +
> > +Decrements sequence number and doesn't return the new value. ::
> > +
> > +        seqnum32_dec() --> atomic_dec()
> > +        seqnum64_dec() --> atomic64_dec()
> 
> Why would you need to decrement a sequence number?  Shouldn't they just
> always go up?
> 
> I see you use them in your patch 12/13, but I don't think that really is
> a sequence number there, but rather just some other odd value :)

Note, other than this, I like the idea.  It makes it obvious what these
atomic variables are being used for, and they can't be abused for other
things.  Nice work.

thanks,

greg k-h
