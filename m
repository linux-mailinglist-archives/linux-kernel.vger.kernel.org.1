Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 347C8286284
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgJGPqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbgJGPqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:46:21 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EE4C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 08:46:21 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id n6so2462259wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 08:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YzPiSX7AQ1L9YnXrnLU91iAOqoFafCUH8YuU1FCjhMc=;
        b=HmuQOSO5fQzzPoNooQ98zkg3PTY6swd4ETESnICsiJr6LKNVV0WEsV8kBq9p+YJSZl
         14LLqkPF7gSHmgpFN3Rv7Wid+GDiKlRXAQqkDDRLkcL8D3b3nX+R243/oeNaHvpaGCsw
         HCXmyxlDIFx4qPL3IxeI9ZLisjCcZC/HKgGSHoTT2hEdLXjjSbbsoEjPEgcMGtSwDnmS
         p+NrMcNj/QklFSMbPoX2hLQOSlbEjBKBTsiEx4nNGYXKCJC7HWv1493vmlE9QYCls3Fp
         VjGyamtXkRoQKfKsziofoTvhBEy92/v2Bbt8RbwTmLGvzaiINVBHBn92Z1BBiCF+V7Ha
         TrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YzPiSX7AQ1L9YnXrnLU91iAOqoFafCUH8YuU1FCjhMc=;
        b=iUcEWQcf+1YU1Na3OlICQZhXc+z1nRaxof1CWKCQFIBtKg98uAcGtP8vDVldNt6Fbq
         hyrFTKDcWXIf2jKh7cJi55zGokDhzscGMowwx0k7brUzXoCMcVXYodyl40slyrOvavbJ
         xYYaB+GPV+KLLEKsBWVhyOSWP7i+sWGARiIncZz2U38I3wXdYMcu30iGC5b2QhPBonMA
         9rribYvcayCfeF92wPtzasYnc+3sOO/ld0uJ6pJ5ZI8V7FMgIhLBXFEHM1GiJ5t73itz
         tJzgcxiWV1qFeLGPdRUvN8f22Gd5yAcpWhl8ubOxAedI3gNs9OGZvKavJhhUbWbOaTM5
         R44Q==
X-Gm-Message-State: AOAM533QAEaW2pikL4Ls4K07efu5tyuzEl9ffXBmcAasyzqgIf1YgQdD
        7WAobUOkKL5PuaATDWaa0qIRYYu16IEkGtH+
X-Google-Smtp-Source: ABdhPJwAUva8Y6sfFj4UDNguAWXZjtX41JdpwwGKDeXgg/qMbYOvETz04L0/DLuh/b5zsSxQC9ixew==
X-Received: by 2002:adf:91a4:: with SMTP id 33mr4521604wri.170.1602085579687;
        Wed, 07 Oct 2020 08:46:19 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id p21sm3253767wmc.28.2020.10.07.08.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 08:46:19 -0700 (PDT)
Date:   Wed, 7 Oct 2020 17:46:18 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Moshe Shemesh <moshe@mellanox.com>, f@nanopsycho
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 04/16] devlink: Add reload stats
Message-ID: <20201007154618.GB3064@nanopsycho>
References: <1602050457-21700-1-git-send-email-moshe@mellanox.com>
 <1602050457-21700-5-git-send-email-moshe@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602050457-21700-5-git-send-email-moshe@mellanox.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Oct 07, 2020 at 08:00:45AM CEST, moshe@mellanox.com wrote:
>Add reload stats to hold the history per reload action type and limit.
>
>For example, the number of times fw_activate has been performed on this
>device since the driver module was added or if the firmware activation
>was performed with or without reset.
>
>Add devlink notification on stats update.
>
>Expose devlink reload stats to the user through devlink dev get command.
>
>Examples:
>$ devlink dev show
>pci/0000:82:00.0:
>  stats:
>      reload:
>        driver_reinit 2 fw_activate 1 fw_activate_no_reset 0
>pci/0000:82:00.1:
>  stats:
>      reload:
>        driver_reinit 1 fw_activate 0 fw_activate_no_reset 0
>
>$ devlink dev show -jp
>{
>    "dev": {
>        "pci/0000:82:00.0": {
>            "stats": {
>                "reload": {
>                    "driver_reinit": 2,
>                    "fw_activate": 1,
>                    "fw_activate_no_reset": 0
>                }
>            }
>        },
>        "pci/0000:82:00.1": {
>            "stats": {
>                "reload": {
>                    "driver_reinit": 1,
>                    "fw_activate": 0,
>                    "fw_activate_no_reset": 0
>                }
>            }
>        }
>    }
>}
>
>Signed-off-by: Moshe Shemesh <moshe@mellanox.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
