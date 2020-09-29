Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BB727D0B9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgI2ONF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgI2ONF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:13:05 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E2DC0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 07:13:05 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y74so4912360iof.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 07:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pIqAOqrn6h0sWTOG6HQcdrGe1pJQq2qqrnbCVqbIgK8=;
        b=ewHwiI493jKey9fnPfl//AmXDX3kVu2s6HJz1Vb9Hu7z26kP0rDDqWys9IU7lcNE/k
         JFHIG/W9k5nNwlEs/Wnw3qvTnuxuiI37gYGYowcIV6OR9eN+HLF5xx2vtMOR1d5t7ruA
         2iVl4x/jzPtSh79NtDTrreBP8eCKty6KM4FLSf4zjvQKu3dIeZ6Zo3r//G5iMPbpZyJ4
         Nmtd2028l9Dcxz8RUS+xiA1WV/iGQnd90OZLTtYvOLi1BXCVqyIlTLm/gzC0hTe5QKF9
         mE5TC/xgZUtBWF3GeeKLmG8i85jts+BLh5mhgtciEtvHNT3wz08PEdagNVdzVRChRkLo
         218A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pIqAOqrn6h0sWTOG6HQcdrGe1pJQq2qqrnbCVqbIgK8=;
        b=GKwhATd1wTZs/ntWVsL/F6ljoH1UtvTUyI4vwEMBbE2NEtavmMsUqbCfEmMwrK7Heb
         k4e97gLdGKi1OMAFWM3y7Mzn1DgJz70orrD00vdJSqUciMgMDkZYqIOzkQ6q0gPwwks7
         BkZ7TZ8T0bWtg20pX4BNcB5ZBFmdZJXfWA9q04/fToN/z1ZmqtpbIZDMqr9NY0SLUFcI
         IJPzOpBJqlxoBvk3agPC1SV7lCKXefCs9wBnzvPRTABp/IfMz3qo7KqiaYe/NjZTwubY
         Z5vIhMd+kOMXlSIo+catOpg0CyDzhLMbazt7B3gdPtNyfs7cvSQo/4dVOuJkPNtQxKlq
         444Q==
X-Gm-Message-State: AOAM531Y1t32JlMX8/sh4Mv8/dxocys3KIbF/10mQ9JwbUAOvAoBdDAs
        Q3X2qksW5VJ3pGOnKvoO77dzJfMpZPdeog==
X-Google-Smtp-Source: ABdhPJxQPOLCOgpVlhV5WKBv4IpAqB78vNhpqOcppe1fOObbXJynagNpVFBnb2oq44Wxf0zr3YAFjw==
X-Received: by 2002:a5d:8b4a:: with SMTP id c10mr2629435iot.143.1601388784174;
        Tue, 29 Sep 2020 07:13:04 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id l6sm2406115ilo.21.2020.09.29.07.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2020 07:13:03 -0700 (PDT)
Subject: Re: [PATCH v3] null_blk: add support for max open/active zone limit
 for zoned devices
To:     Niklas Cassel <niklas.cassel@wdc.com>
Cc:     damien.lemoal@wdc.com, johannes.thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200828105400.80893-1-niklas.cassel@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ea94a097-c5c1-1996-3398-a08d64503941@kernel.dk>
Date:   Tue, 29 Sep 2020 08:13:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828105400.80893-1-niklas.cassel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/20 4:54 AM, Niklas Cassel wrote:
> Add support for user space to set a max open zone and a max active zone
> limit via configfs. By default, the default values are 0 == no limit.
> 
> Call the block layer API functions used for exposing the configured
> limits to sysfs.
> 
> Add accounting in null_blk_zoned so that these new limits are respected.
> Performing an operation that would exceed these limits results in a
> standard I/O error.
> 
> A max open zone limit exists in the ZBC standard.
> While null_blk_zoned is used to test the Zoned Block Device model in
> Linux, when it comes to differences between ZBC and ZNS, null_blk_zoned
> mostly follows ZBC.
> 
> Therefore, implement the manage open zone resources function from ZBC,
> but additionally add support for max active zones.
> This enables user space not only to test against a device with an open
> zone limit, but also to test against a device with an active zone limit.

Applied, thanks.

-- 
Jens Axboe

