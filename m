Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62973036A2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388227AbhAZGfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:35:13 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46344 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbhAYOUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:20:06 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10PEIQcL034678;
        Mon, 25 Jan 2021 08:18:26 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1611584306;
        bh=l8MqkTrspZlMfkzgo3/5nS3QIQbMMeHh3WA/tS5Z+wA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ThDlTgJPRdOf6dgZg1BQ74EIZVBODtg3S7RY1yp7nU91rNJzrEnLXZsCGDDb3l4y9
         7jb/rTweB20iG6GykQJ2FlsJuHoWwI/+Qbsdf1LfMs5QHeEFbKJajYt8ocVzg1cvL8
         ztLqZE7hXu2jJsJZ0eShTH0JbLyHqKrs+4YnHe2A=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10PEIQsU098221
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jan 2021 08:18:26 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 25
 Jan 2021 08:18:25 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 25 Jan 2021 08:18:26 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10PEIQk2058681;
        Mon, 25 Jan 2021 08:18:26 -0600
Date:   Mon, 25 Jan 2021 08:18:26 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] mmc: J7200: Add support for higher speed modes in
 MMCSD subsystems
Message-ID: <20210125141826.b7gfv6molvunzzwb@generous>
References: <20210122162403.20700-1-a-govindraju@ti.com>
 <20210122180629.3j3aoueiwiib4gso@cavalier>
 <5341eeb2-e637-424f-3328-60dbddee1376@ti.com>
 <20210125135112.gvddr4uv7vx7kfrq@triangle>
 <fd7ac744-a6dc-9f1f-c13f-96faca14d75b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fd7ac744-a6dc-9f1f-c13f-96faca14d75b@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19:43-20210125, Aswath Govindraju wrote:
> >>> Will also help to provide some verification log along with this.
> >>>
> >>
> >> May I know what sort of logs would be best to provide. Would enumeration
> >> logs during boot suffice ?
> >>
> >> Like this,
> >> https://pastebin.ubuntu.com/p/v9NRV7GwMw/ ?
> > 
> > That just says we detected the cards, no?
> > I thought we had tests around this? Something including /sys/kernel/debug/mmc*/ios
> > 
> > Something that demonstrates that this actually runs at the claimed
> > speeds? That would be nice on linux-next, if possible as well..
> > 
> 
> Yes there are tests which confirm that claimed speeds are functional. I
> will add them in the respin.

Awesome.  much appreciated.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
