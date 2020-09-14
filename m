Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50432699FC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 01:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgINX74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 19:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgINX7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 19:59:53 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A7EC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:59:51 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w186so2485145qkd.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s+D9XMZ1jPyuXwGqHc+ajg65qFn6d40xSHUZSsGwDms=;
        b=aJfGo70Jabf9ZjvZMb10fhhLl23I8KWpDWnfOFg4Ru48CIqIpSHGvt3W64+QvAZ09L
         eMMy0/7+NuAnCHtAoOAkuZiYBiLJEPSaWezzPamfq1IxrLBS6nfWQ1lPKahi386qsQR9
         VBUS2yvrsMhEDG7Vk2ZNLpHkvHUt/RP0vtV/kbODtXEfRCA+XYK9XrelVE6FokN3Ub7W
         Hn5tL+kZsc0zC+fSmxhS1SFLFcgVOlV5uqKwlSiQTYV5lOcomoHqE0vYNoKXOqYIs71m
         o4S3UCx8B9xMS9dTwKcAosNr/GDx4rJFszDgPvAJuHEud8rxuonk5DxNTCWuAHZP3Cgo
         OYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s+D9XMZ1jPyuXwGqHc+ajg65qFn6d40xSHUZSsGwDms=;
        b=pm3RqGB+95MEZjBieaMIRMVPuiqKW9y1iLmnphZDnGzV3c1SfGbpjLMCsVZ51hJ0HE
         O/el9KzEDczmb3Ql+5GvN8SCjnCrU7j7n8OnDWxG23yamXjktPO+7zyT0Y3cxPA7XCH9
         W5cMfg9n4WMfkZK0CYbaRcFmo8o4Hl8/FQWpSsX7sJomx7G2htCYhfUJxbXTSppBuP8i
         Mp23Npzbwb+2aHoqXCtebgdl6apewMvarIwdZtH3sk/3IJbU7JTscCnNPyWWWjwIeDsJ
         YzS8+Hn74/OdqtJS+AAQicj3/7GdRh5fkkx9aq/Rq6VG7u1CN8fOusDMmfsVD8wy0n1H
         NPQA==
X-Gm-Message-State: AOAM533UVransce3Na2/P+DauOBdgIaw7GU6tjADyZATB63LgnKKQKeg
        tqA1hH6hWb3oZuAexZDYQZ6sgA==
X-Google-Smtp-Source: ABdhPJz/EKcPRQd0aezEJWSxXoe5tCiYr5gNZLNu1Xag1+dH6WurzzLTZnYoALFVujHZMCflMhPn/Q==
X-Received: by 2002:a05:620a:546:: with SMTP id o6mr15829768qko.296.1600127990550;
        Mon, 14 Sep 2020 16:59:50 -0700 (PDT)
Received: from [192.168.0.189] ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id g25sm15241941qto.47.2020.09.14.16.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 16:59:50 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] SM8150 and SM8250 dispcc drivers
To:     Stephen Boyd <sboyd@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>,
        COMMON CLK FRAMEWORK <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
References: <20200903222620.27448-1-jonathan@marek.ca>
 <fd5fbe73-e2a5-d877-743c-ad7cc6110483@linaro.org>
 <160012787871.4188128.16710718496771467444@swboyd.mtv.corp.google.com>
From:   Jonathan Marek <jonathan@marek.ca>
Message-ID: <540d95d2-ea53-f103-590e-a34d2d0cb8c5@marek.ca>
Date:   Mon, 14 Sep 2020 19:58:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <160012787871.4188128.16710718496771467444@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/20 7:57 PM, Stephen Boyd wrote:
> Quoting Dmitry Baryshkov (2020-09-07 07:25:45)
>> On 04/09/2020 01:26, Jonathan Marek wrote:
>>> Add display clock drivers required to get DSI and DP displays working on
>>> SM8150 and SM8250 SoCs.
>>>
>>> Derived from downstream drivers. Notable changes compared to downstream:
>>>    - EDP clks removed (nothing uses these even in downstream it seems)
>>>    - freq_tbl values for dp_link clk is in Hz and not kHz
>>
>>
>> On SM8250:
>> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> Can this be carried to v3?
> 

I already included the tag in the last commit which adds the SM8250 
dispcc driver (probably should've included it in the SM8250 dt-bindings 
patch too though).
