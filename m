Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94ADC2A93C9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgKFKLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKFKLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:11:46 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D37C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 02:11:45 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 2052023EEE7;
        Fri,  6 Nov 2020 11:11:42 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.941
X-Spam-Level: 
X-Spam-Status: No, score=-2.941 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.041, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Am71BUPAJc1H; Fri,  6 Nov 2020 11:11:40 +0100 (CET)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 563BB23F314;
        Fri,  6 Nov 2020 11:11:40 +0100 (CET)
Date:   Fri, 6 Nov 2020 11:11:35 +0100
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/25] Make charlcd device independent
Message-ID: <20201106101135.xesjdqg2z3hgpqnv@lem-wkst-02.lemonage>
References: <20201103095828.515831-1-poeschel@lemonage.de>
 <CANiq72mDG8YJLcpKuE+noUQY5B9K6Cc71ado_dyLFVVf_xzKwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mDG8YJLcpKuE+noUQY5B9K6Cc71ado_dyLFVVf_xzKwA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 02:30:04PM +0100, Miguel Ojeda wrote:
> Thanks a lot for all the work, Lars. Queued in -next.

I got an email [1] with a report about a build failure in
hd44780_common. The fix is simple but I don't know the process from here
on. Should I post a v7 of the whole patchset or only a follow-up patch
for the fix ?

Regards,
Lars

[1]: https://lore.kernel.org/linux-next/77c23d41-b652-bd08-12ef-6d3403f0ad8c@infradead.org/T/#u
