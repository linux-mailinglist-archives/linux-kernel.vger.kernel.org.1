Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE34244A64
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Aug 2020 15:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgHNN32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Aug 2020 09:29:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgHNN30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 09:29:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A467A20866;
        Fri, 14 Aug 2020 13:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597411766;
        bh=M8IpowAfT+qBbeI+kIkA0UlQOUYyX+jTYiiQpIPwmw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F56Y4rVIhbN+6XtGPSMHwM5TPr7H/j7x7kEXaCkwOgLXodlV7qRVA7/UjhjKwlkUN
         Le0wU5p/acM1m7zqwOG+LrvENCWLf8vxnftr/3iVMuLat3mnKNV+V0LgVhgEOiBZQl
         ptu2WfHluw1yb3UfxR2Y/PGPxxVh5lPilnafn3Uw=
Date:   Fri, 14 Aug 2020 15:29:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
Subject: Re: [PATCH v2] scripts: coccicheck: Change default value for
 parallelism
Message-ID: <20200814132948.GA62819@kroah.com>
References: <7733e0b3-91f2-0033-75d6-77947253bfeb@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7733e0b3-91f2-0033-75d6-77947253bfeb@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 03:06:06PM +0200, Markus Elfring wrote:
> > a decrease in performance is noted. The elapsed time is  minimum
> 
> Can the following wording variant be more appropriate?
> 
>   a decrease was noticed in the software performance. The elapsed time is minimal
> 
> 
> > respectively for two separate runs. …
> 
> Can such information trigger further considerations for benchmarking approaches?
> 
> Regards,
> Markus


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
