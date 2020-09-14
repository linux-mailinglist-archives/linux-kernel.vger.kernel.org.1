Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAA2268CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgINOBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:01:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:54410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgINN7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:59:22 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D322208E4;
        Mon, 14 Sep 2020 13:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600091962;
        bh=L0mDfxQsitxWKkVEy61huFFBlVpZdenmKB6RQVodr3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DSGroWHvU+TtVCjWoy6vQ28a2g1JAVIDAN75mlAVpumcN06r/WRqh4sJKcG1xwtLs
         AmJblMeO6bCyStmzhZWNHmxmJ5XsnJQnC+r3IhtG9Gv8muyCJPne6Yf09LAD3ws7O0
         gQCEfzPcpwi6JVVhENi49u2Z0I9XHwE2UmEhr4Gs=
Date:   Mon, 14 Sep 2020 14:59:18 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Salter <msalter@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers/perf: xgene_pmu: Fix uninitialized resource
 struct
Message-ID: <20200914135917.GF24441@willie-the-truck>
References: <20200913174536.207265-1-msalter@redhat.com>
 <20200914112803.GA24312@willie-the-truck>
 <f226e8f00f3f3a62b2b3367a8ddc03dd455bfa6c.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f226e8f00f3f3a62b2b3367a8ddc03dd455bfa6c.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 09:13:39AM -0400, Mark Salter wrote:
> On Mon, 2020-09-14 at 12:28 +0100, Will Deacon wrote:
> > On Sun, Sep 13, 2020 at 01:45:36PM -0400, Mark Salter wrote:
> > > @@ -1483,11 +1473,23 @@ xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
> > >  		return NULL;
> > >  
> > >  	INIT_LIST_HEAD(&resource_list);
> > > -	rc = acpi_dev_get_resources(adev, &resource_list,
> > > -				    acpi_pmu_dev_add_resource, &res);
> > > +	rc = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
> > > +	if (rc <= 0) {
> > > +		dev_err(dev, "PMU type %d: No resources found\n", type);
> > > +		return NULL;
> > > +	}
> > > +
> > > +	list_for_each_entry(rentry, &resource_list, node) {
> > > +		if (resource_type(rentry->res) == IORESOURCE_MEM) {
> > > +			res = *rentry->res;
> > > +			rentry = NULL;
> > > +			break;
> > > +		}
> > > +	}
> > >  	acpi_dev_free_resource_list(&resource_list);
> > > -	if (rc < 0) {
> > > -		dev_err(dev, "PMU type %d: No resource address found\n", type);
> > > +
> > > +	if (rentry) {
> > 
> > I'm curious as to why you've had to change the failure logic here, setting
> > rentry to NULL instead of checking 'rentry->res' like the TX2 driver (which
> > I don't immediately understand at first glance).
> > 
> > Will
> > 
> 
> I don't fully understand the tx2 logic. I do see there's a memory leak if
> that (!rentry->res) is true. I was going to dig deeper and follow up with
> a patch for tx2. I suspect that rentry->res should never be true. And tx2
> won't detect if no memory resource is in the table.

Ah good, so it wasn't just me then! In which case, please send the two
patches as a series fixing both drivers, and I'll queue them both together.

Ta,

Will
