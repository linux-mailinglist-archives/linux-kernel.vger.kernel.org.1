Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABAC1D756F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 12:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgERKpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 May 2020 06:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgERKpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 06:45:01 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5636BC05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 03:45:00 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id l17so11263562wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 03:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hE6kxSlc/mEJ+YZKX8B1+sByxpuTTLbhqigf1AXAxVw=;
        b=hYc/PMH+QFxVF4H286qlDXrAO66M1kONtHWhqYKGHxITlJODYwexD7Xsjow3VJ1R1a
         cG/pRhf1ZghXtPCPbEJqHi9Qt1sLok0yTiFZmNxf4vP7ZdD2C6F4hvmVB6lC2AKGedaX
         wqgo18ftlCSOoCZJ2tjpT2gnrhEOVLab/ZxgKjAe4qT+f84bg0YehgHC2bP43GmaDM5h
         QNSpahnlU9Afm5EtPmBFTk3WWZku1PEx6iozm6zK2VmNqK5puae3YgeNYiQfVnvzfWXj
         ebS6GhnpqCC/oGgIDzOdqI+QJKFWRmdX1Iu/wHLI9s3PeEDbMSLcjxzZPU1zPzuBjgyv
         cKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hE6kxSlc/mEJ+YZKX8B1+sByxpuTTLbhqigf1AXAxVw=;
        b=qwzb6ewdmaCu5rvu2ZxCUn/+H1UcXGYWZukYIt8y+49N46PyAUKM1p5w0JJVc5n5Fj
         ialT4SzfEea6l0+P1+HBJrNT6Y3gxxisvW5IfdswdGmPvEuOVjMSf1em/Ly4LEJp4Ora
         uqOUaF1a04G7tGtWllW3MRKRGyX0IwENozqoS2VJX6nENhOEeoCy47fxptjlYfpgsCKK
         DF5oYQk4mrHf0Mah38Zro9LWZ4I3DqsQx65kdpiAuVYBS0jIkVakRK5e6Bo/jf9lo90D
         A0VyhJVi1xUbGi5Mdw2oV47CpL8x49gekt/4ZFyxfr3n6Mbm+QoQT+kVyKKuuCTGRedh
         IpqA==
X-Gm-Message-State: AOAM533VXS31C4G3SHeptelYb016fOxfKOmvLThDc4SaHzTIFay2jiDY
        q3LTJ03xVFUg/+H7lut3CTWfow==
X-Google-Smtp-Source: ABdhPJyUpwNXd+W7hZ5l15SAjS0pLYzR8jaVAG7t4kQ6hcKvL6QFGJkllPqOzijkj/oMuxAZcPfAYw==
X-Received: by 2002:adf:fa47:: with SMTP id y7mr18123438wrr.337.1589798698943;
        Mon, 18 May 2020 03:44:58 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id d6sm17201443wra.63.2020.05.18.03.44.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 03:44:58 -0700 (PDT)
Subject: Re: [RFC v1 2/3] drivers: nvmem: Add driver for QTI qfprom-efuse
 support
To:     "Ravi Kumar Bokka (Temp)" <rbokka@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org, dianders@chromium.org
References: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org>
 <1589307480-27508-3-git-send-email-rbokka@codeaurora.org>
 <ffaccce7-95c0-2f95-ad3b-55f1da42eaee@linaro.org>
 <14e1fa51-066c-6e1b-01a4-2103612de9e9@codeaurora.org>
 <d5902226-21b3-7941-6405-688d7a115142@linaro.org>
 <b80aaca0-0594-e04b-5320-b5b3c4478161@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d76e4eb2-fa6a-0b76-3912-83bce678bc96@linaro.org>
Date:   Mon, 18 May 2020 11:44:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b80aaca0-0594-e04b-5320-b5b3c4478161@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/05/2020 11:39, Ravi Kumar Bokka (Temp) wrote:
>>
> 
> Based on the compatible, do i need to separate probe function for 
> qfprom-efuse and maintain separate nvmem object to register nvmem 
> framework. Is this what you are suggesting to implementing this in to 
> one existing driver?

Yes for same driver we should add new compatible string and add support 
to this in existing qfprom driver.
Ideally we should allocate nvmem_config object at probe with different 
parameters based on compatible string.

> Do I need to maintain separate efuse dt node?

Not sure what you mean this w.r.t driver, but based on compatible string 
the device tree bindings might vary like clocks, regulators and so on.

--srini
> 
> Could you please suggest me to proceed further.
