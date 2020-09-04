Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C226825CFF2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 05:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgIDDuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 23:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbgIDDuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:50:11 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81327C061244;
        Thu,  3 Sep 2020 20:50:11 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id k13so503619plk.13;
        Thu, 03 Sep 2020 20:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QYGHSoSafVtyuMdTLqi7XHoNGOUoxbP6OoKTyB4RHfY=;
        b=SdpBnRg/CbI/ZFFB9meyVHXSbhZHH2jgT4bZCpk3/zSCWVyfQ+lGF2oUsAvbNK11xH
         sMaKDPnHcqiUn/aSrzOL0Dx6CYrIQHLxPa7ed1AkuiymCJbBdpBO5FgcH+fW2lbqac1J
         KlPq4HgLwFgutEZrRr0IzHpi1/gODSXxQDedOqpYKyVBcP9lpcT9ZZwBbqX+zxyu3NHV
         9E6oyLZ9eX1ub9lzVVic34QdPDB+FvtR3yn8wNtYbqVA1k9O7xei+Q7SnebI9Kxd/PUE
         b28k7lFGmCCYczdwAwxdP3hGty5UHphW5jvLeooPFARGbhTfKVODDeK8rR4PAyi3y5WC
         zrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QYGHSoSafVtyuMdTLqi7XHoNGOUoxbP6OoKTyB4RHfY=;
        b=jszMXE8D7QJFSgnbA11YPbGbONEgcrBcH1ktFdIdAvw6WALSTx/mAumjyOO2qF9D4u
         DyYAtxMDZRVcpgqIWIltbRi60/u0/EYz9c2jymataRVNnTWYVgpiXmtVYg7JTwrErJN8
         4yuhMN9XwdbfVSeUooDb7r7wTSW5htBZVlkZGdXqsNDd2Xt3eNrfdpemAkghRBduIwyJ
         3Mjfqfd66laOegaBzaflkDbydKigxKTPXMTQeRCc6HwVftdY0LOz2p1Ay0wzTXNfU7F4
         F7ePSs7vtV7UYdY8bK7I7waGQayrixOQvwJ2EX8VSPpWKCx0qVunpkXvug3ALjDYdNOE
         iqVw==
X-Gm-Message-State: AOAM532+OuY1wCqoX/0wlbr+Rx0wJPyosZXoSQZyF5iDDpgOnbiEQKLj
        6zX50RSMG+pyoMBFA7puKmw=
X-Google-Smtp-Source: ABdhPJyEu2t2cm7/oGcJv7wfAIGt3TQlttUJP59Lrch6Eiy2YYYXi/9kLmjyn26wli93WxE5scYHwQ==
X-Received: by 2002:a17:902:c408:: with SMTP id k8mr6889197plk.102.1599191411088;
        Thu, 03 Sep 2020 20:50:11 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d77sm4831886pfd.121.2020.09.03.20.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 20:50:10 -0700 (PDT)
Subject: Re: [PATCH v2 05/11] usb: gadget: bdc: fix check warning of block
 comments alignment
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Peter Chen <peter.chen@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
 <1597923046-12535-5-git-send-email-chunfeng.yun@mediatek.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <92ab47ff-4aef-1bca-e21a-0f6bab3210cf@gmail.com>
Date:   Thu, 3 Sep 2020 20:50:07 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <1597923046-12535-5-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/2020 4:30 AM, Chunfeng Yun wrote:
> fix the warning:
>    WARNING:BLOCK_COMMENT_STYLE:
>    Block comments should align the * on each line
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
