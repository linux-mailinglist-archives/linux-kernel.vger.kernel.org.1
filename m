Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D190F29595F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508722AbgJVHkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506715AbgJVHkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:40:22 -0400
Received: from smtp2-2.goneo.de (smtp2.goneo.de [IPv6:2001:1640:5::8:33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD2CC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 00:40:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 98E9223FC61;
        Thu, 22 Oct 2020 09:40:18 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.974
X-Spam-Level: 
X-Spam-Status: No, score=-2.974 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.074, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Fppe8Uv8iBUp; Thu, 22 Oct 2020 09:40:17 +0200 (CEST)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp2.goneo.de (Postfix) with ESMTPSA id 6793B23F497;
        Thu, 22 Oct 2020 09:40:17 +0200 (CEST)
Date:   Thu, 22 Oct 2020 09:40:11 +0200
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/32] Make charlcd device independent
Message-ID: <20201022074011.w5hvw4ssvhhfdsh4@lem-wkst-02.lemonage>
References: <20201005122732.3429347-1-poeschel@lemonage.de>
 <CANiq72mH93Yes8dShcFffEqS_O3NtuDOa8HyS20zKvLoiPn1hg@mail.gmail.com>
 <20201006083834.ejbl5itjvkbqbmby@lem-wkst-02.lemonage>
 <CANiq72=cz-bvbGU_cY+Rwoq_hJAXBEur=Yw4=Cs2APxp5yODAg@mail.gmail.com>
 <CANiq72mhhYYpXM6ROKUGa-QMDd_qqV5Ki7eifo-5rz4=PG9oXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mhhYYpXM6ROKUGa-QMDd_qqV5Ki7eifo-5rz4=PG9oXQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 05:59:04AM +0200, Miguel Ojeda wrote:
> On Fri, Oct 16, 2020 at 4:33 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > Picking these for linux-next (including Rob's Reviewed-by). I have
> > spotted a few typos that I corrected -- I will note them by email.
> 
> Hmm, I think we should do another round instead, since I found what
> looks to be an unintended revert of a previous commit in patch 24.
> Lars, can you please take a look?

I will work on this soon.

> Also, please take the chance to apply my comments given we have a new
> round (and Rob's Reviewed-by too).

Yes, of course.

> By the way, I think you could simplify by squashing the "implement
> hd44780_*" commits together (i.e. from 15 to 22 except 20), and the
> two cleanups together too (i.e. 20 and 23). I know we asked you to
> split things up before, but those two sets are quite similar
> (including in their commit message) and easy to understand all
> together.

No problem. I will do this as well.

Regards,
Lars
