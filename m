Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9A92F556B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 01:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbhANADU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 19:03:20 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:18823 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729599AbhAMXxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 18:53:25 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610581986; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=jhMQN08IbsbcKCk475v0+9qsmF+cIHbqf+wt7iI9mSY=;
 b=c+bCWQeRp+AoNJmRdA2LH2ecYRVBvK2ZidQQA49tKjw6yHemBMJy7KfBRQ8OhxsRTyzQJU90
 kq00AoeHGxvzNByriFnn/6UkJyNDmOAgv03qoxsFUglMZAKIrJYydxZJBcO6aJKiFrReQmiv
 QCxAuzlhMyyDscRSHjCVUCyQt3U=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fff87c7c88af06107673a07 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 13 Jan 2021 23:52:39
 GMT
Sender: khsieh=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7092EC43461; Wed, 13 Jan 2021 23:52:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: khsieh)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0BD4FC433ED;
        Wed, 13 Jan 2021 23:52:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 13 Jan 2021 15:52:37 -0800
From:   khsieh@codeaurora.org
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, tanmay@codeaurora.org, abhinavk@codeaurora.org,
        aravindh@codeaurora.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2]  fix missing unplug interrupt problem
In-Reply-To: <161056955435.3661239.1548841852585636847@swboyd.mtv.corp.google.com>
References: <1610564400-29788-1-git-send-email-khsieh@codeaurora.org>
 <161056955435.3661239.1548841852585636847@swboyd.mtv.corp.google.com>
Message-ID: <5b1c9e0706fdaf4cc1ecbe740b8c916c@codeaurora.org>
X-Sender: khsieh@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-13 12:25, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2021-01-13 10:59:58)
>> Both AUX_SW_RESET and DP_SW_RESET clear pending HPD interrupts.
>> Therefore irq_hpd handler should not issues either aux or sw reset
>> to avoid following unplug interrupt be cleared accidentally.
>> 
>> Kuogee Hsieh (2):
>>   drm/msm/dp: return fail when both link lane and rate are 0 at dpcd
>>     read
>>   drm/msm/dp: unplug interrupt missed after irq_hpd handler
> 
> It won't apply to the drm msm tree. Please rebase and resend.
Both V1 two patches are picked by Rob already.
I will drop V2 patches.
