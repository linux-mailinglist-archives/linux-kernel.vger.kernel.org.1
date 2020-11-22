Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84072BC677
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 16:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbgKVP1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 10:27:50 -0500
Received: from gproxy6-pub.mail.unifiedlayer.com ([67.222.39.168]:59657 "EHLO
        gproxy6-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727317AbgKVP1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 10:27:50 -0500
Received: from cmgw15.unifiedlayer.com (unknown [10.9.0.15])
        by gproxy6.mail.unifiedlayer.com (Postfix) with ESMTP id 9DAFF1E0623
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 08:27:47 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id grHHkFjZPh41lgrHHkK09f; Sun, 22 Nov 2020 08:27:47 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=FoUrAVjq c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=IpJZQVW2AAAA:8
 a=V5HrGZSkAAAA:8 a=y-cM_Wnh2vrtR7T-X1gA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=IawgGOuG5U0WyFbmm1f5:22 a=EqIeuvSPQFrb6XTREnMR:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KsyIk3GaA7LYm+DY1XjzBR2mCUpVCJ8ksXBotlkQ9xg=; b=MlK7cIpkjzQ6LLIgIp2zrG6qZf
        RqdO1wQiBjsf/e2fA4BwNdk3egqDgBKBDkPryXD/JsyLMjjfGzlY0mEh7P5KsegnWQB0snK1x1TDj
        YQqOEFCcC8gV7SQUDQsvkPIYX4XF8N0Teo7prmbhPjykD168Vhu1JOo2Qg90Zqsacq4e5A2DbZtkw
        QMOjW4xTruJlgJf6cRhYhpOiTKimrmCL4SW2VW2eT44+ihDhTRGefje+CRmXJ591Ckh2VYVZmQRyD
        r7WIZPP9+mZN86JsqZshJEb5Wy/H+A759Qk7kl4cMB7FQuRTvAVmzY/ox85HyUn3WAFG0amTx8PQm
        hrSGvXSw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:45162 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kgrHG-003S12-Mt; Sun, 22 Nov 2020 15:27:46 +0000
Date:   Sun, 22 Nov 2020 07:27:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: drivetemp: fix typo temperatire => temperature
Message-ID: <20201122152746.GA128684@roeck-us.net>
References: <20201115190910.12539-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201115190910.12539-1-clabbe@baylibre.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kgrHG-003S12-Mt
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:45162
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 5
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 07:09:10PM +0000, Corentin Labbe wrote:
> This patch fix a trivial typo temperatire => temperature.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/drivetemp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/drivetemp.c b/drivers/hwmon/drivetemp.c
> index 72c760373957..1eb37106a220 100644
> --- a/drivers/hwmon/drivetemp.c
> +++ b/drivers/hwmon/drivetemp.c
> @@ -10,7 +10,7 @@
>   *    hwmon: Driver for SCSI/ATA temperature sensors
>   *    by Constantin Baranov <const@mimas.ru>, submitted September 2009
>   *
> - * This drive supports reporting the temperatire of SATA drives. It can be
> + * This drive supports reporting the temperature of SATA drives. It can be
>   * easily extended to report the temperature of SCSI drives.
>   *
>   * The primary means to read drive temperatures and temperature limits
