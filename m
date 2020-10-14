Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAAF28E58A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbgJNRjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:39:11 -0400
Received: from foss.arm.com ([217.140.110.172]:54734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727924AbgJNRjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:39:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32359D6E;
        Wed, 14 Oct 2020 10:39:10 -0700 (PDT)
Received: from bogus (unknown [10.57.12.254])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D234B3F71F;
        Wed, 14 Oct 2020 10:39:08 -0700 (PDT)
Date:   Wed, 14 Oct 2020 18:39:06 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] firmware: arm_scmi: Fix duplicate workqueue name
Message-ID: <20201014173906.aytbl4bjbwjwa6wr@bogus>
References: <20201014021737.287340-1-f.fainelli@gmail.com>
 <20201014091806.GB20315@bogus>
 <20201014130524.cj42wknvzdpgsbsr@bogus>
 <20201014134819.GA24061@e120937-lin>
 <20201014160120.4x2l7hozf376gk3l@bogus>
 <fdb270ef-bec0-9592-1d33-3339872bbffe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fdb270ef-bec0-9592-1d33-3339872bbffe@gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 10:13:04AM -0700, Florian Fainelli wrote:
> On 10/14/20 9:18 AM, Sudeep Holla wrote:
> > On Wed, Oct 14, 2020 at 02:48:19PM +0100, Cristian Marussi wrote:
> > 
> > [...]
> > 
> >>>
> >>> I have pushed a version with above change [1], please check if you are
> >>> happy with that ?
> >>>
> >>> [1] https://git.kernel.org/sudeep.holla/linux/c/b2cd15549b
> >>
> >> I agree with the need to retain _notify name, but I'm not so sure about
> >> the above patch...which is:
> >>
> > 
> > I agree, I thought about it and just cooked up this as a quick solution.
> > I will move to that, even I wasn't happy with this TBH.
> 
> The reason why I went with just dev_name() was such that the workqueue
> name and the device nodes under /sys would strictly match, which helps
> as an user, and also it avoided the temporary buffer and its size
> limitations.

Agreed. I just showed that as example and was hoping to use some nice
kstr* APIs to achieve what I wanted but soon realised there exists none.
So as replied earlier, I will take this change as it for now. Let us
address this in future if it becomes an issue.

Thanks for quick test, we now know whom to bother if we need more testing
😉 as out internal platforms are not that great to cover all the aspects
we add in the spec and even in the kernel.

-- 
Regards,
Sudeep
