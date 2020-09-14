Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBA0268C20
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 15:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgINNWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 09:22:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25617 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726671AbgINNNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 09:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600089225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rHosvbjE+qxesSMeQdFmkgpnqKzDeColCCFxXxMS9zE=;
        b=SVL49iGqOvZHjoR11lAdpBwcmMg7U07wGBaM7fy6j59KQq2vzWcHsRPTkPYIpRK/eRX7Yt
        Fz84kTE5LyztdIdcnV50NIBy8QPrOTfusXPaIsiWSX4ywP4yBpB3aj20ISglszdTu77aob
        ADcH+NDJLanlmFuYdxe4lcY+kI0380k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-5fIobcj3O96clNvJiYWhmQ-1; Mon, 14 Sep 2020 09:13:41 -0400
X-MC-Unique: 5fIobcj3O96clNvJiYWhmQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F8D2190A3F0;
        Mon, 14 Sep 2020 13:13:40 +0000 (UTC)
Received: from ovpn-119-163.rdu2.redhat.com (ovpn-119-163.rdu2.redhat.com [10.10.119.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86A8960C0F;
        Mon, 14 Sep 2020 13:13:39 +0000 (UTC)
Message-ID: <f226e8f00f3f3a62b2b3367a8ddc03dd455bfa6c.camel@redhat.com>
Subject: Re: [PATCH v2] drivers/perf: xgene_pmu: Fix uninitialized resource
 struct
From:   Mark Salter <msalter@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 14 Sep 2020 09:13:39 -0400
In-Reply-To: <20200914112803.GA24312@willie-the-truck>
References: <20200913174536.207265-1-msalter@redhat.com>
         <20200914112803.GA24312@willie-the-truck>
Organization: Red Hat, Inc
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-09-14 at 12:28 +0100, Will Deacon wrote:
> On Sun, Sep 13, 2020 at 01:45:36PM -0400, Mark Salter wrote:
> > @@ -1483,11 +1473,23 @@ xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
> >  		return NULL;
> >  
> >  	INIT_LIST_HEAD(&resource_list);
> > -	rc = acpi_dev_get_resources(adev, &resource_list,
> > -				    acpi_pmu_dev_add_resource, &res);
> > +	rc = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
> > +	if (rc <= 0) {
> > +		dev_err(dev, "PMU type %d: No resources found\n", type);
> > +		return NULL;
> > +	}
> > +
> > +	list_for_each_entry(rentry, &resource_list, node) {
> > +		if (resource_type(rentry->res) == IORESOURCE_MEM) {
> > +			res = *rentry->res;
> > +			rentry = NULL;
> > +			break;
> > +		}
> > +	}
> >  	acpi_dev_free_resource_list(&resource_list);
> > -	if (rc < 0) {
> > -		dev_err(dev, "PMU type %d: No resource address found\n", type);
> > +
> > +	if (rentry) {
> 
> I'm curious as to why you've had to change the failure logic here, setting
> rentry to NULL instead of checking 'rentry->res' like the TX2 driver (which
> I don't immediately understand at first glance).
> 
> Will
> 

I don't fully understand the tx2 logic. I do see there's a memory leak if
that (!rentry->res) is true. I was going to dig deeper and follow up with
a patch for tx2. I suspect that rentry->res should never be true. And tx2
won't detect if no memory resource is in the table.

Mark


