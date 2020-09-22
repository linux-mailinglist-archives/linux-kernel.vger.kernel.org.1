Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C30A27419F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 13:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgIVLv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 07:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgIVLv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 07:51:56 -0400
Received: from smtp1.goneo.de (smtp1.goneo.de [IPv6:2001:1640:5::8:30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0471C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 04:51:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 655CC23EE82;
        Tue, 22 Sep 2020 13:51:55 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.992
X-Spam-Level: 
X-Spam-Status: No, score=-2.992 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.092, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id niXY_X-4a3T9; Tue, 22 Sep 2020 13:51:54 +0200 (CEST)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPSA id 5FAFA23F158;
        Tue, 22 Sep 2020 13:51:54 +0200 (CEST)
Date:   Tue, 22 Sep 2020 13:51:50 +0200
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Willy Tarreau <w@1wt.eu>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 31/32] auxdisplay: charlcd: Do not print chars at end
 of line
Message-ID: <20200922115150.w6np52gwegloei6b@lem-wkst-02.lemonage>
References: <20191016082430.5955-1-poeschel@lemonage.de>
 <20200921144645.2061313-1-poeschel@lemonage.de>
 <20200921144645.2061313-32-poeschel@lemonage.de>
 <20200922052701.GB16386@1wt.eu>
 <20200922094422.ucj24ohtervhcetv@lem-wkst-02.lemonage>
 <20200922100400.GH16421@1wt.eu>
 <CANiq72kS-u_Xd_m+2CQVh-JCncPf1XNXrXAZ=4z+mze8fwv2kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kS-u_Xd_m+2CQVh-JCncPf1XNXrXAZ=4z+mze8fwv2kw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 12:20:36PM +0200, Miguel Ojeda wrote:
> Hi Lars, Willy,
> 
> On Tue, Sep 22, 2020 at 12:04 PM Willy Tarreau <w@1wt.eu> wrote:
> >
> > The points you mention are good enough indicators that it's extremely
> > unlikely anyone has ever used that feature with these drivers. So I
> > think it's best to keep your changes and wait to see if anyone pops
> > up with an obscure use case, in which case their explanation might
> > help figure another approach.
> 
> Agreed -- Lars, please add an explanation for the removed feature in
> the appropriate commit message and also mention it in the cover letter
> so that such user-facing change (and any other) is documented.

Ok, I will do this.

Regards,
Lars
