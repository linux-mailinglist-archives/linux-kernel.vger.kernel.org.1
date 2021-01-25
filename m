Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374FE302844
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 17:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbhAYQzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 11:55:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53313 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728716AbhAYQxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 11:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611593532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hi3/EhTCQKXByshBpUGZW/lVojHvkwr5VvXoIisBL5U=;
        b=XuPxQsVoNYHiwLKmScN8iO8so6EluwNh5onBZl4IeSUYSUAFcLSwFCVkFKQb9NRumhC5+K
        Qe3oupSMuXIH0WNFaZunLnzAQAwUWjICQ6lnILm3e0PVAzwCDOCUAG/nTS7xwQAfqoLOUU
        4MWFH/RjrkcgeFOkYGl4MHU02Eh7CT4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15--GlEk7GYPKqJH7ljFK5B7w-1; Mon, 25 Jan 2021 11:52:09 -0500
X-MC-Unique: -GlEk7GYPKqJH7ljFK5B7w-1
Received: by mail-qk1-f199.google.com with SMTP id l124so2985421qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 08:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=hi3/EhTCQKXByshBpUGZW/lVojHvkwr5VvXoIisBL5U=;
        b=p5J7ADKjJpxloEaTuu8yH+Yx22rJrK6YveW0gL7eUjhiZ/2txKDtyJ0pvE+Kj9xYVg
         WF2xp5PZIfI/n3Ov5IiXoU4McrbP5mEixcEkeDmqhOouzZLKpMTdJVgyETDj0Bl3RDLX
         VTXzs1qZV9dq0gCJr1z7UkP8G8SFPGfrCxE9oYqx4EB0uifs6+o8V6/JIcZ+4YeieYtw
         Q8QThR5UOEipoFk1JoFVqh/RJS6WO01a2wAXAWNLMjnQ04X2CDS1FOUwSZjpB9X1Q2Ga
         lvtN+nOoDk6T3LLryah48WGVP3iXxxQJtca0+oLPwfUBGmWFVp735KiA3sT2M6xg7uBW
         OX6g==
X-Gm-Message-State: AOAM533ZhJIi++ZV3FHFw3Pb7yRfUttFc05uKVq74pMUnhDkiu+T7smv
        NgRQfJeDW2+KkuktRBV2CL2ZKUMtZ1nZmFtTIChVA9O/Hh5BCHVuCkabcFFJQo8D97cKKazCxmG
        3scskVd6fE7aFz+nmop2sWJV3
X-Received: by 2002:a05:620a:113a:: with SMTP id p26mr1604854qkk.154.1611593529481;
        Mon, 25 Jan 2021 08:52:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwso6b56EVKYW8JYdR6aANSc7NfyrSGapb0gTEHggrInKpFi/oSMMAdoyhVrqVTSFF5DtqH4Q==
X-Received: by 2002:a05:620a:113a:: with SMTP id p26mr1604844qkk.154.1611593529327;
        Mon, 25 Jan 2021 08:52:09 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y67sm12355083qka.68.2021.01.25.08.52.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 08:52:08 -0800 (PST)
Subject: Re: [PATCH v9 2/2] Documentation: fpga: dfl: Add description for DFL
 UIO support
To:     Xu Yilun <yilun.xu@intel.com>, gregkh@linuxfoundation.org,
        mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     lgoncalv@redhat.com, hao.wu@intel.com
References: <1611564563-9665-1-git-send-email-yilun.xu@intel.com>
 <1611564563-9665-3-git-send-email-yilun.xu@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3d7fa820-119c-9887-6bc1-7eba683acec0@redhat.com>
Date:   Mon, 25 Jan 2021 08:52:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1611564563-9665-3-git-send-email-yilun.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/21 12:49 AM, Xu Yilun wrote:
> This patch adds description for UIO support for dfl devices on DFL
> bus.
>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> ---
> v2: no doc in v1, add it for v2.
> v3: some documentation fixes.
> v4: documentation change since the driver matching is changed.
> v5: no change.
> v6: improve the title of the userspace driver support section.
>     some word improvement.
> v7: rebased to next-20210119
> v8: some doc fixes.
> v9: some doc change since we switch to the driver in drivers/uio.
> ---
>  Documentation/fpga/dfl.rst | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

This looks fine.

Reviewed-by: Tom Rix <trix@redhat.com>


