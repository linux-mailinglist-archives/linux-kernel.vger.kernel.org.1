Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED862AB46B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 11:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbgKIKHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 05:07:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKIKHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 05:07:33 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01B2C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 02:07:31 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id h62so7358624wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 02:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WA6hvKE9VJojFQOzi9QEpYRT857z2U07FeG13Vkm4y0=;
        b=v1eQhOPuLvv6blbzGVB56oqqQICvaxSyKfVPwDu/whIjXbzF+6Z3Yz9d3xmhR9Zt3i
         +GxMaYQq4uglWuXeQPXQYNAXK7eXQ4soSggjqEaLAoM24ugAjDS813YTi4YJorCWeNLH
         sr1w+DiRFCryKmCJUAPvYV5j09B1Sho0yU6gaa1C8W/th76nHpl1nNewR0OX1oejHKmr
         zzs+Nbe+0keJXwpjjfyJ8LmW0s0ZFxpltmhh8bj+Ha+jZumZ0kpzRo2r7BuuW0Hte9cN
         5/z4RodIHOVZ3dzkDlQ+XwyaFUx+MzGMr3soi8wghwwKOBZEhTM9tce/rbTgR8H0B3C4
         xaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WA6hvKE9VJojFQOzi9QEpYRT857z2U07FeG13Vkm4y0=;
        b=iCJ6bZTGz1tGkC6KRAE0CrAWV5APvv9uTi1vWzl/m6qgEUPe4Buawo/tSLVZGUiQ+a
         EKFyIdzBaZ0F/C9aA6sbi/7E+2jHrJpSHMnN1X+B70q+rFkBPPbfsO7fJWrYq3acZxfv
         AWsBlDqYctvTurs7GuSoxB0EGOtPyCRANw9S0fwd0sgvWlYPse4sMshyNz6uOb+Z8dSA
         9GJiF9AF3f7MOwa1V9rn3OI3+Z2DLsUeIys9HuhBuq/YueCwVX1z9l/lct9yXCT8PY2k
         OlJtcwHSgXsdYKuFP9HV3VQ+nIOtJ+VBQi/JoflzenGEc+FawW3Lxd92KpXyBoamNDcA
         Uqzw==
X-Gm-Message-State: AOAM532yyNIpwjobuUHWODIIEWmQXYSHJ7C4ROV4wjIsol0jxaG6k3za
        OmUTFzHLovu/Dhg6CYmaCITvFzuyQg60AdGc
X-Google-Smtp-Source: ABdhPJxsbT0TdfPHOjOjCdO+rNmo/rLDcowmmWqxQcWEBQ/Jp48JlwJ3FR5FJ7pnbWslYwRp4BJMHw==
X-Received: by 2002:a1c:bcd6:: with SMTP id m205mr13307911wmf.47.1604916449257;
        Mon, 09 Nov 2020 02:07:29 -0800 (PST)
Received: from [192.168.1.12] ([194.35.116.160])
        by smtp.gmail.com with ESMTPSA id y63sm11692139wmg.28.2020.11.09.02.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 02:07:28 -0800 (PST)
Subject: Re: [PATCH bpf] tools: bpftool: Add missing close before bpftool net
 attach exit
To:     Wang Hai <wanghai38@huawei.com>, ast@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andrii@kernel.org, john.fastabend@gmail.com,
        kpsingh@chromium.org, toke@redhat.com, danieltimlee@gmail.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201109070410.65833-1-wanghai38@huawei.com>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <48e85eae-659b-9116-35c8-e4e01a8c05b6@isovalent.com>
Date:   Mon, 9 Nov 2020 10:07:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201109070410.65833-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2020 07:04, Wang Hai wrote:
> progfd is created by prog_parse_fd(), before 'bpftool net attach' exit,
> it should be closed.
> 
> Fixes: 04949ccc273e ("tools: bpftool: add net attach command to attach XDP on interface")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks!
Quentin
