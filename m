Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9C21CC308
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 19:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgEIRIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 13:08:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgEIRIr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 13:08:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0847D2071C;
        Sat,  9 May 2020 17:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589044125;
        bh=SK+x+QtJMkOjWOTDF9c5W7kaKonfAERKpd7EamMSlF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0n5LVcX+gJX092CwscX+RdlddH0MH6vkbpRUMe2bYnOLotAocWNqPoBdFh25FZP36
         k+5eURSzn42ddVYfoGFsCTAWRadHGCilUELNim5eZJrrzS+tgFonEp6EBQRdssMgo9
         xOPuaUF8Kd4Lp2OBly0kFaHk5cv7sbxCYwNU8ucg=
Date:   Sat, 9 May 2020 19:08:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v2] usb: raw-gadget: fix gadget endpoint selection
Message-ID: <20200509170843.GD2482887@kroah.com>
References: <2f05fe9aa7e4bcb1bad3f6d11e48a411c901af68.1588197975.git.andreyknvl@google.com>
 <875zdabzs3.fsf@kernel.org>
 <CAAeHK+yxoYigM7uWC3cpKmCjgMLXQ1pT=MkJ7XQYCVRgZ-DdTQ@mail.gmail.com>
 <87zhahlenu.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhahlenu.fsf@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 11:02:13AM +0300, Felipe Balbi wrote:
> 
> Hi,
> 
> Andrey Konovalov <andreyknvl@google.com> writes:
> >> here you're changing userspace ABI. Aren't we going to possibly break
> >> some existing applications?
> >
> > Hi Felipe,
> >
> >  I've been working on tests for Raw Gadget for the last few weeks [1],
> > which revealed a few problems with the interface. This isn't yet
> > included into any released kernel, so my hope that changing the ABI is
> > OK during the rc stage.
> 
> Fair enough. If that's okay with Greg, it's okay with me, but then how
> do we include it into the -rc seen as it's not really a fix?
> 
> Greg, are you okay with me including such large patches during the -rc?
> They essentially add new IOCTLs to the raw-gadget interface.

Yes, as the driver only went in for -rc1, it's fine to add fixes like
this so late as we don't want to ship a -final with it in broken form.

thanks,

greg k-h
