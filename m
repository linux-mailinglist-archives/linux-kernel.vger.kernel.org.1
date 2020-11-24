Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9027D2C2AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 16:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389461AbgKXPDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 10:03:33 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:62717 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389452AbgKXPDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:03:32 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606230212; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=dBxRLrikwfdOCdYQNdXaO+t+MKqYJDFhURsCC0X/DOQ=;
 b=iMEi25O5vv3loIk8cn0WzEf2wbG1JgGONhamj5wz4lw0km42SQJo/apaXH1BJmFkeDbA/808
 M2Okdn9eeAVHNJMl+yVhtP81h0Eibr9JyqDBpbMJc5+MA4cmqPtNh5V7ObHGY0G0qssbBJaP
 ixoUQEHLtsnyiJae0PqFY5frEko=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fbd20917ef0a8d843037edc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 24 Nov 2020 15:02:41
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9DECDC43464; Tue, 24 Nov 2020 15:02:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AD0B9C433ED;
        Tue, 24 Nov 2020 15:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AD0B9C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtlwifi: rtl8192de: remove the useless value assignment
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1605332735-9648-1-git-send-email-kaixuxia@tencent.com>
References: <1605332735-9648-1-git-send-email-kaixuxia@tencent.com>
To:     xiakaixu1987@gmail.com
Cc:     pkshih@realtek.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201124150241.9DECDC43464@smtp.codeaurora.org>
Date:   Tue, 24 Nov 2020 15:02:41 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The variable u4tmp is overwritten by the following call and the assignment
> is useless, so remove it.
> 
> Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Patch applied to wireless-drivers-next.git, thanks.

0409d504aa6c rtlwifi: rtl8192de: remove the useless value assignment

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1605332735-9648-1-git-send-email-kaixuxia@tencent.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

