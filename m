Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B605A273DF7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 11:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgIVJEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 05:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIVJEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:04:01 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AF9C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 02:04:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so16186142wrm.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 02:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Wk8RB2FS8Tj/v9Bovq9laQuDvkZMp0w9HVmyCt+kdK4=;
        b=WVUIdMNdyGd0f56cdyukfhsTWf2NtFV1xZDWf/Im88CKA0TDJWxyLsrN3114p63pwt
         +Wn7JgmCAJHxPbueZ5KCRRZnluPppa53MR86ThoTnTtG+9leNtHg//PzUb3ucrwfiI/C
         CJdu8dUicv+ol8pXLLxuOolkYbz32W7usI3XQPBCdMQESWhqIAy1/GXvCGvsazGZ7vt3
         k19COHuoO5VUcvIejpHCn7aZ2liPM6VkOWSSA3E8Z0zvoAGVzOvw5NOgd/wAMjpS4a17
         Qas/uEZZ5Zo0uvb6sNJ1GCHxVCMpgHzsdVQ8qWW7pB3H1ZlO1S5EfTL6Qo22y5Ht2VVt
         wsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Wk8RB2FS8Tj/v9Bovq9laQuDvkZMp0w9HVmyCt+kdK4=;
        b=e3ApkokKhr3gOxVFEz8tKpJ567potAL96GZYSI3bzMnxCmUDmpHHWV3NPfim9C/Gmp
         LUM/62MCk/slIHwIHiugq5LUTiqBvihQDs8Ft3NUZ8BmQbG8XBV+fuc1lbD0X9gDGz2z
         CoYhU68D06SogHu7qhaxTRMa0jphC4p46VXJrrqJt4BvwAEnxqhWsdXZTzkbVcNbF/h9
         8Zrjt5CEytD+qszUtj7sboCSnA7v8LyGTDmu8KU49xgybqtjdlTvcahDthJik5e9cRqc
         x33+Dy7aTEYnjmGAsH8UxeLdP7g13mfuI6AsnXV1S9l2d0VdDInZ5/mIv0i7SQ6ZhBdf
         Pc6g==
X-Gm-Message-State: AOAM531hWUxngx/G/mXUKjn9uVIMOaXD2yxSj9HJeF4oFLhrerBIhrR5
        1lLO5rDRDtSPOdvbRvhv8+Xtki80+xxRyA==
X-Google-Smtp-Source: ABdhPJz42el5aodMJWwxi5xbLXIAGCmuaRdFSNJx0f4b1MTYLxQAatz4RcgWcb1WvrNEDmDV1yBu+g==
X-Received: by 2002:adf:a34b:: with SMTP id d11mr2555608wrb.7.1600765439317;
        Tue, 22 Sep 2020 02:03:59 -0700 (PDT)
Received: from dell ([91.110.221.219])
        by smtp.gmail.com with ESMTPSA id m18sm24976917wrx.58.2020.09.22.02.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 02:03:58 -0700 (PDT)
Date:   Tue, 22 Sep 2020 10:03:57 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     =?utf-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Questions about drivers/mfd/mfd-core.c
Message-ID: <20200922090357.GH4678@dell>
References: <989ff36ebc5746d69528ce05b660c777@realsil.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <989ff36ebc5746d69528ce05b660c777@realsil.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Sep 2020, 冯锐 wrote:

> Hi Jones,
> 
> I have a question about drivers/mfd/mfd-core.c and need your help.
> The driver in drivers/misc/cardreader/rtsx_pcr.c call 'mfd_add_devices' and 'mfd_remove_devices' in probe and remove functions
> Before Linus 5.9-rc1, the two functions can run properly, but in Linus 5.9-rc1 when I unplug the cardreader 'mfd_remove_devices' will lead to a kernel bug like below:

The problem should be fixed in Mainline.

Please upgrade your kernel to the latest -rc.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
