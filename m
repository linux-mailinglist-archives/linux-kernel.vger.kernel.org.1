Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEAF2DFFFB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgLUSiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:38:01 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:62016 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgLUSiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:38:00 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608575856; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=+7IUQX8UG4nANB6kFLyJRu/+ACYHTL99hUFDp7Y8Ufw=; b=u9Rh7mx4CUFvRaRDbTtd3T8bG0wZsydYGQ+Y0ZYFioK13LHYxIvdl9yKh1ic1H9wK8knWJX+
 aH2KqDVcWI9zHS4S1/kNRAzAtDq4TTablSLI0jryGU+R5MnTRtWgs+coAhdpJX7pCwEiBqMd
 qgirmaE2gMUr+MGuxgKpkqLt4Zo=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fe0eb54120d248bb5761219 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Dec 2020 18:37:08
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3C576C43467; Mon, 21 Dec 2020 18:37:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 315D1C43461;
        Mon, 21 Dec 2020 18:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 315D1C43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] ath10k: Fixes during subsystem recovery
References: <1593197633-9014-1-git-send-email-pillair@codeaurora.org>
Date:   Mon, 21 Dec 2020 20:37:01 +0200
In-Reply-To: <1593197633-9014-1-git-send-email-pillair@codeaurora.org> (Rakesh
        Pillai's message of "Sat, 27 Jun 2020 00:23:51 +0530")
Message-ID: <87k0tbngz6.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> writes:

> This patch series includes some fixes when the device
> is in recovery mode, i.e. when the firmware goes down.
>
> - Pausing TX queues when FW goes down
> - Removed unwanted/extra error logging in pkt TX path
> - Skipping wait for FW response for delete cmds
> - Handling the -ESHUTDOWN error code in case of SSR.
>
> Rakesh Pillai (2):
>   ath10k: Pause the tx queues when firmware is down
>   ath10k: Skip wait for delete response if firmware is down

This has been tested only on WCN3990. How do I know that this doesn't
break other hardware families?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
