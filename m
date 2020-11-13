Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE402B17C3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 10:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgKMJEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 04:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMJEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 04:04:33 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EBFC0613D1;
        Fri, 13 Nov 2020 01:04:32 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id j205so12736647lfj.6;
        Fri, 13 Nov 2020 01:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2GxhUCefEOa/B6zdFZukUMX5vwuWHoZ4mk0/X54rIZY=;
        b=HVGTSAeTWJudmGTp17fSJDYNbrg4dxXFjx/IOQ0uLp2ZICcL7iw/PI0jlxfHikdZGx
         hkrzdczrlfX7xE0zX9zAF7tVum74KM/67YMwYH4gdN5Cpeuzb+cb/gJMh+Z72oGDIsrM
         m+shjk9V6bg2eL6CNGxqBvpyrj8ziTyW808V1Go5Lv7q2/CmwzMefSfA9dLu3Lc81+Uj
         OyuRPRw+zTr5o5zk9lpoOPoWq/YYuH9QUy2ol73gwFURc6D4BTeRVp00mm6gq7LAzpJa
         j8/XBsEVf+spxn+oMLy4toLJLqHSs4rqAbzARmxRejHFy3tzx1VHyq5kFTFTftg5BuPf
         Z4Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2GxhUCefEOa/B6zdFZukUMX5vwuWHoZ4mk0/X54rIZY=;
        b=X3Zfxt+8DQ2vzf31B8/Ak/2sTZ/m+978WUrL9VwJKiH4MvYPYhQrU0vAgwt7p/cRVh
         2oOXQ46LGS+pKt9r5N2+DnUB0MJrYkEeP6jSpvT6q8y6nbufBOKLirRYGiYM3l05pm/5
         vDK31yCz02bqL9F8qiYmSZcWdMv+oX2J/F5NzWx+xRp2T81MobxRCfsioKYPa+yeNZZ3
         QL1EOLKhnDRgoZbT8teqsRM6e676WIVTQp4pGhhTqiZ7Fi6wusrWmlstRqkuq9Zg0Y5+
         0zZBEbvxJJLZ3s46NvJJ8KJDr17ri+uNoKzif6FZu8DQalUS06/BB5C6FxwkgeyOu2d1
         x3uA==
X-Gm-Message-State: AOAM530a5+CdEKXy9Rqf1R7NkuAihyUsEsddJTuIrGI4uQ3jHA+VtPOt
        CsyYOPorVgodF0iyrlaq8MT7SkF2+wA=
X-Google-Smtp-Source: ABdhPJynCMzZYISl7vpAXlcm6rIcnGx2Q0JYl/1WSXHcUtg6esCLaQzR/10qulOq3rbyHw7eARJGVg==
X-Received: by 2002:a19:6619:: with SMTP id a25mr450970lfc.186.1605258271117;
        Fri, 13 Nov 2020 01:04:31 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.googlemail.com with ESMTPSA id p9sm1473413lfa.129.2020.11.13.01.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 01:04:30 -0800 (PST)
Subject: Re: [PATCH v1] clk: Add enable-state column to clk summary
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201104165631.22295-1-digetx@gmail.com>
 <160525551074.60232.7613044083282105115@swboyd.mtv.corp.google.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <519526ca-fd50-f8c5-6ea9-dba6d356f0e9@gmail.com>
Date:   Fri, 13 Nov 2020 12:04:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <160525551074.60232.7613044083282105115@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

13.11.2020 11:18, Stephen Boyd пишет:
> Quoting Dmitry Osipenko (2020-11-04 08:56:31)
>> Add "enable state" column to the clk summary. It's handy to know actual
>> hardware state of all clocks for debugging purposes. In conjunction with
>> clk_ignore_unused, this tells us what unused clocks are left on after
>> bootloader without disabling the clocks.
> 
> Should it be called "boot state" then? That idea sounds OK to me.
> 
>> It's also s useful debugging
> 
> Stray 's' here.
> 
>> information for cases where firmware touches clocks.
> 
> Care to explain more? Presumably you mean when firmware is modifying clk
> state without notifying the kernel?

This is exactly what I meant.

> In which case it should be called
> "hardware enable" or something like that and be a "Y/N/?" value
> depending on if the value can be read or not and if it is enabled or not?

Indeed, I like the "hardware enable", thank you for the suggestion. The
"Y/N/?" suggestion is also good.

I'll prepare v2, thank you for the review!
