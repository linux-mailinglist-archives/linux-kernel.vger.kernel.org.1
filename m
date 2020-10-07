Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26CBF285E62
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 13:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgJGLnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 07:43:40 -0400
Received: from foss.arm.com ([217.140.110.172]:42440 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbgJGLnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 07:43:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 996B831B;
        Wed,  7 Oct 2020 04:43:39 -0700 (PDT)
Received: from bogus (unknown [10.57.54.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8315C3F71F;
        Wed,  7 Oct 2020 04:43:37 -0700 (PDT)
Date:   Wed, 7 Oct 2020 12:43:35 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/4] mailbox: arm_mhu: Add ARM MHU doorbell driver
Message-ID: <20201007114335.5j7cq4cv4iwbam3g@bogus>
References: <20200928114445.19689-1-sudeep.holla@arm.com>
 <20200928114445.19689-5-sudeep.holla@arm.com>
 <20201007060525.ya6limypf6ggmtae@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201007060525.ya6limypf6ggmtae@vireshk-i7>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 11:35:25AM +0530, Viresh Kumar wrote:
> On 28-09-20, 12:44, Sudeep Holla wrote:
> > The MHU drives the signal using a 32-bit register, with all 32 bits
> > logically ORed together. The MHU provides a set of registers to enable
> > software to set, clear, and check the status of each of the bits of this
> > register independently. The use of 32 bits for each interrupt line
> > enables software to provide more information about the source of the
> > interrupt. For example, each bit of the register can be associated with
> > a type of event that can contribute to raising the interrupt.
> > 
> > This patch adds a separate the MHU controller driver for doorbel mode
> > of operation using the extended DT binding to add support the same.
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/mailbox/Makefile     |   2 +-
> >  drivers/mailbox/arm_mhu_db.c | 359 +++++++++++++++++++++++++++++++++++
> 
> Please put an entry in MAINTAINERS as well for this.

Sure.

-- 
Regards,
Sudeep
