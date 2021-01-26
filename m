Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EBC304F94
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235161AbhA0DPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405293AbhAZUJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:09:49 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20E1C061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:09:08 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id i7so12166134pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=RFzsjs73B5QGolUY36etsSHceLP09/8jna6hDkWinoI=;
        b=NHT3FZZp9joO/4A2cIe+S9vs9lbh0VEwMmGIlFcM997cgIKdCTtbDRMw4vIA8MMDdf
         6jcCKXxlNPkYB8uu8Hy+MaYzrcgk3VKsx2mI9hjgdhZe72QkNP4jUkynGfyhyI0ITftK
         227BFngVq9IP8Wgi0ugTfmuPU4FVdvPhokdvsmjWzu+T+fPoJBlhy3Q4n2tsleUiNta0
         6Py2C+w367MVGvQRkucb6NNdksabAslf+2p+oOiyJiF/FNPG7ExQ4vVuqt63u+NqL3H4
         XatCkFDYUoDc2dcuDuNyVZTYgSwbubVLj78PUT9GqcK99Vh7sUSCVekPcyShTy7JHGpC
         F+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RFzsjs73B5QGolUY36etsSHceLP09/8jna6hDkWinoI=;
        b=V07rocvBSvGBAGZeC3GwtMNeRDM0PEpJln9ANlep9QmFKgu56Y/DeVpZw+FKS2Xxqh
         /g+pqpSSazzH3NttHcmiC9j0jTGsbVMobfm0uTj/B9WVi9ThYQVyzzOuJNCetX97ws/T
         mIknPArUkuLH5L7+umlthSZ8xiAgEC6aSUFdurCg4Ev7ql2kMM9LP6RIbuW12V3B5OzE
         ZdxDX8ar2a0SBjY9r9g8gYDS2PMdzefewKPCbiyzkopu2rgCkGD7575hSChXqym70qPa
         2imOpYY1v2ptzte0jLh3f2eiHjgpi8PM4uB/9H8VrH1W3omjp0i1kUVGWySUdPu2gv2e
         /aww==
X-Gm-Message-State: AOAM530HW9TZGXAkCV2jSXyaUtroDqmsOMCuWu+GqH3Bm8xsyU0VrUgK
        apAbPxgD3CyZj1M7OoOTKzK29g==
X-Google-Smtp-Source: ABdhPJz8CuV4Pt+g2YOn4X6fah7MOajq5qzAEUxnHyOT2+pUQj854HVAxAZIErQWr8QR9q0WtpBfNw==
X-Received: by 2002:a62:380a:0:b029:1a9:5aa1:6d0d with SMTP id f10-20020a62380a0000b02901a95aa16d0dmr6617617pfa.45.1611691748448;
        Tue, 26 Jan 2021 12:09:08 -0800 (PST)
Received: from [192.168.4.41] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id u126sm18970542pfu.113.2021.01.26.12.09.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 12:09:07 -0800 (PST)
Subject: Re: [PATCH v4 1/1] loop: scale loop device by introducing per device
 lock
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        tyhicks@linux.microsoft.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, sashal@kernel.org, jmorris@namei.org,
        lukas.bulwahn@gmail.com, hch@lst.de, pvorel@suse.cz,
        ming.lei@redhat.com, mzxreary@0pointer.de, mcgrof@kernel.org,
        zhengbin13@huawei.com, maco@android.com, colin.king@canonical.com,
        evgreen@chromium.org
References: <20210126144630.230714-1-pasha.tatashin@soleen.com>
 <20210126144630.230714-2-pasha.tatashin@soleen.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <daf21294-f51e-3f03-8a46-d0181104d9e3@kernel.dk>
Date:   Tue, 26 Jan 2021 13:09:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210126144630.230714-2-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/26/21 7:46 AM, Pavel Tatashin wrote:
> Currently, loop device has only one global lock: loop_ctl_mutex.
> 
> This becomes hot in scenarios where many loop devices are used.
> 
> Scale it by introducing per-device lock: lo_mutex that protects
> modifications of all fields in struct loop_device.
> 
> Keep loop_ctl_mutex to protect global data: loop_index_idr, loop_lookup,
> loop_add.
> 
> The new lock ordering requirement is that loop_ctl_mutex must be taken
> before lo_mutex.

Applied, thanks.

-- 
Jens Axboe

