Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D2B2DCD07
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 08:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgLQHmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 02:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgLQHmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 02:42:46 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A040C061794
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 23:42:05 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id o19so29313835lfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 23:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TWzHdyMfc0thY5qkjgUIgtxlJpXx+ozEUZmoTQ+ig14=;
        b=naSuP99ytzw3v3MSWnPwWl/cQ2eBIEyTX3UfovKp7yGGybv45FyW14ol8oPypiqyFa
         IDRU+UO4PnZg7gs6KZ1qjv0MiDuKNqapooOEA9neTyT5qzhXoXVgHKPKQcgFeT3S48yA
         YI3n2i/ydfCeckTFmIpfQF2xIRUIIyEfUB3CYx7ypqLxK19XuDxJc0z+GF4c/eGNbrBI
         HaXLMt0JrPOLuemsuBgikr9jlqjEMuabzlPMBvGICzd725rb8VZ8mr6mRoUn0uqL0O1J
         sPN4lK/sRETvFReW3GszDEIxzHyuMyPGe6H1dq8oGZpGiUGYvkqIxMevOPcGFR6cr1n3
         7YyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TWzHdyMfc0thY5qkjgUIgtxlJpXx+ozEUZmoTQ+ig14=;
        b=J23U3J8g3dvJVnH4+MAtulIK8q0cFhKX2CgyDbTSDGApEDKCDfVpfpGbFpWpx2jtCy
         Ce8z6Y9imLSoIr3k8PoimyW6QqLIjKxSdBqQepTUfz4nJ/u3poK6Z2MW0uJeXR2ugOzd
         L3oZNnHD3SI1jfCRD4H/YYpPSKwK0HQayQsG6PBkHwcum3uTVdGlcUyVUeE3mqI8yag9
         iNOMJ7MYJ1Sj4jxfUfrHADIf7BeAkVvBcdie5gXDRYWsvSI3boUwdfYd4g9uMue8Dz7w
         DyX/GXFzp70hzTpJ4B26sxureCyZ5UDS6MZBsadQVVTw9Z0k/bg/NIuvV2TxCUHDvMrD
         MPJg==
X-Gm-Message-State: AOAM533NDEj8JA13RmPxVRQVyxKZTRq4YQN6+gPN4HCkPcW/5rtP3Z8M
        EbU8aKHZ+SFvfVW7dBiO0j0=
X-Google-Smtp-Source: ABdhPJyMJaPOJPFpKWocox8it+6OzUQ4gV4xNYHIyKLuVC9NJtKwlct3vTd9NXmqNWBIggi2Qx6kcw==
X-Received: by 2002:a05:6512:248:: with SMTP id b8mr9749590lfo.371.1608190923996;
        Wed, 16 Dec 2020 23:42:03 -0800 (PST)
Received: from grain.localdomain ([5.18.199.94])
        by smtp.gmail.com with ESMTPSA id o21sm495160lfc.153.2020.12.16.23.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 23:42:03 -0800 (PST)
Received: by grain.localdomain (Postfix, from userid 1000)
        id 248B61A020B; Thu, 17 Dec 2020 10:42:02 +0300 (MSK)
Date:   Thu, 17 Dec 2020 10:42:02 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, mkoutny@suse.com,
        ktkhai@virtuozzo.com
Subject: Re: brk checks in PR_SET_MM code
Message-ID: <20201217074202.GD14556@grain>
References: <CABV8kRwoHAAdez8k60O+AJ9E3g5_PM0F6tpbpB9dC115_FD3Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABV8kRwoHAAdez8k60O+AJ9E3g5_PM0F6tpbpB9dC115_FD3Eg@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 08:29:30PM -0500, Keno Fischer wrote:
> Hi all,
> 
> The code in prctl(PR_SET_MM, ...) performs a number of sanity checks,
> among them
> 
> ```
> /*
>  * @brk should be after @end_data in traditional maps.
>  */
> if (prctl_map->start_brk <= prctl_map->end_data ||
>     prctl_map->brk <= prctl_map->end_data)
> goto out;
> ```
> 

Thanks for pointing, Keno! I don't remember the details right now,
gimme some time and once I refresh my memory I'll reply with
details.
