Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CB420BFF3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jun 2020 10:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgF0IDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Jun 2020 04:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:48868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgF0IDL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 04:03:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 052B72081A;
        Sat, 27 Jun 2020 08:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593244991;
        bh=FxmCdS8O54mxRzyX22UP4gP8aPWMTFqpBboIyM9uHy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BGa5vpvy7dZu4hmc66dH6NPCZZDnW2jk6ItxrDlnt6TtPKx4m6V882Xm1ot0+MI2t
         asMaMgs37mK9j1TCA7xzjIWGXCMiPiv2GamUQ77dUxJe+UCsx+uR4gjgfcRCaCSIkA
         UoLMHW2WCL1O4nBDaa7B11hn+0XpsNSl9DjemI+w=
Date:   Sat, 27 Jun 2020 10:03:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     richard.gong@linux.intel.com, atull@kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH V3] firmware: stratix10-svc: Fix some error handling code
Message-ID: <20200627080305.GB1547070@kroah.com>
References: <0ecc14c7-b4df-1890-fbe7-91307c2db398@wanadoo.fr>
 <20200626193720.949431-1-christophe.jaillet@wanadoo.fr>
 <20200627051556.GD233327@kroah.com>
 <eb3ed7ba-902e-8ecf-1246-82ce88efd436@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb3ed7ba-902e-8ecf-1246-82ce88efd436@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 09:31:27AM +0200, Marion & Christophe JAILLET wrote:
> 
> Le 27/06/2020 à 07:15, Greg KH a écrit :
> > On Fri, Jun 26, 2020 at 09:37:20PM +0200, Christophe JAILLET wrote:
> > > ---
> > > v2: takes Dan's comment into account and fix another resource leak.
> > > v3: merge the previous 4 patches in a single one to ease review
> > 
> > No, 4 small patches are _MUCH_ easier to review than one larger one that
> > mixes everything together.  Who told you to put them together?
> 
> The cover letter of v2 serie can be found at [1].
> The request for merging them in 1 patch is in [2].
> 
> V3, should be the same as v2, but all in one.
> 
> [1]: https://lkml.org/lkml/2020/4/29/77
> [2]: https://lkml.org/lkml/2020/5/5/541

Please use lore.kernel.org in the future, we don't control lkml.org and
can't rely on it.

Anyway, that request was incorrect, sorry.  Please keep them split up in
a way that makes it easy to review.

Which would you want to read if you had to review hundreds of patches?

thanks,

greg k-h
