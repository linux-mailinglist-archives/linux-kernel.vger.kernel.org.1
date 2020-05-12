Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C461CFCC0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 20:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbgELSCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 14:02:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:51114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgELSCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:02:38 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2032420673;
        Tue, 12 May 2020 18:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589306558;
        bh=Bl5AWwxvtvS15cL54qzacH1d+G/nfDGOda1PCAQWAl4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jr+4aVPsN2It+/lF2IdqdvJJGphWE9NfHtJNBjwZOtyu/zIDEpjDIjYygZmereZF1
         btnvMmE1SFEWC5DBurcL7S4Vw85Odd2mYALJlkZMRkfzXIKdtxEME9ziT+TY7KiUja
         n0P+FRK2DDU/qHppo1BbvHyN4b+BZUS+R1jDu4DI=
Date:   Tue, 12 May 2020 13:07:12 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memstick: Replace zero-length array with flexible-array
Message-ID: <20200512180712.GD4897@embeddedor>
References: <20200507192218.GA16315@embeddedor>
 <CAPDyKFqd6QKSOzZp2Cq1kMusNQYithdodk2anpWWVOiQ6w0+SQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqd6QKSOzZp2Cq1kMusNQYithdodk2anpWWVOiQ6w0+SQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 10:12:11AM +0200, Ulf Hansson wrote:
> On Thu, 7 May 2020 at 21:17, Gustavo A. R. Silva <gustavoars@kernel.org> wrote:
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Applied for next, thanks!
> 

Thanks, Uffe.

--
Gustavo
