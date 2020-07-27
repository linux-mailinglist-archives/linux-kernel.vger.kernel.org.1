Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DE022F734
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 19:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbgG0R7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 13:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729969AbgG0R7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:59:08 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B001FC0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 10:59:08 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o1so8512593plk.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mFDUQmogg46Posu3w903aMyaH9JFMPS/SgmwZ4I8ccU=;
        b=I1T7nVAHC3vzto7UQ9hEUXPS9L7N6JIHGvzV+CxpjYgmTe+ds1sKddaNfOp5Lz3zFa
         gwq29Ta3R+Ik6gTSzyHZj/QZTNGF+3YjxvH/oCQsmR39XPWWUgXlruApbZuRv4+UO6m+
         F+qJsD58I3vBK2wxxeMXuf1z2fVrikDTjLjbR3nvBVLAacLbU8HVbI0K7jV8MOuA6Bxz
         4oT6R6utDcWVEFQn1fppwmwQNvzuhRptA2GEPRg7km6J4qyewnJSZB9xyCMkLRSxVBOr
         HSqr07ARxowQi2ya25mF7GPbk4Gk2mFcDQT0lHnrh3jPX2oUlHgOexqhi5yZie7+ZxLf
         N3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mFDUQmogg46Posu3w903aMyaH9JFMPS/SgmwZ4I8ccU=;
        b=bjUdUwia1GX5/LJq7AMuSqrbtmqJ93FC8LLMVISGaqHcJYfQOjMn/ZaZ7MgG9guH1S
         j1FsGiGhvlw06UBVxKkvN6XocsYdYgUQxMNWvHNB+3On9VlSDGykXE+4H83FttO9mgf4
         lMGY74nuxjPMPcTWmEgy6jpNHOQNFLsrkp/z1L7gepETlryYXybKffkbygq2dUQT4Th1
         p2qVIC8sAh1zug9z4DsaG2NDl+JmM4g7UauZ9bzkVH0+6h4cs3OdKx54wP0rU7I8Rjj5
         V70YFxj755u6L1lnGR1ahs5ItHKp/MhegMIzYtj87Ih/TOmTaXa4kIXiCfRlStywVse6
         ojVg==
X-Gm-Message-State: AOAM530cvNnp9D142+wBIx7sIClsz+TV7EV3LnvNYWN4t9Ebmzpr3yny
        Wvlems461+eZcBlS2J8WCw6ogA==
X-Google-Smtp-Source: ABdhPJxmYU88VTup/scAe1Pwy/mPgv3UJuWHJtQ3YU8xLR7QKaHQ2gI4MwOQdpbgduq0ybJfvL0uCg==
X-Received: by 2002:a17:90b:1116:: with SMTP id gi22mr495293pjb.8.1595872748151;
        Mon, 27 Jul 2020 10:59:08 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w70sm8378070pfc.98.2020.07.27.10.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 10:59:07 -0700 (PDT)
Subject: Re: [PATCH v2] ata: use generic power management
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200727173923.694872-1-vaibhavgupta40@gmail.com>
 <20200727174012.GA696265@gmail.com>
 <2b4738b0-5c2c-8ee2-83f9-10b961a5d0d3@kernel.dk>
 <20200727175119.GA700880@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <99b7cc57-1b4f-6c0b-00c6-08e22021c373@kernel.dk>
Date:   Mon, 27 Jul 2020 11:59:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727175119.GA700880@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/20 11:51 AM, Vaibhav Gupta wrote:
> On Mon, Jul 27, 2020 at 11:42:51AM -0600, Jens Axboe wrote:
>> On 7/27/20 11:40 AM, Vaibhav Gupta wrote:
>>> The patch is compile-tested only.
>>
>> Please test and verify actual functionality, if you're serious about
>> potentially getting this into the kernel.
>>
> Hello Jens,
> 
> Sadly I don't have the hardware. This upgrade is part of my Linux Kernel
> Mentorship Program project. Like other PCI drivers which I have updated, I could
> do compile-testing only. Though this patch covers 54 drivers but the actual
> change is done only in drivers/ata/libata-core. Since rest of the drivers
> make use of the same ata_pci_device_suspend/resume(), it was a chain reaction. I
> only had to change variable binding in "struct pci_driver" variable of dependent
> drivers.

That's understandable, but you should find at least some hardware (maybe remotely
accessible) to test this on. I'm not going to apply this without some confidence
that it actually works, and compile only testing is a far cry from that. Lots of
code compiles, but fails miserably at runtime.

While it's touching 54 drivers, at least basic coverage of the most popular
choices will give everybody some confidence that it works in general.

-- 
Jens Axboe

