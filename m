Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4375D26E85D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 00:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgIQW1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 18:27:35 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44944 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgIQW1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 18:27:34 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08HMRSpt011058;
        Thu, 17 Sep 2020 17:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600381648;
        bh=h+Q2eSsTW2yRHUSQNoDOtGVTTIrEGzENy7jzvlOi3uc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=RZJHQ4BWNwIIarh+iUclORVVwBwVWgghl/ZXql4jHaGbLg0/Eb5paX+1mhWw3ejDm
         igG59wlGEO5XGEl0Lilo96R6PiJAtQbEjnzv6aZLDC0hhSKf/i23TS2e0F3te/Nz5H
         p3urHaWnReuYZuCFPCqxl12iCGqlKq4MODBbK2Qs=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08HMRRCt111599;
        Thu, 17 Sep 2020 17:27:27 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Sep 2020 17:27:27 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Sep 2020 17:27:27 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08HMRRfj064869;
        Thu, 17 Sep 2020 17:27:27 -0500
Date:   Thu, 17 Sep 2020 17:27:27 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Roger Quadros <rogerq@ti.com>
CC:     <peda@axentia.se>, <t-kristo@ti.com>, <nsekhar@ti.com>,
        <kishon@ti.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-j721e: Rename mux header and update
 macro names
Message-ID: <20200917222727.fbp2gt5c5kblyff6@akan>
References: <20200917161649.27667-1-rogerq@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200917161649.27667-1-rogerq@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:16-20200917, Roger Quadros wrote:
> We intend to use one header file for SERDES MUX for all
> TI SoCs so rename the header file.
> 
> The exsting macros are too generic. Prefix them with SoC name.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

Could you add Fixes and take care of the comments from Peter and repost?

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
