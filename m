Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4314524EFC2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Aug 2020 22:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHWU6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 16:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgHWU6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 16:58:24 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693D9C061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 13:58:24 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so3586279pgf.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 13:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zS0ecbpZZ+cVdlZa+aZAL5hWPlBuHCBFZniPWAzuhC8=;
        b=K3kr31LRIux788x0rBtRMvzRJ+5++K+3UFf3uhX9RcvkrOioN6TY7wv71Wt8cLwLXv
         YfIT7goRQUkp3f0koA0fOY8Ql1jBqviGoqKvo6w63ao3quEat9E2b0V/7CsbYMtUYhNW
         0f92pTadFo0+RkPe14oNq5c8RtgPBaRSmXIvtMFBmthXM9gQUrAc9Oo2ThjhVSB9Hxu/
         YmW1lv2QSo4fJA+eFn6LfSWmcimedezE09Ec+Z57OX4PqNEaK72yXLd4teDIp5YMnddV
         KPumVHW4hJnkNcWX1ugwPOQPId60RQhySTQbndgfomxAgJL9607+e0TiSQP6Dmz8CdFP
         DIBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zS0ecbpZZ+cVdlZa+aZAL5hWPlBuHCBFZniPWAzuhC8=;
        b=Em1ojYxCFXjdCyDScyItwt7LBmqRSwHq1KSX78AHmAkCixXbaZpJITaqXHQAhi/f9G
         +akw4euoJmodI8PZ+7+mslKm/qP9U/fDDoxEkQj2qt0IPZU3pUJOSRNvAnNCM2QlD6Z4
         x9NGe4vure4OceTJuOWbYAeKeTJ4OQ2a5kRDvGVGSTP9b1l6Bhfz0/p+BQA2xxA55Y/p
         k16Nhk7Z0bWS72iMJz6Td/imKLIhzE1b1sn9QmMufk4Mq/jJMZSw9AM+oAjwLpo/K9uZ
         grB1xaU3lV4V1aqIEAuVL00+IJ4apQ+9WO7Aqea/fzNYGqieHPgpjCZG0d6EFNPnhJbl
         830g==
X-Gm-Message-State: AOAM5330gXkcdz5MxUC+L84y2Vd/wMjfPdD/9CuylpKZzkA77GGAPcr/
        cvVRbFLMN9FcfKd7GJvM8yK+aLYGvmba38Ps
X-Google-Smtp-Source: ABdhPJwlLmInfWDL6vJxQX8lHTn4RlsoAdp7APBoSmQoNVguKawr7GFn7LH5UYATXd4T5rVt0yaJdw==
X-Received: by 2002:a63:cf03:: with SMTP id j3mr1593200pgg.14.1598216303091;
        Sun, 23 Aug 2020 13:58:23 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id y72sm9192384pfg.58.2020.08.23.13.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2020 13:58:22 -0700 (PDT)
Subject: Re: [PATCH] blk-mq: use BLK_MQ_NO_TAG for no tag
To:     Xianting Tian <tian.xianting@h3c.com>, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200823154459.40731-1-tian.xianting@h3c.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <1b85d18e-b0ae-a925-bb84-0a1eb8942099@kernel.dk>
Date:   Sun, 23 Aug 2020 14:58:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200823154459.40731-1-tian.xianting@h3c.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/20 9:44 AM, Xianting Tian wrote:
> Replace various magic -1 constants for tags with BLK_MQ_NO_TAG.

Doesn't look like this patch was even compiled...

-- 
Jens Axboe

