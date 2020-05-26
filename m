Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A318B1B5127
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 02:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgDWAJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 20:09:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40430 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgDWAJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 20:09:06 -0400
Received: by mail-pg1-f196.google.com with SMTP id n16so1944485pgb.7;
        Wed, 22 Apr 2020 17:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sm2s9oTr54AuFPui/oDg5EqpKZfyC2+O0n8zH1kfUfU=;
        b=FOYd160y9Cfutu0h5hPjR+WOk+Ohy3nCaI3mp7dxbN4S8U6y2NngDnuk5TIqrXECTy
         jGR0XtKH2RtZA5JhBBLzPw+OANIC6WZa+8tVSd1Erj3hpNVIrrzS9oUvve8Zfb1oEWDi
         JFk1Os/mHre7s7Y/Gcj7joOzRItczg2bCl8KK1580V2/W1WOMHbEwEBXkS0GVnY4SKVC
         aubqNSDk2pFOIZNCOppwa3bOwLYtleHZFyd3oqLNbu96dOr1rbdG27kVoFiiuToFzJCp
         d5vvEgP2xYxQHdzt7Zu7Jf4Bs5sDjLoi5DxgDqPQhxyXvgsiBdfJmAqSElZXQUBnvIpD
         bWrg==
X-Gm-Message-State: AGi0PubuWZAdjOZyIWgMUA9eGxkKHZ5UxMD2BhYcEwyD4Tga4oesuYpQ
        n3aqgXUjK4I37LW/HT4SZtfL7FjL8G8=
X-Google-Smtp-Source: APiQypJIsXmqbm0r0JIFrqjbyNs2skkIhzf5QnQP81/l0CsVnrHEMngDXoNFko8+jzfCsmDdnqhKSw==
X-Received: by 2002:a63:564e:: with SMTP id g14mr1527375pgm.63.1587600545568;
        Wed, 22 Apr 2020 17:09:05 -0700 (PDT)
Received: from [100.124.12.67] ([104.129.198.228])
        by smtp.gmail.com with ESMTPSA id z5sm644931pfn.142.2020.04.22.17.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 17:09:04 -0700 (PDT)
Subject: Re: [PATCH 4/9] bdi: add a ->dev_name field to struct
 backing_dev_info
To:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk
Cc:     yuyufen@huawei.com, tj@kernel.org, jack@suse.cz, tytso@mit.edu,
        hdegoede@redhat.com, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200422073851.303714-1-hch@lst.de>
 <20200422073851.303714-5-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <dfdba0c2-7a52-eb75-355d-a2cfaab80d7a@acm.org>
Date:   Wed, 22 Apr 2020 17:09:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422073851.303714-5-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 12:38 AM, Christoph Hellwig wrote:
> Cache a copy of the name for the life time of the backing_dev_info
> structure so that we can reference it even after unregistering.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

