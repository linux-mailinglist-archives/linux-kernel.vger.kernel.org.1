Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA6D28CAA5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 10:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404185AbgJMIxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 04:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:60788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404181AbgJMIwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 04:52:45 -0400
Received: from coco.lan (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B202208D5;
        Tue, 13 Oct 2020 08:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602579165;
        bh=aJgA6ExP0DSm6nBNCKO0momyiW8rATBh/N/tjVwFoX4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZywSp6g3fnrc+dDQMTMevQ8bcDbXccGRW63CJVA2KMFyTFl0jxAgzSVH8Aw8PNDz+
         j3v4uCB0LjBf6Jn4L/HdYC8dTD5oBNRwMhesK4lvxwmxta4Z03kHimqRZ47PVUBLjb
         Bthn3zxlJZejgxmGxKBjUTeAZMI9LPBgnxdP+pGQ=
Date:   Tue, 13 Oct 2020 10:52:39 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: fix broken doc refs due to yaml
 conversion
Message-ID: <20201013105239.348efc0c@coco.lan>
In-Reply-To: <20201012192114.GA1938842@bogus>
References: <cover.1602245659.git.mchehab+huawei@kernel.org>
        <ba7319ab47bc7e80a57667f700ab677ceaa3ca8c.1602245659.git.mchehab+huawei@kernel.org>
        <20201012192114.GA1938842@bogus>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 12 Oct 2020 14:21:14 -0500
Rob Herring <robh@kernel.org> escreveu:

> On Fri, Oct 09, 2020 at 02:15:30PM +0200, Mauro Carvalho Chehab wrote:
> > Several *.txt files got converted to yaml. Update their
> > references at MAINTAINERS file accordingly.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/clock/hi6220-clock.txt | 2 +-
> >  MAINTAINERS                                              | 9 ++++-----
> >  .../devicetree/bindings/net/wireless/silabs,wfx.yaml     | 2 +-
> >  3 files changed, 6 insertions(+), 7 deletions(-)  
> 
> Doesn't apply for me.

It is based on the top of -next, so perhaps it depends on some other
changes that aren't upstream yet and comes from other trees. 

I could try to split it, but I guess the easiest way is
to just push this one by the end of the merge window, together
with the remaining patches I have left, fixing the other doc
build issues.

Would that work for you?

Thanks,
Mauro
