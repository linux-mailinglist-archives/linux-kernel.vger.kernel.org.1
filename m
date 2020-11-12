Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6131F2B0D05
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 19:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgKLSxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 13:53:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgKLSxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 13:53:06 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 990AA22228;
        Thu, 12 Nov 2020 18:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605207186;
        bh=c/e5tsEv43Yt5+CaOvP8oVoxcTKUl1FT9+Ff9Ppt774=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kGOf3eWckxp1f+m0XDYkYRGAnFOwisWpR/k6rLYnQn9lbGdXI1xH3in9/v0sfB7Iy
         hA5SLwQmOWnH5TFmI9Yn5rqj8DvHHeF6n0HRzzx407cW5dgZUH+3tOF3gb0n+MRiIC
         uXucGG/+0bzpjrqM8x6jnEC731g91b6FLz/abUw4=
Date:   Thu, 12 Nov 2020 19:54:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Boero <boeroboy@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: Null deref in kernel with USB webcams.
Message-ID: <X62Ey+xUIs+9Un19@kroah.com>
References: <CAO5W59jOWuRKizngF8vv9jb-zr_HnLC2eNxKqi3AYwg8KLwKoA@mail.gmail.com>
 <X61rce8GANHW1ysh@kroah.com>
 <CAO5W59iGm3kN-HhA_g78iJH9cV3fHzjQORM_b3xqo1Mg+XEi2g@mail.gmail.com>
 <X613chtPVIg8kquH@kroah.com>
 <CAO5W59jZdDgSBE3Tr79u7TuCrdsirhisFxKH6aCH5oE4soOz1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO5W59jZdDgSBE3Tr79u7TuCrdsirhisFxKH6aCH5oE4soOz1g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 06:15:08PM +0000, John Boero wrote:
> Then why does line 278 right below it check for NULL?

I am sorry, but there is no context here at all.  There's a reason you
don't top-post for technical discussions :)

thanks,

greg k-h
