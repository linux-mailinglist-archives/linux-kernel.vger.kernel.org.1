Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A852848BC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 10:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgJFIim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 04:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgJFIim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 04:38:42 -0400
Received: from smtp2-2.goneo.de (smtp2.goneo.de [IPv6:2001:1640:5::8:33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14952C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 01:38:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 9382623F0DD;
        Tue,  6 Oct 2020 10:38:55 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.975
X-Spam-Level: 
X-Spam-Status: No, score=-2.975 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.075, BAYES_00=-1.9] autolearn=ham
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jTXJSYUp0euX; Tue,  6 Oct 2020 10:38:54 +0200 (CEST)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp2.goneo.de (Postfix) with ESMTPSA id 12590241A53;
        Tue,  6 Oct 2020 10:38:54 +0200 (CEST)
Date:   Tue, 6 Oct 2020 10:38:44 +0200
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 00/32] Make charlcd device independent
Message-ID: <20201006083834.ejbl5itjvkbqbmby@lem-wkst-02.lemonage>
References: <20201005122732.3429347-1-poeschel@lemonage.de>
 <CANiq72mH93Yes8dShcFffEqS_O3NtuDOa8HyS20zKvLoiPn1hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mH93Yes8dShcFffEqS_O3NtuDOa8HyS20zKvLoiPn1hg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 05:30:59PM +0200, Miguel Ojeda wrote:
> Hi Lars,
> 
> On Mon, Oct 5, 2020 at 2:27 PM <poeschel@lemonage.de> wrote:
> >
> > This tries to make charlcd device independent.
> 
> Thanks a lot for the work!
> 
> I see you have written the differences between versions in each patch,
> but given there are 32 patches, it'd be nice to comment which ones have
> changed so that folks that already did a review can take a look at
> those.

Changes in v4:
- modtronix -> Modtronix in new lcd2s driver
- Kconfig: remove "default n" in new lcd2s driver

Changes in v3:
- Fix some typos in Kconfig stuff
- Fix kernel test robot reported error: Missed EXPORT_SYMBOL_GPL
- new patch to reduce display timeout
- better patch description to why not move cursor beyond end of a line
- Fixed make dt_binding_doc errors

Changes in v2:
- split whole patch into many smaller chunks
- device tree doc in yaml

Regards,
Lars
