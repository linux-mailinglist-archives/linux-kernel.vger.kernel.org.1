Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A36288D87
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 17:58:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389606AbgJIP6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 11:58:21 -0400
Received: from foss.arm.com ([217.140.110.172]:54474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389380AbgJIP6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:58:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AB67D6E;
        Fri,  9 Oct 2020 08:58:20 -0700 (PDT)
Received: from bogus (unknown [10.57.53.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C96EA3F66B;
        Fri,  9 Oct 2020 08:58:18 -0700 (PDT)
Date:   Fri, 9 Oct 2020 16:58:16 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>
Subject: Re: [PATCH 3/5] firmware: arm_scmi: add config dependency for smc
 transport
Message-ID: <20201009155816.il56rbatvcagyosz@bogus>
References: <20201008143722.21888-1-etienne.carriere@linaro.org>
 <20201008143722.21888-3-etienne.carriere@linaro.org>
 <20201008210839.6nnl2tvm2re2ckvu@bogus>
 <CAN5uoS-t2De5OvawUSeK1NuskqpBEt-rWGVtJky-E=+RRpe+_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN5uoS-t2De5OvawUSeK1NuskqpBEt-rWGVtJky-E=+RRpe+_Q@mail.gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 02:33:41PM +0200, Etienne Carriere wrote:
> On Thu, 8 Oct 2020 at 23:08, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, Oct 08, 2020 at 04:37:20PM +0200, Etienne Carriere wrote:
> > > Fix dependencies for configuration switch ARM_SCMI_PROTOCOL that
> > > is not exclusively dependent on MAILBOX since the alternate
> > > smc transport that is depends on HAVE_ARM_SMCCC_DISCOVERY since [1].
> > >
> >
> > Do you need any build issues ? I don't see why this is needed.
> >
> 
> This change is for consistency of the kernel configuration.
> Without this change, a kernel configured without CONFIG_MAILBOX
> cannot embed SCMI support even is using only the SMC transport
> enabled thanks to HAVE_ARM_SMCCC_DISCOVERY.
> 

Fair enough, however instead of adding to the list for each added transport
we need to do better transport abstraction now that we have multiple.
I don't see this as critical, let me know if you disagree.

-- 
Regards,
Sudeep
