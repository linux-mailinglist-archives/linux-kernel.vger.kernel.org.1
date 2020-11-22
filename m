Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57ADA2BC63B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 15:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgKVOt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 09:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgKVOt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 09:49:26 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04936C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 06:49:26 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id a15so14483843edy.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 06:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LGSv+zaXag5bhul/n9vAaILaF4/C2Vq/pib9rWiVqdI=;
        b=cQ8IvQoMl4tgBQPIgz8T3aEV3/bSlcLoSFZI+ehIw/5IVA1jHdd1QAajE5BbDXZU4g
         Cpo2LDBWUub9OB/QDsIt+1HZqXYBsOm4xnspae8b4+f7wplItrWZNL6qUQRTNoRxbQKu
         LSA/gam/9dXsaTz1KXd63aMQInMU3Bejl5lOF4a76LZ0EMjhW0M4HmwwQj9F9JB9KVyc
         Q8BXrB+RxsGQPkgrL3/ARvtI9tIoei6ijCHBP0Z7aICiLmHFrUiRxjzEDKnhZ4mb56eU
         Z2QB5AO0IwXuZJad+p7AFcLWoOy2OhcTckQ3y2nxiDfkEeHrsObJKLvfOs4cfUzDNUyP
         YZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LGSv+zaXag5bhul/n9vAaILaF4/C2Vq/pib9rWiVqdI=;
        b=pIJQq01Z0metfFoFsb4h1MePMkG625R2jJOwnL6KQVP7a0ie7ScahnnhbmtkiNtxXR
         wDldSSYh/K0Won1zHCSgy4JaI7SD7jzEcsfc4WQCLudtujjObSU+2PnrpVqiilDHXhqh
         7btNYZz9Hec56aPdEto31BKMzkFwBFamsoCnwOIevwQgzoVyda/HjxbtiHjWtdfvILey
         G2Tw6xIM9N67lcI8yKzaQG+wVpTx6gXJxrQ5u85us7DN0nfltniD6z/zERwwFARFPCJB
         H+yp3lwtXyIQ21b+v0MibcR9NuJWdaUTP4VOlvmnin1WQxyWoSJ6HBn23qpi9rOxfa4L
         mGkg==
X-Gm-Message-State: AOAM533RdgbphSeOGsfrlBIrdwlcnt86NGbuHaVqEqa6NmIY5OchP6xV
        CnVQnYQFIkmfvOYdb93U3QkjOA==
X-Google-Smtp-Source: ABdhPJyNNX6HJM4vvTmYVCILFgg+3NQhUwFMDW2ZA+3bcbujvwDDydmwxveVPATBPZeBDM8qh6AFaA==
X-Received: by 2002:a50:950e:: with SMTP id u14mr42735701eda.260.1606056564785;
        Sun, 22 Nov 2020 06:49:24 -0800 (PST)
Received: from [192.168.1.9] (hst-208-222.medicom.bg. [84.238.208.222])
        by smtp.googlemail.com with ESMTPSA id aq15sm3658002ejc.70.2020.11.22.06.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2020 06:49:24 -0800 (PST)
Subject: Re: [PATCH 3/3] media: hfi_venus: Request interrupt for sync cmds
To:     Fritz Koenig <frkoenig@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>
References: <20201120001037.10032-1-stanimir.varbanov@linaro.org>
 <20201120001037.10032-4-stanimir.varbanov@linaro.org>
 <CAMfZQbwjCNjeWJYt8A4Zrq5yABB0bDnOrg41JjDP=MZF86TOjQ@mail.gmail.com>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <493867b4-4106-9167-a361-09737b06a8b7@linaro.org>
Date:   Sun, 22 Nov 2020 16:49:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMfZQbwjCNjeWJYt8A4Zrq5yABB0bDnOrg41JjDP=MZF86TOjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/21/20 3:02 AM, Fritz Koenig wrote:
> On Thu, Nov 19, 2020 at 4:12 PM Stanimir Varbanov
> <stanimir.varbanov@linaro.org> wrote:
>>
>> From: Vikash Garodia <vgarodia@codeaurora.org>
>>
>> For synchronous commands, update the message queue variable.
>> This would inform video firmware to raise interrupt on host
>> CPU whenever there is a response for such commands.
>>
>> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
>> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
>> ---
>>  drivers/media/platform/qcom/venus/hfi_venus.c | 74 ++++++++++---------
>>  1 file changed, 41 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
>> index 4be4a75ddcb6..b8fdb464ba9c 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
>> @@ -372,7 +372,7 @@ static void venus_soft_int(struct venus_hfi_device *hdev)
>>  }
>>
>>  static int venus_iface_cmdq_write_nolock(struct venus_hfi_device *hdev,
>> -                                        void *pkt)
>> +                                        void *pkt, bool sync)
>>  {
>>         struct device *dev = hdev->core->dev;
>>         struct hfi_pkt_hdr *cmd_packet;
>> @@ -397,15 +397,23 @@ static int venus_iface_cmdq_write_nolock(struct venus_hfi_device *hdev,
>>         if (rx_req)
>>                 venus_soft_int(hdev);
>>
>> +       /* Inform video firmware to raise interrupt for synchronous commands */
>> +       queue = &hdev->queues[IFACEQ_MSG_IDX];
> 
> I don't think there is any reason to scope queue outside of  the sync
> block below.

OK. I'll move into the 'if' statment.

> 
>>
>> +       if (sync) {
>> +               queue->qhdr->rx_req = 1;
>> +               /* ensure rx_req is updated in memory */
>> +               wmb();
>> +       }
>> +
>>         return 0;
>>  }
>>
<cut>

-- 
-- 
regards,
Stan
