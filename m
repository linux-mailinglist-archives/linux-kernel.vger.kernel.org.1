Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253C12C2349
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732228AbgKXKwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732047AbgKXKwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:52:06 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4981C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:52:06 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l1so21798906wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QQio1s0DCG/7feDbhPWYAjV7QRB02xC2LTb4uvAbajI=;
        b=btOHx204IHjtMuAN1QTcOtlbSP2dKgIUkmjptjHW7P0wtM7GPRL/BegU0VdM3FdJtz
         TLuwUyAXLTOcPci65/SWhhJPcCOF67Us/9AMX0Vzc9VXbkfOP5/egbLAzzWaJcK50NsV
         m8cS94WsciprnRnibLnKE5X24+mASeWEsg4ropPpTWOBaiKmQIT+SJbBAcvs9cal/8RK
         NLltqudXPZf01mU9wnzl/biTR9HJjDwaVSSwGEc3UPgqgZtg23ZMiiF/nPpZzdfcKUF3
         FawUZL79y3jPNEUSW9xxFRJPapqh7vIc2elsEMO+MnPo3DC3tj+CfS7P8dKlbnP4o2JP
         DQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QQio1s0DCG/7feDbhPWYAjV7QRB02xC2LTb4uvAbajI=;
        b=n26vs00U9Uq1GSuS8woaRqXaJyO99SPhT5YcFiGLH3ke3GsJgAww37rX0HtzfzdyCJ
         n2D0Hos25TuuAJUlGVze0IPOXbLJvGGoJz9k4hecL5G0JEupx9IS2gaY6ZYRN+D2W3N4
         QVVghX52pqDUr9OwV5iDo+I70RlGTHmJW+vkkHIoJ/nRlWv9gUiwC4k8mdLJ1AiiXgJU
         9czAqaEmPJTXHxe9RQ++6lD3WjSm53+zh4cAMe1lav2d2IKfeeyFf02oUCxfQcPSJgZj
         KGL6WXbGyqKhYE/DGJZ5YWuyEvZsKyPycZVjkvqXXaYTXLgK76EWxyh9EHoAFQiS+WVu
         hJww==
X-Gm-Message-State: AOAM530pbjmNz9xYzxmBNX4O+f8B0BbACOAPnvieXADzJ2/TjPSL93h5
        WmgrmgqYb+M3iu9EGi/rI9GJc03K52wnyjKx
X-Google-Smtp-Source: ABdhPJxAXndNlS+VEafezs0trbCLabjTslqf2k88bRoCHGlR54xMnQFdZYlAEgzf5jdXSd8ZclTBwQ==
X-Received: by 2002:adf:e6cf:: with SMTP id y15mr4645433wrm.403.1606215125160;
        Tue, 24 Nov 2020 02:52:05 -0800 (PST)
Received: from [192.168.86.34] (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.googlemail.com with ESMTPSA id u81sm5019026wmb.27.2020.11.24.02.52.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 02:52:04 -0800 (PST)
Subject: Re: [PATCH] nvmem: imx-ocotp: add support for the unaliged word count
To:     peng.fan@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1603352683-23918-1-git-send-email-peng.fan@nxp.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <628bb6a8-9d09-46a0-70cd-89a51f0f8108@linaro.org>
Date:   Tue, 24 Nov 2020 10:52:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1603352683-23918-1-git-send-email-peng.fan@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/10/2020 08:44, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> When offset is not 4 bytes aligned, directly shift righty by 2 bits
> will cause reading out wrong data. Since imx ocotp only supports
> 4 bytes reading once, we need handle offset is not 4 bytes aligned
> and enlarge the bytes to 4 bytes aligned. After reading finished,
> copy the needed data from buffer to caller and free buffer.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied thanks,

srini
