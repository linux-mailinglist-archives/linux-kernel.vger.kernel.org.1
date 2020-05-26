Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C339F1C4F40
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 09:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgEEHhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 03:37:00 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:15974 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726575AbgEEHhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 03:37:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588664219; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=kIFbus3pdBIDI9q5dNQbOWwVqxDFyCbLIbVYGC3IkTQ=;
 b=vagCgOeykJ42vpaE0uNOq/51602FAR4zeAcoOphrv+nj3GKqBE6e+hU7D1YUWM5tZWisznP+
 kuHrGXCJixBQp/uO3X2a/CzvagqhWy17DU7YPhZ+VuoU+pwXyAwO4O7TMOnzegG5VHRzxhPj
 GQnMi004QNWU0+SWVKddGdE7MdA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb11796.7fc83b4433b0-smtp-out-n03;
 Tue, 05 May 2020 07:36:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A2428C44788; Tue,  5 May 2020 07:36:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 01650C433D2;
        Tue,  5 May 2020 07:36:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 May 2020 13:06:52 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nishanth Menon <nm@ti.com>, Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>, lukasz.luba@arm.com,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH v4 07/12] OPP: Add and export helper to get icc path count
In-Reply-To: <CAGETcx9=kfuG9WtaSxsDe_SM1Gewbn889eQ--3ui3H_rzm3BRA@mail.gmail.com>
References: <20200504202243.5476-1-sibis@codeaurora.org>
 <20200504202243.5476-8-sibis@codeaurora.org>
 <CAGETcx9=kfuG9WtaSxsDe_SM1Gewbn889eQ--3ui3H_rzm3BRA@mail.gmail.com>
Message-ID: <9c5786c552bf7f0092cecbbdabd7761b@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-05 03:33, Saravana Kannan wrote:
> On Mon, May 4, 2020 at 1:24 PM Sibi Sankar <sibis@codeaurora.org> 
> wrote:
>> 
>> Add and export 'dev_pm_opp_get_path_count' to get the icc path count
>> associated with the device.
> 
> This is not related to OPP. You should add this helper function to ICC
> framework?

yes it should be, I'll work with
Georgi so that it gets re-used in
his series as well.


> 
> -Saravana

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
