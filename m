Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECB1295087
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502922AbgJUQOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395293AbgJUQOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:14:04 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5830F2087D;
        Wed, 21 Oct 2020 16:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603296844;
        bh=i2r8+LLdXk82cLTC6WhfL3hmWJYUtjMthlbx3M7e3vU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7mQu3kONyq4FHBUhDPUDm7RWPDAkDIlY0FUuRhTIoILQOeGMgizsR/oKvnIRDjHc
         eW2E8gEiIzI2zdX2F5PlBlyeNwMmNPPyhSrHrG5BqzLzGnymTzCpRb5aezXiTsPeT9
         dxJWmvktmRa5Qs2kuXLD1Hb0DEe+XeW1ib2RLRR0=
Date:   Wed, 21 Oct 2020 18:14:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ziyi Cao <kernel@septs.pw>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: serial: option: add Quectel EC200T module
 support
Message-ID: <20201021161443.GA1197225@kroah.com>
References: <17f8a2a3-ce0f-4be7-8544-8fdf286907d0@www.fastmail.com>
 <209b0a93-ff0e-4e1a-b180-92e8f6214fb2@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <209b0a93-ff0e-4e1a-b180-92e8f6214fb2@www.fastmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 12:05:55AM +0800, Ziyi Cao wrote:
> Request to accept this patch, thanks.
> 
> On Tue, Oct 20, 2020, at 00:08, Ziyi Cao wrote:

It's been less than days, in the middle of the merge window, when we are
all totally busy and we can't take patches anyway.

Please relax, there is no rush.  If, after 2 weeks of not hearing
anything, then it is ok to ask what is up with a patch, or to resend it.

But to top-post after 1 1/2 days?  That's a recipe to get your patch
ignored :(

thanks,

greg k-h
