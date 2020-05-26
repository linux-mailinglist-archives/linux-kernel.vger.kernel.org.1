Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088861CBB61
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 01:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgEHXr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 19:47:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgEHXr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 19:47:29 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72D7B2063A;
        Fri,  8 May 2020 23:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588981648;
        bh=HUQ67EEIsQVFcCahCseqAKcOIXIPY9vgvfdXk7frLUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KtDD8d0x65ztcKyvnqGKMniRC6Zdyptkx/Ipckt+eNzuHIhBbvP7e81qmQgDVt/WX
         S2rSvZNmrPDRkqTh7yPnBUfqqcl27ZnXhX9GqPxkoR7UBy9BbY6TsEOo3lrNwmG6zv
         md/3L4rib3sCdsrvvt7XR9ojmVhjNiUE73PNjnoc=
Date:   Fri, 8 May 2020 18:51:56 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] audit: Replace zero-length array with flexible-array
Message-ID: <20200508235156.GA27779@embeddedor>
References: <20200507185041.GA13930@embeddedor>
 <CAHC9VhSm_GWWXuzuwrrcTF3QcKCv1WSZv2=WF4t3DB4P7vshoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhSm_GWWXuzuwrrcTF3QcKCv1WSZv2=WF4t3DB4P7vshoA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 10:52:09PM -0400, Paul Moore wrote:
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  include/linux/audit.h |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Merged into audit/next, thanks!
> 

Thanks, Paul.

--
Gustavo
