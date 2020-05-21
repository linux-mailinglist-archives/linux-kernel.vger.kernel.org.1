Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92351DCDAD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 15:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgEUNEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 09:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbgEUNEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:04:21 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 931022072C;
        Thu, 21 May 2020 13:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590066261;
        bh=MRCEC+nXdSDz6i5TZrMw6mLNWWrHvA60N+e767YVxns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lmu3epPATx/GzY3jREbvlRwGrVQu7NJk8uFE7w/S8G1BcG1hgzymFGCxBxB3viHil
         R4Hecc/Gx26n2kk2sBrr248PsSUtFBnxZcpkpZTD3fq88XA76zFMe4Kr03Js3lMNcM
         cHsdSest9biXfmMIG+b2eQph4k3krZ8JUH+dhwf0=
Date:   Thu, 21 May 2020 14:04:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        John Garry <john.garry@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V1 RESEND 1/3] perf/imx_ddr: Add system PMU identifier
 for userspace
Message-ID: <20200521130415.GB5949@willie-the-truck>
References: <20200512073115.14177-1-qiangqing.zhang@nxp.com>
 <20200512073115.14177-2-qiangqing.zhang@nxp.com>
 <20200519185125.GB453195@bogus>
 <20200520073304.GA23534@willie-the-truck>
 <CAL_JsqJfQ0PFy5mmwSG4aM91ghq5xiAEPR2YZOymws+BfGa+uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJfQ0PFy5mmwSG4aM91ghq5xiAEPR2YZOymws+BfGa+uA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 09:23:41AM -0600, Rob Herring wrote:
> On Wed, May 20, 2020 at 1:33 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Tue, May 19, 2020 at 12:51:25PM -0600, Rob Herring wrote:
> > > On Tue, May 12, 2020 at 03:31:13PM +0800, Joakim Zhang wrote:
> > > > +static ssize_t ddr_perf_identifier_show(struct device *dev,
> > > > +                                   struct device_attribute *attr,
> > > > +                                   char *page)
> > > > +{
> > > > +   struct ddr_pmu *pmu = dev_get_drvdata(dev);
> > > > +
> > > > +   return sprintf(page, "%s\n", pmu->devtype_data->identifier);
> > >
> > > Why do we need yet another way to identify the SoC from userspace?
> >
> > I also really dislike this. What's the preferred way to identify the SoC
> > from userspace?
> 
> /proc/cpuinfo? ;)

The *SoC*!

> For an non-firmware specific case, I'd say soc_device should be. I'd
> guess ACPI systems don't use it and for them it's dmidecode typically.
> The other problem I have with soc_device is it is optional.

John -- what do you think about using soc_device to expose this information,
with ACPI systems using DMI data instead?

Will
