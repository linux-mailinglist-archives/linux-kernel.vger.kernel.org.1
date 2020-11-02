Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624AC2A32AA
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 19:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKBSRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 13:17:21 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:58113 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgKBSRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 13:17:21 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604341040; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=nS7fTYel1RkJvIVetfpxWCWaUmGRrDbjg87RLUX+kic=;
 b=WUwAXySLLD80/TRy6Nr3iC2eTVV4K3ICrKLCsnIaXwvMnnbHy2xazCZ+7ak5YS82cG5UpmPB
 8VfzX+LDT7QOnc0CZygz+kY6NTaANG0P7cEjgpfGiHrzxeX9MXPqtzmvbbIO2bCwBo30ZnYM
 WLUEmyGA4sKIn0CC3xX5hn1YBrs=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fa04d15978460d05b8ef3c5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 02 Nov 2020 18:16:53
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8A854C433F0; Mon,  2 Nov 2020 18:16:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EFC12C433C6;
        Mon,  2 Nov 2020 18:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EFC12C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: rtw88: fix fw_fifo_addr check
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201011155438.15892-1-trix@redhat.com>
References: <20201011155438.15892-1-trix@redhat.com>
To:     trix@redhat.com
Cc:     yhchuang@realtek.com, davem@davemloft.net, kuba@kernel.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Tom Rix <trix@redhat.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201102181653.8A854C433F0@smtp.codeaurora.org>
Date:   Mon,  2 Nov 2020 18:16:53 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

trix@redhat.com wrote:

> From: Tom Rix <trix@redhat.com>
> 
> The clang build reports this warning
> 
> fw.c:1485:21: warning: address of array 'rtwdev->chip->fw_fifo_addr'
>   will always evaluate to 'true'
>         if (!rtwdev->chip->fw_fifo_addr) {
> 
> fw_fifo_addr is an array in rtw_chip_info so it is always
> nonzero.  A better check is if the first element of the array is
> nonzero.  In the cases where fw_fifo_addr is initialized by rtw88b
> and rtw88c, the first array element is 0x780.
> 
> Fixes: 0fbc2f0f34cc ("rtw88: add dump firmware fifo support")
> Signed-off-by: Tom Rix <trix@redhat.com>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Acked-by: Tzu-En Huang <tehuang@realtek.com>

Patch applied to wireless-drivers.git, thanks.

ddcd945e556e rtw88: fix fw_fifo_addr check

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201011155438.15892-1-trix@redhat.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

