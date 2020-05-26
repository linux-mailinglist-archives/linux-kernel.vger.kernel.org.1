Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762331D0AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 10:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbgEMIQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 04:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730127AbgEMIQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:16:36 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF27DC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 01:16:35 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l11so13773157wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 01:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=68iwW7UL5e+iBKHN9tLOFWom89CxDwBg9Pl7JVWSM4A=;
        b=iQxgcZlfMjQRPPSZ5uhlo40CDVFDwQDPhpCcdsYyHOfgi4n0ZaVS++9T0jRrzyRZ04
         fU6dl0Pen+0Z0PIn6Vx5xNs5Jl6MUspRHOuRbEMq7iEmLkbBRKDrKkhRyczBYPML//aq
         edMFxpqStGDfiV3UKCM3zyuQ57zUGb2xVAaec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=68iwW7UL5e+iBKHN9tLOFWom89CxDwBg9Pl7JVWSM4A=;
        b=YQqcIJxvaSGWlViPGFkclIOrrgSxtcdr/y4KSEOL1RaV265B828VVAeao1GG4hBmVR
         eXGBHuEsrNn9qyFaWYwjhvak5opmyT4mxonJ5Jbh9/QASkcVKEEoIj8pdCNunJtQOs5T
         jBkgnpvdM7Q3k+MQuZzE1FBe21i6jpFOaTv8MaoBhpdbZNHqUvNf6Kvq/yKzBzG+vYoa
         +Oo2faluErKkZv0bD8dMGV6XaC37w0xK8ILlLObbLRV7Cy3MRNXGVmcae3HDDwE+dAvU
         +BVZMqEeYeuWQ3xckmUpUVeUtotT9HuTaqqoJhWO6Md9KlIoFvnySty0OiWdQtp6Kgw2
         QoZw==
X-Gm-Message-State: AGi0PuZ8/ZKeslf8+sEw3MADuT3xIIWZKaYFuKTVWvVJY08igLCRG3M+
        pQLOolkfvkztxicTfd9SwnpKAA==
X-Google-Smtp-Source: APiQypIGGpDRAERxZPNv77vPASHntgpN+ldwaZOVqADykf4NdpezOORDz6NX3UgSVw9HxdlctxvzpQ==
X-Received: by 2002:adf:f5c4:: with SMTP id k4mr27137925wrp.23.1589357794549;
        Wed, 13 May 2020 01:16:34 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id j206sm25587279wmj.20.2020.05.13.01.16.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 01:16:33 -0700 (PDT)
Subject: Re: [PATCH v5 1/7] fs: introduce kernel_pread_file* support
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>
References: <20200508002739.19360-1-scott.branden@broadcom.com>
 <20200508002739.19360-2-scott.branden@broadcom.com>
 <20200513002741.GG11244@42.do-not-panic.com>
 <2e4bc125-5fe5-e3e5-4881-29374da942aa@broadcom.com>
 <20200513065133.GB764247@kroah.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <6f12fada-3ff6-e0f2-279a-20a2363c8881@broadcom.com>
Date:   Wed, 13 May 2020 01:16:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200513065133.GB764247@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-05-12 11:51 p.m., Greg Kroah-Hartman wrote:
> On Tue, May 12, 2020 at 11:23:27PM -0700, Scott Branden wrote:
>> Hi Luis,
>>
>> A few comments inline before I cleanup.
>>
>> We do not export symbols when there are no in-kernel users.
>>
>> Note: Existing kernel_read_file_from_path_initns is not used in the kernel.
>> Should we delete that as well?
> Probably, yes.
I found drivers/base/firmware_loader calls 
kernel_read_file_from_path_initns so EXPORT_SYMBOL_GPL can stay there.
> thanks,
>
> greg k-h

