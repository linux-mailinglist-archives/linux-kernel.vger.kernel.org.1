Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3540F2B023F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgKLJtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKLJtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:49:13 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D337C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:49:13 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id l1so5271169wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a5+NFcDyPVwL4iDr+PAgUKJYb6rVA8T1U3x0Y4iCU9k=;
        b=nCaiXL2psPM+FnJMd+r6pB5nz7nVij0ktda8iIthyPuh27My6jq6bK55KBD2IBAUCx
         EECNaxhegOFYeP/1/TQKaQewftt81BMj9zxZ5fMbaXIZp+CWIVtaSZH2G6r57mDIb7et
         S8a65SAEMNUJaPQDq3G+SHeTKxqZYHFUDdjGrb4Un20AyRLdptmWJKKGBSKT0eRWRoBh
         S2hTsKp9jIgfgZhQaEQy04LTP08EqYfKvWqo2p1l4Y10eFPodBD3H2OkwMTj3isJ4ueM
         031jkS6AHE+N5dSbuxk1iPwKm4qG6+KjqCoFVw5dSLQqPRxv9GQy5q8yqiQLw/SU0g/i
         Vw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a5+NFcDyPVwL4iDr+PAgUKJYb6rVA8T1U3x0Y4iCU9k=;
        b=mdutAWW9m0ujibRbJw045xClSh/xitlFJa2CFsZ57JZddOwtzi7xd/VZaq77SRWzxj
         9feDdXecOWxi4hu1ui7GG0e5hx1NVYAtOXAWZXvRqi0Nf5MWmvlTi5kjHDJ388hYvaBb
         caK8LpYyqTO6AgMhtqB9P7pmutcz8MUfHvCRx+Gs9zfPOmMCbjBh1yml27sFq8/uxeMU
         gZKp6M80v9L3gJCq576xP9pB4qI+VGNswH9StBAfP/FmbDSbQ4TStb3BOxmGL0OHbK5t
         eRj9EUykPqDBXuRr0u+U41hITeD9rt0xkkVWM1l6TkYa9F0gyK6nMDbSFw8OBiGL8hVI
         WwwQ==
X-Gm-Message-State: AOAM531szuzL+z/kcg8LwSlBK/Wx6erzEBgfPq/IrDDiOzoVFVNG/QqV
        Lk7KgWpMW9yLfY8YRVpIV2AIQg==
X-Google-Smtp-Source: ABdhPJz1apoQxEsILClSk8e3lpSerncqkwJEG4iNylA+2jXkWdzyi/suvY3r8p2Ego5yOLNm/c8JPg==
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr18323110wrm.259.1605174551837;
        Thu, 12 Nov 2020 01:49:11 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:6971:b700:3764:fa96? ([2a01:e34:ed2f:f020:6971:b700:3764:fa96])
        by smtp.googlemail.com with ESMTPSA id r8sm6125262wrq.14.2020.11.12.01.49.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2020 01:49:11 -0800 (PST)
Subject: Re: [PATCH 1/3] drivers/clocksource: Remove EZChip NPS clocksource
 driver
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-snps-arc@lists.infradead.org
References: <20201105212210.1891598-1-vgupta@synopsys.com>
 <20201105212210.1891598-2-vgupta@synopsys.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7647e159-411c-92ea-6a1a-6f3b9fa8ec8d@linaro.org>
Date:   Thu, 12 Nov 2020 10:49:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201105212210.1891598-2-vgupta@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2020 22:22, Vineet Gupta wrote:
> NPS platform has been removed from ARC port and there are no in-tree
> users of it now. So RIP !
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> ---

Applied, thanks!


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
