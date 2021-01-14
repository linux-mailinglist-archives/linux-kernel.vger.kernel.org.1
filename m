Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E522F65FA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 17:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbhANQ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 11:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbhANQ34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 11:29:56 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029D9C061575;
        Thu, 14 Jan 2021 08:29:16 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id d189so6449631oig.11;
        Thu, 14 Jan 2021 08:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lNuHwTHxLYq5cpORlTDNHqlxB525vpL/DPhAxSmcbqo=;
        b=UaMbNL9H3UaSgkfj1lAxlLmEtchZizZirxSvGLtejHiP42lmwQh9OXMIMlBhc4+8pv
         g85lXX0crapqcFaDUlApfLwm5+GsHXpfT9YhJrsrKY+Xo+PoGtodA826hZ5YQNrQU0cl
         fUd43uJjYBDt4/ZciupoPdczCF8rcTnlorBxnd0embT+xz5xVAJ7CZ0MpSn3XdwM+FcV
         ddaS28VwiNVvzeEpzCz+jHY/xXZXQneXI893Z95dfWmrEKhCMkLBo0XYa47wgD5G6RsK
         sFjWzzZ9OsobVt79Bs9w8renscbf3PcR/d3jx58SD8eLhJxK1eJpfYglxDody2Kh/R/P
         NXBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lNuHwTHxLYq5cpORlTDNHqlxB525vpL/DPhAxSmcbqo=;
        b=cSoOu5S6Z9wpN0Acvdahp/Ivbs5NLFlx/wNXUYi4kdG+mra2YYb+wq8rLMyGWTZfi6
         +q0KKQoVgtwjmh8yCUajC+LxEXjYjXMbb905HPT5u/ANN6Y8CeJfEHfBqhWnmuxBBS55
         feA2xIi4SHv7kZA2rL3fHUFtbEH82/Lyf1Lo3PS7AdapMF5Gqjcr4LYmw00wG81w8v59
         yuXIRoWxekPZwNyuuvuo02cmBfgmxuRg5Fyxkvs9On23+u953YALhiYdEw1Vu42MCy7O
         7aiEQCDTH8vIa9An9S7mJQv7Qb2YLDiY2ma9QagIk4j7xyLN3kxquMAJDknHXUU9ysYa
         jIlQ==
X-Gm-Message-State: AOAM531faKzOKi1lEff9R1AvhSdHbYmcde5yyWfQwZIkmgPG0ifRmE36
        C52z1vN1rHSAo28TyRTWAYE=
X-Google-Smtp-Source: ABdhPJx0RGfxj3cXrJRb2tKwHm/9xzMe0lDWvb0t+zgS2bR9LVK0FbrmiQEDSIia5ElWZEo5NNGdDw==
X-Received: by 2002:aca:438b:: with SMTP id q133mr3138232oia.50.1610641755362;
        Thu, 14 Jan 2021 08:29:15 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p4sm1137285oib.24.2021.01.14.08.29.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jan 2021 08:29:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 14 Jan 2021 08:29:03 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Doug Anderson <dianders@chromium.org>,
        Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
        Felipe Balbi <balbi@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Hudson <skrll@netbsd.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Minas Harutyunyan <hminas@synopsys.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] usb: dwc2: Fixes and improvements
Message-ID: <20210114162903.GA139397@roeck-us.net>
References: <20210113112052.17063-1-nsaenzjulienne@suse.de>
 <CAD=FV=VnsVgTGTkr9VYQHCkBSVVksT1UGfsmk+dqTyQ1sqF=Qw@mail.gmail.com>
 <20210114030715.GA102157@roeck-us.net>
 <9a8d9a57a1837fb7e0b17f19f089c55f955c98fc.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8d9a57a1837fb7e0b17f19f089c55f955c98fc.camel@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 10:26:25AM +0100, Nicolas Saenz Julienne wrote:
> Hi Guenter, Doug, thanks for having a look at this.
> 
> On Wed, 2021-01-13 at 19:07 -0800, Guenter Roeck wrote:
> > On Wed, Jan 13, 2021 at 03:20:55PM -0800, Doug Anderson wrote:
> > > Hi,
> > > 
> > [ ... ]
> > > 
> > > It's been long enough ago that I've forgotten where this was left off,
> > > but IIRC the 3 patches that you have here are all fine to land (and
> > > have my Reviewed-by tag).  However, I think Guenter was still tracking
> > > down additional problems.  Guenter: does that match your recollection?
> > > 
> > > It looks like there are still bugs open for this on our public bug tracker:
> > > 
> > > https://issuetracker.google.com/issues/172208170
> > > https://issuetracker.google.com/issues/172216241
> > > 
> > > ...but, as Guenter said, I don't think there's anyone actively working on them.
> > > 
> > > I'm not really doing too much with dwc2 these days either and don't
> > > currently have good HW setup for testing, so for the most part I'll
> > > leave it to you.  I wanted to at least summarize what I remembered,
> > > though!  :-)
> > > 
> > 
> > The patches in this series still match what I had in my latest test code,
> > so it makes sense to move forward with them. I don't think I ever found
> > an acceptable version of the DMA alignment code.
> 
> As for the alignment code rework, can you recall the underlying issue that
> warranted it?
> 

See

https://patchwork.kernel.org/project/linux-usb/patch/20200226210414.28133-2-linux@roeck-us.net/

for details. It isn't up to date - it says that buffer alignment to
DWC2_USB_DMA_ALIGN would be acceptable. However, it turned out in testing
that buffers do have to be aligned to dma_get_cache_alignment(), at least
on some mips systems.

My latest work-in-progress patch describes the changes made as:

    To simplify the code, move the old data pointer back to the beginning of
    the new buffer, restoring most of the original commit. Increase buffer
    alignment to dma_get_cache_alignment(). Ensure that the data pointer is
    DMA aligned by using ____cacheline_aligned instead of realigning it after
    allocation. Ensure that the allocated buffer is a multiple of
    wMaxPacketSize to guarantee that the chip does not write beyond the end
    of the buffer.

I can provide that version of the patch in case someone wants to pick it up,
but it would need thorough testing on a variety of systems before it is
applied.

Guenter
