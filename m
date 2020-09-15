Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D873269B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 03:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgIOBrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 21:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgIOBrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 21:47:23 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF28C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 18:47:21 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kk9so913732pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 18:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/9oiy6NhFDTGuIxMwjEr15PaiJFbKdR5/rgyk3WXdXc=;
        b=DtQVwdE2S9R/KfRwpS6ild8EgzksvCRGPDk9J+V8CdffdQfgowKv8CpUq48KX75Y1P
         669X8UNtYFor3iEDN0x0oGQoMt/dcse4uetjme/WNloj199sgOCSPdMGd69BZyG/98KT
         34HvirvPnAlPClPnxlAn/sH/HTAEL1OEJTUhT99X6xUsnAdARcdFKTgwpDARJ3p6GRaJ
         uFLHKBRC6E2GMc2MGJEDZJ4ckCz0Ba8Lan+3ifA+aA80V6O/IDFgL9cjpmYUcFChqw9a
         mavI984e7SNomsxxXorHzZN2hHE0qmiQCabw1lyz4nGWxbkz0kKDloKpkLZWcPlnHUnW
         UBow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/9oiy6NhFDTGuIxMwjEr15PaiJFbKdR5/rgyk3WXdXc=;
        b=ojqHpxj3JHFES+bp98oFwSWpJcEkESAlXvrAZEntaWXLq9CNXunR/HUo3k3DISaDX6
         lnNdAlSRPsSFZPEd8ftSCBwV8CeQiSh+mUwU7UN5i+MbTWnrOo6qE3GKvXmyzk1+Jkkk
         j8M6nuCeiK6aiKI5UPTWEj4pMHE33sHkUc5OutirTIfwjJWn7Wxh+Sn9DmD0nGcycoM3
         1afKHcbGB1MYRfUXj7r13hgg1DZDXIAgDzbHHpA/ERl5IS+taJMxvaUD6AaUNvTF1ADG
         z/GsAr418kFbctH/GaZhYRROp0KC8qtUyx5Ru/xF8474/jf5dbh+GSSTQmOCnrS1xoMb
         pXMw==
X-Gm-Message-State: AOAM531JAcmqqM9LaYbRG/x2PBiaC0612XZvOuK5grivJxD+MOU9NIZL
        VCvJOyY4kVN8ChuRYAYqsLlzvA==
X-Google-Smtp-Source: ABdhPJwxfL5xQuFralaUQ/x0twZ1620o62+Ds6n78hZQcjd0/dYsXAiLBN2tNTGD8o6vdlvinniFJg==
X-Received: by 2002:a17:90b:1649:: with SMTP id il9mr1940966pjb.94.1600134441347;
        Mon, 14 Sep 2020 18:47:21 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id h15sm10006345pfo.194.2020.09.14.18.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 18:47:20 -0700 (PDT)
Subject: Re: [PATCH block/for-next] iocost: fix infinite loop bug in
 adjust_inuse_and_calc_cost()
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        kernel-team@fb.com
References: <20200914150513.GC865564@mtj.thefacebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e9e616d2-4bba-43b4-e41f-3c73f65371aa@kernel.dk>
Date:   Mon, 14 Sep 2020 19:47:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914150513.GC865564@mtj.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/20 9:05 AM, Tejun Heo wrote:
> adjust_inuse_and_calc_cost() is responsible for reducing the amount of
> donated weights dynamically in period as the budget runs low. Because we
> don't want to do full donation calculation in period, we keep latching up
> inuse by INUSE_ADJ_STEP_PCT of the active weight of the cgroup until the
> resulting hweight_inuse is satisfactory.
> 
> Unfortunately, the adj_step calculation was reading the active weight before
> acquiring ioc->lock. Because the current thread could have lost race to
> activate the iocg to another thread before entering this function, it may
> read the active weight as zero before acquiring ioc->lock. When this
> happens, the adj_step is calculated as zero and the incremental adjustment
> loop becomes an infinite one.
> 
> Fix it by fetching the active weight after acquiring ioc->lock.

Applied, thanks.

-- 
Jens Axboe

