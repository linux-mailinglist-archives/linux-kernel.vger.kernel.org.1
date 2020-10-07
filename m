Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3262228622D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbgJGPes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgJGPer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:34:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DB2C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 08:34:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t9so2690916wrq.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 08:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+XHpDefsBIm2Wcc7l0A0wAeXuSoeHx4lJ/xyRHbCKCg=;
        b=MZIoX+EX3cuOi3WuU1lL5WA2iLCEE61m/usYjvBnstLFDugdB5GoFxTY2LbDmj8qiE
         rXP/I2ABb0GsBXR17uBboT/sAy6E94KRqoBI7M8B40plqBx5xfZR6CRTEoySO4pK0N0v
         29evrmQHFbqA47QyR9zimpyqpE1HjvRsisqmpfkyz/r54HJgJ8WaeQsoWu1qKQ2LNgGG
         7xFKt2Ag5gM08crdcyw4iN8LzXgwMAKCyim/AZMFW0BdnVXWuaN7IvvLcD8LXRBU88B6
         34eoL0KaR5G5Q17g+BfeklFJOFz2yFh6+28XzPwXwNw36aEEyb1/H191b27pax/hj0/2
         dMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+XHpDefsBIm2Wcc7l0A0wAeXuSoeHx4lJ/xyRHbCKCg=;
        b=XXTmXMCGUumflNw9qltTEPKogKnNYCeXNMSH3B2ZJ+ZS++1Btfr0AsRXo6nkTo1eeS
         01wiSrEhWbKzmzoF2/2A4qFWs6VDN8JCd4JdDbJ3pd2LaqrEb6avGxNBPWVIpsTnnqu7
         0l2Q8sGSs2SmAMzA/yEcz/N/yMMa3lkgVJPUnnaj/pQlQkjQjMenGPQ9VB610P4aBYTS
         lkB8fPOiW5FTdry2t6KZDV6dq7MMeNiLlemDEPPy2T5VZ4et0eGoRKDDhjhfJwKp/Uc/
         FNAmfGjLCgIKHg8vvG2tZWXMvizawrP8WSnA6RVksr7yzpHbmIs0fqSBI6MMYepPtRjX
         PIfg==
X-Gm-Message-State: AOAM5313EzlEV7dXVF/nqHtGGYMF8u7aAuQ/o7Dt/P/qngs9Iec1/hiO
        TmOx5FocAM7kdhQRUGYbF1zbRA==
X-Google-Smtp-Source: ABdhPJx1DMuOtEbdBBSv/OykWRlla0M47n4Zd0oyrTdowQSBvswRHUyoxe6fBa5XHm1CDpATIXU2dw==
X-Received: by 2002:adf:fc0d:: with SMTP id i13mr4332489wrr.156.1602084885509;
        Wed, 07 Oct 2020 08:34:45 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id t6sm3914101wre.30.2020.10.07.08.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 08:34:44 -0700 (PDT)
Date:   Wed, 7 Oct 2020 17:34:43 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Moshe Shemesh <moshe@mellanox.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 02/16] devlink: Add reload action option to
 devlink reload command
Message-ID: <20201007153443.GA3064@nanopsycho>
References: <1602050457-21700-1-git-send-email-moshe@mellanox.com>
 <1602050457-21700-3-git-send-email-moshe@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602050457-21700-3-git-send-email-moshe@mellanox.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Oct 07, 2020 at 08:00:43AM CEST, moshe@mellanox.com wrote:
>Add devlink reload action to allow the user to request a specific reload
>action. The action parameter is optional, if not specified then devlink
>driver re-init action is used (backward compatible).
>Note that when required to do firmware activation some drivers may need
>to reload the driver. On the other hand some drivers may need to reset
>the firmware to reinitialize the driver entities. Therefore, the devlink
>reload command returns the actions which were actually performed.
>Reload actions supported are:
>driver_reinit: driver entities re-initialization, applying devlink-param
>               and devlink-resource values.
>fw_activate: firmware activate.
>
>command examples:
>$devlink dev reload pci/0000:82:00.0 action driver_reinit
>reload_actions_performed:
>  driver_reinit
>
>$devlink dev reload pci/0000:82:00.0 action fw_activate
>reload_actions_performed:
>  driver_reinit fw_activate
>
>Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
>Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
