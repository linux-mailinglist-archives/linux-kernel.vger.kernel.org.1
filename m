Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E892C3249
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 22:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbgKXVDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 16:03:30 -0500
Received: from mx-relay80-hz1.antispameurope.com ([94.100.133.250]:43091 "EHLO
        mx-relay80-hz1.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729237AbgKXVD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:03:29 -0500
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Nov 2020 16:03:28 EST
Received: from smtp.eckelmann.de ([217.19.183.80]) by mx-relay80-hz1.antispameurope.com;
 Tue, 24 Nov 2020 21:58:20 +0100
Received: from ws067.eckelmann.group (2a00:1f08:4007:e035:172:18:35:1b) by
 EX-SRV2.eckelmann.group (2a00:1f08:4007:e030:172:18:30:61) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 24 Nov 2020 21:58:15 +0100
Date:   Tue, 24 Nov 2020 21:58:14 +0100
From:   Thorsten Scherer <thorsten.scherer@eckelmann.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 0/2] siox: two cleanups
Message-ID: <20201124205814.lzzxc5nepulcngva@ws067.eckelmann.group>
References: <20201124141834.3096325-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201124141834.3096325-1-u.kleine-koenig@pengutronix.de>
X-Originating-IP: [2a00:1f08:4007:e035:172:18:35:1b]
X-ClientProxiedBy: EX-SRV1.eckelmann.group (2a00:1f08:4007:e030:172:18:30:60)
 To EX-SRV2.eckelmann.group (2a00:1f08:4007:e030:172:18:30:61)
X-cloud-security-sender: t.scherer@eckelmann.de
X-cloud-security-recipient: linux-kernel@vger.kernel.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay80-hz1.antispameurope.com with 56B7D10E0EDE
X-cloud-security-connect: smtp.eckelmann.de[217.19.183.80], TLS=1, IP=217.19.183.80
X-cloud-security: scantime:.5004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=eckelmann.de; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=hse1; bh=
        94A4EPYzV4lPgvsCmlirKBfWsaa2kY+iLIBRveRHuDo=; b=QnnnX/nlaVJGh1bA
        XD4p9HaPwsxTp+drlSffn4qzwGAshAJjyAihPBaBMuoR3TqU3SP0QZNBvcmlcPAo
        pOq0aDE5FplKVFel4ySAD6w4chWtZX9RXFX40A+0MlCYAecvJkk6mvQRwZRt4E8e
        pzCCaweoDhfs4QG1q2o0O4i8n4FKwh1bHI/mVFBHHqKJiDMYMWqwpbMEc5B79zUd
        kX0cvPVWQn+6xAqcD6AsLa2mhDlZ39ZjrAMOOyaRb+k251pMWoVXau1YQC3kVpHk
        pFJkZGeu79HqvknulO8J63qUZdDjojC7Z8PKSY82FIAvhGdrmxneEm7gQ69VL7Ml
        sgVhvQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Nov 24, 2020 at 03:18:32PM +0100, Uwe Kleine-König wrote:
> Hello,
> 
> compared to v1 sent starting with
> Message-Id:20201119132311.2604232-1-u.kleine-koenig@pengutronix.de:
> 
>  - Prepare siox_shutdown() to be called even for unbound devices in
>    patch 1.
>  - remove stray "if (sdriver->probe)" in patch 1 (how embarrassing).
>  - Fix grammar in patch 2's commit log.

I successfully ran our siox testcases with this series applied.  

Though not expecting this result to change, i will re-run them on v3 and
then add a Tested-by.

> 
> Uwe Kleine-König (2):
>   siox: Use bus_type functions for probe, remote and shutdown
>   siox: Make remove callback return void
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

Kind regards
Thorsten

--
Thorsten Scherer | Eckelmann AG | www.eckelmann.de |
