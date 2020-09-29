Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7176227BEF6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgI2IOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:14:48 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:36327 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgI2IOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:14:47 -0400
Received: by mail-pf1-f177.google.com with SMTP id d9so3779105pfd.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 01:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=nSfcmuB/6nve2Q2+0rkYlIemWZK/+Ii36id+QeSMR7dcF5cBg0nO4COfawE/CXKMOD
         8GTOx1rE8BhlLP9ZwUXl/fQyc6ZRvZru7ioLhW4JSO556gE1q7mFmSuRksIm53xlVYb8
         6jPvlXZQObHtkuAEF+Cbd9R3EmGpHBCR6zcex9NfAP6NCY0aK+lTMx6KUDIgBTDeOHo+
         MCDPvVBuuSSChAqssGvjkUkRFYu9xMa9D6QP2cBlQaHxgT6eEY8OqCMlt+IPmaPVtAq1
         vo4ZSbevlSFSA/zeZcAU7FhZGEQIlHpGkEakbc9WqOKrQVux5Txyi5ADZKO8TAko1Wt8
         1Ytw==
X-Gm-Message-State: AOAM530pNyQ/s4WD79AMeu/eXgjD3rUlUp+ybjO8AVXG9foeci9RPTkB
        bY6fz6cmgU10xr9iHoLy/wrcPj4ibOU=
X-Google-Smtp-Source: ABdhPJyxpBZd5gDKDEFKF7nTD72p5mg0bBklYnrG+VNrKrXBgtH1KoVMJOYAFRaelIVZgzXL1NEEyQ==
X-Received: by 2002:a17:902:8ec7:b029:d2:42fe:37de with SMTP id x7-20020a1709028ec7b02900d242fe37demr2247420plo.23.1601367285551;
        Tue, 29 Sep 2020 01:14:45 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8ff9:9348:1454:22ce? ([2601:647:4802:9070:8ff9:9348:1454:22ce])
        by smtp.gmail.com with ESMTPSA id d12sm3644988pgd.93.2020.09.29.01.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 01:14:44 -0700 (PDT)
Subject: Re: [PATCH] [v2] nvme: replace meaningless judgement by checking
 whether req is null
To:     Xianting Tian <tian.xianting@h3c.com>, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200922062517.30031-1-tian.xianting@h3c.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2b9e078d-7fb9-804b-cca1-b5b1197d1b4f@grimberg.me>
Date:   Tue, 29 Sep 2020 01:14:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200922062517.30031-1-tian.xianting@h3c.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
