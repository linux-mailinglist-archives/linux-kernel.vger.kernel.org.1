Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA67E2C4263
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 15:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgKYOsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 09:48:30 -0500
Received: from mx-relay76-hz1.antispameurope.com ([94.100.133.238]:36292 "EHLO
        mx-relay76-hz1.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729922AbgKYOs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 09:48:29 -0500
Received: from smtp.eckelmann.de ([217.19.183.80]) by mx-relay76-hz1.antispameurope.com;
 Wed, 25 Nov 2020 15:47:31 +0100
Received: from ws067.eckelmann.group (2a00:1f08:4007:e035:172:18:35:1b) by
 EX-SRV2.eckelmann.group (2a00:1f08:4007:e030:172:18:30:61) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 25 Nov 2020 15:47:22 +0100
Date:   Wed, 25 Nov 2020 15:47:20 +0100
From:   Thorsten Scherer <thorsten.scherer@eckelmann.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v3 0/2] siox: two cleanups
Message-ID: <20201125144720.5imcc3atcqpegk4i@ws067.eckelmann.group>
References: <20201125093106.240643-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201125093106.240643-1-u.kleine-koenig@pengutronix.de>
X-Originating-IP: [2a00:1f08:4007:e035:172:18:35:1b]
X-ClientProxiedBy: EX-SRV1.eckelmann.group (2a00:1f08:4007:e030:172:18:30:60)
 To EX-SRV2.eckelmann.group (2a00:1f08:4007:e030:172:18:30:61)
X-cloud-security-sender: t.scherer@eckelmann.de
X-cloud-security-recipient: linux-kernel@vger.kernel.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay76-hz1.antispameurope.com with 3AC9B1BF2F4B
X-cloud-security-connect: smtp.eckelmann.de[217.19.183.80], TLS=1, IP=217.19.183.80
X-cloud-security: scantime:2.592
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=eckelmann.de; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=hse1; bh=
        R3ZnwqsuvKngyokZzQKiDFAwcxStjCBV+HQgRMdAeeM=; b=aiYFi9EbppKEnIUe
        ClQ469MNT2TT3GFAgq3+W+RM4eu0T9AmeZsgynfKbNpiCsxjilHp6BblgUPo7kC5
        1dDkMglK3V3fV7j0huElW09uPLjaTFgJ423fJUXOIM67mIpM0XRfdvZtbThaB9Uv
        sIXBdDDaLzqdwNNk49PIZUaxwRtTftfRbrUG7gcQBoFCH167zkWHUef27gQ3OdNc
        ldC5WzY8vlLUIXiMS2VOiemE8Qu3Ti1hq5Ro5irQCtM/x73FIuzImrg4n5sk7pcz
        xEHb7pWqT+uL9Wu0YjNlds/eAIHXoxsHWdcCOWAkfwiOHTq1K2hOTogv8G74tJ0o
        QXIKvA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Nov 25, 2020 at 10:31:04AM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> compared to v2 sent starting with Message-Id:
> 20201124141834.3096325-1-u.kleine-koenig@pengutronix.de:
> 
>  - fix typo in commit log of patch 1
>  - add Ack by Thorsten for patch 1
> 
> Uwe Kleine-König (2):
>   siox: Use bus_type functions for probe, remove and shutdown
>   siox: Make remove callback return void

Successfully ran our siox testcases on v3.

Tested-by: Thorsten Scherer <t.scherer@eckelmann.de>

> 
>  drivers/siox/siox-core.c | 50 ++++++++++++++++++++--------------------
>  include/linux/siox.h     |  2 +-
>  2 files changed, 26 insertions(+), 26 deletions(-)
> 
> 
> base-commit: 418baf2c28f3473039f2f7377760bd8f6897ae18
> -- 
> 2.29.2
> 

Thanks.

Kind regards
Thorsten

--
Thorsten Scherer | Eckelmann AG | www.eckelmann.de |
