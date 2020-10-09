Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9AD289164
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 20:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387728AbgJISsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 14:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733050AbgJISsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 14:48:12 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023FCC0613D6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 11:48:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g9so7903136pgh.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sZ18D9yNTLA/NbXOdAuKEsTcR5giW4iKOjznOdAv43U=;
        b=layQZtMfZhok4YcGFUOCqBqjuos48dSw3w18unOH1LX6L5xlaUBWWByGGvXBb7BfUY
         YR/R9NS0u/GmmrkajjNXDdwNfv/b9fehQyfuQ4Ar7gYgqEnuLwFz0PJXkJA/zeeOEeCR
         AZ8FNy9/r4DY4HD7lGgrMwC8bKvaLjpjKhA0GeDhI+rqgLxcKdzolXS6jrFRvAFq2be5
         a9LcLzDXrSJco0b54+y5eGsHRePe9iJ0vfd7j3Fpne9Hpf7RAX6df+FEUXZn7qf/O8Fb
         uIxDAOifs0PQvIPAcI2ygNeiDNF0TAVRlGSvz7How+mz5ZKVHCcc+4tJxDH8NTTk6Qdo
         RpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sZ18D9yNTLA/NbXOdAuKEsTcR5giW4iKOjznOdAv43U=;
        b=Ex0izr1Gmgc0kR2eSHmDpCNv9h5u4iwE2VYDIUQb8oxZROOWvj70ZVR8Y/TTulQPgk
         l0zEYzSIY+WzDH98w1dYIxUD3l1CkOqnDCV/2VXaa38UOuTjiMFSJ5vvAm9dFP5PgqrH
         3sjVAQK/st2amP32dk39tTknpcDnjDj3arguInvo4GMF1QEZAIR+F2OkMUf8dcrSxyby
         CcSEVjwvBT1+5vEzwAmSD+S9giJGRXKP4WVSmvOR5p/6SnHTxGHry2rqgYXZcxWUPtYF
         5vlSirjbF8CLYkPaE71fbzf2DmhwjZxayr09lm+mObKu2pKH4r1vQKcPrWX4HsS/j6hw
         jRNw==
X-Gm-Message-State: AOAM531M31f0Tksmd97nOMmqi9yKbh08lFP3wOIGs1thE91kXwYddRFX
        DnDiMpz+UBZ+dmgvrMy0c+y7LCsRau2qX64L
X-Google-Smtp-Source: ABdhPJxqyas0MEynpaSrfsaEfLR4Dw2Rhv/m+ZG1w/Op5bM6JIENsGe0bADD3LRy+bUWa3/ZvTrqsQ==
X-Received: by 2002:a17:90a:62c2:: with SMTP id k2mr5904693pjs.78.1602269291364;
        Fri, 09 Oct 2020 11:48:11 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id n67sm11148309pgn.14.2020.10.09.11.48.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Oct 2020 11:48:10 -0700 (PDT)
Subject: Re: [PATCH] ata: ahci: mvebu: Make SATA PHY optional for Armada 3720
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>,
        Andre Heider <a.heider@gmail.com>,
        Tomasz Maciej Nowak <tmn505@gmail.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201009084244.29156-1-pali@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7e60bd4f-46bf-cc13-0705-0431adc699c7@kernel.dk>
Date:   Fri, 9 Oct 2020 12:48:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009084244.29156-1-pali@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/20 2:42 AM, Pali Rohár wrote:
> Older ATF does not provide SMC call for SATA phy power on functionality and
> therefore initialization of ahci_mvebu is failing when older version of ATF
> is using. In this case phy_power_on() function returns -EOPNOTSUPP.
> 
> This patch adds a new hflag AHCI_HFLAG_IGN_NOTSUPP_POWER_ON which cause
> that ahci_platform_enable_phys() would ignore -EOPNOTSUPP errors from
> phy_power_on() call.
> 
> It fixes initialization of ahci_mvebu on Espressobin boards where is older
> Marvell's Arm Trusted Firmware without SMC call for SATA phy power.
> 
> This is regression introduced in commit 8e18c8e58da64 ("arm64: dts: marvell:
> armada-3720-espressobin: declare SATA PHY property") where SATA phy was
> defined and therefore ahci_platform_enable_phys() on Espressobin started
> failing.

Applied, thanks.

-- 
Jens Axboe

