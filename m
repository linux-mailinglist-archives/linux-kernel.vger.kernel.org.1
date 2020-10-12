Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6A228BBA7
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389797AbgJLPRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:34524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389142AbgJLPRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:17:39 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B54A8206CA;
        Mon, 12 Oct 2020 15:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602515857;
        bh=1xZhHA/uDuJ7Gy1WDUFXCvtNvBHEC12Qmx8K7X14idw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sj/jL+LdugfJz86Zym6e2oM0sHSAKq0djYYcEJUbRr1EvI7OX09bls/61ZmVETZc4
         639Zk/cOlV3aKBT0yvYY4Bya6mZmkXlTTex/88TI0ptadYj/86lztw/lOiDfVwLc8d
         wEqSm/xSHV/NprwRAo5n7Q3au5mprYhc86J8WV60=
Date:   Mon, 12 Oct 2020 17:18:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        linux-kernel@vger.kernel.org, linux-safety@lists.elisa.tech,
        linux-usb@vger.kernel.org
Subject: Re: [linux-safety] [PATCH] usb: host: ehci-sched: add comment about
 find_tt() not returning error
Message-ID: <20201012151816.GA1559916@kroah.com>
References: <20201011205008.24369-1-sudipm.mukherjee@gmail.com>
 <alpine.DEB.2.21.2010121550300.6487@felia>
 <20201012145710.GA631710@rowland.harvard.edu>
 <alpine.DEB.2.21.2010121659040.6487@felia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2010121659040.6487@felia>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 05:10:21PM +0200, Lukas Bulwahn wrote:
> And for the static analysis finding, we need to find a way to ignore this 
> finding without simply ignoring all findings or new findings that just 
> look very similar to the original finding, but which are valid.

Then I suggest you fix the tool that "flagged" this, surely this is not
the only thing it detected with a test like this, right?

What tool reported this?

thanks,

greg k-h
