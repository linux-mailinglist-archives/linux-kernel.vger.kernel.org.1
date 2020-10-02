Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C5E2813D6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbgJBNPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387767AbgJBNPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:15:36 -0400
Received: from smtp1.goneo.de (smtp1.goneo.de [IPv6:2001:1640:5::8:30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67018C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 06:15:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id CC80B23F122;
        Fri,  2 Oct 2020 15:15:33 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.986
X-Spam-Level: 
X-Spam-Status: No, score=-2.986 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.086, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qib-y-r-5iat; Fri,  2 Oct 2020 15:15:33 +0200 (CEST)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPSA id E552223F069;
        Fri,  2 Oct 2020 15:15:32 +0200 (CEST)
Date:   Fri, 2 Oct 2020 15:15:27 +0200
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 33/33] auxdisplay: add a driver for lcd2s character
 display
Message-ID: <20201002131527.d7tthjxym3bcugfv@lem-wkst-02.lemonage>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <20200921144645.2061313-1-poeschel@lemonage.de>
 <20200921144645.2061313-34-poeschel@lemonage.de>
 <20201002124249.GA10628@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002124249.GA10628@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 02:42:49PM +0200, Pavel Machek wrote:
> Hi!
> 
> > From: Lars Poeschel <poeschel@lemonage.de>
> > 
> > This driver allows to use a lcd2s 20x4 character display from modtronix
> > engineering as an auxdisplay charlcd device.
> 
> Is there userland interface documenteted somewhere? I tried to grep
> through Documentation and did not find anything useful :-(.

I am also not aware of any userland documentation. But this driver does
not have any userland facing parts. ;-)

Regards,
Lars
