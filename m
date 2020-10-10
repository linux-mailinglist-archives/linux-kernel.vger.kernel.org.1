Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF87289F31
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 10:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgJJIN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 04:13:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729820AbgJJIJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 04:09:07 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C808207E8;
        Sat, 10 Oct 2020 08:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602317346;
        bh=UPcr+Ibg07POMWxl1HvL2IeGuaIGl6soETIqzkJhXjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HMwOBN4IbvGaEGnave/74riINOP0cR6MsHA3Ytl9Ej1+bHp3WLTtGXHkTC/T6Ur/h
         vsuKBIZ6Oo94MAOIGD0BdsudPZN58FgsJUf/zRySLGmTEnhz+mI1rO8cz0lbnaKTYL
         A6MjC3dIF2CncvSx0CKawexv5Z4LWXzbsIhRFvkM=
Date:   Sat, 10 Oct 2020 10:09:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     devel@driverdev.osuosl.org,
        syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com,
        Ian Abbott <abbotti@mev.co.uk>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: comedi: check validity of wMaxPacketSize of usb
 endpoints found
Message-ID: <20201010080904.GA140279@kroah.com>
References: <20201009162030.293781-1-anant.thazhemadam@gmail.com>
 <20201010070007.GB132110@kroah.com>
 <b84879e9-425e-6354-d21a-cd7c5d237be5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b84879e9-425e-6354-d21a-cd7c5d237be5@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 07:29:13AM +0530, Anant Thazhemadam wrote:
> Hi,
> 
> On 10-10-2020 12:30, Greg Kroah-Hartman wrote:
> > On Fri, Oct 09, 2020 at 09:50:29PM +0530, Anant Thazhemadam wrote:
> >> While finding usb endpoints in vmk80xx_find_usb_endpoints(), check if 
> >> wMaxPacketSize = 0 for the endpoints found.
> >>
> >> Some devices have isochronous endpoints that have wMaxPacketSize = 0
> >> (as required by the USB-2 spec).
> >> However, since this doesn't apply here, wMaxPacketSize = 0 can be
> >> considered to be invalid.
> >>
> >> Reported-by: syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com
> >> Tested-by: syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com
> >> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> >> ---
> > You sent 2 patches with the same subject, which one is the "latest" one?
> 
> This patch (that you have replied to) is the "latest" one.
> 
> > Please always version your patches and put below the --- line what
> > changed from the previous version, so that maintainers have a chance to
> > know which to accept...
> 
> The other patch (with the same subject line) wasn't supposed to be sent out.
> I realized there was a coding style error in that while sending, and cancelled
> sending it, but it got sent nonetheless.
> I would have included a v2 tag in this patch itself, but I didn't realize that the
> previous one got sent until afterwards. :(
> I'm sorry for that.
> 
> > Can you fix this up and send a v3?
> 
> Shouldn't I resend this patch as a v2 instead? Since there wouldn't be any
> changes from v2 (this patch) to v3 otherwise (unless of course, somebody could
> suggest some more changes that could be made to this patch itself).

The change would be that you are correctly listing the version
information, so it would be v3 :)

thanks,

greg k-h
