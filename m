Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0CC29953D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789686AbgJZSZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:25:36 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:23838 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1784566AbgJZSZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:25:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603736734; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=G0eqTb28YUCQE6wydCPTKC1qYreOL0mpGP289xk3vI0=;
 b=Kj0qTIrb0atNlicikwrs4Y7v6KawUYyk33euoizGvzHqIw8LaIq1TKM26y8TPdJ6oaIqkrAY
 afxohxigikeZQSbWfKUIL8iKYodt9ABkA+HXLomkN99qG2sJN5afsZDvi9zMbYCSzdEIcQnu
 f0JMAB4tzPYAa2MGL1tl8+JNQXs=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f97149e1e4642bf75fe23b7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 26 Oct 2020 18:25:34
 GMT
Sender: asutoshd=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ADC35C433CB; Mon, 26 Oct 2020 18:25:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: asutoshd)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA587C433FE;
        Mon, 26 Oct 2020 18:25:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 26 Oct 2020 11:25:32 -0700
From:   asutoshd@codeaurora.org
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        cang@codeaurora.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, Jaegeuk Kim <jaegeuk@google.com>
Subject: Re: [PATCH v3 2/5] scsi: ufs: clear UAC for FFU and RPMB LUNs
In-Reply-To: <20201024150646.1790529-3-jaegeuk@kernel.org>
References: <20201024150646.1790529-1-jaegeuk@kernel.org>
 <20201024150646.1790529-3-jaegeuk@kernel.org>
Message-ID: <84bad19305642b7faf21a1a48eb3e46f@codeaurora.org>
X-Sender: asutoshd@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-24 08:06, Jaegeuk Kim wrote:
> From: Jaegeuk Kim <jaegeuk@google.com>
> 
> In order to conduct FFU or RPMB operations, UFS needs to clear UAC. 
> This patch
> clears it explicitly, so that we could get no failure given early 
> execution.
> 

What's the meaning of 'given early execution'?

> Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
> ---
>  drivers/scsi/ufs/ufshcd.c | 70 +++++++++++++++++++++++++++++++++++----
>  drivers/scsi/ufs/ufshcd.h |  1 +
>  2 files changed, 65 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> index e0b479f9eb8a..011e80a21170 100644
> --- a/drivers/scsi/ufs/ufshcd.c
> +++ b/drivers/scsi/ufs/ufshcd.c
> @@ -7057,7 +7057,6 @@ static inline void
> ufshcd_blk_pm_runtime_init(struct scsi_device *sdev)
>  static int ufshcd_scsi_add_wlus(struct ufs_hba *hba)
>  {
>  	int ret = 0;
> -	struct scsi_device *sdev_rpmb;
>  	struct scsi_device *sdev_boot;
> 
>  	hba->sdev_ufs_device = __scsi_add_device(hba->host, 0, 0,
> @@ -7070,14 +7069,14 @@ static int ufshcd_scsi_add_wlus(struct ufs_hba 
> *hba)
>  	ufshcd_blk_pm_runtime_init(hba->sdev_ufs_device);
>  	scsi_device_put(hba->sdev_ufs_device);
> 
> -	sdev_rpmb = __scsi_add_device(hba->host, 0, 0,
> +	hba->sdev_rpmb = __scsi_add_device(hba->host, 0, 0,
>  		ufshcd_upiu_wlun_to_scsi_wlun(UFS_UPIU_RPMB_WLUN), NULL);
> -	if (IS_ERR(sdev_rpmb)) {
> -		ret = PTR_ERR(sdev_rpmb);
> +	if (IS_ERR(hba->sdev_rpmb)) {
> +		ret = PTR_ERR(hba->sdev_rpmb);
>  		goto remove_sdev_ufs_device;
>  	}
> -	ufshcd_blk_pm_runtime_init(sdev_rpmb);
> -	scsi_device_put(sdev_rpmb);
> +	ufshcd_blk_pm_runtime_init(hba->sdev_rpmb);
> +	scsi_device_put(hba->sdev_rpmb);
> 
>  	sdev_boot = __scsi_add_device(hba->host, 0, 0,
>  		ufshcd_upiu_wlun_to_scsi_wlun(UFS_UPIU_BOOT_WLUN), NULL);
> @@ -7601,6 +7600,63 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
>  	return ret;
>  }
> 
> +static int
> +ufshcd_send_request_sense(struct ufs_hba *hba, struct scsi_device 
> *sdp);
> +
> +static int ufshcd_clear_ua_wlun(struct ufs_hba *hba, u8 wlun)
> +{
> +	struct scsi_device *sdp;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	spin_lock_irqsave(hba->host->host_lock, flags);
> +	if (wlun  == UFS_UPIU_UFS_DEVICE_WLUN)
> +		sdp = hba->sdev_ufs_device;
> +	else if (wlun  == UFS_UPIU_RPMB_WLUN)
> +		sdp = hba->sdev_rpmb;
> +	else
> +		BUG_ON(1);
> +	if (sdp) {
> +		ret = scsi_device_get(sdp);
> +		if (!ret && !scsi_device_online(sdp)) {
> +			ret = -ENODEV;
> +			scsi_device_put(sdp);
> +		}
> +	} else {
> +		ret = -ENODEV;
> +	}
> +	spin_unlock_irqrestore(hba->host->host_lock, flags);
> +	if (ret)
> +		goto out_err;
> +
> +	ret = ufshcd_send_request_sense(hba, sdp);
> +	scsi_device_put(sdp);
> +out_err:
> +	if (ret)
> +		dev_err(hba->dev, "%s: UAC clear LU=%x ret = %d\n",
> +				__func__, wlun, ret);
> +	return ret;
> +}
> +
> +static int ufshcd_clear_ua_wluns(struct ufs_hba *hba)
> +{
> +	int ret = 0;
> +
> +	if (!hba->wlun_dev_clr_ua)
> +		goto out;
> +
> +	ret = ufshcd_clear_ua_wlun(hba, UFS_UPIU_UFS_DEVICE_WLUN);
> +	if (!ret)
> +		ret = ufshcd_clear_ua_wlun(hba, UFS_UPIU_RPMB_WLUN);
> +	if (!ret)
> +		hba->wlun_dev_clr_ua = false;
> +out:
> +	if (ret)
> +		dev_err(hba->dev, "%s: Failed to clear UAC WLUNS ret = %d\n",
> +				__func__, ret);
> +	return ret;
> +}
> +
>  /**
>   * ufshcd_probe_hba - probe hba to detect device and initialize
>   * @hba: per-adapter instance
> @@ -7720,6 +7776,8 @@ static void ufshcd_async_scan(void *data,
> async_cookie_t cookie)
>  		pm_runtime_put_sync(hba->dev);
>  		ufshcd_exit_clk_scaling(hba);
>  		ufshcd_hba_exit(hba);
> +	} else {
> +		ufshcd_clear_ua_wluns(hba);
>  	}
>  }
> 
> diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
> index 47eb1430274c..718881d038f5 100644
> --- a/drivers/scsi/ufs/ufshcd.h
> +++ b/drivers/scsi/ufs/ufshcd.h
> @@ -681,6 +681,7 @@ struct ufs_hba {
>  	 * "UFS device" W-LU.
>  	 */
>  	struct scsi_device *sdev_ufs_device;
> +	struct scsi_device *sdev_rpmb;
> 
>  	enum ufs_dev_pwr_mode curr_dev_pwr_mode;
>  	enum uic_link_state uic_link_state;
