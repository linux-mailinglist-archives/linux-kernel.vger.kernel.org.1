Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB61D2CE685
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 04:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgLDD10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 22:27:26 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:45259 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbgLDD10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 22:27:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607052425; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=1UXuPNhqVN/1Lyd5lzJ0aTxwSGmky4+URvxqVkO3+HQ=;
 b=ak5SJsxo5HAHwk9cTwyDeVymR17hZOfatbkj+yTYySqxCFkrOgrzc9F7xuxS4dv1DG1NcFFU
 tFo0qC3yhZKpS/5p21/3DkZcetsjJ4er/eBk3VEN9JtmbOc2Jgdg/f+7ZrZhtKyppXNTZuKd
 rzBJLZcQgXUBby+8CeBsiw48wls=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5fc9ac880ce450987abd684b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 04 Dec 2020 03:27:04
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5334BC433CA; Fri,  4 Dec 2020 03:27:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 709CEC433ED;
        Fri,  4 Dec 2020 03:27:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 04 Dec 2020 11:27:02 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Bean Huo <huobean@gmail.com>
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] scsi: ufs: Changes comment in the function
 ufshcd_wb_probe()
In-Reply-To: <20201130181143.5739-4-huobean@gmail.com>
References: <20201130181143.5739-1-huobean@gmail.com>
 <20201130181143.5739-4-huobean@gmail.com>
Message-ID: <ad0e4e0405887fa2850fe59072dfbf06@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-01 02:11, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> USFHCD supports WriteBooster "LU dedicated buffer” mode and
> “shared buffer” mode both, so changes the comment in the
> function ufshcd_wb_probe().
> 
> Signed-off-by: Bean Huo <beanhuo@micron.com>

Reviewed-by: Can Guo <cang@codeaurora.org>

> ---
>  drivers/scsi/ufs/ufshcd.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index eb7a2534b072..2091775ed3e2 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -7166,10 +7166,9 @@ static void ufshcd_wb_probe(struct ufs_hba
> *hba, u8 *desc_buf)
>  		goto wb_disabled;
> 
>  	/*
> -	 * WB may be supported but not configured while provisioning.
> -	 * The spec says, in dedicated wb buffer mode,
> -	 * a max of 1 lun would have wb buffer configured.
> -	 * Now only shared buffer mode is supported.
> +	 * WB may be supported but not configured while provisioning. The 
> spec
> +	 * says, in dedicated wb buffer mode, a max of 1 lun would have wb
> +	 * buffer configured.
>  	 */
>  	dev_info->b_wb_buffer_type =
>  		desc_buf[DEVICE_DESC_PARAM_WB_TYPE];
