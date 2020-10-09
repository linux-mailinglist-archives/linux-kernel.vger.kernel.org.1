Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECF6288F8A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 19:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390012AbgJIRDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 13:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389892AbgJIRDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 13:03:30 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA45C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 10:03:30 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d23so4744663pll.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/5wUWQqgMKt7EGmPaNqqLH40EmDYIrJnvSXrx5dUlfw=;
        b=DCep2uQD5hojSI+iubeC4ePB1JKrfcPeMCDgdyK1NcM+Lu1tOEpMv/owXhhHzOyk/b
         eEn0mvP5cuStSnehisWFtPm25Wt28Otk25unezJKareUfkyDhkkChIAxtPMsgh/v5eoT
         IWOAhxdClc21cwJejzXAUnhxUAvcRv8FVLT8vscGqIeXuRQMdepUg2/CIP0KTs2rRj/x
         ykKvQT05no5w53AuHLR8M/KiKROLbFkyQaG9xjxD7Ae2WIInZi1vcptAjXHJFmqbjlUE
         6lPpf5OAKLEdilHeWZ8cT5QuOOCRgl/trSimnYJOc5Y+T2nIct4IiASUn88FEWtqNK7U
         UnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/5wUWQqgMKt7EGmPaNqqLH40EmDYIrJnvSXrx5dUlfw=;
        b=Vc4gSOOfYlbZliuj3b/sZMrjv1SWkJmSdQR4ir9Fbqd/PDO3Ly16TWjQ3y7qtOK08G
         C7FeZf0wmfJuRLAwBHvwP8jWkKyvC7kOslyBlcFFM3bElNL6MwzmJ/aQz6nIICRkB+XM
         QvwVLsa2ZX16ZRBPTB6omh17zTZrvPMcoQ1U0YLCTjuEUmWkLgkNfxbZEpc1FUOzqld4
         LSx7JlqkHbM/02GFUGrox2EJwct0KkSu3y4sLbyp1fqkLYPgVvKA6GAXVOI1MtfDyjHo
         1n32fpuol0a2dt60oDhX6Gt5/d2Gk+u2X22foGDAsgCo9pT6l1+g25gokViC45gdKvF5
         iFvg==
X-Gm-Message-State: AOAM533gtYKL1qOQV1kFgg+NZf3+8+4Hu7vnpZj+TnJfjOsmvyn20VBm
        aI0UMqw9tlpGld/UgtXqwqg=
X-Google-Smtp-Source: ABdhPJx3JUTkvfsPcw7gs1d2kYtotEv4gnjk+LmY9OMqeL/Ogeywcwyswcg09r+xu5odjV+nopaxWA==
X-Received: by 2002:a17:902:aa44:b029:d3:8b4f:5083 with SMTP id c4-20020a170902aa44b02900d38b4f5083mr12653891plr.78.1602263010127;
        Fri, 09 Oct 2020 10:03:30 -0700 (PDT)
Received: from [10.230.29.112] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b4sm3932644pjz.51.2020.10.09.10.03.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 10:03:29 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] mailbox: Add Broadcom STB mailbox driver
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Jim Quinlan <james.quinlan@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200919192235.43872-1-james.quinlan@broadcom.com>
 <20200919192235.43872-3-james.quinlan@broadcom.com>
 <20201009163848.5tbl5bmvuoj2de2v@bogus>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <b4f88367-ff8b-08cb-16b3-7432aa6b3117@gmail.com>
Date:   Fri, 9 Oct 2020 10:03:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201009163848.5tbl5bmvuoj2de2v@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/9/2020 9:38 AM, Sudeep Holla wrote:
> On Sat, Sep 19, 2020 at 03:22:30PM -0400, Jim Quinlan wrote:
>> only implements the agent-to-platform channel;
> 
> In that case any reason why you can't reuse the existing smc transport
> for SCMI. It was added recently in case you haven't checked the latest
> kernel version(v5.8 or above). Check out for drivers/firmware/arm_scmi/smc.c
> IIUC rather vaguely Florian was cc-ed on those patches.

Our firmware completes all commands by posting an interrupt and we 
already have platforms in the field with this mailbox driver. I was 
hoping we could make use of the SMC transport, but the current firmware 
implementation completes commands by raising an interrupt. The reason 
why we did that was that we could support synchronous and asynchronous 
calls the same way.

> 
>> we may implement the platform-to-agent channel in the future.
> 
> This is not yet support with that transport, it is hard to generalise
> as different vendors have their own solutions there.
> 
>> An unusual aspect of this driver is how the completion of an SCMI message
>> is indicated.  An SCMI message is initiated with an ARM SMC call, but the
>> return of this call does not indicate the execution or completion of the
>> message.  Rather, the message's completion is signaled by an interrupt.
>>
> 
> So are these not fast SMC/HVC calls then ? If so we may need some changes
> to that driver. I just rejected multiple message support as we had assumed
> fast smc/hvc.
> 

-- 
Florian
