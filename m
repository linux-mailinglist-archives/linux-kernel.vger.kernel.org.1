Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71872281665
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbgJBPTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBPTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:19:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E746FC0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 08:19:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id m6so2265124wrn.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 08:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LKNths/LPQbAs0cdB5bW5xnTf55TpFYTO0PPt8yn7hM=;
        b=HmtgrxraewM+QiIP5fF3kDfxH+EmFXsFA+9vQWpXPUnmkEM0HtsW9+VTFWmAcdO9ND
         G/KAiTsCOQ9nGgYR5+kgU8dxn8FQ3yYel6OyOHGVrKcQksJew5YNQ5fSMG4d0GYguB2P
         /PUnEHPYURpy7YGupOiGQvkHX4wQGcD4OLb42VLLXZNeiK5o4rOzcVRFLlUIZDhtvupk
         pVAJICVVwgTSRqIiqqZg4YqdjditXgjaRtxhsfpuMYtb2cncgSUQinPd7BvCyqfn1dEI
         op56BMgRzIfTXJfwwoPBJJVNbW/qtXmvlozQNgt1CrR3al8yECelmI9/GxOvY4yKEXpH
         FFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LKNths/LPQbAs0cdB5bW5xnTf55TpFYTO0PPt8yn7hM=;
        b=Kia8i9hyPAYyoF1kF6gSV7BYv5vtP47YceoqauvT5IKZwwo2psLGcxqPb6AfUiwSU6
         RlDCaoV0V3r7ZQRm3snCbAffS0u05loECfIRQOc8yCNNWf1zWvQGmlMflfgZL1rd7jwV
         TOFJkEufqesZmdG3qXh9cdC7uL8c3004Ok++iDrUz9LXYvSqw+HtG/FhnFhGzA/hAXkW
         CaC2o2zVPmSG5mWYU5n2vXpuP+vOVvm1UGFNZrFkrgnj+5S4ss6vr9rZJeeYlRwE23xc
         RhvBsMoodzlgQfCYWGHvRk9iEo+Q7oJgwNu7dklyKm/YTwG+F0Ilvh53YZ1TvjElVk1i
         njig==
X-Gm-Message-State: AOAM531ykpfc/+q8+FZUrnDFWewrdvqgo4SNfFLQM/lx4MCpZuChJpLW
        IVGRQOdqJLluFzhlA9caqEVKBA==
X-Google-Smtp-Source: ABdhPJx3IBbQHwBSSzG6L4x/26S6UraQ0pRj1kDGMlBA3/UoTNvnCSqve7suFeszzrKl5zrRYzxPtQ==
X-Received: by 2002:adf:dcc7:: with SMTP id x7mr3722324wrm.203.1601651984611;
        Fri, 02 Oct 2020 08:19:44 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id y6sm2080079wrn.41.2020.10.02.08.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 08:19:44 -0700 (PDT)
Date:   Fri, 2 Oct 2020 17:19:43 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Moshe Shemesh <moshe@mellanox.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 02/16] devlink: Add reload action option to
 devlink reload command
Message-ID: <20201002151943.GB3159@nanopsycho.orion>
References: <1601560759-11030-1-git-send-email-moshe@mellanox.com>
 <1601560759-11030-3-git-send-email-moshe@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601560759-11030-3-git-send-email-moshe@mellanox.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Oct 01, 2020 at 03:59:05PM CEST, moshe@mellanox.com wrote:

[...]


>diff --git a/include/net/devlink.h b/include/net/devlink.h
>index 1c286e9a3590..ddba63bce7ad 100644
>--- a/include/net/devlink.h
>+++ b/include/net/devlink.h
>@@ -1077,10 +1077,11 @@ struct devlink_ops {
> 	 * implemementation.
> 	 */
> 	u32 supported_flash_update_params;
>+	unsigned long reload_actions;
> 	int (*reload_down)(struct devlink *devlink, bool netns_change,
>-			   struct netlink_ext_ack *extack);
>-	int (*reload_up)(struct devlink *devlink,
>-			 struct netlink_ext_ack *extack);
>+			   enum devlink_reload_action action, struct netlink_ext_ack *extack);
>+	int (*reload_up)(struct devlink *devlink, enum devlink_reload_action action,
>+			 struct netlink_ext_ack *extack, unsigned long *actions_performed);

Nit. Could you please push extack to be the last arg here? It is common
to have extack as the last arg + action and actions_performed are going
to be side by side.

Otherwise the patch looks fine.
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
