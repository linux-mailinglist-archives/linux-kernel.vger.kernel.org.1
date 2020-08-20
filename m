Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3111C24B756
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 12:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731450AbgHTKvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 06:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730228AbgHTKOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:14:44 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7572BC061757;
        Thu, 20 Aug 2020 03:14:44 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c8so638773lfh.9;
        Thu, 20 Aug 2020 03:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vIqpTmovFa8dVc4Ln43GhodOHY6DYWmxTNMxOIaUSmk=;
        b=mQKGf1p7s26/YEZUJCDJw1Tu7tKxQjJkJbGshc8hEqWQ0aPATF1nLsD1c05MqNppYj
         F7jcqy60M6TktK4f2Wp3LLFT1sdbnUNe/NNDlql4uUI1NzKxREGwwFn14IbP8avMucma
         r9jei4zpVrMjL61VyCyH6hwunwyHB68u3Ls8drUYwxNlUC1ZYwt0nNupTO+1jIVjCjVe
         BD9MynVK7jENWyxu3sjHrYYu1efw/Zbd4cm+0zg7DEX2+v4oU33KwNy5HSJcfoWUuTsw
         wp5JP6ddhwrgggtUAiArIdP2nV6uH9hU/1rYqQh881fcMBGyenh6aClx2abnWiMyMlR6
         LVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=vIqpTmovFa8dVc4Ln43GhodOHY6DYWmxTNMxOIaUSmk=;
        b=MTv5nZiKouMVjE74zMUuUt6SYrm0fVUzDL7LpM27k1jRbRgmyDrKyGDe78eddRC0FB
         oJ7mVztlF6UvVuH8BVWv1T2Wk8dJhc8YCeDQpIMenq1/T3vL/TBZxAt4etHiNJxb23zI
         wzUaOBNRxpVzcBa8MxKEKjLwH3axF1nZc2ToXrFLpMn+dUWoXd0jI7fWg8E1WVuHlp5k
         p1pWetVb9mjnpzbdub2Bazds8AYAxsA7ZnJXGCwP+jYyClU32LGMMf59sV31iePF0cum
         XwVchtXVG+kEEG7TdaAwKRuYpzmeWa+UlodXAZY/UGQXydZ94S72UbIp8ztTSp4R7sVh
         I8RA==
X-Gm-Message-State: AOAM531yKnyWO/VY44HgOC3mdViwwHPq2cbReq4TgVvhda1/u38+6xkt
        8/1/0pa1pEsr2/FMsGJR2OE=
X-Google-Smtp-Source: ABdhPJwkqxUCR2HlVxBFdk4S2ON7cs2z7amFEy/eH3RHaxNifp9RAtkK3fIzcr28JtSp2B8dyQlCSw==
X-Received: by 2002:a19:c894:: with SMTP id y142mr1226308lff.74.1597918482964;
        Thu, 20 Aug 2020 03:14:42 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:42ab:a165:4cb2:5f04:a1e8:63b? ([2a00:1fa0:42ab:a165:4cb2:5f04:a1e8:63b])
        by smtp.gmail.com with ESMTPSA id a12sm400511lfi.83.2020.08.20.03.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 03:14:42 -0700 (PDT)
Subject: Re: [PATCH v2 11/11] iopoll: update kerneldoc of
 read_poll_timeout_atomic()
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>
References: <1597902349-8998-1-git-send-email-chunfeng.yun@mediatek.com>
 <1597902349-8998-11-git-send-email-chunfeng.yun@mediatek.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <49de5eaf-9870-522c-b1f2-037ecb122237@gmail.com>
Date:   Thu, 20 Aug 2020 13:14:32 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1597902349-8998-11-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 20.08.2020 8:45, Chunfeng Yun wrote:

> Arguments description of read_poll_timeout_atomic() if out of date,

    s/if/is/?

> update it.
> 
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
[...]

MBR, Sergei
