Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492EA2F224A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732176AbhAKV5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728040AbhAKV5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:57:54 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD016C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:57:13 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id a109so386445otc.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ahNV2VwLuL8qXxYB3lq81Sz8ySayl2Ljd5w/aJv+yoM=;
        b=UqKvnMysQJagjVcvERzqDRF5WxDKpZsLPGsSvYiZPSwHTZjumL9KYltANkHy0a0mxO
         wIkxl5564cEWQ6owf812WUcGPvCNMDVwXX4iHJmNzhevElyj8ryYD6o73tnsef1uT9d7
         ucUEz/LUGMzA0vRi8R6/grxnLT65clVREe5Dzw9Wuooeok+bh0a6YLD6ct6MS2ksLgEA
         je0xgyjBEKHdMUMTMQt2rcHfKQqamyjv+Hb7sCt4pg4echDPvckCTNJckT23UbY8BpPV
         vsOB4iRCjMVKYeOaR0Xh6qiegtn856KcGZZBKtp4mBueWofJ8iMGcGkwCIF0Bf/BGWp6
         KvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ahNV2VwLuL8qXxYB3lq81Sz8ySayl2Ljd5w/aJv+yoM=;
        b=L0eaxBgco5eWWWo6iOvIiBCi2DtWnsGHeBCIwXiRTzjD2LTNMfmL0BOj+P2hLEUVUE
         qYQSi3Kvz0ohVAMTouP4CAYaJmCYmGQk6ACr92oo2SowpXEvEhDwV4keyS42ur8bSEmA
         jfY4WsdZy0RdTtAUJOfIHEHwOHsJnteofh4wMoI1IsU2ZDsEDDUi3z+bM5DLGk/12mOq
         9blVU2/ZN9UGzTgRum0+IuxPvjeuPwHojfFjbZDBc/h/QpHZCwtuZT6BXU/0GhSzFjfg
         kbyWZ/9uG+6zqiJDSGhbsF6LGQWPofKhiyFWt90MC7Col9oGE3jPhcOLSjlDZXMo92C/
         oC5Q==
X-Gm-Message-State: AOAM530UzoIhO8czwlSoucRL0/giUPegzFBKxogJwfOPYNav4kudmAc9
        7y7xobOyMDeriy1K/bG8g+DeNPrphYY=
X-Google-Smtp-Source: ABdhPJzT+HT1tC4f0uqD5D4DMjnChJ4FVHzg3FC3E5/Eff1BEdDzW50sI1n1ytCl01EKq2zDDcuMSg==
X-Received: by 2002:a05:6830:90a:: with SMTP id v10mr790176ott.364.1610402233387;
        Mon, 11 Jan 2021 13:57:13 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h26sm233111ots.9.2021.01.11.13.57.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jan 2021 13:57:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 11 Jan 2021 13:57:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.11-rc3
Message-ID: <20210111215711.GA57318@roeck-us.net>
References: <CAHk-=wizR7--Ub-rasYx2S5XURkooCQ63Sat23BpvTAuN0scQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wizR7--Ub-rasYx2S5XURkooCQ63Sat23BpvTAuN0scQA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 02:48:47PM -0800, Linus Torvalds wrote:
[ ... ]
> So please go out and test, and report any issues you find,

Build results:
	total: 153 pass: 151 fail: 2
Failed builds:
	arm64:allmodconfig
	ia64:defconfig
Qemu test results:
	total: 430 pass: 428 fail: 2
Failed tests:
	arm:raspi2:multi_v7_defconfig:bcm2836-rpi-2-b:initrd
	arm:raspi2:multi_v7_defconfig:sd:bcm2836-rpi-2-b:rootfs

Same old ...

Guenter
