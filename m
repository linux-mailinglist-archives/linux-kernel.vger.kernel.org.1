Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03E12730C1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgIURPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:15:30 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:44106 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbgIURP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 13:15:29 -0400
Received: by mail-ej1-f65.google.com with SMTP id r7so18781826ejs.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 10:15:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=rDEk8+qtgaTIgJcXNOfNBGVxcO9yDbgx91NGKXOIH1I=;
        b=Kp+jhz5CiWQQoXIvD2H16aDpp18FnXdzAzMWLrEQ+co28H2YvGHmdpUwpty8HxHCq8
         8+/7WIkWEFW8ZKtIfH8pRuQCMoMfuKXEOPVh6lOXLYn5WVF9/WfK185bOGiFFnrkyVNl
         V0V1n5pYIu6B/rdbIcRCwW72wcpbd5UM9TwKw2OOtoR1smN41sRfpfDqisQHBUTqJGSo
         /B63XF61UhEZcgD+mUA9mzw4XjgyQICavIAm4EYbgTNwj6qNx8yTzNAN2yh2N0MaKLUU
         0QFNumoPTVz1QE1AllWzZ3PyoYOdZEhiO/i+GRguTWyK88eYUrtCikM8CpfHjQeEjvUq
         wbmQ==
X-Gm-Message-State: AOAM531os49HjLKKNOTEg07AAlY/ZiLCVPx+NRsgtcmSXaPOAivlwZoh
        GguwaZh8sbcSpq+gN+B4O35wKE7mQ/I=
X-Google-Smtp-Source: ABdhPJwhexHNdqaetEprhV4BK2N5GD3vYButvSSBXuXUVq/Woaw13Uqu/Pe4huWmk7vTlYFZiv7neA==
X-Received: by 2002:a17:906:914b:: with SMTP id y11mr473315ejw.145.1600708526986;
        Mon, 21 Sep 2020 10:15:26 -0700 (PDT)
Received: from [10.10.2.174] (winnie.ispras.ru. [83.149.199.91])
        by smtp.gmail.com with ESMTPSA id n26sm9213862ejz.89.2020.09.21.10.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 10:15:26 -0700 (PDT)
Reply-To: efremov@linux.com
Subject: Re: [PATCH v7] coccinelle: api: add kfree_mismatch script
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
References: <20200605204237.85055-1-efremov@linux.com>
 <20200803183438.34685-1-efremov@linux.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <d6d3d1de-0394-64ae-bd66-2804e256fa8a@linux.com>
Date:   Mon, 21 Sep 2020 20:15:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200803183438.34685-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/3/20 9:34 PM, Denis Efremov wrote:
> Check that alloc and free types of functions match each other.

Julia, I've just send the patches to fix all the warnings emitted by the script.

[1] https://lore.kernel.org/patchwork/patch/1309731/
[2] https://lore.kernel.org/patchwork/patch/1309273/
[3] https://lore.kernel.org/patchwork/patch/1309275/

Other inconsistencies and bugs detected by this script:

1e814d630fd1 drm/amd/display: Use kfree() to free rgb_user in calculate_user_regamma_ramp()
842540075974 drm/amd/display: Use kvfree() to free coeff in build_regamma()
f5e383ac8b58 iommu/pamu: Use kzfree() in fsl_pamu_probe()
360000b26e37 net/mlx5: Use kfree(ft->g) in arfs_create_groups()
114427b8927a drm/panfrost: Use kvfree() to free bo->sgts
742532d11d83 f2fs: use kfree() instead of kvfree() to free superblock data
47a357de2b6b net/mlx5: DR, Fix freeing in dr_create_rc_qp()
a8c73c1a614f io_uring: use kvfree() in io_sqe_buffer_register()
7f89cc07d22a cxgb4: Use kfree() instead kvfree() where appropriate
bb2359f4dbe9 bpf: Change kvfree to kfree in generic_map_lookup_batch()


> Changes in v2:
>  - Lines are limited to 80 characters where possible
>  - Confidence changed from High to Medium because of 
>    fs/btrfs/send.c:1119 false-positive
>  - __vmalloc_area_node() explicitly excluded from analysis
>    instead of !(file in "mm/vmalloc.c") condition
> Changes in v3:
>  - prints style in org && report modes changed for python2
> Changes in v4:
>  - missing msg argument to print_todo fixed
> Changes in v5:
>  - fix position p in kfree rule
>  - move @kok and @v positions in choice rule after the arguments
>  - remove kvmalloc suggestions
> Changes in v6:
>  - more asterisks added in context mode
>  - second @kok added to the choice rule
> Changes in v7:
>  - file renamed to kfree_mismatch.cocci
>  - python function relevant() removed
>  - additional rule for filtering free positions added
>  - btrfs false-positive fixed
>  - confidence level changed to high
>  - kvfree_switch rule added
>  - names for position variables changed to @a (alloc) and @f (free)

Is there something I can improve in this cocci script to be accepted?

Thanks,
Denis
