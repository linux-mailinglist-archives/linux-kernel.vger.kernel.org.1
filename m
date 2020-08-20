Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B6024C11B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 16:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgHTO62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 10:58:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:51218 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHTO6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:58:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07KEvtA8067332;
        Thu, 20 Aug 2020 09:57:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597935475;
        bh=fwkjcqXjAEvoMKw7hysN2k2pYEvPoK7LylOknVO56H8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bSWNXg7BixCbnYUPuP2MzE8rW78OaND2YyN88iHDZlhTjXdFm2cvItfXDvRvw41tl
         ymwYkvHT/xVBg38dy9ftZULxF1s0HUiI/kof7WsuiUMqeJW8H2aQnQxp7vIf0BzL7u
         3KmTDV8JPtdEOyz55TXL0M1tKRApLluZ8Ho8xUdU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07KEvto1057736
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 20 Aug 2020 09:57:55 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 20
 Aug 2020 09:57:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 20 Aug 2020 09:57:55 -0500
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07KEvrLK024724;
        Thu, 20 Aug 2020 09:57:53 -0500
Subject: Re: [PATCH v5] phy: omap-usb2-phy: disable PHY charger detect
To:     Roger Quadros <rogerq@ti.com>, <kishon@ti.com>
CC:     <vigneshr@ti.com>, <jan.kiszka@siemens.com>,
        <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>
References: <20200820133937.32504-1-rogerq@ti.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <a3b3e82c-983b-928c-156e-13d43636aa36@ti.com>
Date:   Thu, 20 Aug 2020 20:27:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200820133937.32504-1-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/20 7:09 PM, Roger Quadros wrote:
> AM654x PG1.0 has a silicon bug that D+ is pulled high after POR, which
> could cause enumeration failure with some USB hubs.  Disabling the
> USB2_PHY Charger Detect function will put D+ into the normal state.
> 
> This addresses Silicon Errata:
> i2075 - "USB2PHY: USB2PHY Charger Detect is Enabled by Default Without VBUS
> Presence"
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

+ Vinod as well
