Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0C32026C9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jun 2020 23:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgFTVWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Jun 2020 17:22:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39388 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728891AbgFTVWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 17:22:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id v11so6209869pgb.6
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 14:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lZgSGwAntb0/3yR8kQL2Gr50e6PlDlNK7lkPR/KXNC0=;
        b=U7Bt62yAVSNu4txp+rBDdYHJ/Ly/MAhXujOQpyxdcdSnGR2J53xkTjTB9RAA3RLhk4
         8k/RWPaN1xvQxNWMl5IJMBmjhlEpCM9C1TVE+slLlTIFS5fDBps8ikBAFwbgF+lZmzQ9
         GWV8ErBFE8jGDxMq72DENBH6z2v1SNrjr7vTi/xSroGAcYwvOjvTFMtwh8jBnFGmWoTh
         7LX0Mq8DtcnC3MJl+22CCHq8kRXANya9+vzbotMdvugBt8gGkxEuvDxZIwQG9xNo/hLn
         GJIk46VJyxRa4MVAoD1FZ7yqlLzCvx3IWNdqS7B1MDf3XNp2edMwgCimwJo8XpFYBOvj
         pthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lZgSGwAntb0/3yR8kQL2Gr50e6PlDlNK7lkPR/KXNC0=;
        b=AVZrm+9clt1UAfGrNYB8e0v5u//+TAaLiCojELRLWc8ZMpBH1J1MQoG97jfSZ8hXGa
         UWefY1Y++HTBsPKB6TS4q3RwJQzQnEnA/lmHJBv9z5nsAk/L0g7OCxBTWGs+8e75LpcR
         Q3XZTkQBsWvYfo1luGawhQAEBypLXUd+22qkVnql6bXrmEqQdh2Bk5LUot23v3+Bc2o+
         GKM/jaXzXRfe1J+csLdJdif+V/ECvKBGYuLgZBqNWgtZUAG6Fo93tTGgqUO8pqmseIna
         xdnyI6o8/MFHm/DtuMpfH1cdU51e9puaitUK5yVSwpa0ujzeF9NK2oCmSpXnMFCd8X6n
         yzPg==
X-Gm-Message-State: AOAM531b2Sb+Z8IhGqJG33V/8IyIsIar8xJTzWBcGI74zzhxW/wRtD+X
        5e9FB8WT2pTvsKJ+Tp8p7anFzw==
X-Google-Smtp-Source: ABdhPJzETBIPzSKpGeMgGm10RL0hb3bG4nkEHjd55w7jaTnH8Xdo6StEMqi4XsC1Dhpr6fKRYqHm5w==
X-Received: by 2002:a63:141:: with SMTP id 62mr1437460pgb.366.1592688067642;
        Sat, 20 Jun 2020 14:21:07 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 3sm53307pfv.156.2020.06.20.14.21.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 14:21:07 -0700 (PDT)
Subject: Re: [PATCH v4] docs: block: Create blk-mq documentation
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        corbet@lwn.net, linux-block@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, rdunlap@infradead.org,
        dongli.zhang@oracle.com
References: <20200620002036.113000-1-andrealmeid@collabora.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d7b3b500-cb3c-1348-61c9-9e14767fa4ac@kernel.dk>
Date:   Sat, 20 Jun 2020 15:21:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200620002036.113000-1-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/19/20 6:20 PM, André Almeida wrote:
> Create a documentation providing a background and explanation around the
> operation of the Multi-Queue Block IO Queueing Mechanism (blk-mq).
> 
> The reference for writing this documentation was the source code and
> "Linux Block IO: Introducing Multi-queue SSD Access on Multi-core
> Systems", by Axboe et al.

This looks fine to me now - Jon, would you care to queue it up?
You can add my:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

