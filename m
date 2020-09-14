Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C674B268D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 16:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgINOMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 10:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgINOM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 10:12:28 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE89C061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 07:12:27 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id k14so1844213edo.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 07:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YkDjJRWfqlGAuduCEVOILaEtaqS3c7Ol34fg5k0MENw=;
        b=TEalkhKhjRApsZQOHhwz/lM+USWzpU7x6Ybv1YH7KyJ0porTpeAO+tt7QEGspKWEMa
         CVJooXpiuj50M62pZO7HqLQnadCCugcpOPb29kyYMueDBY5s14jZy9fB6rVjYh5eEihX
         0B2SjDblDqqpMmMzCnLAa0utE+7snU1lre1+l8yyPGKX2bLuKLAjhpCayEIe2oBd6G5N
         inn/TlbARMwFDieGtoPyvXkm50GqMeXDFq0Ru40fQVcjbcRcSJjjfHO3vP3oJQNL28xQ
         3aINoi3gpXZKznij00Od4jPQj0R8yM9quIx5QyXHSV3KmYRevakTWIIzW0nhaD6uqTIi
         GByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YkDjJRWfqlGAuduCEVOILaEtaqS3c7Ol34fg5k0MENw=;
        b=mL6nM0LTdgEQk1F3NQyw9qceHxwLGTQPWK/Bzo3K2KlmGqi/0RkNxagQVHj0U6oMiQ
         5JVtAdKAQxsqay/3wcQ7wXkDzR87s96JNLje8IQi8+JdcGYdLMpbtvUHaRi+EgUiCyHm
         1xBIlY4Vv7tApyIAWGzN3ATEh0aKLPqSR4VEVoG6eW5rsOWBH6l3T0TlhyW4bSuDTv6D
         CsX90KeUrE73pkX5J1VtOT0JpabfL42CfP15CoU1KUeJdFIlFc/Q0ZRC9AqsrRpmBrFg
         tbTYkiMmiYOEi2W4TUN3crf3FsfAvCTevA2683ZYOaPAQ6qD4uEWLlyPe1ZnwkEob4Ay
         PAsA==
X-Gm-Message-State: AOAM532AGXBhvRunLEkI/ed79X8jCw4AN3NhLSWSfQO28FjbITLk1Pi+
        7ysA8OqHNwsMLHhxY3DUN//YEA==
X-Google-Smtp-Source: ABdhPJwmk/+mNmcLyM6kTq4XXNnc5tWnPlItZjDw6sTwDcn6zX0ztg86nqWfKC8lEzKGBx0Vlz8jrg==
X-Received: by 2002:a50:fc08:: with SMTP id i8mr17876143edr.257.1600092746469;
        Mon, 14 Sep 2020 07:12:26 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id si28sm7735535ejb.95.2020.09.14.07.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 07:12:26 -0700 (PDT)
Date:   Mon, 14 Sep 2020 16:12:25 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Moshe Shemesh <moshe@mellanox.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RFC v4 11/15] devlink: Add
 enable_remote_dev_reset generic parameter
Message-ID: <20200914141225.GK2236@nanopsycho.orion>
References: <1600063682-17313-1-git-send-email-moshe@mellanox.com>
 <1600063682-17313-12-git-send-email-moshe@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600063682-17313-12-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Sep 14, 2020 at 08:07:58AM CEST, moshe@mellanox.com wrote:
>The enable_remote_dev_reset devlink param flags that the host admin
>allows device resets that can be initiated by other hosts. This
>parameter is useful for setups where a device is shared by different
>hosts, such as multi-host setup. Once the user set this parameter to
>false, the driver should NACK any attempt to reset the device while the
>driver is loaded.
>
>Signed-off-by: Moshe Shemesh <moshe@mellanox.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
