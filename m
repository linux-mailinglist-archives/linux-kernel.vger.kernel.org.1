Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695912CBE24
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbgLBNZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbgLBNZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:25:09 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E373DC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 05:24:23 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id v3so1512468ilo.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 05:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dv8ZiKgBcnrmHIpIdvmlabal0p64cd22xU1Edp1tW/Q=;
        b=ScPpKJHfvj+cLFIbyJZHKhcxkLb1V/F1eF8VrmPqvgZNdU4PvfX5CHT2oAM+eYI9ou
         Tnx43RsMsmqsy/5rAg6/XY38z9Zqf1AmvZ5MI9IPvw+D1mYPuX+h9J/14N9c4FtYBKe6
         5UhoIjk/+0DWu/zVupOxZyxjVue3QTfKDohfRPwtVfmX8J9Bl2EQ0tBLvvN9+EPPQ/OC
         IHKi3sw5Jn1KUXW0gF7wR5Bcbn8/7v9iVzrRAgGdLovSyP88Tp2+AcGJDa/XFRS0B4jH
         o0s5eUyKjYW1fDjvm07vl+sfIopVjAZs+1fVmrrhYatfhInYC0mkfr7F6zjwwJo5uV/S
         wLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dv8ZiKgBcnrmHIpIdvmlabal0p64cd22xU1Edp1tW/Q=;
        b=mdGCTTU4/Fu98wzcEwQ2i7HOGV6a5NuIRZY7YHcIWLyGtOah7d55NPJyWckFAGCQ3b
         0EYNz7JhZrWKPQ7BUPPCtW+5mZS/C4rsfjV6IVRPU0niTLHwUtoFxnj4FW4PBbA0r827
         gECPudHZzuwirsLYYHIoJ/99xLsS7+qOG1vOlRZUIuK/X5E5jpdVySc00qCxyp6xS1DQ
         XFIZiEH6RPTDQTKsj/L8gvfmWll76UzxkiVqww584ByuBH8TaKquYYa+MnUmn7bhTHoN
         OTQoeMW7bql+THC/KPuRAlUpAmfx7vW8DW/MI6y3t40bbCmDhkTBmttEFqCvfpGWEXfr
         sbMw==
X-Gm-Message-State: AOAM531a1VM24Meg2u0UdmTMsnIn4u3Yf4jp5rTl/Y8HIAOkofQF5MCw
        gyzrrjGN54RLYSXmaEzv2WnaEmAxMyFkVQ==
X-Google-Smtp-Source: ABdhPJyA9HGXtcZqRuPGy5PU3kC1yKYFQgCr0Ya1Q48vab3miN+IIwUyIhQD8EqqZjwczpMEjL10Lw==
X-Received: by 2002:a92:a154:: with SMTP id v81mr2398764ili.85.1606915462869;
        Wed, 02 Dec 2020 05:24:22 -0800 (PST)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id u11sm913650iol.51.2020.12.02.05.24.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 05:24:22 -0800 (PST)
Subject: Re: [PATCH net-next 2/2] net: ipa: add support for inline checksum
 offload
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, evgreen@chromium.org, cpratapa@codeaurora.org,
        bjorn.andersson@linaro.org, subashab@codeaurora.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201201004143.27569-1-elder@linaro.org>
 <20201201004143.27569-3-elder@linaro.org>
 <20201201181319.41091a37@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
From:   Alex Elder <elder@linaro.org>
Message-ID: <cea6a211-dea3-2eae-4f82-eb07c70115a4@linaro.org>
Date:   Wed, 2 Dec 2020 07:24:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201181319.41091a37@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/20 8:13 PM, Jakub Kicinski wrote:
>> To function, the rmnet driver must also add support for this new
>> "inline" checksum offload.  The changes implementing this will be
>> submitted soon.
> We don't usually merge half of a feature. Why not wait until all
> support is in place?
> 
> Do I understand right that it's rmnet that will push the csum header?
> This change seems to only reserve space for it and request the feature
> at init..

You are correct.  The IPA hardware needs to be programmed to
perform the computation and verify that the checksum in the
header matches what it computes (for AP RX offload), or
insert it into the header (for AP TX offload).  That's what
this patch handles.

The RMNet driver is responsible for stripping the offload
header off on RX, and acting on what it says (i.e., whether
hardware is able to state the checksum is good).  And on TX
it inserts an offload header that says what to checksum and
where to put it in the packet.

It's totally fine not to merge this until we have the whole
package ready, I understand.  I'll see what I can do to get
that done quickly.

Thanks Jakub.

					-Alex
