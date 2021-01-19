Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA7A2FB858
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392688AbhASMSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:18:35 -0500
Received: from m42-8.mailgun.net ([69.72.42.8]:42565 "EHLO m42-8.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390836AbhASMJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:09:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611058141; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=aUEtiVmAQ8CmZiOc/Yc+ZB78ABF/TMFtTD6V4jrkLKc=;
 b=pkaLJXIdXujY6VsMRQwuiH84dumdFKuHW0D/Kecx6olkfkx+nNp5Wh7udX1D0on9AfXtNUmD
 DWvXAC/gWWbT0WkVMByRuxaWUnSz0TqzjWBBKw1jCxls6+AxJ0DivllOdj3Svq6JzVG+zIQ3
 liSi6sxpvcyOz8FQ8U8Iw3TsyvY=
X-Mailgun-Sending-Ip: 69.72.42.8
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6006cbb1859d74370d289e03 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 19 Jan 2021 12:08:17
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 257D5C433CA; Tue, 19 Jan 2021 12:08:17 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1D9FDC433ED;
        Tue, 19 Jan 2021 12:08:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 Jan 2021 20:08:15 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Nitin Rawat <nitirawa@codeaurora.org>
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        vbadigan@codeaurora.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] scsi: ufs: Add UFS3.0 in ufs HCI version check
In-Reply-To: <1611058021-18611-1-git-send-email-nitirawa@codeaurora.org>
References: <1611058021-18611-1-git-send-email-nitirawa@codeaurora.org>
Message-ID: <d08cc44fa93256f040d397372afa7af1@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-19 20:07, Nitin Rawat wrote:
> As per JESD223D UFS HCI v3.0 spec, HCI version 3.0
> is also supported. Hence Adding UFS3.0 in UFS HCI
> version check to avoid logging of the error message.
> 

Reviewed-by: Can Guo <cang@codeaurora.org>

> Signed-off-by: Nitin Rawat <nitirawa@codeaurora.org>
> ---
>  drivers/scsi/ufs/ufshcd.c | 5 +++--
>  drivers/scsi/ufs/ufshci.h | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index 82ad317..54ca765 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -9255,8 +9255,9 @@ int ufshcd_init(struct ufs_hba *hba, void
> __iomem *mmio_base, unsigned int irq)
>  	if ((hba->ufs_version != UFSHCI_VERSION_10) &&
>  	    (hba->ufs_version != UFSHCI_VERSION_11) &&
>  	    (hba->ufs_version != UFSHCI_VERSION_20) &&
> -	    (hba->ufs_version != UFSHCI_VERSION_21))
> -		dev_err(hba->dev, "invalid UFS version 0x%x\n",
> +	    (hba->ufs_version != UFSHCI_VERSION_21) &&
> +	    (hba->ufs_version != UFSHCI_VERSION_30))
> +		dev_err(hba->dev, "invalid UFS HCI version 0x%x\n",
>  			hba->ufs_version);
> 
>  	/* Get Interrupt bit mask per version */
> diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
> index 6795e1f..48f6c19 100644
> --- a/drivers/scsi/ufs/ufshci.h
> +++ b/drivers/scsi/ufs/ufshci.h
> @@ -80,6 +80,7 @@ enum {
>  	UFSHCI_VERSION_11 = 0x00010100, /* 1.1 */
>  	UFSHCI_VERSION_20 = 0x00000200, /* 2.0 */
>  	UFSHCI_VERSION_21 = 0x00000210, /* 2.1 */
> +	UFSHCI_VERSION_30 = 0x00000300, /* 3.0 */
>  };
> 
>  /*
> --
> 2.7.4
