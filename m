Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA102F8946
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 00:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbhAOXPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 18:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbhAOXPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 18:15:49 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF19C0613D3;
        Fri, 15 Jan 2021 15:15:08 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id p18so6950750pgm.11;
        Fri, 15 Jan 2021 15:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fsiTqch2n1LG6wIpcUlKM7XzDBMoXg4WvmIcHlnCVoM=;
        b=mbkJbCHivhvsvjWAq13VHiQSHbiE2+8f7mUBVeIys7KvfC1mKHwU+oV4iuNYflsgJI
         LJrqr1fnzhbAXUjly/5J2L2bx51SUuF4qUM4klJdtJT+mdcLp/vmfJMyj75XftjNUZ+X
         ncqQ93kO7xSMBnbWdQ8UeU9j+gdIkG2MaLHhGNGUhrj967Zjrk1wpImyPKiTPfsNOh9u
         qRYwx/fQrOrHubBQe0Pp5cQH+WD3gwiX0rvXPT6XaVDtD/wuFUayPn8T3GRkheYQ/krS
         /Hn+RzlvyS/a7dubvnNoeEaugNUbEAkfwamC6w/7zfv+zZxRC8dfqRkBA+4ljRnDy+Zo
         c3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fsiTqch2n1LG6wIpcUlKM7XzDBMoXg4WvmIcHlnCVoM=;
        b=YFFgG4WnyZJ0MUgISMajlbo0rnXn1qpUxzNRnyiQEkDaMAUoVkXae08HFc8/hFKTv7
         vxVr99Vox7qZ2teIdl7eWGGQIaN1mCg1g58Eamds8Sm2jvo1xhfBnmDBOkxx5JLEF/GR
         ClWQpFyVz/RE+I8n4ljqmULg7gFVo0wKVr3cfhHHKSoBhCcme8IJx/PTk3mq33L+sj/w
         Lp66xUFzmMcpjLLdVxoR5vDeKHO/w2whyW1Wrbb5n0um0cfb4XSS78lJj8fuzCksXQsG
         t+hQx26nLaB7NATResKZtXof0B0NCtgCVKBoJ7Jo6EmrRI2RMuA1mSjMlTxsgZ45YgXw
         Ofbw==
X-Gm-Message-State: AOAM530qcCKjxT98tYjfSK5aDyOn4xw11/phWBH1RmdO9GceY7Cvteiz
        Yl8OR/UymVvVWWAvF/zhZ8rkvb3PmCs=
X-Google-Smtp-Source: ABdhPJyxGO97R39+tIsSb6SDIbULamP4fV4cAqTmr6zuPmZxc+mQ0wr6pjITEVhDmhRlYJhFMSAFlg==
X-Received: by 2002:a62:ddcd:0:b029:1a6:99ff:a75e with SMTP id w196-20020a62ddcd0000b02901a699ffa75emr15237281pff.42.1610752508389;
        Fri, 15 Jan 2021 15:15:08 -0800 (PST)
Received: from [10.230.29.29] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u25sm9221445pfn.170.2021.01.15.15.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 15:15:07 -0800 (PST)
Subject: Re: [PATCH] usb: bdc: Remove the BDC PCI driver
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
References: <20210115213142.35003-1-alcooperx@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3a45bc02-9c6c-c065-e845-d57698bf724d@gmail.com>
Date:   Fri, 15 Jan 2021 15:15:05 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210115213142.35003-1-alcooperx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/15/2021 1:31 PM, Al Cooper wrote:
> The BDC PCI driver was only used for design verification with
> an PCI/FPGA board. The board no longer exists and is not in use
> anywhere. All instances of this core now exist as a memory mapped
> device on the platform bus.
> 
> NOTE: This only removes the PCI driver and does not remove the
> platform driver.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
