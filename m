Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94121B5124
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 02:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDWAIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 20:08:19 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:38318 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWAIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 20:08:18 -0400
Received: by mail-pj1-f67.google.com with SMTP id t40so1694362pjb.3;
        Wed, 22 Apr 2020 17:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b8MI707XPUmbVBAHMkRUlSdETaigvCBuJWiM5vEnnQY=;
        b=VL6AvHwHItydmqCwRicH/9w6ecpnto4VAkk7OYKOPgnUwmozf99MXCNDC+6HcNmKNx
         9ytZqWD4wfR71R/rp16cYRZofgqT+EiTzRdNWKninDyolmWxc+uimJ5kddo8OpTJ1wS8
         d14FDQ3xnk80EX+wlx+/stc1LOIZI7RX2YBg/mbgflxRw0u/KkKICXgomBk6pPHUfqZk
         rNLuNxMgBOHJAwtLiHHnPPmEx9wc18KqdJ7Huy3c8BZTYb7XjuD9/Yjc+E1lwDiaMNZb
         EPPmBOTyokV48FXyKD3/PNH9YoXxjRDtL542NpW4myEtFEI05CJyXTgNjJk0a8ZbkHrj
         FOUw==
X-Gm-Message-State: AGi0Puap0Do/oz9L3UHicyLVvg91B4YUOQZu1xVIM+lmyT2OtVU99fux
        WD3a9oZD75mpb+gqvKRFZRTXqi1efYs=
X-Google-Smtp-Source: APiQypJihfVSc9CfqAV+1F/S2/EpyZjF9KKfzUlRSXpWDlow/vWnYMyVxMD12AZVN1IlJIWHVD2hvg==
X-Received: by 2002:a17:902:a713:: with SMTP id w19mr1243857plq.197.1587600498096;
        Wed, 22 Apr 2020 17:08:18 -0700 (PDT)
Received: from [100.124.12.67] ([104.129.198.228])
        by smtp.gmail.com with ESMTPSA id 128sm614323pfx.187.2020.04.22.17.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 17:08:17 -0700 (PDT)
Subject: Re: [PATCH 3/9] bdi: use bdi_dev_name() to get device name
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz, tytso@mit.edu,
        hdegoede@redhat.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200422073851.303714-1-hch@lst.de>
 <20200422073851.303714-4-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <ff0f4b9a-3724-fcaf-bf52-2c99507cafb7@acm.org>
Date:   Wed, 22 Apr 2020 17:08:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422073851.303714-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 12:38 AM, Christoph Hellwig wrote:> Use the common interface 
bdi_dev_name() to get device name.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
