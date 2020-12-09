Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842AB2D3F0F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 10:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgLIJq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 04:46:27 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:13529 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729042AbgLIJq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 04:46:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607507161; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=TT4m8+gnciHFxdRsn31IdGNUoKU41SWMx8jAAS1/Yyg=; b=XZl5tTHHfOYgXTSi4gtg1YghyhtLHVbEsQRJZPCek/T0lT+lasD57X9Zw+l/dntp//bgsp+M
 89/thAoXlmEZjC9jGFRSnggwHN3aaFpG1rhfHh6nSIMWKp3xbFZJ0g+7fXQeDnzQfr+nqxaq
 MACa36mIYhiY8oivMjNj6WRGdok=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fd09cd8fab0cd4073d5220e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 09 Dec 2020 09:46:00
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EC25DC433ED; Wed,  9 Dec 2020 09:45:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE07FC433C6;
        Wed,  9 Dec 2020 09:45:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE07FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <davem@davemloft.net>,
        <kuba@kernel.org>
Subject: Re: [PATCH wireless] iwlwifi: fw: simplify the iwl_fw_dbg_collect_trig()
References: <20201209092835.20630-1-zhengyongjun3@huawei.com>
Date:   Wed, 09 Dec 2020 11:45:54 +0200
In-Reply-To: <20201209092835.20630-1-zhengyongjun3@huawei.com> (Zheng
        Yongjun's message of "Wed, 9 Dec 2020 17:28:35 +0800")
Message-ID: <87im9bb9d9.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zheng Yongjun <zhengyongjun3@huawei.com> writes:

> Simplify the return expression.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> index ab4a8b942c81..9393fcb62076 100644
> --- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> +++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
> @@ -2558,7 +2558,7 @@ int iwl_fw_dbg_collect_trig(struct iwl_fw_runtime *fwrt,
>  			    struct iwl_fw_dbg_trigger_tlv *trigger,
>  			    const char *fmt, ...)
>  {
> -	int ret, len = 0;
> +	int len = 0;
>  	char buf[64];
>  
>  	if (iwl_trans_dbg_ini_valid(fwrt->trans))
> @@ -2580,13 +2580,8 @@ int iwl_fw_dbg_collect_trig(struct iwl_fw_runtime *fwrt,
>  		len = strlen(buf) + 1;
>  	}
>  
> -	ret = iwl_fw_dbg_collect(fwrt, le32_to_cpu(trigger->id), buf, len,
> +	return iwl_fw_dbg_collect(fwrt, le32_to_cpu(trigger->id), buf, len,
>  				 trigger);
> -
> -	if (ret)
> -		return ret;
> -
> -	return 0;
>  }
>  IWL_EXPORT_SYMBOL(iwl_fw_dbg_collect_trig);

Up to Luca of course, but I prefer the original style.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
