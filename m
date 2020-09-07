Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90437260217
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 19:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbgIGRTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 13:19:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729703AbgIGOA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:00:56 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB4412064B;
        Mon,  7 Sep 2020 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599486630;
        bh=J7KhyjwPkOJGOay8k3dotO+k4kIPfPIOXH16l9SfKnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nqPSx7Yg7Dl3jwKJBWll4TFZ9RfVikUBT1Sx9PemWPtM1NMfcWAh+PXCs2dng91S4
         EgW1V+1KMTn274zvq7rhmRpyKPTiC/sEHR0/0Hu4m3mKYq/BGFAMUTC7k8YzLL4/Ac
         5ERBrYKHDKOXeeQbsoQCn7Z0c0st8Adb/JzalYBY=
Date:   Mon, 7 Sep 2020 14:50:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Salter <msalter@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: xgene_pmu: Fix uninitialized resource
 struct
Message-ID: <20200907135026.GC12551@willie-the-truck>
References: <20200902182729.27415-1-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902182729.27415-1-msalter@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 02:27:29PM -0400, Mark Salter wrote:
> diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
> index edac28cd25dd..fdbbd0804b92 100644
> --- a/drivers/perf/xgene_pmu.c
> +++ b/drivers/perf/xgene_pmu.c
> @@ -1483,6 +1483,7 @@ xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
>  		return NULL;
>  
>  	INIT_LIST_HEAD(&resource_list);
> +	memset(&res, 0, sizeof(res));
>  	rc = acpi_dev_get_resources(adev, &resource_list,
>  				    acpi_pmu_dev_add_resource, &res);
>  	acpi_dev_free_resource_list(&resource_list);

Hmm, to be honest, I'm not sure we should be calling devm_ioremap_resource()
at all here. The resource is clearly bogus, even with this change: the name
and the resource hierarchy pointers will all be NULL. I think it would be
better to follow the TX2 PMU driver (drivers/perf/thunderx2_pmu.c) which
appears to assign the resource directly in tx2_uncore_pmu_init_dev().

Is there a reason we can't do that?

Will
