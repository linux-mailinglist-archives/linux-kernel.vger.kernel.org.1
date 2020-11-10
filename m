Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DA62AE0D3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 21:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbgKJUkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 15:40:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgKJUkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 15:40:40 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5DEB2064B;
        Tue, 10 Nov 2020 20:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605040838;
        bh=ygQ77iajMW+rFVqEi8lB/U24W0TwnixggGc9eDY9Rco=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nahDtk9mLCqh4d2DbcHNT3CX0J6+9ubHWLwNUhBOWKqEitASVQFphddU0ddyjtVIt
         r0Si4k8Uw2FcDhI5C0Xo04MezhjEXJNMaH35m9HZZE1diIRvpwR81qp0vQ3bQLOjd2
         spSTUxWrZG7sPQ7l7OOFxJjKsvcFKDB7eWP452PM=
Date:   Tue, 10 Nov 2020 21:41:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     corbet@lwn.net, keescook@chromium.org, peterz@infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/13] seqnum_ops: Introduce Sequence Number Ops
Message-ID: <X6r7BIG8JTUOLcY0@kroah.com>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
 <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 12:53:27PM -0700, Shuah Khan wrote:
> +Decrement interface
> +-------------------
> +
> +Decrements sequence number and doesn't return the new value. ::
> +
> +        seqnum32_dec() --> atomic_dec()
> +        seqnum64_dec() --> atomic64_dec()

Why would you need to decrement a sequence number?  Shouldn't they just
always go up?

I see you use them in your patch 12/13, but I don't think that really is
a sequence number there, but rather just some other odd value :)

thanks,

greg k-h
