Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E25B21F8AC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 20:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgGNSAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 14:00:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbgGNSAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:00:39 -0400
Received: from embeddedor (unknown [201.162.240.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7540522582;
        Tue, 14 Jul 2020 18:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594749639;
        bh=3/I2eTVPWqvrsySRhFsLdL2VS130lm9nIDIg6wCK//Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aFWSPCFqzRP4iRvQgv8DRsG9NhBv6ElfZROED0uvt+26WJ3714qsCtztlEWqgPOB3
         CTWJux3REx/kZEqn284Yfd30b4TzC1sN5sW8WdMjxRqepIVKsM7QzZ1fVD3EDdaNgl
         DXlOBuEJso4aLPQP8erdbhFDOvqNzGaiQ3yphLwg=
Date:   Tue, 14 Jul 2020 13:06:11 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] hpilo: Replace one-element array with
 flexible-array member
Message-ID: <20200714180611.GA30749@embeddedor>
References: <20200714154449.GA26153@embeddedor>
 <20200714161948.GA2092551@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200714161948.GA2092551@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 06:19:48PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Jul 14, 2020 at 10:44:49AM -0500, Gustavo A. R. Silva wrote:
> > There is a regular need in the kernel to provide a way to declare
> > having a dynamically sized set of trailing elements in a structure.
> > Kernel code should always use “flexible array members”[1] for these
> > cases. The older style of one-element or zero-length arrays should
> > no longer be used[2].
> > 
> > For this particular case, it is important to notice that the cachelines
> > change from 7 to 6 after the flexible-array conversion:
> 
> That's really funny to see.  Nice work, I'll go queue this up.  I doubt
> anyone will notice as this is a very old driver :)
> 

Yep; by the way, notice the link to the Kernel CI test results:

https://github.com/GustavoARSilva/linux-hardening/blob/master/cii/kernel-ci/hpilo-20200714.md

I plan to add the generation --and inclusion in the changelog text-- of
such links to my workflow, whenever possible.

When Kernel CI reports 'SUCCESS', they don't send the report to any mailing
list; they only send those reports to the maintainers/developers. So. I'm
going to store the ones I get in this github repository:

https://github.com/GustavoARSilva/linux-hardening/tree/master/cii/kernel-ci/

Thanks
--
Gustavo
