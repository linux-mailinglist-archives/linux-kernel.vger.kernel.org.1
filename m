Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A0E289ECF
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 09:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgJJHC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 03:02:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728618AbgJJHAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 03:00:24 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34B76207E8;
        Sat, 10 Oct 2020 07:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602313210;
        bh=pe+4amqH5ukXnmBdCIgLvkVQzzJBofYyjsBk6c7UY18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CfnpH+QDa+0haYKPm4ZDZpqqK2ywi8pwQm5jJfbJgTcdnzRQZnH5/HJ6dDF7Q/MZA
         pnRhMrdi9IBl6F8PjxY4qk5zBEOOFGlhBM+e7CGRPgw65vIW0nOHcWuBYcn1naZp5P
         oAJed6uVvEeg4gOlEYdcsi5tsz0/ZLwAYkxq0yzw=
Date:   Sat, 10 Oct 2020 09:00:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Anant Thazhemadam <anant.thazhemadam@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>,
        syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] staging: comedi: check validity of wMaxPacketSize of usb
 endpoints found
Message-ID: <20201010070007.GB132110@kroah.com>
References: <20201009162030.293781-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009162030.293781-1-anant.thazhemadam@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 09:50:29PM +0530, Anant Thazhemadam wrote:
> While finding usb endpoints in vmk80xx_find_usb_endpoints(), check if 
> wMaxPacketSize = 0 for the endpoints found.
> 
> Some devices have isochronous endpoints that have wMaxPacketSize = 0
> (as required by the USB-2 spec).
> However, since this doesn't apply here, wMaxPacketSize = 0 can be
> considered to be invalid.
> 
> Reported-by: syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com
> Tested-by: syzbot+009f546aa1370056b1c2@syzkaller.appspotmail.com
> Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
> ---

You sent 2 patches with the same subject, which one is the "latest" one?
Please always version your patches and put below the --- line what
changed from the previous version, so that maintainers have a chance to
know which to accept...

Can you fix this up and send a v3?

thanks,
greg k-h
