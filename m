Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7162887DF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 13:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbgJILbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 07:31:35 -0400
Received: from foss.arm.com ([217.140.110.172]:48630 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729986AbgJILbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 07:31:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22299D6E;
        Fri,  9 Oct 2020 04:31:34 -0700 (PDT)
Received: from bogus (unknown [10.57.53.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 55B1A3F66B;
        Fri,  9 Oct 2020 04:31:32 -0700 (PDT)
Date:   Fri, 9 Oct 2020 12:31:29 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 0/4] mailbox: arm_mhu: Add ARM MHU doorbell controller
 driver
Message-ID: <20201009113129.uqw5zrqztjgw6vga@bogus>
References: <20201008191452.38672-1-sudeep.holla@arm.com>
 <20201009042237.yuumlyoiougygoqs@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201009042237.yuumlyoiougygoqs@vireshk-i7>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 09:52:37AM +0530, Viresh Kumar wrote:
> On 08-10-20, 20:14, Sudeep Holla wrote:
> > Hi,
> > 
> > These series adds ARM MHU doorbell controller driver based on the
> > discussion[1]. The DT patches are just repost from Viresh's last posting[2]
> > 
> > Regards,
> > Sudeep
> > 
> > v1[3]->v2:
> > 	- No updates to binding patches(1-2)
> > 	- Fixed memory leak and improved logic to find free channel reusing
> > 	  mhu_db_mbox_to_channel as suggested by Jassi
> > 
> > [1] https://lore.kernel.org/r/20200909044618.deyx37pzocxiga7u@vireshk-i7
> > [2] https://lore.kernel.org/r/3874de094d193a08624a00a35067a3237e0b42b1.1600249102.git.viresh.kumar@linaro.org
> > [3] https://lore.kernel.org/r/20200928114445.19689-1-sudeep.holla@arm.com
> > 
> > Sudeep Holla (3):
> >   dt-bindings: mailbox: add doorbell support to ARM MHU
> >   mailbox: arm_mhu: Match only if compatible is "arm,mhu"
> >   mailbox: arm_mhu: Add ARM MHU doorbell driver
> > 
> > Viresh Kumar (1):
> >   dt-bindings: mailbox : arm,mhu: Convert to Json-schema
> > 
> >  .../devicetree/bindings/mailbox/arm,mhu.yaml  | 135 +++++++
> >  .../devicetree/bindings/mailbox/arm-mhu.txt   |  43 ---
> >  drivers/mailbox/Makefile                      |   2 +-
> >  drivers/mailbox/arm_mhu.c                     |   3 +
> >  drivers/mailbox/arm_mhu_db.c                  | 354 ++++++++++++++++++
> >  5 files changed, 493 insertions(+), 44 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> >  create mode 100644 drivers/mailbox/arm_mhu_db.c
> 
> MAINTAINERS ?

Duh ! Generated patches before I added and totally forgot to regenerate.
Will wait for Jassi's response and then will post as addon if no comments
or will respin the series. Sorry for that.

-- 
Regards,
Sudeep
