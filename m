Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F4A23DB6B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Aug 2020 17:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgHFPeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Aug 2020 11:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgHFOUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 10:20:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3901C0A54D6
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 06:57:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id q4so31994328edv.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IIm6TB2DhuDQ44K6wIJRyHH6Xdto2sFrurS9xyjL+rA=;
        b=rd1vI8Zlk7oq+FHWbvUuvfUOesZGL+1j6zN0cGdF5/0N+mvQt/d72y655/XSu1FIms
         fhsGfoFsLAw8xYk4ZXkEVZDlL7D8YhHX8ICjz52hB2y8K8AKwh0t52NRNms/RIjR4vaf
         IG9TbK3IJarxL49Ti9ODqMHSrshGBLHM22YAjo2NOhWirqHqYodvI9GgI4nW2BQnVCjA
         2kUR7YWtDdT2WqUQOCuUOsglzHAoAqSthD7IibVLp3kwyFvZWFLfnA9ITZDYIS5JQSPe
         IOJRmrSdFeHbUU+K4b3ho4uisvZy08XXzMSTd63Vj3ALNKSbS1DC6su0H9KXWMr8xf1K
         DBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=IIm6TB2DhuDQ44K6wIJRyHH6Xdto2sFrurS9xyjL+rA=;
        b=niYkXG56CJ84G5hGYQxzAB2yvW68pUa23mRrmdnnGpwSLoskVQeJhFZYIEZsoDyMYK
         U8ZEgOf0dEDoe2hokGNtR55WdiXqUUgtaPDPaXyRyCVfEMps1+3pl2slZVoFcwZ16HUe
         c1Li2zBHU0rn545f3F7JKNsAHEmR6cQVElqI8XGgRr6Oajujq5Tljzm17Kv+hPZ2Ivhb
         InMzo5uyeZrXYFkkKOv/tiT+W2ak0rgGkVp/J2jEM4eZMQdUjB8zaENh5QHeM2mbdBpT
         osubX02paOJYfKP+5hoiBq7P1f0yQjxopaTUdu0GoCDnqFN9F4OzDH7jlArnne35jQS+
         tuDA==
X-Gm-Message-State: AOAM530pxoyMSq0BL6OrAc4au/v/TAgGE+OI/EP7XF43RpjeSQ7RPke6
        RHhQyyxI2cQsPp4mB0F7jvo=
X-Google-Smtp-Source: ABdhPJx5o+15B/66I272m4UZ+rb1HvnvnKwemZ6TbWP/v7P69Hkts0QWBS0WzpCMwst+5V0EqlTvOQ==
X-Received: by 2002:aa7:c697:: with SMTP id n23mr4103938edq.50.1596722257591;
        Thu, 06 Aug 2020 06:57:37 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id bd13sm3548692edb.38.2020.08.06.06.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 06:57:36 -0700 (PDT)
Date:   Thu, 6 Aug 2020 15:57:34 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v4 07/10] sched/topology: Add more flags to the SD
 degeneration mask
Message-ID: <20200806135734.GB2077896@gmail.com>
References: <20200731115502.12954-1-valentin.schneider@arm.com>
 <20200731115502.12954-8-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731115502.12954-8-valentin.schneider@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Valentin Schneider <valentin.schneider@arm.com> wrote:

> I don't think it is going to change much in practice, but we were missing
> those:
> 
> o SD_BALANCE_WAKE: Used just like the other SD_BALANCE_* flags, so also
>   needs > 1 group.
> o SD_ASYM_PACKING: Hinges on load balancing (periodic / wakeup), thus needs
>   > 1 group to happen
> o SD_OVERLAP: Describes domains with overlapping groups; can't have
>   overlaps with a single group.
> 
> SD_PREFER_SIBLING is as always the odd one out: we currently consider it
> in sd_parent_degenerate() but not in sd_degenerate(). It too hinges on load
> balancing, and thus won't have any effect when set on a domain with a
> single group. Add it to the sd_degenerate() groups mask.

Would be nice to add these one by one, just in case there's a 
performance or boot regression with any of them.

Thanks,

	Ingo
