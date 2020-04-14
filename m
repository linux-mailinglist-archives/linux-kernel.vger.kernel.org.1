Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B761A7AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 14:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501945AbgDNM1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 08:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2501933AbgDNM1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 08:27:39 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC53C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:27:38 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id i19so12937331ioh.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 05:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xn8/ZRFExSMKU2UJG3B6HUEv5uOUwoceNajhHRuX6V0=;
        b=L8rBoWwiY/GOC81qGixrT5zatrTvrh+T0u2I/lyH02NoT6c5clc8grzAYBiIUZ1Toc
         HUZ2sL7IK7OFmqIPG2nCDan618rLX1ERrpB0179fm/1uoX+XpZm5VdPnkJenUo9YubHm
         hogsN7DydnqEAXT9SAEmHVJ+jNfuQUPbn5Y5VutJVmd4RgY+iwt6QZJYRA6t0yt7ZhQj
         EYkn+r/q1J3RWoTJ37KdklxA2G2dWYGZnY3G7wWjdaLzw/M5/9OQO6Zwr/sMuhPPHRLB
         neanrnVNGNoEIG34PFeVmiq0s9SxP0hBDXVo2eUvvGOzRnL/C3ttJggh4psN7YIHNQDO
         LVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xn8/ZRFExSMKU2UJG3B6HUEv5uOUwoceNajhHRuX6V0=;
        b=GBWZAMSmup/3ld8FsaoxiB0eU7iL/HhyaTdXjAUwHuTTP8WuiB5Oe3I+btpkNGMLpO
         gqITA8PihoxNxDRV6s20MJwfwIbeiWCjkBFOHSFNDh326SWheYqHolamniDSQx2RT6K3
         L6CGaBkPzoj1bF4Tytw5pdVw1SC4Ndqjts9+p+zzV/2HDTnUXTIoVzvompPoXU/j5yAb
         6zwZ2yox7IiRrqDyhgiqm/Png9yj2pE5ymTsuemDV//mii3345bELSZkwjJvQEqJD2v7
         LY5JkHRC85Ya7gJgGUsdJYaHHu51aj7x+3ovIj/ZgKarb1PqzaLzOHZTxCSltTlEYS/M
         CexQ==
X-Gm-Message-State: AGi0PuYDA4HQxLo+dB5Qyi6VQEA16uUigr3V0etVx0K+WqgrSUZ2chGb
        nx2SdwPLtY/B44Utkr8nqmy75g==
X-Google-Smtp-Source: APiQypJPkNYzInmS2MYdSfh5zb7ZMT1+nhzriatmUZIlwuRMjkmgVtkGbSJHY7hD/WGF+tS+04xaYA==
X-Received: by 2002:a6b:fc0d:: with SMTP id r13mr20547117ioh.89.1586867257797;
        Tue, 14 Apr 2020 05:27:37 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id r10sm4346744iom.42.2020.04.14.05.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 05:27:37 -0700 (PDT)
Subject: Re: [PATCH 4/4] remoteproc: Get rid of tedious error path
To:     Markus Elfring <Markus.Elfring@web.de>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-remoteproc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, Suman Anna <s-anna@ti.com>
References: <e5e03d6b-46bd-5ece-a7f6-3cb557c3b0b0@web.de>
From:   Alex Elder <elder@linaro.org>
Message-ID: <3c2ea363-e60f-b3ef-e66f-df8d558972bf@linaro.org>
Date:   Tue, 14 Apr 2020 07:27:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e5e03d6b-46bd-5ece-a7f6-3cb557c3b0b0@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/20 3:53 AM, Markus Elfring wrote:
> …
>> +++ b/drivers/remoteproc/remoteproc_core.c
> …
>> @@ -2105,11 +2104,8 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
> …
>> +out:
>> +	put_device(&rproc->dev);
> 
> How do you think about to use the label “put_device”?

+1

> 
> Regards,
> Markus
> 

