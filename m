Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7492976D0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 20:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754594AbgJWSVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 14:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750665AbgJWSVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 14:21:03 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14FAC0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 11:21:02 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id p7so2927889ioo.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 11:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=P1VAgbL5Nu9xQpoma8IOMEGFKLYoq5WVSujqi1jyKgY=;
        b=rAbqxPC2VQNEYRxnvNmkLskSPPyOEPbWivfmxBlTPA3qayf89gJOsA67iWwnyVmZly
         YmyvWuRLcSU+rxm9DNZqJoJ7Dmg13gk7ZnGbnHxnq6WAJED74sQ/atQtQorP1Saeqvuh
         GUS+1r/fHdngbqyNCRuFFdrnYcGJl2TYKvlwIni/wlCcNWHIkInPmjNOqzX7hob/sT6x
         zmRDCzq1tBW4IYNHWMwuRLzaR0bDp/MWwj0A9PH4/zcs6kiwUki7NazXwgkdtph/M/RQ
         6Ms22QS//vHIcFOBMrJa0BLEHlrkMhMSRn8uHWU5Zf9jD67kjdrku8pKDA6HNGFueQ2j
         WaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P1VAgbL5Nu9xQpoma8IOMEGFKLYoq5WVSujqi1jyKgY=;
        b=QGCAB9GIY0P+OxF8GE+kvD8pTrVrMJh0fKN2xHv1r2EkbDuXAmLrMk/rxCsx4wbwCj
         eeVQYyznMZyB3F74wwohpJhMiUED+ktHa9hJu3oPqi56odfZ/tK0SdfL83OLuu+Ejkbw
         yuhSGx8OYoQV9AOoUK133sC/ebrMBDGXStu8z+qaF53MDsMjNfBy/GEP/Ve+L4DJvmbl
         1Aumo5+sFLAESo8PzPS3owuDjiYAeDJ0AL7hZY2AjhzRntARL/469Ch6LTw+/LON67e2
         S1nN0hrL2MPmxvFj+qGvSLeHbYuG2vat/nYMVKCMNKxUQHX71SmAVMSWhNU4ENsQUUs2
         60xQ==
X-Gm-Message-State: AOAM5312AeQNZyfC9S98tLZA3Fq98S/jMhmv05hbF8Eh82bbSVPv3vAN
        h6JdsQHn4G1HFK+v7lKLrtZS8gjx2obLIg==
X-Google-Smtp-Source: ABdhPJx8qoQk7VQ7uKvt2wBD9BQFogJlh+zzJNIe/v80ZeH6np9XqS2RoBJfDU8kUNV1urnbNmbYTA==
X-Received: by 2002:a05:6602:20c4:: with SMTP id 4mr2611908ioz.149.1603477261961;
        Fri, 23 Oct 2020 11:21:01 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c2sm1099963iot.52.2020.10.23.11.21.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 11:21:01 -0700 (PDT)
Subject: Re: [PATCH v3 08/56] ata: fix some kernel-doc markups
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <a7e159be08bcb0c42aa219cf99c2adfd4db0a9d9.1603469755.git.mchehab+huawei@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <25423969-161c-f471-2968-df4f3f9fd319@kernel.dk>
Date:   Fri, 23 Oct 2020 12:21:01 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a7e159be08bcb0c42aa219cf99c2adfd4db0a9d9.1603469755.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/23/20 10:32 AM, Mauro Carvalho Chehab wrote:
> Some functions have different names between their prototypes
> and the kernel-doc markup.

Applied, thanks.


-- 
Jens Axboe

