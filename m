Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA9E2A1C72
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 07:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgKAGix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 01:38:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgKAGix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 01:38:53 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E05DE221FF;
        Sun,  1 Nov 2020 06:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604212732;
        bh=boYuok5ikWnQogxw2HrezS6EMElUqo+A/TC044I6YRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w9BJrjaVil+DnAbZ3Rcmd8vUdVwB8LnhFAsF0xDVEkwxcQc8m/DNLOftNU/cJP3WN
         fQX7rHX2vtSGzl7dEvmvcIYX0SSmHmyzQYhE/wheSMNDhJNexvC4rs24gRFv0uIkwu
         b/6XHcSfNZwV0X09YMjJ9mrbil7xPWUlWESd1N1w=
Date:   Sun, 1 Nov 2020 07:38:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyungtae Kim <kt0755@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH] USB: gadget: hidg: fix use-after-free in f_hidg
Message-ID: <20201101063848.GA432418@kroah.com>
References: <CAEAjamvSRv3m1XZjS7pe2HptX20w7otn6hNU4YFvt7XF4WPPng@mail.gmail.com>
 <CAEAjamuZLCHS4geFiA5j7aUrw5p0bpefLQHZeYq6CA_LwqM7Bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEAjamuZLCHS4geFiA5j7aUrw5p0bpefLQHZeYq6CA_LwqM7Bg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 10:16:05PM -0400, Kyungtae Kim wrote:
> On Wed, Oct 28, 2020 at 4:13 PM Kyungtae Kim <kt0755@gmail.com> wrote:
> >
> > FuzzUSB (a variant of syzkaller) found the bug

<snip>

You sent this 3 days ago.  Please give us a chance, at least 2 weeks, to
get to a patch when submitted.

thanks,

greg k-h
