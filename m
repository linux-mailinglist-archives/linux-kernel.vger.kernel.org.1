Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12EA2B3DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgKPHxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:53:41 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:33710 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgKPHxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:53:41 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605513220; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=A6Y/pPvQHSECx1kY1OndhW71vtjhtOREXblvdLFxNwE=; b=aTQnn7eu+FROhzaARIxGmgFAmc8CX6EMOnT5MF3JsH4EKkSeZ7p/EoSzJtcRXKTdt+m1vUCH
 nelIznchpJW2MWqDG03Z9wdtTFVeBS9o7qJZ137Au5vI5aEi1RFewNVSNi+xDpf///6XpB2D
 pEhdxh9q+rnxkx55nL/ncur4kR8=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fb22ffe57dd92cbec0729fd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 16 Nov 2020 07:53:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A7C66C43462; Mon, 16 Nov 2020 07:53:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C45DC433ED;
        Mon, 16 Nov 2020 07:53:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C45DC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Wen Gong <wgong@codeaurora.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: drivers/net/wireless/ath/ath10k/sdio.c:2234:2: warning: Non-boolean value returned from function returning bool
References: <20201116055212.GA3723@shao2-debian>
Date:   Mon, 16 Nov 2020 09:53:29 +0200
In-Reply-To: <20201116055212.GA3723@shao2-debian> (kernel test robot's message
        of "Mon, 16 Nov 2020 13:53:19 +0800")
Message-ID: <87o8jx20w6.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ ath10k list

kernel test robot <rong.a.chen@intel.com> writes:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f01c30de86f1047e9bae1b1b1417b0ce8dcd15b1
> commit: 3c45f21af84eb05a355919abc80cf70a3a681cee ath10k: sdio: add
> firmware coredump support
> compiler: nios2-linux-gcc (GCC) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <rong.a.chen@intel.com>
>
>
> cppcheck possible warnings: (new ones prefixed by >>, may not real problems)
>
>>> drivers/net/wireless/ath/ath10k/sdio.c:2234:2: warning: Non-boolean
> value returned from function returning bool
> [returnNonBoolInBooleanFunction]
>     return param & HI_OPTION_SDIO_CRASH_DUMP_ENHANCEMENT_FW;
>     ^

Is this really a problem? I guess we could change that to "!!(param &
HI_OPTION_SDIO_CRASH_DUMP_ENHANCEMENT_FW)" but how is that better and
does it make any practical difference when
ath10k_sdio_is_fast_dump_supported() returns a boolean anyway?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
