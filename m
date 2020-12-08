Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECAF2D22F1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 06:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgLHFOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 00:14:33 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39990 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgLHFOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 00:14:33 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B85CpMI047510;
        Mon, 7 Dec 2020 23:12:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607404371;
        bh=EPY4xqNnNXYsKpQoLpiUx0Ymy0gzS8hZazWoKAWQL8Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AuYICTq9YxO2wHEFboLScc4iMgKFkUWVh+8umkng1efoXxNl7nNOdEgTRJ/j1/+ah
         7276PfJXksp/DUKA9mENHgKmM/ZDBnECQXWDCo42mcDf9xqJzbdKoolOEEyizOq8Cq
         R2MBMDiM7XFv3O2W4S5lFVvO0EG2XElE0TbTs0kc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B85Cp1T004344
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Dec 2020 23:12:51 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 7 Dec
 2020 23:12:51 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 7 Dec 2020 23:12:51 -0600
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B85CjEp095316;
        Mon, 7 Dec 2020 23:12:46 -0600
Subject: Re: [RESEND PATCH] MAINTAINERS: Add myself as a reviewer for CADENCE
 USB3 DRD IP DRIVER
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Peter Chen <peter.chen@nxp.com>,
        Pawel Laszczak <pawell@cadence.com>,
        "Quadros, Roger" <rogerq@ti.com>
References: <20201208050806.15382-1-a-govindraju@ti.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <80b6d061-2d35-c8e9-81ed-8fd67445410c@ti.com>
Date:   Tue, 8 Dec 2020 10:42:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20201208050806.15382-1-a-govindraju@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Peter, Pawel and Roger for their acks.

On 08/12/20 10:38 AM, Aswath Govindraju wrote:
> I would like to help in reviewing CADENCE USB3 DRD IP DRIVER patches
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> Resending the patch to add more viewers.
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6aac0f845f34..ff9bd7d18d94 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3861,6 +3861,7 @@ CADENCE USB3 DRD IP DRIVER
>  M:	Peter Chen <peter.chen@nxp.com>
>  M:	Pawel Laszczak <pawell@cadence.com>
>  M:	Roger Quadros <rogerq@ti.com>
> +R:	Aswath Govindraju <a-govindraju@ti.com>
>  L:	linux-usb@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
> -- 
> 2.17.1
> 

