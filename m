Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911C42587AA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 07:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgIAFvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 01:51:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgIAFvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:51:39 -0400
Received: from localhost (unknown [122.172.190.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F41B20767;
        Tue,  1 Sep 2020 05:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598939499;
        bh=z5XCUQAfrvapBmSGoVWTsEXnaABO6mMpxg+ww00LI1U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FbiMqz9Ssh5FnfjQ1l/ceIE+gUOnjtAMrEnwEQEUvR3Z8ZFC8r5cJLA2HoTDmh/xN
         yDFwCcIWYNHXqddMfxRNaQ0L2FD4MHmxACaiksZHGWC1k6OfDUo4sCDfHaeoQRujqf
         V3QtPByy6EWETerkV6C4rbQBnJdQfsbB4RCFO1UA=
Date:   Tue, 1 Sep 2020 11:21:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     "kishon@ti.com" <kishon@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "eswara.kota@linux.intel.com" <eswara.kota@linux.intel.com>,
        "vadivel.muruganx.ramuthevar@linux.intel.com" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 2/3] dt-bindings: phy: intel: Add Keem Bay eMMC PHY
 bindings
Message-ID: <20200901055135.GY2639@vkoul-mobl>
References: <20200821113747.2912-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200821113747.2912-3-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200831091013.GL2639@vkoul-mobl>
 <DM6PR11MB37210C56315013E4995DE2A3DD2E0@DM6PR11MB3721.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB37210C56315013E4995DE2A3DD2E0@DM6PR11MB3721.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-09-20, 04:58, Wan Mohamad, Wan Ahmad Zainie wrote:

> > > @@ -0,0 +1,44 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id: "http://devicetree.org/schemas/phy/intel,keembay-emmc-
> > phy.yaml#"
> > > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > > +
> > > +title: Intel Keem Bay eMMC PHY bindings
> > 
> > This seems same as
> > Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml, why
> > not add a new compatible in lgm binding, or did I miss a difference?
> 
> AFAIK, LGM make use of syscon node, whilst KMB does not.
> And LGM and KMB belongs to different SoC family. So, I prefer them to
> be in separate file.
> 
> Having said that, with few changes in wordings in title and description,
> I think we can make it generic and can be used across few products.

The bindings seems quite similar. We can have two drivers loaded using
two compatible but binding description can be made same

-- 
~Vinod
