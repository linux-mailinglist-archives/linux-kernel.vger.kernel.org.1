Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539972D8924
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 19:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407704AbgLLSTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 13:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgLLSTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 13:19:55 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AC5C0613D6
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 10:19:15 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id r4so6408229pls.11
        for <linux-kernel@vger.kernel.org>; Sat, 12 Dec 2020 10:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qnChcwX0lm3LKyBYeRwkUu/vih7wqjvXnMOF9i5s9ss=;
        b=nOtS/oKAT9H15+A9f8LiHEOoMM5F+W2dNuZUworyENwbdBwUcwmZUttVmJ6xa4Jupj
         MH19QlTgvTCFCC63jIJSYU5pn9dqq+jLvYxWcA37vtqzhP02T7qmEr/oXFiVwaFEahS5
         W4k6zxhcVuvpPU06MWnvvFPmcOgbu0lgX4D2PlaaH5o5TKgUmTN8U1FI99xpQP+L+WFD
         /ug0Gr8DJoVRc04UtF2exf8X+VZTph2k1XRYLskO66ISeM28yn3yQzPxr/lbG6hzH3x1
         KS0vVCdYT7IJ04w7gOX64NUbhudpzC7M5zavB+S13ti2DGX8Ja2d4i8NqKa+fiMrTZtV
         TBPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qnChcwX0lm3LKyBYeRwkUu/vih7wqjvXnMOF9i5s9ss=;
        b=DiZSIdl0dKcQGe5Ui10TnRS9V+g9zaVJyEp6Z6P5bQtDnqa8Ddzh/4EJngKUfi4qF9
         P3KUOu2KzciKKzGGKT6izq7pem1syRsOga2gUGhnQeXKlK7vUcvkoHnppYP4MJYhsi/7
         ngnt2VdMymtugfMY1ro8/tHZ4SQtVlvZbb6xBY3Y+mxSVwjjfGx6QrDfWz20XagDvElT
         Fe48qVXSzViIwA2I5ZwkTJ6Wv2jFQhmWxZHiexpIihkoPK6fuLYsfcu6PI6nH3UTjhvK
         LlIRdiGPONZZ1YuVLgBlNQILrgqW1qio/Cai1LqSxkzbChEj2H3UX06qZqdaYW3ye3HH
         Pisw==
X-Gm-Message-State: AOAM530VsW/6AGyHxdwwQb58XYCLHPXLtk3ndMT8bNfl3EBrq4VEC/Fj
        rI1ElID4DxslZJSEo0fJuLo53A==
X-Google-Smtp-Source: ABdhPJxwM+Jlx+7ltgeHPanU1z6OPWN7VzVA6bxKCusm42XE7aAIaOmxJGHXSuLcyw6j8RcvXrCzIA==
X-Received: by 2002:a17:902:10e:b029:d8:d11d:9613 with SMTP id 14-20020a170902010eb02900d8d11d9613mr10032047plb.26.1607797154683;
        Sat, 12 Dec 2020 10:19:14 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id p8sm14333425pjf.11.2020.12.12.10.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Dec 2020 10:19:13 -0800 (PST)
Subject: Re: [PATCH v3] block: drop dead assignments in loop_init()
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, kernel-janitors@vger.kernel.org
References: <20201212051302.26008-1-lukas.bulwahn@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c064e9b2-f366-a70e-2016-333be8f03334@kernel.dk>
Date:   Sat, 12 Dec 2020 11:19:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201212051302.26008-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/20 10:13 PM, Lukas Bulwahn wrote:
> Commit 8410d38c2552 ("loop: use __register_blkdev to allocate devices on
> demand") simplified loop_init(); so computing the range of the block region
> is not required anymore and can be dropped.
> 
> Drop dead assignments in loop_init().
> 
> As compilers will detect these unneeded assignments and optimize this,
> the resulting object code is identical before and after this change.
> 
> No functional change. No change in object code.

Applied, thanks.

-- 
Jens Axboe

