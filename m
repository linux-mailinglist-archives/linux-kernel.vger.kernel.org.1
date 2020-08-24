Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4A0250996
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 21:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgHXTpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 15:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHXTpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:45:45 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E84BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 12:45:44 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id d4so4746843pjx.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 12:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=XLzPGl4Eap2WEQDnCBOMpgiVYB87oR4tNzXe04U1Yus=;
        b=XFo2LL3y7AhxhrbYL3AA5QloXwqCtv51CFv+ivg2vqei/6inK40GT7BuWmfnCoqsag
         0TB19Ve8hTo23hLyYbP2EB4J627lToJoVqRnzGrN0ziDNgINk1UHHXiIlQxRxVjxoDyO
         MrfK8UK5FHNIHYSB07msbw8lRemEDR8lfZ74UIMQxiiklijoaS5ZwdC8vGg3NnN/cu9/
         4aJlQnL7TX1W4yY0mNjKPq+5tV+qzpORVVVTA9X90A8/BN7DIlPfo6iWc5bWHhY20bj+
         k1SHQTfNN67IP3GLzbkCDC8jlXLCty/OmE3lRGlaYyL/0Ynxx8vKbjUuEIHUWt5FxZJO
         rKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XLzPGl4Eap2WEQDnCBOMpgiVYB87oR4tNzXe04U1Yus=;
        b=jmDYBetH9YUIe6+tOYTCZuq39C03HwYnuzhIM6U6xXDo1O309SsU+1iNGyzTgU5+A7
         fScDIlQzOOzRFWe9uoAzG8/fLCoCAaMKFUjR2Ayt0XSZcJ04UlnqAaG2g20ewWBebfWE
         cfur3G6JFx/vtANr3eWf+tytyHU8S9UMiFuyLj1+j6YVnCF/N87PNK4P/zqe85HSwMTs
         0GUqjWvWLtPhN+7TFuh1JpX7K/nFhk7w+Oy9fy4yOTLDKb26PCBrovTtfOJOGnVkvqyL
         +3xsM6PLcDDCk1nAvJUB45NoMCenqfTk9AXkCJxIgizlWZsLfUUUY/TtYduUfNMtka3f
         ALng==
X-Gm-Message-State: AOAM53036iDxzK3jrm3TNoduGSWz+SlAsO/ywkcWuMsOGCIzX7CU3etb
        bZ7vEAAakMqNspzhScrVs8lZOjy9L5X5/t/7
X-Google-Smtp-Source: ABdhPJwS7A/m7RK1cRDv1D4biUVRSI0CtsgcuILfl5254A5JscLQW1n+XDBrmv9+ubuiC+AL2ZrNnQ==
X-Received: by 2002:a17:90a:ac07:: with SMTP id o7mr702682pjq.194.1598298343792;
        Mon, 24 Aug 2020 12:45:43 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21e8::193f? ([2620:10d:c090:400::5:b493])
        by smtp.gmail.com with ESMTPSA id j14sm1880974pgj.3.2020.08.24.12.45.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 12:45:43 -0700 (PDT)
Subject: Re: [PATCH] rnbd: fix uninitialized variable
To:     Tong Zhang <ztong0001@gmail.com>, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200824194322.337375-1-ztong0001@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <3b904063-ca08-092d-a861-e1c80d511ab1@kernel.dk>
Date:   Mon, 24 Aug 2020 13:45:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200824194322.337375-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/20 1:43 PM, Tong Zhang wrote:
> variable err is uninitialized when bio is an error code

It's fixed in Linus's tree:

commit 17bc10300c69bd51b82983cdadafa0a7791f074e
Author: Nathan Chancellor <natechancellor@gmail.com>
Date:   Mon Aug 17 23:49:25 2020 -0700

    block/rnbd: Ensure err is always initialized in process_rdma

-- 
Jens Axboe

