Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CAC82CC6EC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389599AbgLBTp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728940AbgLBTp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:45:27 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F246DC0617A6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:44:40 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id t8so3188046iov.8
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QyEPDAytTEl0uopebdyNHFfe+27dQnLC51NhV3dnBlQ=;
        b=OBM1e4X4T5ctyaC99rN18qygJBuxT+Na4CBNEK0YrhauMduyrFTBQhoBjaEMQ9gkgP
         RJDGNWlQZUoeYB18Zc8lohe07PWMzXOXi36725jdFTsya/BtObnqro1yRkyJ+pPO4K4m
         2Key7R6FaAFR5VWNEtq5Q8UX8qafo/GEDz6cEwX68EMT3OyNwoakm1ExLrjmVVqzAkX5
         TeGUe2RLSQvwYYvowut5+1w4CA2CMErINS9xnd5OutfEFUpKZ1U5Rb+h7ImZFTFCrloo
         BhBk8q6z//pFqFhMRW75a30MgVsZ0ZSTKti8GAxpWsA4PNnPv6iHFpneacE6hFIqcjsz
         uJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QyEPDAytTEl0uopebdyNHFfe+27dQnLC51NhV3dnBlQ=;
        b=lpAwqzNOLRW5u8Y5EKsnbToNO0CTK1o8tKRJKHJLPt5g+wlqByLcguPANJ4i2+cAAV
         z8A4vEy5cOderVRIIYQ0EJ+xi6CHkmWyyVoRXy5sIuT74z4SkDh+YIu7XeERM88DCB7C
         NR/w56SaYfmckYkIrNcfeqlQThvdrF6j1IH0PQR+aCYTAgN1qArfQwoPzuofX+INkN6E
         esEGmUoN9bqY8agUbDa68ZQb1HVycjlfY0Io1iyuyUHuMJ6D4N4aqCmyBC2pIrwTGrQv
         wNXRDtgz4iKSav4aHE4QxcmbHp3Jg9lbIrzJBrKuL9pVBbcN7OnBOtmmXtkAxqo6N8YA
         7dsA==
X-Gm-Message-State: AOAM532hLAMcnto7vaARdLL0k9J7YKLkMW5/Rtzt2adc4Z2LmZar8rc2
        qIy2S5jEq0MtTGKDbzmhp4dF/A==
X-Google-Smtp-Source: ABdhPJz8UN2fY5APc9Sjo+vvBdGu2jQKXfD20JyDILa/0y1RXXAbuPmiCHQzcqnjlgbJWrFl1+onVg==
X-Received: by 2002:a6b:3118:: with SMTP id j24mr3303413ioa.171.1606938280197;
        Wed, 02 Dec 2020 11:44:40 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id z18sm1157219ilb.26.2020.12.02.11.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 11:44:39 -0800 (PST)
Subject: Re: [PATCH] blk-throttle: don't check whether or not lower limit is
 valid if CONFIG_BLK_DEV_THROTTLING_LOW is off
To:     Yu Kuai <yukuai3@huawei.com>, tj@kernel.org
Cc:     cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        zhangxiaoxu5@huawei.com
References: <20201126031834.40807-1-yukuai3@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <51844d83-3447-cf0f-bde2-d368f5f43f5a@kernel.dk>
Date:   Wed, 2 Dec 2020 12:44:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126031834.40807-1-yukuai3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/25/20 8:18 PM, Yu Kuai wrote:
> blk_throtl_update_limit_valid() will search for descendants to see if
> 'LIMIT_LOW' of bps/iops and READ/WRITE is nonzero. However, they're always
> zero if CONFIG_BLK_DEV_THROTTLING_LOW is not set, furthermore, a lot of
> time will be wasted to iterate descendants.
> 
> Thus do nothing in blk_throtl_update_limit_valid() in such situation.

Applied, thanks.

-- 
Jens Axboe

