Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EAE26C606
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 19:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgIPR3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:29:51 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38456 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgIPR2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:28:19 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08GHRrkH025564;
        Wed, 16 Sep 2020 12:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600277273;
        bh=LkBW9ONdKm4rqq/prIT6RDmrGFJczaFsMOjwTjMAG/o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rj6XGgTVaO0Xk3aevo8OqbCTnu5gU+bONevSGgPR25UDSnxGOIsKPnOczH9yNHaDd
         d0gjFSZ6UNTP0yLgOM9A9H8/LrrPBuxjbVegyyQVNxWyh5uaZX+zZ2VeO7YOpH9fw5
         xsoEzPnaZatnccyICtESgqbM9b623/1VaVLMbvIY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08GHRrjT051739;
        Wed, 16 Sep 2020 12:27:53 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Sep 2020 12:27:53 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Sep 2020 12:27:53 -0500
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08GHRk1W018084;
        Wed, 16 Sep 2020 12:27:50 -0500
Subject: Re: [PATCH v6 0/2] PHY: Add new PHY attribute max_link_rate
To:     Vinod Koul <vkoul@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Swapnil Jakhade <sjakhade@cadence.com>, <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <maxime@cerno.tech>,
        <mparab@cadence.com>, <yamonkar@cadence.com>,
        <tomi.valkeinen@ti.com>, <jsarha@ti.com>, <praneeth@ti.com>
References: <1599805114-22063-1-git-send-email-sjakhade@cadence.com>
 <e1ae0a53-02a2-8a17-094f-570be6d24b1c@ti.com>
 <20200916121855.GB3853@pendragon.ideasonboard.com>
 <20200916124307.GL2968@vkoul-mobl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <d7d2f8b5-86a2-c2f9-62ff-cf60278a5463@ti.com>
Date:   Wed, 16 Sep 2020 22:57:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200916124307.GL2968@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/20 6:13 PM, Vinod Koul wrote:
> On 16-09-20, 15:18, Laurent Pinchart wrote:
>> Hi Sekhar,
>>
>> On Wed, Sep 16, 2020 at 01:11:17PM +0530, Sekhar Nori wrote:
>>> On 11/09/20 11:48 AM, Swapnil Jakhade wrote:
>>>> This patch series adds a new PHY attribute max_link_rate.
>>>> It also updates Cadence Torrent PHY driver to set attributes bus_width,
>>>> max_link_rate and mode for DisplayPort.
>>>>
>>>> It includes following patches:
>>>>
>>>> 1. 0001-phy-Add-new-PHY-attribute-max_link_rate.patch
>>>> This patch adds max_link_rate as a new PHY attribute.
>>>>
>>>> 2. 0002-phy-cadence-torrent-Set-Torrent-PHY-attributes.patch
>>>> This patch sets PHY attributes in Cadence Torrent PHY driver. This will
>>>> enable drivers using this PHY to read these properties.
>>>>
>>>> These attributes will be used in the Cadence MHDP DRM bridge driver [1]
>>>> which is in the process of upstreaming.
>>>
>>> Can you please add these patches on an immutable branch/tag when you are
>>> ready to apply them - will try to see if we can use it to get the
>>> DisplayPort driver merged in v5.10 too.
>>>
>>> Hi Laurent, any other ideas on managing the dependency?
>>
>> I think that will work fine.
> 
> Please pull tag phy-attrs-5.10 for phy tree

Thanks Vinod!

Swapnil, please be sure to let DRM maintainers know about the PHY tree
and the tag they can use when the DP patches are ready for merge.

Please keep Vinod in the loop too so he is aware of the tag being pulled.

Thanks,
Sekhar
