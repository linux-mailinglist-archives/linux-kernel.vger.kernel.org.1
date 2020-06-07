Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869591F0CCF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jun 2020 18:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgFGQLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jun 2020 12:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgFGQLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 12:11:48 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AF6C08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=njlruQYuAV0d21dmSUrYb6a5f5iQ0Xnz6igzcVOYFeY=; b=sCen6iQUxrv+B3NZP/uU3Z8u3
        1vWhrMKVqis6hCQ+QNKmV2K3mjA15DOW5Ao25BSqS5Rx5WjHVzx+C1cu0TmpFpgpMFPO5BByWsDRv
        fPlRzXYqnz3GZ6Wn+xCLDAi7faJzdrEIus4VmvX989nXY3nnMAQkg9bG7ZUe4lNvE2eU7WwwxuwT8
        TQOOhWBtl10+jvLCM4DqgT6qMZkdjGklrmv3baVitSRy7YElSiQ7+lu+BxirodBnOPqGyYWwV33uN
        +7x+gu+Kv+eHxhY5li99oodfEVfkS41PIkTOpwRB+pNyx/cA4n7Lthnzb1fiQFW6JMZ1/d1luoj2/
        BvWDLhxaw==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:40082)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jhxtQ-0006jA-0t; Sun, 07 Jun 2020 17:11:33 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jhxtE-0001Dc-K3; Sun, 07 Jun 2020 17:11:16 +0100
Date:   Sun, 7 Jun 2020 17:11:16 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ARM: vmsplit 4g/4g
Message-ID: <20200607161116.GN1551@shell.armlinux.org.uk>
References: <CAK8P3a0=+aBJLTvHOskTv=tba_s5b5MzWrYG8mxH3iLNy4hfBw@mail.gmail.com>
 <20200512104758.GA12980@afzalpc>
 <CAK8P3a1DQWG1+ab2+vQ2XCAKYxPUjJk5g3W3094j-adDXSQfzQ@mail.gmail.com>
 <20200514111755.GA4997@afzalpc>
 <CAK8P3a2PNZY-9L9+SFDLtrp731ZGo6Nbs-7jY6E2PwWXa0kfKw@mail.gmail.com>
 <20200514133545.GA5020@afzalpc>
 <CAK8P3a1PVwkAi8ycUAB-7EMk4nQ_qOu0rC5vJAQk_q9j5xvOJw@mail.gmail.com>
 <20200516060624.GA6371@afzalpc>
 <CAK8P3a01FYoWY9sZKU1q=UQ3ut4srwXXUeGRzW6APi+GpoKo1w@mail.gmail.com>
 <20200607125932.GA4576@afzalpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607125932.GA4576@afzalpc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 07, 2020 at 06:29:32PM +0530, afzal mohammed wrote:
> Hi,
> 
> On Sat, May 16, 2020 at 09:35:57AM +0200, Arnd Bergmann wrote:
> > On Sat, May 16, 2020 at 8:06 AM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
> 
> > > Okay, so the conclusion i take is,
> > > 1. VMSPLIT 4G/4G have to live alongside highmem
> > > 2. For user space copy, do pinning followed by kmap
> 
> > Right, though kmap_atomic() should be sufficient here
> > because it is always a short-lived mapping.
> 
> get_user_pages_fast() followed by kmap_atomic() & then memcpy() seems
> to work in principle for user copy.

Have you done any performance evaluation of the changes yet? I think
it would be a good idea to keep that in the picture. If there's any
significant regression, then that will need addressing.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up
