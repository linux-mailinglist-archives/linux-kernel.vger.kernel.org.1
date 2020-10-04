Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAE828290F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 07:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgJDFRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 01:17:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:51712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgJDFRb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 01:17:31 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 086392068E;
        Sun,  4 Oct 2020 05:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601788650;
        bh=3qVFkra62m6VKWNZU53WNA9U+ftgMpquElg1Cq2XFI4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NhqtuyIEe82i8G9Be4vStwUMAmBDPW0248OyC9SmUKeof71/woFRl5hKbhd/AgvA4
         e9PxWYcnYONhtD4lSAixFMN/k6QedXA7gm/lEIo85eGpSHLC5bDP7P/ffk2+k1GgBI
         8iW2wMTpGGkt6tHdKD39yGdu8jbN1qeKp1l9CSDo=
Date:   Sun, 4 Oct 2020 07:17:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Byron Stanoszek <gandalf@winds.org>
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        "M. Vefa Bicakci" <m.v.b@runbox.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: USBIP is claiming all my USB devices - Commit 7a2f2974f265 is
 broken
Message-ID: <20201004051727.GA133949@kroah.com>
References: <alpine.LNX.2.23.451.2010031259080.4257@winds.org>
 <20201003172738.GA1526548@kroah.com>
 <alpine.LNX.2.23.451.2010031353180.5043@winds.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.23.451.2010031353180.5043@winds.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 03, 2020 at 01:54:46PM -0400, Byron Stanoszek wrote:
> On Sat, 3 Oct 2020, Greg Kroah-Hartman wrote:
> 
> > On Sat, Oct 03, 2020 at 01:18:36PM -0400, Byron Stanoszek wrote:
> > > All,
> > > 
> > > I was testing Linux 5.9-rc7 today when I realized that none of my USB devices
> > > were responding anymore. For instance, my mouse does not respond and its usual
> > > red LED is not on.
> > > 
> > > Reverting git commit 7a2f2974f265 solved the problem for me.
> > 
> > Can you try the patches listed here:
> > 	https://lore.kernel.org/r/20201003142651.GA794077@kroah.com
> > 
> > As this issue should be solved with them.  Hopefully :)
> 
> I confirm this also solved the problem for me.

Great!  Those patches are now in Linus's tree so all should be good.

thanks for testing and letting me know.

greg k-h
