Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10742E17D0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 04:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgLWDiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 22:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgLWDiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 22:38:06 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749DBC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 19:37:26 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 11so9604976pfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 19:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LuJaSbVapuF1xE4c0AaAdxE/WvHPBsVQQdMUsaXqhfE=;
        b=FAMg0YDv6wy5gFci9qPmyQjcSul42HXIsFUkS+010t9Ycefb++aqK8Poc4Nq3Nmuc3
         kEtS52ZVO1njFByrEDowe46cV71dNua4319OnFEpoPMdE/S3qmkzIw/QF4vdM21IDTsi
         8uhWrzosTH4kW4LjEGBmHvRzuXwCGMw4FhCw+aRCaMEACSAHb96JbcLw0pQycERMxm8u
         TV8Kx9MBIH9BWJ+HlGp6tv57rUFMXpdE7vhly6YPxAzHywQSQ+Z4f5iNRc8BXPOj5YUN
         +HM+89Odz/GOQ7MHmdPRwZ0ZvT7bCIAJ32bGcpLdeCeUqgg/fea63vQPkVwB5fQpOKvo
         aicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LuJaSbVapuF1xE4c0AaAdxE/WvHPBsVQQdMUsaXqhfE=;
        b=dNNZrHeNZCIYjUzPMAiVkGzDAT9TZomQeus3l740ft8aBv2s/AflsUXdNDkxs16zha
         9EVhL8b9zJdNYfIcpuzJRg22rr0Ex4dNfg3mkdFN303d2leCA6jvFGXeo7jVh0eyHLN5
         4AbWwGemhQVyHLH4D0bnnFAYwTkUCK0a4HldnrdovXvJLAXUDb5/o+gqCGY6kNfmcojL
         2x6H6NiF2nPYavajty7N3q4BcF8NbIgjriDfxIV7JP0+slXKzHdhoZEqRSO5/Yo4MPA2
         AjmHtvpbBrRcp49gR5+M2rHtrE2wL7HlsE9UKNGsxxgZIbY2dMSvZmGssHcHx0/2gT2s
         nL6w==
X-Gm-Message-State: AOAM532GMwmh+0skgBFiix17awae0zcq2M1tyQkSoFw5J3RHVftFupJ2
        uiNB+mBygZ5TZ8RMWn+pKI+7mkZdYcg=
X-Google-Smtp-Source: ABdhPJyQCYnLmNHNbiGK55qMGv0bN1WMu0fPT7KEY6oIYRW7+FttAnEy4BUjAvA+PsC4D7K6ocqnuQ==
X-Received: by 2002:aa7:9d81:0:b029:19d:ca64:3c62 with SMTP id f1-20020aa79d810000b029019dca643c62mr364266pfq.16.1608694645437;
        Tue, 22 Dec 2020 19:37:25 -0800 (PST)
Received: from [10.230.29.166] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id z11sm20522360pjn.5.2020.12.22.19.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Dec 2020 19:37:24 -0800 (PST)
Subject: Re: [PATCH v4 2/2] firmware: arm_scmi: Augment SMC/HVC to allow
 optional interrupt
To:     Jim Quinlan <jim2101024@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     "open list:SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE Mes..." 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20201222145603.40192-1-jim2101024@gmail.com>
 <20201222145603.40192-3-jim2101024@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <e37cb2fc-14a3-b658-9df7-6f67a2c4d755@gmail.com>
Date:   Tue, 22 Dec 2020 19:37:22 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201222145603.40192-3-jim2101024@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/22/2020 6:56 AM, Jim Quinlan wrote:
> The SMC/HVC SCMI transport is modified to allow the completion of an SCMI
> message to be indicated by an interrupt rather than the return of the smc
> call.  This accommodates the existing behavior of the BrcmSTB SCMI
> "platform" whose SW is already out in the field and cannot be changed.
> 
> Signed-off-by: Jim Quinlan <jim2101024@gmail.com>

This looks good to me, just one question below:

[snip]

> @@ -111,6 +145,8 @@ static int smc_send_message(struct scmi_chan_info *cinfo,
>  	shmem_tx_prepare(scmi_info->shmem, xfer);
>  
>  	arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0, &res);
> +	if (scmi_info->irq)
> +		wait_for_completion(&scmi_info->tx_complete);

Do we need this to have a preceding call to reinit_completion()? It does
not look like this is going to make any practical difference but there
are drivers doing that for correctness.
-- 
Florian
