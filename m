Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD152E753E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 00:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgL2Xne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 18:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgL2Xnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 18:43:33 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 422CEC061799
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 15:42:53 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id w5so10147901pgj.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Dec 2020 15:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=q4Bj8R3CBvSLLqXZEXLAtLCkJF2/pgC4QbS3Flo515I=;
        b=fTTuZB7iU/GntjPlkOkOnWlss20rQLQ9sHuSinM6jGXWjrI/XIl2bE9MDwZc0HMmng
         c/5MpRxMYQcBv9tSJmRKUB6ZdknSOBVf8YpbhMobb2khk5HdD8I9zMS6jYJZXFY5lA1f
         mNUQdO2w5lcfL+q3Qy/syqG15KJQJow24ZELXVBo367bQEPRgGgQDF89y2mZ7WKq0iQ2
         lK3X4ZY7ELHnGKPGhhGUmzM3s2+dF99WOqap6H5LdlLtwRYXTBASVZpG9NgQwR1J7lwl
         vknzbe4iHWMxMxh1MMS/qPVm5xhjprbLEneTofPZdeCXAHkeUq8pU7LligkIzM0JA1rP
         ytsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q4Bj8R3CBvSLLqXZEXLAtLCkJF2/pgC4QbS3Flo515I=;
        b=d+Lo2wUmyOGJ9HnRBtvdnE8+vsMao+o1v3V1MjNtgPyVMDEn66U3Ydk9yJBnxHe9YM
         PW6eYAYeBE0lsw0IPHSIDnCaK9sf5j0kl+Ad/vAOA+/X6ZtXyU+VTrWkTyDPDTwfLzzY
         K42Dnr2nU/I3Tv2NyP0PFNpY4GCfpO84gfl7DSxgxsspuxliiNXMdvjqxedsK21LGZ8D
         981ppEBvL49WK8uSziCdRIS1VAIZhDu5V0OKZHDjV1+TJ8HEgEV/ibJOMEAMhQGj4quv
         YakFXMRe4ZCtHfjoYEffdLmvaHNKwysClJ96tHqQeQa4AYn/tbchyoYUexGWcdktkFwY
         K3xA==
X-Gm-Message-State: AOAM53017hnanOI0Wqv3HBXsv+Qqg4C58wnqdxv287aeygNheqKVy4x+
        hAe3BfDQ1Ns3NHoAZMjccvI2qA==
X-Google-Smtp-Source: ABdhPJzspcMDHWJuLnzSJYt8zopcP6WTzV7PbdwkVQnDnz5XY+EQYIwMMEmOpy3OVcMOhtvftKO/mg==
X-Received: by 2002:a62:5e44:0:b029:1a4:daae:e765 with SMTP id s65-20020a625e440000b02901a4daaee765mr46537636pfb.8.1609285372176;
        Tue, 29 Dec 2020 15:42:52 -0800 (PST)
Received: from ?IPv6:2603:8001:2900:d1ce:8f91:de2a:ac8a:800e? (2603-8001-2900-d1ce-8f91-de2a-ac8a-800e.res6.spectrum.com. [2603:8001:2900:d1ce:8f91:de2a:ac8a:800e])
        by smtp.gmail.com with ESMTPSA id t1sm14595051pfq.154.2020.12.29.15.42.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Dec 2020 15:42:51 -0800 (PST)
Subject: Re: [PATCH -next] aoe: Use kzalloc for allocating only one thing
To:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     justin@coraid.com
References: <20201229135120.23537-1-zhengyongjun3@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <da043bd3-8446-d0bc-bbbc-b3996afce4b8@kernel.dk>
Date:   Tue, 29 Dec 2020 16:42:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201229135120.23537-1-zhengyongjun3@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/20 6:51 AM, Zheng Yongjun wrote:
> Use kzalloc rather than kcalloc(1,...)
> 
> The semantic patch that makes this change is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> @@
> 
> - kcalloc(1,
> + kzalloc(
>           ...)
> // </smpl>

Should probably fix up that missing set of () while at it.

-- 
Jens Axboe

