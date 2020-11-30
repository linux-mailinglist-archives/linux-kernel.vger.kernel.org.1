Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A4B2C8C42
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729285AbgK3SK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbgK3SKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:10:55 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD28C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:10:15 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id b10so9522621pfo.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JfjXD662manSUYpiP1JHUSzxo/pxTsLkc9sAPIYNsuI=;
        b=X79HjfLzljA+0Z27ZuzPIdUYlvtzP24/jRs07S1yBlgCMuvo49QylUAckwZg1pPtIj
         bY2LIMf6iYBYSllo2QqRE/KKFwuSB+JiJh1SnpMk7sWk2ztcpxvwcuf+OUjUW/ZoNEjt
         0TzmvLsz4TD0325LPk9LQNHKfcgbPoewgdSgeVQtSFoWckP6AO1FPT/ZDGpXekg6muAN
         galyM2iZi8IniMmKe0L8FEm3hG/e2y7c4qNLyWboSA6vnBpWRUbV0Rb/jsNML8l4ORrp
         jCI/Mz/nTieD0slwqHCSyWVrYl1GORYnZByamdTE1VHf2jmnCqsTVXHFPjwfAMP2u/tr
         W3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JfjXD662manSUYpiP1JHUSzxo/pxTsLkc9sAPIYNsuI=;
        b=j40c+tJORe7DH20x3himqvRKLTfrPfrE30nH1AuOcM43s4Asx6Jr4k2opBHad5LufB
         j59h716K/3ya+L6soQES1kby9feNwzp0xDvkDu3/GZT8kW9Uujs9sVOUVAduWeCALcZl
         F9+ew3PuXwulul2xeLAQQ0HHfN1UD9brPHn7qn/8nDAlqmMDEbboXC/+dCSN/xvZBrfj
         o1oRYJgKLMJF9shaw1fH1ZWGzg3OjHEbOI8sAg5GfkyiPviwKieaRJdpfhjsepWZZCxE
         9u4SW4v/tPLPi2azI489d9fWEiqyFuhBLIK21qzeXRMK0fIQaGFvK5cv/+8GGJ2qziZ1
         N8wQ==
X-Gm-Message-State: AOAM531TABdEkSW1kPU4PunsRFi3Yj4n+If6+8wD8o7WOw2Q9am8GGZv
        OOGuhlN6MSux0WWEcTJxuVkcOw==
X-Google-Smtp-Source: ABdhPJxh3Uowu7JH4UdkTNftlk54k603Bv/jaftSe1FU3Lsss96e05qjowDMM/Ug6HmqnFOsblmqKA==
X-Received: by 2002:a62:2ac2:0:b029:18c:25ff:d68 with SMTP id q185-20020a622ac20000b029018c25ff0d68mr20455201pfq.64.1606759815084;
        Mon, 30 Nov 2020 10:10:15 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 184sm17681065pfc.28.2020.11.30.10.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 10:10:14 -0800 (PST)
Subject: Re: [PATCH] block: wbt: Remove unnecessary invoking of
 wbt_update_limits in wbt_init
To:     chenlei0x@gmail.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lei Chen <lennychen@tencent.com>
References: <1606702852-14157-1-git-send-email-lennychen@tencent.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5cbc949d-5703-90e2-fe0b-809b1b76bb08@kernel.dk>
Date:   Mon, 30 Nov 2020 11:10:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1606702852-14157-1-git-send-email-lennychen@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/20 7:20 PM, chenlei0x@gmail.com wrote:
> From: Lei Chen <lennychen@tencent.com>
> 
> It's unnecessary to call wbt_update_limits explicitly within wbt_init,
> because it will be called in the following function wbt_queue_depth_changed.

Applied, thanks.

-- 
Jens Axboe

