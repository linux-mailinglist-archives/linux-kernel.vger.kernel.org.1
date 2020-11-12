Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63172B0A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgKLQo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:44:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:40292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728643AbgKLQo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:44:56 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5630B22201;
        Thu, 12 Nov 2020 16:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605199495;
        bh=0nhD/WqlMJ8Pv79MqKKt0vSqZj2iK1s1b6fB6XQ3BnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s0F50Ebh+SmJAcWpfQa+qpb6NcgwA9M3g77Rz2Nm6oz7QTTTjD5JSVHulMK3XvMPd
         OIMyVtHhXHGzEU+8p4rAHhw50hUyamI+5AxqT00BQR4KGH/v7+/txgZHKivBPYlZLy
         6naphLWfosq50gxir6dhjT2SdypuJneaWEvoN32g=
Date:   Thu, 12 Nov 2020 17:45:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>, corbet@lwn.net,
        peterz@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] seqnum_ops: Introduce Sequence Number Ops
Message-ID: <X61mwRe6tFrSrgQa@kroah.com>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
 <X6r7BIG8JTUOLcY0@kroah.com>
 <X6r7Vl45bgGQiAD2@kroah.com>
 <202011101614.E7D880689@keescook>
 <3075a4fd-8615-1459-2b20-b7d9d2be34ff@linuxfoundation.org>
 <20201112123621.GY17076@casper.infradead.org>
 <acad8c18-a0a6-f52c-429a-02e614bee05c@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acad8c18-a0a6-f52c-429a-02e614bee05c@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 09:17:27AM -0700, Shuah Khan wrote:
> On 11/12/20 5:36 AM, Matthew Wilcox wrote:
> > On Wed, Nov 11, 2020 at 12:23:03PM -0700, Shuah Khan wrote:
> > > > Agreed: this is a clear wrapping sequence counter. It's only abuse would
> > > > be using it in a place where wrapping actually is _not_ safe. (bikeshed:
> > > > can we call it wrap_u32 and wrap_u64?)
> > > 
> > > Still like seqnum_ops.
> > > 
> > > There is seqcount_t in seqlock.h which is a totally different feature.
> > 
> > Yes, and that's why this new thing, whatever it is called should not
> > have the word "sequence" in it.  People will get it confused.
> 
> Any suggestions for name. I am bad with coming up with names. How does
> Statcnt API and struct statcnt along the lines of your name suggestions
> in your previous email?

What does "stat" mean here?

And I don't understand the hesitation about "sequence" in a name, as
that's exactly what this is.  seqlock is different, yes.

How about "seqnum_t"?  That's what we call the sequence number that we
export to uevents, a "SEQNUM".

thanks,

greg k-h
