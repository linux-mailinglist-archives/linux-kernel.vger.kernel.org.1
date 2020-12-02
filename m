Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 759772CBA16
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 11:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388560AbgLBKFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 05:05:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388535AbgLBKFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 05:05:21 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C001CC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 02:04:40 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id lt17so3079905ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 02:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k2wK+SflPRbjYVi77tMFczNFaefq/+v7eYCY6aqL0Dk=;
        b=bVO0rlUvIw1AdYtEvq7dl8VyY+qyie7H/qPxoruOvWHpd/77weF9FvlLWaD9YFfhgy
         QAOrQMvhAaApkQ4whj92STIDXdMQCyC+DZZV5hBUg4n/El62LpF6f6J3gSz9ORevu2wF
         i/TBCT02fWq2q47FXfhhPYhiJiRDtGyVFMHTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k2wK+SflPRbjYVi77tMFczNFaefq/+v7eYCY6aqL0Dk=;
        b=iz8P/kErqDmg/SpuQu0tHw7Fdt+5tHtoT5CwQ5BPNuVHCU1amuKRUHQMuCGy6N4RD+
         Mj4grj2MMQOW01Nj59bW9IKAEsTTMB9eNZg69AR2+t0cj/xOW8ZOt0DNz86cPuondWX/
         xqyUqf7LTe+3bzhG5gLTM7yZ8Ywt/VRaGAMp243M/PpeoN7nBv//Fxsu3yg9H8fcQUdj
         +7TblbPqdxjNEAdFKItY7LaHOIqZIuZZ50SkL0SR/LMSeB2mtvZlTqOGQLfQE5/+QLDy
         w0f7aP+W2Zq9Ab2FP4Sivgk+gMT383bfMWbFgTyTwtdLk3FA0g2M155VK21kYcIs+qhZ
         tMUQ==
X-Gm-Message-State: AOAM533RBw2DAR23SGfrAnf3P/Y70mm2qKDbV9VddvFxVQSOe4jx+5hp
        t2IUhqcBc/d/z22De9aov6FcDg==
X-Google-Smtp-Source: ABdhPJzpkAGir7ziC7QC+svpkAEpoRzlwaxlnYLvzym46j0cacf2e+dFT8ttvmImRsG9XVUvX213Zg==
X-Received: by 2002:a17:906:a1cb:: with SMTP id bx11mr1509253ejb.508.1606903479488;
        Wed, 02 Dec 2020 02:04:39 -0800 (PST)
Received: from [192.168.1.149] (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id pk19sm806705ejb.32.2020.12.02.02.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 02:04:38 -0800 (PST)
Subject: Re: [PATCH] lib/find_bit: Add find_prev_*_bit functions.
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yun Levi <ppbuk5246@gmail.com>
Cc:     dushistov@mail.ru, arnd@arndb.de, akpm@linux-foundation.org,
        gustavo@embeddedor.com, vilhelm.gray@gmail.com,
        richard.weiyang@linux.alibaba.com, joseph.qi@linux.alibaba.com,
        skalluru@marvell.com, yury.norov@gmail.com, jpoimboe@redhat.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <CAM7-yPQcmU3MM66oAHQ6kcEukPFgj074_h-S-S+O53Lrx2yeBg@mail.gmail.com>
 <20201202094717.GX4077@smile.fi.intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <c79b08e9-d36a-849e-d023-6fa155043aa9@rasmusvillemoes.dk>
Date:   Wed, 2 Dec 2020 11:04:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201202094717.GX4077@smile.fi.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2020 10.47, Andy Shevchenko wrote:
> On Wed, Dec 02, 2020 at 10:10:09AM +0900, Yun Levi wrote:
>> Inspired find_next_*bit function series, add find_prev_*_bit series.
>> I'm not sure whether it'll be used right now But, I add these functions
>> for future usage.
> 
> This patch has few issues:
> - it has more things than described (should be several patches instead)
> - new functionality can be split logically to couple or more pieces as well
> - it proposes functionality w/o user (dead code)

Yeah, the last point means it can't be applied - please submit it again
if and when you have an actual use case. And I'll add

- it lacks extension of the bitmap test module to cover the new
functions (that also wants to be a separate patch).

Rasmus
