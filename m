Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32672C349E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 00:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387776AbgKXXXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 18:23:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40597 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387688AbgKXXXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 18:23:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606260197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=juO2ukM0vWEz2TyhMweuiHZkMxI8vTNzyetnn/4z4BE=;
        b=A7BpR2UkLEnMKa/0H7Mmu1+00OIJSAnX3Eth5gvI6qTDxrb0TRJqPq488LNsvoJPmBFbwm
        OH1SmFVQ74q08UyZh8wDqMjMhpaelBtB0sL96hCwSexsvHVryqag0R1oECANvByvjgX+7E
        aHVnF77qtntPfJa22DcpJ7778QjLhOw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-OIAh5lbUNuqNJH_B7lfNAA-1; Tue, 24 Nov 2020 18:23:15 -0500
X-MC-Unique: OIAh5lbUNuqNJH_B7lfNAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB07680F041;
        Tue, 24 Nov 2020 23:23:13 +0000 (UTC)
Received: from ovpn-112-111.phx2.redhat.com (ovpn-112-111.phx2.redhat.com [10.3.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 541061001E73;
        Tue, 24 Nov 2020 23:23:13 +0000 (UTC)
Message-ID: <b09bdc573715f51117c788a9b02d6b87c9735c4b.camel@redhat.com>
Subject: Re: [PATCH][next] scsi: pm8001: remove space in a debug message
From:   "Ewan D. Milne" <emilne@redhat.com>
To:     Colin King <colin.king@canonical.com>, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 24 Nov 2020 18:23:12 -0500
In-Reply-To: <20201124093828.307709-1-colin.king@canonical.com>
References: <20201124093828.307709-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-11-24 at 09:38 +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There are two words that need separating with a space in a 
> pm8001_dbg message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/scsi/pm8001/pm8001_hwi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/pm8001/pm8001_hwi.c
> b/drivers/scsi/pm8001/pm8001_hwi.c
> index 08d6cc9b50db..c8d4d87c5473 100644
> --- a/drivers/scsi/pm8001/pm8001_hwi.c
> +++ b/drivers/scsi/pm8001/pm8001_hwi.c
> @@ -1031,7 +1031,7 @@ pm8001_chip_soft_rst(struct pm8001_hba_info
> *pm8001_ha)
>  	regVal = pm8001_cr32(pm8001_ha, 2,
> GSM_WRITE_DATA_PARITY_CHECK);
>  	pm8001_cw32(pm8001_ha, 2, GSM_WRITE_DATA_PARITY_CHECK,
> regVal3);
>  	pm8001_dbg(pm8001_ha, INIT,
> -		   "GSM 0x700048 - Write Data Parity Check Enableis set
> to = 0x%x\n",
> +		   "GSM 0x700048 - Write Data Parity Check Enable is
> set to = 0x%x\n",
>  		   pm8001_cr32(pm8001_ha, 2,
> GSM_WRITE_DATA_PARITY_CHECK));
>  
>  	/* step 13: bring the IOP and AAP1 out of reset */

Reviewed-by: Ewan D. Milne <emilne@redhat.com>


