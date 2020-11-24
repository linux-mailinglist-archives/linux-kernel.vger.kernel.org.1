Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E53D2C324A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 22:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgKXVEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 16:04:09 -0500
Received: from mx-relay26-hz1.antispameurope.com ([94.100.133.202]:58261 "EHLO
        mx-relay26-hz1.antispameurope.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729237AbgKXVEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 16:04:09 -0500
Received: from smtp.eckelmann.de ([217.19.183.80]) by mx-relay26-hz1.antispameurope.com;
 Tue, 24 Nov 2020 21:58:45 +0100
Received: from ws067.eckelmann.group (2a00:1f08:4007:e035:172:18:35:1b) by
 EX-SRV2.eckelmann.group (2a00:1f08:4007:e030:172:18:30:61) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 24 Nov 2020 21:58:36 +0100
Date:   Tue, 24 Nov 2020 21:58:35 +0100
From:   Thorsten Scherer <thorsten.scherer@eckelmann.de>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 1/2] siox: Use bus_type functions for probe, remote
 and shutdown
Message-ID: <20201124205835.nqruewwogw23dgea@ws067.eckelmann.group>
References: <20201124141834.3096325-1-u.kleine-koenig@pengutronix.de>
 <20201124141834.3096325-2-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201124141834.3096325-2-u.kleine-koenig@pengutronix.de>
X-Originating-IP: [2a00:1f08:4007:e035:172:18:35:1b]
X-ClientProxiedBy: EX-SRV2.eckelmann.group (2a00:1f08:4007:e030:172:18:30:61)
 To EX-SRV2.eckelmann.group (2a00:1f08:4007:e030:172:18:30:61)
X-cloud-security-sender: t.scherer@eckelmann.de
X-cloud-security-recipient: linux-kernel@vger.kernel.org
X-cloud-security-Virusscan: CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay26-hz1.antispameurope.com with 90C9CD600F9
X-cloud-security-connect: smtp.eckelmann.de[217.19.183.80], TLS=1, IP=217.19.183.80
X-cloud-security: scantime:.2986
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=eckelmann.de; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=hse1; bh=
        VNdb/cGoU76KlIIX/DFltjyrEDcRdbBlHEuyS61v1GU=; b=EtRqu2viqRSoacXd
        8uBJWZg7L2Gsnmh00+rkwEoGCqwzJ0Bgc/+wkVckYTm7Ko/0ureKs3usBcstiOld
        rdmm5aYrXZsNCifD/uQV0jKeI8XrTUYTPXtWfyVjc/Qp4t1GSqUdHEDR2qowi6FS
        XY/viDgxBXc1mWPcsEOXm6EiqjpzuOTf/sW6IzkhbcygrqRbSujMdjiI4eNNcK6X
        gULtY21b+N3YU7T0nRUjObsZUcc3pl8dGJyKOes8tZKARszgYfaZHlhPXBLCOMs+
        bcY4hivVuu19Nizlf5XtbgEFcVGh+RyRDMYdYn11NDR7dLPZupO/JUB0HNKVo2re
        S3njGQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe,

you already know, but FTR, there is a typo in the subject.

s/remote/remove/

On Tue, Nov 24, 2020 at 03:18:33PM +0100, Uwe Kleine-König wrote:
> The eventual goal is to get rid of the callbacks in struct
> device_driver.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/siox/siox-core.c | 49 ++++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/siox/siox-core.c b/drivers/siox/siox-core.c
> index f8c08fb9891d..b56cdcb52967 100644
> --- a/drivers/siox/siox-core.c
> +++ b/drivers/siox/siox-core.c

[...]

Apart from this you can add

Acked-by: Thorsten Scherer <t.scherer@eckelmann.de>

Kind regards
Thorsten

--
Thorsten Scherer | Eckelmann AG | www.eckelmann.de |
