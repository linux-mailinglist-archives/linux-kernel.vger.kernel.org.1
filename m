Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0671B657D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 22:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgDWUes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 16:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgDWUer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:34:47 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D0EC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 13:34:45 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v2so2805551plp.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 13:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lAZLvgUscRE4/uWVi5RrbkZoz5M8Eu/oXCjzKRnqlSA=;
        b=2R5fmG17hWkeAurRHdMXiGPKZ4ZFUN7BUElkzTs+N6osWMzA8Fc3arF4hZn1/iNEQX
         XTnz+E1OPTR8p/AywK8peZM0ZWWjwLP9abn773JK/UllNoKAfCovo+83dmKHAtv2nPgc
         KvAzkSEbAU+wrWoRdYTTTj48sikHnuQcOHvA70ktqOzNdfaiplzxX8kEIDsogjS2G4QL
         WWCFepAdUVTYNaHLfmVk5KuGIFuvJYBcOL2jTU0Fo9JLOHb7e265jmplB4hGbDMgQRwr
         u5zJ10BQzNHGhNI2xpDh0rwPjiPxfoVJt3Dl2Tr+vqV+GZuS3fsaJHqqcqMSOYrGjhcK
         fPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lAZLvgUscRE4/uWVi5RrbkZoz5M8Eu/oXCjzKRnqlSA=;
        b=hwdEaOrYm11mFtpW8qKJIlRwr62dujO7BF+GLoxsumc7OS7JmTZaoppeEt9J4PicFu
         XkkUCE7Qw2RZsOExYI7t5plUjHdYlwzzJ+wiIq19lSSTZk1ARXxliub/77Vb+keYRNCG
         XXPMe5ddPjFhPgte4fNNgq2dFeSOT0E2Dzkxi2mz4aWzfKEBItJJYhfXhB4+fC8/A9W0
         e+Y0M3/VpDcYgFfZCDJwTSPrzoPNfaWm1Lewezd/PW7jLEEsv+J7k9Av6XasNcdvN6aG
         26u+tW1izNUXCfe19ZkwHx8gDjRiND2B2eyi29a5Pm+vaTAWNk9TJZMSrF0CwOb/63Tk
         b3tg==
X-Gm-Message-State: AGi0PuZbgdFfnvK0wRcjD+FWh12CKPRbUAp1xqJo72wPHtz9pzAnGAUU
        ZWEm2j8EAxu7OszhHOAUUwzYImkke7FJbQ==
X-Google-Smtp-Source: APiQypLn+IYcd37nChbfNJ2MjfbSkY+RHfaNofUDTl6fpj9ZG+4vm2WpiQdjVS8Lz5J//GuY0Lfb6A==
X-Received: by 2002:a17:90a:df15:: with SMTP id gp21mr2708249pjb.2.1587674085328;
        Thu, 23 Apr 2020 13:34:45 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id a15sm3155897pju.3.2020.04.23.13.34.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 13:34:44 -0700 (PDT)
Subject: Re: [PATCH] block: Limit number of items taken from the I/O scheduler
 in one go
To:     Jesse Barnes <jsbarnes@google.com>,
        Doug Anderson <dianders@chromium.org>
Cc:     Salman Qazi <sqazi@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@google.com>,
        Hannes Reinecke <hare@suse.com>, Christoph Hellwig <hch@lst.de>
References: <20200206101833.GA20943@ming.t460p>
 <20200206211222.83170-1-sqazi@google.com>
 <5707b17f-e5d7-c274-de6a-694098c4e9a2@acm.org>
 <CAKUOC8X0OFqJ09Y+nrPQiMLiRjpKMm0Ucci_33UJEM8HvQ=H1Q@mail.gmail.com>
 <10c64a02-91fe-c2af-4c0c-dc9677f9b223@acm.org>
 <CAKUOC8X=fzXjt=5qZ+tkq3iKnu7NHhPfT_t0JyzcmZg49ZEq4A@mail.gmail.com>
 <CAD=FV=WgfAgHSuDRXSUWFUV8CB3tPq7HG0+E7q2fRQniiJwa1w@mail.gmail.com>
 <CAJmaN=m4sPCUjS1oy3yOavjN2wcwhMWvZE9sVehySuhibTmABQ@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <016647fc-1d7b-7127-68aa-044d4230a22d@kernel.dk>
Date:   Thu, 23 Apr 2020 14:34:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJmaN=m4sPCUjS1oy3yOavjN2wcwhMWvZE9sVehySuhibTmABQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/23/20 2:13 PM, Jesse Barnes wrote:
> Jens, Bart, Ming, any update here?  Or is this already applied (I didn't check)?

No updates on my end. I was expecting that a v2 would be posted after
all the discussion on it, but that doesn't seem to be the case.

-- 
Jens Axboe

