Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1A6205766
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 18:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbgFWQk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 12:40:26 -0400
Received: from foss.arm.com ([217.140.110.172]:34166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732174AbgFWQk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:40:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CBB01F1;
        Tue, 23 Jun 2020 09:40:25 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 050EE3F73C;
        Tue, 23 Jun 2020 09:40:23 -0700 (PDT)
Date:   Tue, 23 Jun 2020 17:40:21 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Doug Anderson <dianders@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        hsinyi@chromium.org, Joel Fernandes <joelaf@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Quentin Perret <qperret@google.com>, ctheegal@codeaurora.org,
        Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cros_ec_spi: Even though we're RT priority, don't bump
 cpu freq
Message-ID: <20200623164021.lcrnwpli7wdlsn5i@e107158-lin.cambridge.arm.com>
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
 <20200612125250.7bwjfnxhurdf5bwj@e107158-lin.cambridge.arm.com>
 <CAD=FV=WuYZRO=sv4ODr0SFk0gTtvCW0dNQXbFGrBDqRgjYv-jA@mail.gmail.com>
 <20200619153851.vigshoae3ahiy63x@e107158-lin.cambridge.arm.com>
 <CAD=FV=XursDFUWL=aGUwFgXc4BugUMdT5e+Fwwo5w2gReCjUaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=XursDFUWL=aGUwFgXc4BugUMdT5e+Fwwo5w2gReCjUaQ@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/20 11:21, Doug Anderson wrote:

[...]

> > If you propose something that will help the discussion. I think based on the
> > same approach Peter has taken to prevent random RT priorities. In uclamp case
> > I think we just want to allow driver to opt RT tasks out of the default
> > boosting behavior.
> >
> > I'm a bit wary that this extra layer of tuning might create a confusion, but
> > I can't reason about why is it bad for a driver to say I don't want my RT task
> > to be boosted too.
> 
> Right.  I was basically just trying to say "turn my boosting off".
> 
> ...so I guess you're saying that doing a v2 of my patch with the
> proper #ifdef protection wouldn't be a good way to go and I'd need to
> propose some sort of API for this?

It's up to Peter really.

It concerns me in general to start having in-kernel users of uclamp that might
end up setting random values (like we ended having random RT priorities), that
really don't mean a lot outside the context of the specific system it was
tested on. Given the kernel could run anywhere, it's hard to rationalize what's
okay or not.

Opting out of default RT boost for a specific task in the kernel, could make
sense though it still concerns me for the same reasons. Is this okay for all
possible systems this can run on?

It feels better for userspace to turn RT boosting off for all tasks if you know
your system is powerful, or use the per task API to switch off boosting for the
tasks you know they don't need it.

But if we want to allow in-kernel users, IMO it needs to be done in
a controlled way, in a similar manner Peter changed how RT priority can be set
in the kernel.

It would be good hear what Peter thinks.

Thanks

--
Qais Yousef
