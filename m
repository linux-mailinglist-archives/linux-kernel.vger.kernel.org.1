Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A23288099
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 05:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbgJIDCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 23:02:10 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57408 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728854AbgJIDCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 23:02:09 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 099324sh129577;
        Thu, 8 Oct 2020 22:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602212524;
        bh=qmPDrQZm0dVtgPBBI6zBwfHVGiDKozfJgcyz9ge85kg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aD8AY2E5ngqv0lMYWE77G0NTsUl6Ymd0bG2NScHBN+Utet1KnJn7yfX4JVy7au47o
         3HtawoMO2yifRoPaHCn6yoOk+aOIXaCaZOwkMftjdx4zx/PPetSOOB/Aj94rWYH1Li
         a2S7gDiicJf7HhXu2cdBDNEEarV/A3xcnIGrN9h0=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 099324Vx090396
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 8 Oct 2020 22:02:04 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 8 Oct
 2020 22:02:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 8 Oct 2020 22:02:04 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 099324Fv030175;
        Thu, 8 Oct 2020 22:02:04 -0500
Date:   Thu, 8 Oct 2020 22:02:04 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     <t-kristo@ti.com>, <ssantosh@kernel.org>, <lokeshvutla@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2 10/11] soc: ti: k3-ringacc: Use correct device for
 allocation in RING mode
Message-ID: <20201009030204.3i3d6azsmfekl5qx@whole>
References: <20201008115224.1591-1-peter.ujfalusi@ti.com>
 <20201008115224.1591-11-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20201008115224.1591-11-peter.ujfalusi@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:52-20201008, Peter Ujfalusi wrote:
> -	ring->ring_mem_virt = dma_alloc_coherent(ringacc->dev,
> +	ring->ring_mem_virt = dma_alloc_coherent(ring->dma_dev,
>  					ring->size * (4 << ring->elm_size),
>  					&ring->ring_mem_dma, GFP_KERNEL);

Any chance of getting a cleanup of the file for 5.11? I know this series
has'nt introduced this warning or set of warnings, but I am starting to
get concerned that we are carrying over too much of a debt now?

https://pastebin.ubuntu.com/p/tT2kPDsCWD/

Checkpatch does point this:

--- /tmp/kernel-patch-verify.25812/ptest_check-start	2020-10-08
19:33:31.025898581 +0000
+++ /tmp/kernel-patch-verify.25812/ptest_check-end	2020-10-08
19:33:31.593893830 +0000
@@ -0,0 +1,6 @@
+CHECK: Alignment should match open parenthesis
+#84: FILE: drivers/soc/ti/k3-ringacc.c:657:
++	ring->ring_mem_virt = dma_alloc_coherent(ring->dma_dev,
+ 					ring->size * (4 << ring->elm_size),

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
