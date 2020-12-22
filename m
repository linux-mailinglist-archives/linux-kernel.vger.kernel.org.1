Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7082E09C8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 12:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgLVLfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 06:35:16 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:41771 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgLVLfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 06:35:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608636896; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=VzpQ5rwXRSrUDR5+QdfdTTAyPqtNIHURgGYaJE8HPCk=;
 b=W1IBtauKty4gM1xZLHngX71332XqEM2Twhedz5rE1PkLCDK4b9+saiL1ZFtE0ndK5BzU+O3B
 ak7znHEJfPvxKkNhgSpqT9gWU58ig9PIugt8qHrJmRLoVyN5vFWyl+YCdTe95xbp6gSj+eRJ
 rgCIfE4fXb7WlJrD6Q8uHSxHqfc=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5fe1d9d4cfd94dd328496568 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Dec 2020 11:34:44
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D7D2BC433C6; Tue, 22 Dec 2020 11:34:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B22DC433ED;
        Tue, 22 Dec 2020 11:34:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 22 Dec 2020 19:34:43 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        avri.altman@wdc.com, alim.akhtar@samsung.com, jejb@linux.ibm.com,
        beanhuo@micron.com, asutoshd@codeaurora.org,
        matthias.bgg@gmail.com, bvanassche@acm.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kuohong.wang@mediatek.com, peter.wang@mediatek.com,
        chun-hung.wu@mediatek.com, andy.teng@mediatek.com,
        chaotian.jing@mediatek.com, cc.chou@mediatek.com,
        jiajie.hao@mediatek.com, alice.chao@mediatek.com
Subject: Re: [PATCH v1] scsi: ufs-mediatek: Enable
 UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL
In-Reply-To: <20201222072928.32328-1-stanley.chu@mediatek.com>
References: <20201222072928.32328-1-stanley.chu@mediatek.com>
Message-ID: <c862866ec97516a7ffb891e5de3d132d@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-22 15:29, Stanley Chu wrote:
> Flush during hibern8 is sufficient on MediaTek platforms, thus
> enable UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL to skip enabling
> fWriteBoosterBufferFlush during WriteBooster initialization.
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---
>  drivers/scsi/ufs/ufs-mediatek.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/ufs/ufs-mediatek.c 
> b/drivers/scsi/ufs/ufs-mediatek.c
> index 80618af7c872..c55202b92a43 100644
> --- a/drivers/scsi/ufs/ufs-mediatek.c
> +++ b/drivers/scsi/ufs/ufs-mediatek.c
> @@ -661,6 +661,7 @@ static int ufs_mtk_init(struct ufs_hba *hba)
> 
>  	/* Enable WriteBooster */
>  	hba->caps |= UFSHCD_CAP_WB_EN;
> +	hba->quirks |= UFSHCI_QUIRK_SKIP_MANUAL_WB_FLUSH_CTRL;
>  	hba->vps->wb_flush_threshold = UFS_WB_BUF_REMAIN_PERCENT(80);
> 
>  	if (host->caps & UFS_MTK_CAP_DISABLE_AH8)

I guess we need it too...

Change LGTM.

Regards,

Can Guo.
