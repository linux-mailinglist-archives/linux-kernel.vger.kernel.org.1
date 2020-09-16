Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669B926BE52
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgIPHlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:41:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36158 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgIPHlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:41:31 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08G7fM12077914;
        Wed, 16 Sep 2020 02:41:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600242082;
        bh=WohhcHNTIV/ovv97AWxzinKNg6nq6ImDJaomVMGpR50=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KxF1FxOKY6U6oLU2s0j/Cek6Fhz2SKoWKjgZfED/5iPC1FwS6SBZx8cAquKYcCDSV
         ykFmMW3FfxR+fjawhUFJHwKvF9b4awYxLIlGKV34ujZdaCRR/ZB5VftntULcAJqasi
         Ewuyuuekg2qG21UfPLTIjC13DVBr0oChLzIVWnXY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08G7fMhG095493;
        Wed, 16 Sep 2020 02:41:22 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Sep 2020 02:41:22 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Sep 2020 02:41:22 -0500
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08G7fIqw095952;
        Wed, 16 Sep 2020 02:41:19 -0500
Subject: Re: [PATCH v6 0/2] PHY: Add new PHY attribute max_link_rate
To:     Swapnil Jakhade <sjakhade@cadence.com>, <vkoul@kernel.org>,
        <kishon@ti.com>, <linux-kernel@vger.kernel.org>,
        <maxime@cerno.tech>, <Laurent.pinchart@ideasonboard.com>
CC:     <mparab@cadence.com>, <yamonkar@cadence.com>,
        <tomi.valkeinen@ti.com>, <jsarha@ti.com>, <praneeth@ti.com>
References: <1599805114-22063-1-git-send-email-sjakhade@cadence.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <e1ae0a53-02a2-8a17-094f-570be6d24b1c@ti.com>
Date:   Wed, 16 Sep 2020 13:11:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1599805114-22063-1-git-send-email-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 11/09/20 11:48 AM, Swapnil Jakhade wrote:
> This patch series adds a new PHY attribute max_link_rate.
> It also updates Cadence Torrent PHY driver to set attributes bus_width,
> max_link_rate and mode for DisplayPort.
> 
> It includes following patches:
> 
> 1. 0001-phy-Add-new-PHY-attribute-max_link_rate.patch
> This patch adds max_link_rate as a new PHY attribute.
> 
> 2. 0002-phy-cadence-torrent-Set-Torrent-PHY-attributes.patch
> This patch sets PHY attributes in Cadence Torrent PHY driver. This will
> enable drivers using this PHY to read these properties.
> 
> These attributes will be used in the Cadence MHDP DRM bridge driver [1]
> which is in the process of upstreaming.

Can you please add these patches on an immutable branch/tag when you are
ready to apply them - will try to see if we can use it to get the
DisplayPort driver merged in v5.10 too.

Hi Laurent, any other ideas on managing the dependency?

Thanks,
Sekhar
