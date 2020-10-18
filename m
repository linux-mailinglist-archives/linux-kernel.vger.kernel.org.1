Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7265D2917D6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 16:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgJROSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 10:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgJROSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 10:18:07 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBD1C061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 07:18:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id n9so4422592pgt.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 07:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3AZHBLLvWMfgbcVvHNhRZAd8EMNoHCbJlZXBEhbtLZw=;
        b=D9BuCuO97oNl7V5Wzzh1hG2ZSeCrc/LLKDf7pMuKA/P72fkl3ikI92sBgKnV9aNnBm
         +KMKz96aOdiw7egPtPVsINZrVhOnBXRCBLPqbItVYF+Q2hWNPAyV4/G7BgM4HcBovRSF
         WVwvs2QEOyR8lWYe4ZSwh4Ma6Ak3ALndiwQB5uwx6hfQcmhOh44elWslk17xVVJsHiSp
         Ac8+Pu1JjhMJ1Eydspe46vX/JbGMxF0fcAHQj+I+I6jMTL/6bmgsNKO7mK0cLrMaoxkq
         A5r4fVvn8VRRIisiouL1MOzCzlxwZFzO2EuXi2QUYgro32DbHarguGVbuVHDm57MQCIO
         lS9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3AZHBLLvWMfgbcVvHNhRZAd8EMNoHCbJlZXBEhbtLZw=;
        b=BRmtO1H2NGX97LlOCtS6CFpZYjx6TvPErdpplkkhyv4JiZtw6t7SpfDNSzJ86c7WDT
         ueiqK8FORmiJ9reSPSJ2ZIaN8mAVOV9Yv+SBIzR0+Sezk96lf1kdGVFpJqs7ObU9rzjn
         6BOaukjTa3XRMFoWoZDAZF6+b2+NHrjqVOMq7lKfVcioGUKzj5qh3Cl/NayfL0g5oIne
         ZfrcBWJ/fO10ObCJU1LDI0TWtAajBFdwxCkGRZquONgugaCLQ4VkR4cB1ptHjftZaryl
         GMXc36+RA/tiRxnkFG4pifP2LQSHPoTk6Pw7kRTm3XTl9zITSXSMAedf2ylR4f9AeWFv
         I9vg==
X-Gm-Message-State: AOAM531HCuzZDAx+UvIvMMLyh/UZDv612sey3I5ql83C8lhEhigtIfZl
        1QokbaLcdl0XGN3XzKzX2RQ/H5f+Nzpl4hPN
X-Google-Smtp-Source: ABdhPJxWtttFXHAzeOr1O9x0LT7JkH9hTHSzs5ZJaGnnrZCiP+EfUa2HJ1smHLL1S/g//i9PUi2P5A==
X-Received: by 2002:a63:dc0a:: with SMTP id s10mr10406878pgg.295.1603030685132;
        Sun, 18 Oct 2020 07:18:05 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 128sm8906689pfd.110.2020.10.18.07.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2020 07:18:04 -0700 (PDT)
Subject: Re: [io_uring] d5883a5113: BUG:using__this_cpu_read()in_preemptible
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20201018085251.GN11647@shao2-debian>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <107a92e6-8c67-32f8-23c0-aa947372dc0d@kernel.dk>
Date:   Sun, 18 Oct 2020 08:18:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201018085251.GN11647@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/20 2:52 AM, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: d5883a5113ffde433efec9b54e4402c9534ccb19 ("io_uring: store io_identity in io_uring_task")
> https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git io_uring-5.10-next

This one should already be fixed.

-- 
Jens Axboe

