Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6A1261F79
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 22:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbgIHUDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 16:03:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54388 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730413AbgIHPXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:23:52 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 088BnQVV020100;
        Tue, 8 Sep 2020 06:49:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599565766;
        bh=pjSPFy6J/xMzAIHU07RF4zz0lm6CxM/QscpYWUYAJXk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AkZy7eEY6cVcc/50fxETiY40qYgi9DiA/hglZeheNUlEZoXUK1RQk8oOOP65xqUty
         F0QD3IDsGXUHvgl8vcpVbypAd3bvYF7dxFlnaO7YeGs42MhnN5jy4SnJ8KRlRAhFlt
         kiwfewEccFkhcz2ExW9F7dAr+iKvLq4Dqf4hPkhw=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 088BnQZd033773;
        Tue, 8 Sep 2020 06:49:26 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Sep
 2020 06:49:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Sep 2020 06:49:25 -0500
Received: from [10.250.38.37] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 088BnPP2040200;
        Tue, 8 Sep 2020 06:49:25 -0500
Subject: Re: [PATCH 2/2] ASoC: tlv320adcx140: Wake up codec before accessing
 register
To:     Camel Guo <camel.guo@axis.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>
References: <20200908083521.14105-1-camel.guo@axis.com>
 <20200908083521.14105-2-camel.guo@axis.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <89f8cce0-2407-15f5-a8e5-0aa17a2eb2c4@ti.com>
Date:   Tue, 8 Sep 2020 06:49:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908083521.14105-2-camel.guo@axis.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Camel

On 9/8/20 3:35 AM, Camel Guo wrote:
> From: Camel Guo <camelg@axis.com>
>
> According to its datasheet, after reset this codec goes into sleep
> mode. In this mode, any register accessing should be avoided except for
> exiting sleep mode. Hence this commit moves SLEEP_CFG access before any
> register accessing.

This is interesting because our HW team suggested putting the device 
into sleep mode when doing register writes/reads because they were 
finding abnormalities in the register settings when the device is active.

I have a local patch that changes this as well that the HW team requested.

Mark

Let me run this by the HW team first before applying this patch.

Dan

