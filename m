Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263782F9E09
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390155AbhARLUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:20:46 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:63284 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389994AbhARLP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:15:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610968505; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=n/+AKCp0WfoXeqcSPUsaiGc887j6r3CbEnS8X7fCkRM=; b=e3NvLOtmqFKbsjuosRAeQ0FfPsBHPOnoJ5IHuYcWhdKKd86ge/dmBFBw8mDs4fUROtKznm/c
 ElabaS90PQYNWTlWXCdpqpT4XGxSJRRPsoGxd67WLr0b6tjzNn7T6XCIplHFFQH3byJvRNNX
 JTEaoFRnDO3qM3TE7xpKJ1Ehin4=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60056d9b7086580d329031a6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 18 Jan 2021 11:14:35
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BAB23C433ED; Mon, 18 Jan 2021 11:14:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.106] (unknown [182.18.191.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1CA46C433CA;
        Mon, 18 Jan 2021 11:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1CA46C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
Subject: Re: [PATCH v4 1/2] lib: stackdepot: Add support to configure
 STACK_HASH_SIZE
To:     Alexander Potapenko <glider@google.com>
Cc:     Minchan Kim <minchan@kernel.org>, dan.j.williams@intel.com,
        broonie@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ylal@codeaurora.org,
        vinmenon@codeaurora.org
References: <1609332331-2456-1-git-send-email-vjitta@codeaurora.org>
 <CAG_fn=V7LwUExnvVhAswj=VtEGPh9okB9ofzqnRfL2OV6qom5w@mail.gmail.com>
From:   Vijayanand Jitta <vjitta@codeaurora.org>
Message-ID: <b841a77d-742b-a810-d0bf-de67272f96fa@codeaurora.org>
Date:   Mon, 18 Jan 2021 16:44:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAG_fn=V7LwUExnvVhAswj=VtEGPh9okB9ofzqnRfL2OV6qom5w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/7/2021 3:14 PM, Alexander Potapenko wrote:
> On Wed, Dec 30, 2020 at 1:46 PM <vjitta@codeaurora.org> wrote:
>>
>> From: Yogesh Lal <ylal@codeaurora.org>
>>
>> Use STACK_HASH_ORDER_SHIFT to configure STACK_HASH_SIZE.
> I think "ORDER_SHIFT" is somewhat redundant, as "SMTH_ORDER" already
> means this is a power of two we'll be using for shifting.
> Leaving this up to you.
> 
> Alex
> 

Right, updated this to STACK_HASH_ORDER in v5.
https://lkml.org/lkml/2021/1/18/255

Thanks,
Vijay
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of Code Aurora Forum, hosted by The Linux Foundation
