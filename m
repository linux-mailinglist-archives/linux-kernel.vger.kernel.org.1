Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C29629044C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 13:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406895AbgJPLrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 07:47:37 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:35392 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406879AbgJPLrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 07:47:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602848855; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=MMWbCx9d3yLwEKVcPZsuF+0hO2zdqzXyO4N7tPF4yGk=;
 b=QRvwsPhWO2sZcioFteiYYDxCMXkS5WBBk9kNtYvrucvyjkCUavJQal5cErZqwzTOczD/TgJJ
 wf0WwaEEEtvr3mq+ejrlVoCvxQNzvTUvzcW/l8nAhtsstnQL0v/szTaT+DJjf6VovXtWTlbS
 ZgIyGLsSy/z92ADnfQTYJ30xaxw=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f89883fbfed2afaa68c0aa3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Oct 2020 11:47:11
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7F6C1C433CB; Fri, 16 Oct 2020 11:47:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CCC45C433F1;
        Fri, 16 Oct 2020 11:47:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 16 Oct 2020 17:17:09 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Suzuki Poulose <suzuki.poulose@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        Stephen Boyd <swboyd@chromium.org>, denik@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] coresight: etm4x: Skip setting LPOVERRIDE bit for
 qcom,skip-power-up
In-Reply-To: <5c4f6f5d-b07d-0816-331f-7c7463fa99b3@arm.com>
References: <20201016101025.26505-1-saiprakash.ranjan@codeaurora.org>
 <5c4f6f5d-b07d-0816-331f-7c7463fa99b3@arm.com>
Message-ID: <41bbcd43c2b016b6d785c3750622e9fe@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 2020-10-16 16:51, Suzuki Poulose wrote:
> Hi Sai,
> 
> On 10/16/20 11:10 AM, Sai Prakash Ranjan wrote:
>> There is a bug on the systems supporting to skip power up
>> (qcom,skip-power-up) where setting LPOVERRIDE bit(low-power
>> state override behaviour) will result in CPU hangs/lockups
>> even on the implementations which supports it. So skip
>> setting the LPOVERRIDE bit for such platforms.
>> 
>> Fixes: 02510a5aa78d ("coresight: etm4x: Add support to skip trace unit 
>> power up")
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> The fix is fine by me. Btw, is there a hardware Erratum assigned for
> this ? It would be good to have the Erratum documented somewhere,
> preferrably ( Documentation/arm64/silicon-errata.rst )
> 

No, afaik we don't have any erratum assigned to this bug.
It was already present in downstream kernel and since we
support these targets with the previous HW bug
(qcom,skip-power-up) now in upstream, we would need this
fix in upstream kernel as well.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
