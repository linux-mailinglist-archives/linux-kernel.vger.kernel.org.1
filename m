Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6F629E275
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389013AbgJ2CMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgJ1VgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:36:19 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BBAC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:36:19 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id f7so1115829oib.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ioYs1BJonmJO6vYXpRm8U4hKxcd63wE2JMeNCJc2SKE=;
        b=yyA9cidd2yR2QAwgyVQBCxpDNBHcJXbWBEvLGlPrYuRB6ZAh1BVaBBJACY89jTImZM
         o30WxWefxQTEpY1PIjcwxO1lb3HUu98mnV7AEdpALvJHUTsMzHkUS0/8FCYyL1QmIiAc
         9LIdZE5qmuNg8v2kGv/4GhFh9GJ3eJDE4pR98/OQM4jTbKMwUpI8gB6uB5kMKatX5jHy
         TW582ksVh1npdMR8sdSdaKbcgKel5WRNwQXrZ4cPvk59XWT3T9VMtZv2MoFb4F2Gl2/9
         HOzSV7ff7UBEjvHD2w3V4HzxoIlR89rKkFvKbkqWyG13QeuAnPenua2W9Yb0eyBSXqlm
         QDQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ioYs1BJonmJO6vYXpRm8U4hKxcd63wE2JMeNCJc2SKE=;
        b=gp8hnt9tAa3FU4nqLQlqUW1MWBBptDIM2R5bvs2HGCG2oWYpLdqQCvcurZwmawMAFu
         20f/TITSql1nIegIAmsg06gQj4tbeAW/WMv7CQJ2GyuzDdWYrec9RQsKnjsz3jhcBx1d
         2KFnahYP05URWMuPlOghbgK0jn+OosETB2cyt+/ggtAw+HffOeeCvzakxAPJ7NfXLnTN
         lMI8KoLK8RtvGjM985UnaXZ5/vlGVKtQYxN4PAS5JMZtXh5EPGgoLXLlE8pWn4vo5foU
         8gWN21kces02yBOy1uxjz6qwPp0s1UnhhX04KmIPTZ3PZKmcpiZ8K4wldLMA1PXjvgVL
         WBzQ==
X-Gm-Message-State: AOAM531TXckgsfRhWMJRN9wL/9nQevCeNWipIVHXtxKIlIiJmK6Lz3UA
        zjGa+IHPRzQgsTpkOgi4e9aNi5nxaWN6SA==
X-Google-Smtp-Source: ABdhPJzD/aMxkb8rpZsPVNj3h9iHyLztP+XLxtCaIuQf8c84XQ8Q1470cVwEj94jjzOvVHHCdwA/zQ==
X-Received: by 2002:a17:90a:d489:: with SMTP id s9mr7374800pju.50.1603893519337;
        Wed, 28 Oct 2020 06:58:39 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21c8::1268? ([2620:10d:c090:400::4:c0d3])
        by smtp.gmail.com with ESMTPSA id s23sm5710056pgl.47.2020.10.28.06.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2020 06:58:38 -0700 (PDT)
Subject: Re: [PATCH v2] libata: Fix retrieving of active qcs
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
References: <20191213080408.27032-1-s.hauer@pengutronix.de>
 <20191225181840.ooo6mw5rffghbmu2@pali>
 <20200106081605.ffjz7xy6e24rfcgx@pengutronix.de>
 <20200127111630.bqqzhj57tzt7geds@pali>
 <20200127112428.sdfxvlqdox5efzcb@pengutronix.de>
 <20200503214627.gerb3ipcwek2h3h7@pali> <20200508054644.GJ5877@pengutronix.de>
 <20201028135514.r2m3kxchbg6nljht@pali>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7ad0bb9e-1bdd-719d-633c-8a18a3b2bf14@kernel.dk>
Date:   Wed, 28 Oct 2020 07:58:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201028135514.r2m3kxchbg6nljht@pali>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/20 7:55 AM, Pali Rohár wrote:
> On Friday 08 May 2020 07:46:44 Sascha Hauer wrote:
>> From fcdcfa9e7a4ee4faf411de1df4f3c4e12c78545c Mon Sep 17 00:00:00 2001
>> From: Sascha Hauer <s.hauer@pengutronix.de>
>> Date: Fri, 8 May 2020 07:28:19 +0200
>> Subject: [PATCH] ata: sata_nv: Fix retrieving of active qcs
>>
>> ata_qc_complete_multiple() has to be called with the tags physically
>> active, that is the hw tag is at bit 0. ap->qc_active has the same tag
>> at bit ATA_TAG_INTERNAL instead, so call ata_qc_get_active() to fix that
>> up. This is done in the vein of 8385d756e114 ("libata: Fix retrieving of
>> active qcs").
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> I tested this second change on nforce4 box with sata_nv controllers:
> 
>   00:07.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA Controller [10de:0054] (rev f3)
>   00:08.0 IDE interface [0101]: NVIDIA Corporation CK804 Serial ATA Controller [10de:0055] (rev f3)
> 
> Both disks are working fine, I do not see any regression or change, so
> you can add my:
> 
> Tested-by: Pali Rohár <pali@kernel.org>
> 
> Ideally add also Fixes line:
> 
> Fixes: 28361c403683 ("libata: add extra internal command")
> 
> Jens, do you need something more from me? Some special tests, etc?

Thanks, I'll queue this up.

-- 
Jens Axboe

