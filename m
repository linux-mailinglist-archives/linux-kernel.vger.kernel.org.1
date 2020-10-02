Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65558281645
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbgJBPNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388223AbgJBPNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:13:53 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7834C0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 08:13:52 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v12so2126706wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XCoSMtm8uK3alwTQ0gtx5gTHymtT/Ql9p6LoQ1R/800=;
        b=nv9CIGD0tPIKUSfSb6iiuIo5RJEy6udMlu0r0mNDAe8YdLnp28haJZAJpuZBGdnyNs
         y7PXkfnRspF0hv4HQgdsuZKoxQ6OnYflzpk6VIyh/rj8G1UMTvzgQ6zk/+76obwNawkt
         GrnzHLCQvN/F2AluBuQuBQMlTr3GHOgGSOia0tLZSpPZsmxtTQ2nlyPIK5DDk7kTgbHo
         9XTlClnIH9ZSnVaRGQ6+k6OvlM7aVcwAYD+1vjeL1kTxNVVz+zdUfnh8Px8WzWrOG1Sw
         y2nlrPqf5Ar54h5tJ4KSw/elJfsD7XLh+lek5tfA79yXnNyaJMVW2wY0+UmszYJpilO8
         CCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XCoSMtm8uK3alwTQ0gtx5gTHymtT/Ql9p6LoQ1R/800=;
        b=b8cS+lPvXo5mnPOYVkT4rUwYkbfpFXli2ADCpqYi7T2P2/O/gdZq2T7pq0XCXlB4S1
         Wn1bNPgmQoqdvv5Ol/RCQr4kB+wOtlorFeq0RosZcpl/d2Z/imHK7RSzjRtjEQtrI1TR
         ehrcWiOMtRS6efASc+G3cg5Xb+dU3V3wiSbYbFsxh8LE7zYU6Sw8gLyclFfPlDK56BkS
         QWAtGyqC6IENnu2wTgoZyWEmYAffSz4YIs5ATJNHc1ft3CRtAb59gA11NuXGYnKnywno
         x7oFi7TNabFRPURiOrM/Q3jiRrroUCimnDe8nwWAl3jcRiwgpI7L/2iPo2oDILbCMtf0
         FAYA==
X-Gm-Message-State: AOAM531wn6Uw3gLTgN//JA++fp4b0yhXYLsMwZYZ8p1XXlCNINmRbA8n
        mF8B0ENU2ZpbqVuwyPCyd17v4A==
X-Google-Smtp-Source: ABdhPJzw3li7zEFTPQF+L2nzFjno5LMp/+4HXHh0JaLeoy7k/krCjHFUNy5oFql7h64xkcNUj/OiJA==
X-Received: by 2002:a7b:c387:: with SMTP id s7mr3415926wmj.171.1601651631598;
        Fri, 02 Oct 2020 08:13:51 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id i9sm2059947wma.47.2020.10.02.08.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 08:13:51 -0700 (PDT)
Date:   Fri, 2 Oct 2020 17:13:49 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Moshe Shemesh <moshe@mellanox.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 01/16] devlink: Change
 devlink_reload_supported() param type
Message-ID: <20201002151349.GA3159@nanopsycho.orion>
References: <1601560759-11030-1-git-send-email-moshe@mellanox.com>
 <1601560759-11030-2-git-send-email-moshe@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601560759-11030-2-git-send-email-moshe@mellanox.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Oct 01, 2020 at 03:59:04PM CEST, moshe@mellanox.com wrote:
>Change devlink_reload_supported() function to get devlink_ops pointer
>param instead of devlink pointer param.
>This change will be used in the next patch to check if devlink reload is
>supported before devlink instance is allocated.
>
>Signed-off-by: Moshe Shemesh <moshe@mellanox.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
