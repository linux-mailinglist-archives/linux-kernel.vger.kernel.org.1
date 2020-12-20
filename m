Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C708A2DF5FF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 16:56:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgLTPyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 10:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbgLTPyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 10:54:24 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8896CC0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 07:53:43 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 23so17736378lfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 07:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w76pCbNy6dxzNTJV7uHayuF0nPAVCQYp3cgaHRN1pxg=;
        b=IWK1veCqkgZg0RfGQiV33qKujvUJIF+bvTfYUJjG5xtXku66UuxK4HiDdFvlrKhlav
         3OpCMbE/9CpWEb6fTIzg7xCi6ftOq25maadCVjcnNh4dk5/Q8UDBxY8lHnE4K7A8hOlT
         SJB56Sy88Qjf4ixmoPGG13RooG5H4+YR5to5qNfm92V4gY0lLgef+CtGAZlr9vPPploF
         SoxD8qsxYBn0Al9+xKMVTLod9hnty09YxFr5JmowJ1O8rnzdCcx3CKTSJxr7oTM9ldbq
         LPiPgwpS2zG3cQnpZUq5FyxLiW9lswXEJ+1yeQA0XCfo/DPNe3EnuDHocDMQpO0zkhLI
         Yv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w76pCbNy6dxzNTJV7uHayuF0nPAVCQYp3cgaHRN1pxg=;
        b=AC/i9H0TiQSwksEDGQkEWD8eZHjm4g7bKwP/fcPbGYelF1d0GEFjcPGc3/sfXNltlV
         mZqDeihDyP9i0h/4DzOLcKq6VlzMIYyrEezGbZkKM28h6ooNloEG7/AdJL9VtUR0VGpu
         phD45i2mbJFB8F1loRDtnHpw7slAjOPYE2hofMGPFr0Gg8J+4Q0w83oAFU6S3ZRed7zP
         cC1ymLpwd0jvXIu30CMtvtaeRZ0iiUWnoLogXHjTHyUVsBHUqfyfDPL7cRYcRZ5AMTXb
         5JYhhDZX02gll37GeNKjW8Z6UmK/wm5+82TgGfGdsSvEtg+OBgd2wnGcATFcMA4pfRQe
         uoUA==
X-Gm-Message-State: AOAM530DeqWf9a2COx+plzIVHXS+kRbkgocwGtyPZOwjG9L5KGlVau4y
        n9apQSaqXZnWOQ1mZ7Iy7J8=
X-Google-Smtp-Source: ABdhPJxk3EmTSSarCFyPET1I9pcrsaQ7+5lBrzGUboTUPa/xBJZ2oxFjq9QVuNDQlgrgX4m20qSOkg==
X-Received: by 2002:a19:3f01:: with SMTP id m1mr4957152lfa.203.1608479621895;
        Sun, 20 Dec 2020 07:53:41 -0800 (PST)
Received: from kari-VirtualBox (87-95-193-210.bb.dnainternet.fi. [87.95.193.210])
        by smtp.gmail.com with ESMTPSA id t196sm1679738lff.195.2020.12.20.07.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 07:53:41 -0800 (PST)
Date:   Sun, 20 Dec 2020 17:53:39 +0200
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     gregkh@linuxfoundation.org, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: fix bool comparison in expressions
Message-ID: <20201220155339.qove5haszqr7zggl@kari-VirtualBox>
References: <20201217114204.12029-1-yashsri421@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217114204.12029-1-yashsri421@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 05:12:04PM +0530, Aditya Srivastava wrote:
> There are certain conditional expressions in rtl8192e, where a boolean
> variable is compared with true/false, in forms such as (foo == true) or
> (false != bar), which does not comply with checkpatch.pl (CHECK:
> BOOL_COMPARISON), according to which boolean variables should be
> themselves used in the condition, rather than comparing with true/false
> 
> E.g. in drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c,
> "if (Type == true)" can be replaced with: "if (Type)"
> 
> Replace all such expressions with the bool variables appropriately
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> - the changes made are compile tested
> - the patch applies perfectly over next-20201204
> 
>  drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c | 4 ++--
>  drivers/staging/rtl8192e/rtl8192e/rtl_core.c   | 4 ++--
>  drivers/staging/rtl8192e/rtl8192e/rtl_dm.c     | 4 ++--
>  drivers/staging/rtl8192e/rtllib_rx.c           | 4 ++--
>  drivers/staging/rtl8192e/rtllib_tx.c           | 8 ++++----
>  5 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> index 9f869fb3eaa8..c4a3fc79fb40 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> @@ -129,9 +129,9 @@ void rtl92e_set_reg(struct net_device *dev, u8 variable, u8 *val)
>  		RegRCR = rtl92e_readl(dev, RCR);
>  		priv->ReceiveConfig = RegRCR;
>  
> -		if (Type == true)
> +		if (Type)
>  			RegRCR |= (RCR_CBSSID);
> -		else if (Type == false)
> +		else if (!Type)

Just else here?

>  			RegRCR &= (~RCR_CBSSID);
>  
>  		rtl92e_writel(dev, RCR, RegRCR);
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> index 663675efcfe4..9078fadd65f9 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
> @@ -1389,7 +1389,7 @@ static void _rtl92e_watchdog_wq_cb(void *data)
>  
>  	rtl92e_dm_watchdog(dev);
>  
> -	if (rtllib_act_scanning(priv->rtllib, false) == false) {
> +	if (!rtllib_act_scanning(priv->rtllib, false)) {
>  		if ((ieee->iw_mode == IW_MODE_INFRA) && (ieee->state ==
>  		     RTLLIB_NOLINK) &&
>  		     (ieee->eRFPowerState == eRfOn) && !ieee->is_set_key &&
> @@ -2471,7 +2471,7 @@ static int _rtl92e_pci_probe(struct pci_dev *pdev,
>  
>  	priv->ops = ops;
>  
> -	if (rtl92e_check_adapter(pdev, dev) == false)
> +	if (!rtl92e_check_adapter(pdev, dev))
>  		goto err_unmap;
>  
>  	dev->irq = pdev->irq;
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> index 462835684e8b..e340be3ebb97 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> @@ -1765,7 +1765,7 @@ static void _rtl92e_dm_cts_to_self(struct net_device *dev)
>  	unsigned long curTxOkCnt = 0;
>  	unsigned long curRxOkCnt = 0;
>  
> -	if (priv->rtllib->bCTSToSelfEnable != true) {
> +	if (!priv->rtllib->bCTSToSelfEnable) {
>  		pHTInfo->IOTAction &= ~HT_IOT_ACT_FORCED_CTS2SELF;
>  		return;
>  	}
> @@ -2447,7 +2447,7 @@ static void _rtl92e_dm_dynamic_tx_power(struct net_device *dev)
>  	unsigned int txhipower_threshold = 0;
>  	unsigned int txlowpower_threshold = 0;
>  
> -	if (priv->rtllib->bdynamic_txpower_enable != true) {
> +	if (!priv->rtllib->bdynamic_txpower_enable) {
>  		priv->bDynamicTxHighPower = false;
>  		priv->bDynamicTxLowPower = false;
>  		return;
> diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
> index d31b5e1c8df4..217557ac8d80 100644
> --- a/drivers/staging/rtl8192e/rtllib_rx.c
> +++ b/drivers/staging/rtl8192e/rtllib_rx.c
> @@ -924,7 +924,7 @@ static int rtllib_rx_check_duplicate(struct rtllib_device *ieee,
>  	sc = le16_to_cpu(hdr->seq_ctl);
>  	frag = WLAN_GET_SEQ_FRAG(sc);
>  
> -	if ((ieee->pHTInfo->bCurRxReorderEnable == false) ||
> +	if ((!ieee->pHTInfo->bCurRxReorderEnable) ||

No need for brackets. Atleast after you remove check.

>  		!ieee->current_network.qos_data.active ||
>  		!IsDataFrame(skb->data) ||
>  		IsLegacyDataFrame(skb->data)) {
> @@ -1442,7 +1442,7 @@ static int rtllib_rx_InfraAdhoc(struct rtllib_device *ieee, struct sk_buff *skb,
>  	}
>  
>  	/* Indicate packets to upper layer or Rx Reorder */
> -	if (ieee->pHTInfo->bCurRxReorderEnable == false || pTS == NULL ||
> +	if (!ieee->pHTInfo->bCurRxReorderEnable || pTS == NULL ||
>  	    bToOtherSTA)

Now bToOtherSTA would fit same line. It is ok to fix that also.

>  		rtllib_rx_indicate_pkt_legacy(ieee, rx_stats, rxb, dst, src);
>  	else
> diff --git a/drivers/staging/rtl8192e/rtllib_tx.c b/drivers/staging/rtl8192e/rtllib_tx.c
> index e0d79daca24a..8add17752eed 100644
> --- a/drivers/staging/rtl8192e/rtllib_tx.c
> +++ b/drivers/staging/rtl8192e/rtllib_tx.c
> @@ -297,7 +297,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
>  			netdev_info(ieee->dev, "%s: can't get TS\n", __func__);
>  			return;
>  		}
> -		if (pTxTs->TxAdmittedBARecord.bValid == false) {
> +		if (!pTxTs->TxAdmittedBARecord.bValid) {
>  			if (ieee->wpa_ie_len && (ieee->pairwise_key_type ==
>  			    KEY_TYPE_NA)) {
>  				;
> @@ -307,7 +307,7 @@ static void rtllib_tx_query_agg_cap(struct rtllib_device *ieee,
>  				TsStartAddBaProcess(ieee, pTxTs);
>  			}
>  			goto FORCED_AGG_SETTING;
> -		} else if (pTxTs->bUsingBa == false) {
> +		} else if (!pTxTs->bUsingBa) {
>  			if (SN_LESS(pTxTs->TxAdmittedBARecord.BaStartSeqCtrl.field.SeqNum,
>  			   (pTxTs->TxCurSeq+1)%4096))
>  				pTxTs->bUsingBa = true;
> @@ -365,9 +365,9 @@ static void rtllib_query_HTCapShortGI(struct rtllib_device *ieee,
>  		return;
>  	}
>  
> -	if ((pHTInfo->bCurBW40MHz == true) && pHTInfo->bCurShortGI40MHz)
> +	if (pHTInfo->bCurBW40MHz && pHTInfo->bCurShortGI40MHz)
>  		tcb_desc->bUseShortGI = true;
> -	else if ((pHTInfo->bCurBW40MHz == false) && pHTInfo->bCurShortGI20MHz)
> +	else if (!pHTInfo->bCurBW40MHz && pHTInfo->bCurShortGI20MHz)
>  		tcb_desc->bUseShortGI = true;
>  }
