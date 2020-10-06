Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4075928436A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 02:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgJFAjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 20:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgJFAjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 20:39:01 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A4DC0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 17:39:00 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id p21so715779pju.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 17:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ccHRaFq+ZAlHmnxc9ccMtnL9e9SHKBcvTvEy6o8JQnU=;
        b=cwFnvlNuuxDNi8ZaOLpl7cLSiHlSTJzsGJULkdn+T4lS/6ELbS1j7X06gHDAwJ6jBm
         jbagL0RVmGJVV8Au5/qAoSaJOT22sgVo/RayUALPSCPK3H2ednLhD9qVfUMb1RZzEHrG
         SyBW+Wk88BYZXCCCwdcpGwzy0JMNbhBHmxpbPwbx10E1BSyFKZD8svSbEPMZlTyAEnfM
         bKUqaFuD/LErFQmHDbM2ha+9GRQ/ttwdWyjK/t9TCyTvCLBIrQsjo0c7N5qfbRkwq0sx
         rc81/CAge8Pv1b+t841C6F0hSvYSXWm1S+gDtpxAq448xe7uC+XcVdKYGIQg/0Y7y1JT
         o+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ccHRaFq+ZAlHmnxc9ccMtnL9e9SHKBcvTvEy6o8JQnU=;
        b=YBBZ5b01k+3utUJ91QQ4rxSd8J7Qmy1nwP4ut0nP1Y/ZQHEZH4VCVg+SWMQH6UYKTF
         7QEuFkO48DsaxMeMfW3GIH4zunmsfL4oVOY7EZv/3kmOUyxh4iQECoA2JkVuQvqwd2O+
         zgGwt5Mhg6Y7Crofq389W9crwd2WEDkqvWcoXh7USfAeY+XQJU7yGy5/X+sonXTpc7lO
         IeDvKmv2Z+XB5XDtUMCWJ5coamd5R1I/XuZSxP83j1Et1juG9THtLrM1XoQAv8mJlK+Z
         nRL4WqSzI9TjbNm/AGoFuDMRLIBnpCbTFaZZOdSSPPL6yT2X7h9ROz8TbZASpyRuH5ab
         vejA==
X-Gm-Message-State: AOAM531rmSjkfdd4WAjmsWGlTRfQIRBo0SztmRqUpXiBVhZX1jgIsnyg
        8tgqRqnCdd3HQcMf3GdvaxI=
X-Google-Smtp-Source: ABdhPJxL+84Awi1wiby1oOua19UOrjF1+qtS7MxRWz6/ueD36rUA5IoNkRlNn6+0p4gKyP99mpHB1w==
X-Received: by 2002:a17:90b:149:: with SMTP id em9mr1781466pjb.129.1601944740152;
        Mon, 05 Oct 2020 17:39:00 -0700 (PDT)
Received: from [10.230.29.112] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g129sm1235855pfb.9.2020.10.05.17.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2020 17:38:59 -0700 (PDT)
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     robh@kernel.org, satyakim@qti.qualcomm.com, sudeep.holla@arm.com,
        broonie@kernel.org, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, etienne.carriere@linaro.org,
        lukasz.luba@arm.com
References: <20201005222623.1123-1-cristian.marussi@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 0/4] Add support for SCMIv3.0 Voltage Domain Protocol and
 SCMI-Regulator
Message-ID: <8483165a-e413-b2f8-bd33-6da07fe56d62@gmail.com>
Date:   Mon, 5 Oct 2020 17:38:52 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201005222623.1123-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/2020 3:26 PM, Cristian Marussi wrote:
> Hi,
> 
> this series introduces the support for the new SCMI Voltage Domain Protocol
> defined by the upcoming SCMIv3.0 specification, whose BETA release is
> available at [1].
> 
> Afterwards, a new generic SCMI Regulator driver is developed on top of the
> new SCMI VD Protocol.
> 
> The series is currently based on for-next/scmi [2] on top of:
> 
> commit 66d90f6ecee7 ("firmware: arm_scmi: Enable building as a single
> 		     module")
> 
> Any feedback welcome,

Well, this is just great! We were right about to develop a proprietary 
SCMI protocol in order to control a locked down PMIC accessible behind a 
secured firmware. We would have done essentially just that since the use 
case is to control the various regulators exposed by this PMIC over 
SCMI. Thanks a lot!

> 
> Thanks,
> 
> Cristian
> 
> [1]:https://developer.arm.com/documentation/den0056/c/
> [2]:https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi
> 
> 
> Cristian Marussi (4):
>    firmware: arm_scmi: Add Voltage Domain Support
>    firmware: arm_scmi: add SCMI Voltage Domain devname
>    regulator: add SCMI driver
>    dt-bindings: arm: add support for SCMI Regulators
> 
>   .../devicetree/bindings/arm/arm,scmi.txt      |  44 ++
>   drivers/firmware/arm_scmi/Makefile            |   2 +-
>   drivers/firmware/arm_scmi/common.h            |   1 +
>   drivers/firmware/arm_scmi/driver.c            |   3 +
>   drivers/firmware/arm_scmi/voltage.c           | 378 ++++++++++++++
>   drivers/regulator/Kconfig                     |   9 +
>   drivers/regulator/Makefile                    |   1 +
>   drivers/regulator/scmi-regulator.c            | 488 ++++++++++++++++++
>   include/linux/scmi_protocol.h                 |  64 +++
>   9 files changed, 989 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/firmware/arm_scmi/voltage.c
>   create mode 100644 drivers/regulator/scmi-regulator.c
> 

-- 
Florian
