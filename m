Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A91D275CFD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgIWQLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:11:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51590 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgIWQLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:11:15 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NGB6qP051092;
        Wed, 23 Sep 2020 11:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600877466;
        bh=GonlYZbi6nuWCM6HFFiNjrh40RYQxuq7I3I6tTMPXms=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Eoh6ys5dXwvuJvbIN04O27uh7DZWwPb2H8oPjiRhmreX2i+4ABzWABg7rt3z/OGOR
         JJgEp2xIRmRXs53+AfleyyaJBhI3koLG2P1kKdC5VtBJMKwZC0j4wYOwjg9vbYHS99
         oEJgWPPioiUTIAIjCky8EZ+2r5wsmkfv/UFEHiww=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08NGB6rE040430
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 11:11:06 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 11:11:06 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 11:11:06 -0500
Received: from [10.250.36.88] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NGB5ix061623;
        Wed, 23 Sep 2020 11:11:05 -0500
Subject: Re: [PATCH 4/6] dt-bindings: tas2770: Remove ti,asi-format property
To:     Mark Brown <broonie@kernel.org>
CC:     <lgirdwood@gmail.com>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
References: <20200923132600.10652-1-dmurphy@ti.com>
 <20200923132600.10652-4-dmurphy@ti.com> <20200923155145.GD5707@sirena.org.uk>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <39d966c4-2f56-c004-4e7c-24a99b07cc72@ti.com>
Date:   Wed, 23 Sep 2020 11:11:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923155145.GD5707@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 9/23/20 10:51 AM, Mark Brown wrote:
> On Wed, Sep 23, 2020 at 08:25:58AM -0500, Dan Murphy wrote:
>> Remove the property ti,asi-format as the driver only reads this property
>> and performs no action against it.
> We should probably leave the property as documented and move it to
> deprecated rather than delete the documentation entirely.

I mulled this over to just deprecate the property and I know removing 
these ABIs are not highly accepted.

But the support code for it was incomplete and if a user had it 
populated in the DT and we removed the support then there will be no 
functional change.

This property was supposed to set the RX edge SBCLK detection but this 
is done based on the dai format.

So removing the property will have no affect on the users.

Dan

