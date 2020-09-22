Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E3B273EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 11:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgIVJod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 05:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgIVJod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:44:33 -0400
Received: from smtp2-2.goneo.de (smtp2.goneo.de [IPv6:2001:1640:5::8:33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5544C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 02:44:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 2A76B23F72E;
        Tue, 22 Sep 2020 11:44:31 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -3.004
X-Spam-Level: 
X-Spam-Status: No, score=-3.004 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.104, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P4sCyejnBAcN; Tue, 22 Sep 2020 11:44:28 +0200 (CEST)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp2.goneo.de (Postfix) with ESMTPSA id 91700242674;
        Tue, 22 Sep 2020 11:44:28 +0200 (CEST)
Date:   Tue, 22 Sep 2020 11:44:22 +0200
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 31/32] auxdisplay: charlcd: Do not print chars at end
 of line
Message-ID: <20200922094422.ucj24ohtervhcetv@lem-wkst-02.lemonage>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <20200921144645.2061313-1-poeschel@lemonage.de>
 <20200921144645.2061313-32-poeschel@lemonage.de>
 <20200922052701.GB16386@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922052701.GB16386@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 07:27:01AM +0200, Willy Tarreau wrote:
> On Mon, Sep 21, 2020 at 04:46:43PM +0200, poeschel@lemonage.de wrote:
> > From: Lars Poeschel <poeschel@lemonage.de>
> > 
> > Skip printing characters at the end of a display line. This fits to the
> > behaviour we already had, that the cursor is nailed to last position of
> > a line.
> 
> Just very old memories, but wasn't this used with the ability to shift
> the display ? IIRC the HD44780 has a 2x64 chars buffer and you can make
> the buffered characters appear when you shift the display. That's akin
> to seeing the display as an adjustable window over the buffer. I don't
> remember having used that feature, so if it didn't previously work, please
> disregard my comment, I just want to be sure we don't break a feature
> others might be relying on.

Yes, indeed. But this is a point, where this was inconsistent. The
feature you described worked only for displays with 2 lines or less. On
displays with 4 lines there simply is no buffer that is not visible and
in this case it sticks to the end of the line already.
To make this work for all displays this would require a whole lot of
work. We would need a fallback implementation that emulates this in
software and then redraws the whole display from that software
(linux-side) buffer when shifting.

Currently my patchset cuts this feature for displays with one or two
lines. I don't see clean an easy way to leave that in. Any ideas ?

Regards,
Lars
