Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDA126E304
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 19:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgIQR4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 13:56:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgIQRzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 13:55:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21698C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 10:55:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id v14so1601823pjd.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 10:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=ubb5DTI+VStVNf7vCLZGfulNZTbgJJzRYzc72+9jK9E=;
        b=ON4H+9Y8h3o8YE3iPqyfPP/sKdjVU6pm9VPHxQEHYlrLmEpE5niP6zABuP3bXIpcje
         Cc+Uk0/IX+bqEQZ2gGRi6yeo/50W0pBd8s44bnh6gbFvk0PoZYrt57DlExVTrGxS08lP
         vjVlih7n178dALzI4v2/bKVM6UfVWFxIe6G8YQO9eY5BeYSeXAkHnYwQupZ2aqpa2mwK
         QWdsnmMBEY1GC2kp5f1Iwu0H6p6swbAY6WKwldbmX9jl8gC+KJ9KHiVq/XYZZupBG2wv
         8u8Zmi8Tor3pcZyLTUc2y7cUWALrMCzBPQXtJm261sUqA7Miofw4BpwEYcCeHdeW3Mbh
         K76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=ubb5DTI+VStVNf7vCLZGfulNZTbgJJzRYzc72+9jK9E=;
        b=uUBZvKW89YUhO0p36oFY2HrPH7RWfS/GqAFsuscZo0gX05reMaBv0pDuNhfy1tPCAg
         j7+odwF+6L3PwHhbK80tEy/lzkev/GW+Z5TFqx62p4S8+s3wrx8gMzQ6Bic+JnAfRUv0
         TLePGtjCvn14O5V8pD3yfLvrEo/EXD17/qEtaDwbNHjVc69qHN59ts/5LrLjzB+bZKmv
         wHItHwRWMGv77D7oHZhaSLBhVtHg+4LqIBrcj+KpC2RebZ1eW5gLp7oZpjoKvnYP36G+
         NU9MavlWd5bY3ejwM1VqRC/AEWOdiL5KaO9g44P11RuPEXXUsgL0SEQ1QHbwa1YZstb/
         Oo2w==
X-Gm-Message-State: AOAM531vclpVTbfCzcy4yV6zYfPijy91LL4CKbAX2/DrZaNBpEEoumQk
        RHkCQHV7X9I2FToEfOGyz+/X1A==
X-Google-Smtp-Source: ABdhPJwsnHCwj1aJ+RtYHAqNUbG0c69lhV8xw3LT+lpTYldpRMG+j90Pd5X/FjCD+qYceDAAgFQaHA==
X-Received: by 2002:a17:90a:d514:: with SMTP id t20mr8857755pju.134.1600365320606;
        Thu, 17 Sep 2020 10:55:20 -0700 (PDT)
Received: from [10.209.126.152] ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id b29sm229896pgb.71.2020.09.17.10.55.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Sep 2020 10:55:19 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Bjorn Helgaas" <helgaas@kernel.org>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, qiuxu.zhuo@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 00/10] Add RCEC handling to PCI/AER
Date:   Thu, 17 Sep 2020 10:55:16 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <39F1C577-2486-43DC-BB65-1F6EDE02B217@intel.com>
In-Reply-To: <20200917173600.GA1706067@bjorn-Precision-5520>
References: <20200917173600.GA1706067@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Sep 2020, at 10:36, Bjorn Helgaas wrote:

> On Thu, Sep 17, 2020 at 09:25:38AM -0700, Sean V Kelley wrote:
>> Changes since v3 [1]:
>
> This series claims "V4 00/10", i.e., there should be this cover letter
> plus 10 patches, but I only got 3 patches.  I don't know if some got
> lost, or if only those 3 patches were updated, or what?  If it's the
> latter, it's too hard for me to collect the right versions of
> everything into a single series.
>
> Either way, can you resend the entire series as a V5?
>
> Bjorn

That's weird.  I can see all 10 got sent. There's something awry with 
the mailer as I got the copies.  You are right.  Lore only shows 3.  I 
will see if something happened with the smtp access.  Will resend as V5.

Thanks,

Sean
