Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD01295217
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 20:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503999AbgJUSUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 14:20:01 -0400
Received: from foss.arm.com ([217.140.110.172]:38508 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2503991AbgJUSUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 14:20:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BBDCD6E;
        Wed, 21 Oct 2020 11:19:55 -0700 (PDT)
Received: from bogus (unknown [10.57.22.167])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D25C63F66B;
        Wed, 21 Oct 2020 11:19:53 -0700 (PDT)
Date:   Wed, 21 Oct 2020 19:19:51 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm,scmi: Do not use clocks for SCMI
 performance domains
Message-ID: <20201021181951.xu2igea2qbca3alf@bogus>
References: <20201020203710.10100-1-sudeep.holla@arm.com>
 <CAL_JsqKH9pN7E7o+UY7YmOrOKCUigrMTxY3f3AH4PdpQUAaawg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKH9pN7E7o+UY7YmOrOKCUigrMTxY3f3AH4PdpQUAaawg@mail.gmail.com>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 11:20:27AM -0500, Rob Herring wrote:
> On Tue, Oct 20, 2020 at 3:37 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >

[...]

>
> When is this not 1 (IOW, you only need this if variable)? How would it
> be used outside SCMI (given it has a generic name)?
>
> > +
> > +* Property arm,scmi-perf-domain
>
[...]

> Really though, why can't you give SCMI a CPUs MPIDR and get its domain?
>

Now I remembered why we can't use MPIDR. The spec talks about perf domains
for devices in generic. CPU is just a special device. We will still need
a mechanism to get device performance domain. So MPIDR idea was dropped to
keep it uniform across all the devices.

--
Regards,
Sudeep
