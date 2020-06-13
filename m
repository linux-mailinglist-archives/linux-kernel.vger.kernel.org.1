Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34BF41F8168
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 08:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgFMGzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jun 2020 02:55:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:35896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgFMGzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 02:55:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E6902071A;
        Sat, 13 Jun 2020 06:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592031346;
        bh=0tUaGopau1A1iufUyqtZihsBPAAnugU54NI34jtKwac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eTbYLuzrFqHleceBVMKJCymNK4FxLLJamy41y2Uz19hj6wwo0WTH0ESx+uIy9TjkZ
         Qn9Qe5NNrxpJRXl3yvIWLwtpugwfNC/LXq41UW47tdAS2K2OHm4vX/qAyTUv/jIfcD
         WM+plkvyKeJZv2Uyg7yPLsJzVKiAPguTRsMxouto=
Date:   Sat, 13 Jun 2020 08:55:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] proc/bootconfig: Fix to use correct quotes for value
Message-ID: <20200613065543.GA2599692@kroah.com>
References: <6de85422-bdf6-e56c-1042-871b7e8a9a01@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6de85422-bdf6-e56c-1042-871b7e8a9a01@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 06:15:13PM +0200, Markus Elfring wrote:
> > Fix /proc/bootconfig to show the correctly choose the
> > double or single quotes according to the value.
> 
> I suggest to improve this wording a bit.
> 
> Regards,

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
> Markus
