Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7D92EEB35
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 03:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbhAHCRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 21:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbhAHCRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 21:17:37 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473FDC0612F4;
        Thu,  7 Jan 2021 18:16:51 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b8so4904311plx.0;
        Thu, 07 Jan 2021 18:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Pyc4ZaRYzaKh+DuAqPHNV2VpXxYFfX6jhSmWrxeGi9E=;
        b=IjdHLom2xDhfM/UCE3BSZJk34lNdhwQhoLOD+gyf1cZTGrhGgUgyj9XwmgkPlMTjL1
         +fF2x2VojydGmvI/YhGNkjqptQlKQjR8pbeXw/l0bU2nyTHYVPMgtRt6uJ0oE8woEh2n
         j/7JUlTtCM91OvAWfkOV9UEZDyM0slsy4Obzf95U2RmVN7dX84v9b16QbL3LyKfCOQKB
         tK8/+SuVk2dj3SxJ/hBMwBJM5LiHFIblzWOpR47tdF5LXb8T9NnvS7M/1gjHvMy68w2x
         Fw2ICNZXDG2IGPWQGrlEu0LtsYQ1MjACG5R2scYLWPrEyGinGUhAJRIb6wxC/Sm4+ja0
         2S0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Pyc4ZaRYzaKh+DuAqPHNV2VpXxYFfX6jhSmWrxeGi9E=;
        b=Jr5aYZXvyGzdPPLjZLV0w1YjH7Fwj/3z4PcaFjRpsipi+HAXgC4lQmej+aEYklw9TX
         SJ2ON4IwniJjp4yInar4EW4sLqENSl8XueZTri4vfjRfCtcttFEBqnwR/BkvYt+7XIDV
         KH8dF+tl1x5dh0JrsrA+xS+tzl2o65GF+9svCVqJIp0J3MEGMaufywumQjtT02UQ9w15
         c9dq7yU17X+K0DWzB2j4PwEu4WGZxzN/WlpgGyW9bQwwzY0fue53Nxq4KJRbjZ3fOr5A
         wCJTULvomgQg1XPJ6oSJ8zOGL3brjjEpHlRzXHtjs47ANbdD8tt/1EMdTcrn832HCAsg
         RTBw==
X-Gm-Message-State: AOAM533ej0LTvO9rFW6RtzgjD1Cu69ZBqnn2PhBu1oGCjczwbStVGV8F
        sDXDhlb2TENHpfsCOrsj2Pg=
X-Google-Smtp-Source: ABdhPJzt7Q6iNDHRNz4zJaH3R9rtLQKDQ22lBiBqHVgi1dtVSQabYnI6eIQh7hUoktL0i/QHx9If6Q==
X-Received: by 2002:a17:90a:8508:: with SMTP id l8mr1308039pjn.131.1610072210874;
        Thu, 07 Jan 2021 18:16:50 -0800 (PST)
Received: from b29397-desktop ([194.5.48.251])
        by smtp.gmail.com with ESMTPSA id h5sm8047912pgl.86.2021.01.07.18.16.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jan 2021 18:16:49 -0800 (PST)
Date:   Fri, 8 Jan 2021 10:16:42 +0800
From:   Peter Chen <hzpeterchen@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Albert Wang <albertccwang@google.com>, balbi@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "usb: gadget: Quieten gadget config message"
Message-ID: <20210108021642.GA4672@b29397-desktop>
References: <20210107090604.299270-1-albertccwang@google.com>
 <X/bZbluYJ0syB/Do@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/bZbluYJ0syB/Do@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-07 10:50:38, Greg KH wrote:
> On Thu, Jan 07, 2021 at 09:06:04AM +0000, Albert Wang wrote:
> > This reverts commit 1cbfb8c4f62d667f6b8b3948949737edb92992cc.
> > 
> > The log of USB enumeration result is a useful log and only occupies
> > one line especially when USB3 enumeration failed and then downgrade
> > to USB2.
> > 
> > Signed-off-by: Albert Wang <albertccwang@google.com>
> > ---
> >  drivers/usb/gadget/composite.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> > index c6d455f2bb92..5b0d6103a63d 100644
> > --- a/drivers/usb/gadget/composite.c
> > +++ b/drivers/usb/gadget/composite.c
> > @@ -840,9 +840,9 @@ static int set_config(struct usb_composite_dev *cdev,
> >  		result = 0;
> >  	}
> >  
> > -	DBG(cdev, "%s config #%d: %s\n",
> > -	    usb_speed_string(gadget->speed),
> > -	    number, c ? c->label : "unconfigured");
> > +	INFO(cdev, "%s config #%d: %s\n",
> > +	     usb_speed_string(gadget->speed),
> > +	     number, c ? c->label : "unconfigured");
> 
> When everything is working properly, the kernel should be quiet.  If you
> have to see this message, you can turn it on at runtime, as Felipe
> pointed out, to enable it for your system.  But it's not a good default
> thing to have.

For most production kernel (or kernel ready for customers), it may not enable
CONFIG_DYNAMIC_DEBUG.

> 
> What do you need to see this message for?  What tool relies on it?  Who
> reads it?
> 

Usually, the developer him(her)self wants to read it to know if current
USB gadget enumerated and what speed is recognized, reading from the
console by eyes is the quickest way. Without this message, there is no
any messages when the USB gadget connects to host.

If enable debug message, there are too many messages, but I think most
developers may only need one information message to know if enumeration
is established correctly.

-- 

Thanks,
Peter Chen

