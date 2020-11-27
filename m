Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2230F2C6DEB
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 01:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbgK1AVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 19:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731032AbgK0XcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 18:32:25 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7964CC0613D1;
        Fri, 27 Nov 2020 15:31:09 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id u10so2560234wmm.0;
        Fri, 27 Nov 2020 15:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=alM8Q2njg9OwW6Iyx+ETd8L6mtGNw6gcD2v5Jf5iUb4=;
        b=pHYa5byX4guCipmpaAwa5bGiFApZpE0i0ilJYouFdfZu45ciRmSLt01KdZjMKVMrfS
         sDXjTAVfHGCHH/MDDc18PznTdJxsPs1neZEiITfPX0zL557YEFLuOULfy/8vmUzwTdUk
         jIhEy6FU5Y1h/fz5qZbH6QU1FsVkqCZ0zEEKs566ulY7+VTEO3VX+vQulszeK0sHdGG1
         Dim4dRxEiWhI+FFX+WIwiE1ijS4AysWLteLHBXbgK4Ng3Ufl0WQHhfTzI7RTFAUI00Wh
         nACxHSFY2ubNlEMUhGHU6tseZ9pnTfySykksiPTtMZYTS7s/fYK4eB1E1oa9j9TdGKsd
         yXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=alM8Q2njg9OwW6Iyx+ETd8L6mtGNw6gcD2v5Jf5iUb4=;
        b=pbfMeRBbJefCp4M8G61JhlFJfFZfBrbhVQW6LJNhqFgYIF/tMSB3q1PdpDEOy5cY/F
         GfGEvIrj+qQUbG3cmgbFm5S2ML+UA629xQpcQvocSdTxmVDYoOmURPcYJQJFwwx1OJVx
         lPGQpKYBpsQn6rodfUED46zPTiUzCHzjqIPCa50FNoMhp2yI3ZzlOxpoyCcEjvS7yt53
         3S2dIFy3udTvMA54DM0OKe/MXNNHh+HVHqFS87H2kUY/cit2rCCh/+BS4ui0H1T1bCzZ
         AI5doNMf971ZHBypXiwD1ZSNDRCV+j077O+IAbTVYeaYqoMiXtPCH9DBjilHDJtgv6Iv
         2pJA==
X-Gm-Message-State: AOAM533komHpQs8L0tvMkR1bB4R4vcYNy3uCvel+MGY6YQxBLXgFbIHD
        QG5vHxZ4yL98zFDLsc5qNK0=
X-Google-Smtp-Source: ABdhPJyuID5dIKPZZQeVL9qAdblCudAB4aEcc6hTQC/271h9HuPtNvWw8Gmj4RK3tZ90EbOiU2vkgg==
X-Received: by 2002:a1c:6807:: with SMTP id d7mr5888750wmc.167.1606519867940;
        Fri, 27 Nov 2020 15:31:07 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id l23sm14232895wmh.40.2020.11.27.15.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 15:31:07 -0800 (PST)
Subject: Re: [PATCH v8] Add MediaTek MT6779 devapc driver
To:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>, wsd_upstream@mediatek.com
References: <1602732039-12179-1-git-send-email-neal.liu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <6ef61089-01c2-bea6-e2eb-958dbe43ef2b@gmail.com>
Date:   Sat, 28 Nov 2020 00:31:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1602732039-12179-1-git-send-email-neal.liu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/10/2020 05:20, Neal Liu wrote:
> These patch series introduce a MediaTek MT6779 devapc driver.
> 
> MediaTek bus fabric provides TrustZone security support and data protection to prevent slaves from being accessed by unexpected masters.
> The security violation is logged and sent to the processor for further analysis or countermeasures.
> 
> Any occurrence of security violation would raise an interrupt, and it will be handled by mtk-devapc driver.
> The violation information is printed in order to find the murderer.
> 

Now pushed to v5.10-next/soc

Thanks a lot!

> changes since v7:
> - fix VIO_MOD_TO_REG_IND calculation wrong problem.
> - revise parameter type of ISR.
> 
> changes since v6:
> - remove unnecessary mask/unmask module irq during ISR.
> 
> changes since v5:
> - remove redundant write reg operation.
> - use static variable of vio_dbgs instead.
> - add stop_devapc() if driver is removed.
> 
> changes since v4:
> - refactor data structure.
> - merge two simple functions into one.
> - refactor register setting to prevent too many function call overhead.
> 
> changes since v3:
> - revise violation handling flow to make it more easily to understand
>    hardware behavior.
> - add more comments to understand how hardware works.
> 
> changes since v2:
> - pass platform info through DT data.
> - remove unnecessary function.
> - remove slave_type because it always equals to 1 in current support SoC.
> - use vio_idx_num instread of list all devices' index.
> - add more comments to describe hardware behavior.
> 
> changes since v1:
> - move SoC specific part to DT data.
> - remove unnecessary boundary check.
> - remove unnecessary data type declaration.
> - use read_poll_timeout() instread of for loop polling.
> - revise coding style elegantly.
> 
> 
> *** BLURB HERE ***
> 
> Neal Liu (2):
>    dt-bindings: devapc: add bindings for mtk-devapc
>    soc: mediatek: add mt6779 devapc driver
> 
>   .../bindings/soc/mediatek/devapc.yaml         |  58 ++++
>   drivers/soc/mediatek/Kconfig                  |   9 +
>   drivers/soc/mediatek/Makefile                 |   1 +
>   drivers/soc/mediatek/mtk-devapc.c             | 308 ++++++++++++++++++
>   4 files changed, 376 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/soc/mediatek/devapc.yaml
>   create mode 100644 drivers/soc/mediatek/mtk-devapc.c
> 
