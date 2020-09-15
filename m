Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCCE26B819
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgIPAgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgION1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:27:11 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B28C0611C0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:26:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z1so3335152wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 06:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nj5427NwfkAcod/jrpxPO35Ai9seXyFseb14ybySFfM=;
        b=QdJ2+kJmwNT2Rpeynd20wnfA2n5PgwvW8q0QlYHqLR7ro3Toewl4315Be5CVsKBHZh
         OMgk03EvoactAAXW/p2vTIkFSHggeL09y0WS6v9YSbB5sBgKsBc1LIwTyxViUDecSze3
         j7f+9+k8UuQGNij/vw1YOL1TLdZVVCsB2h7SbbdsQ+jS/hUhlDRzEDXUbI2eUs+mc6OX
         1MpflgJ5M/nzMSdaRl5D72mgdrbnQSgo3t7miz06w0bL1d2D2xEIGYCzQk0+AHzwq5H+
         cUsIogqEoCMxr3MR+pxkoSQt/LNuvKx9fizekZYmIyA2x+ga2SG3eGTbcZVJX6UYvHLc
         Lj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nj5427NwfkAcod/jrpxPO35Ai9seXyFseb14ybySFfM=;
        b=b2Ppyu9ufg11I+yEipsXzYxfFDEXW0RAuMcrQeBOOIvF9FgQ3qS43CRi5rl8RaGMtw
         BvgqD3p2XweeHngP3Q24HZpP7TOBLS1zzOtO9innB9EIg4z1Vm/AMHgUlOY2ncTSHoC0
         QV/1MHyKla0nogdQQHq6YAH9sUHsz0zdda2YoqFtGqBfFC273fXBhw4I+SwRnkjLk+Y5
         Nd1g5qgiQaVz1DQABQHlin17zZ6yiI/4z5zdnPKOkx8RaHuhONEcH1ks0Onr3z1Qi9oy
         6OXUDZvD55kLWwQsTVvwSxj6Q1zfoGuFDsxg0uZdRifEiWRw7wUZxmaGCjxk/pZjeJQ4
         s6yg==
X-Gm-Message-State: AOAM530glwD72w0VOiRaByiKas9GjG//RlRJ50K8esddAnI35DvFY/Og
        6ORoJUeSsBYF2fGQNZQmqzSRvw==
X-Google-Smtp-Source: ABdhPJxUX3SywtAgbIzvAPBC3VuqGFTB/q/j/ez9t1LNPTmXjvJgQ8L9UOasQDwBRHrHUf+PvOb/og==
X-Received: by 2002:adf:d4c7:: with SMTP id w7mr21860249wrk.263.1600176375639;
        Tue, 15 Sep 2020 06:26:15 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id m4sm28137345wro.18.2020.09.15.06.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 06:26:15 -0700 (PDT)
Date:   Tue, 15 Sep 2020 15:26:14 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Moshe Shemesh <moshe@nvidia.com>
Cc:     Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RFC v4 01/15] devlink: Add reload action option
 to devlink reload command
Message-ID: <20200915132614.GN2236@nanopsycho.orion>
References: <1600063682-17313-1-git-send-email-moshe@mellanox.com>
 <1600063682-17313-2-git-send-email-moshe@mellanox.com>
 <20200914122732.GE2236@nanopsycho.orion>
 <996866b1-5472-dd95-f415-85c34c4d01c0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <996866b1-5472-dd95-f415-85c34c4d01c0@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Sep 15, 2020 at 02:12:25PM CEST, moshe@nvidia.com wrote:
>
>On 9/14/2020 3:27 PM, Jiri Pirko wrote:
>> Mon, Sep 14, 2020 at 08:07:48AM CEST, moshe@mellanox.com wrote:

[..]	
	
>> > @@ -7392,6 +7485,11 @@ struct devlink *devlink_alloc(const struct devlink_ops *ops, size_t priv_size)
>> > 	if (!devlink)
>> > 		return NULL;
>> > 	devlink->ops = ops;
>> > +	if (devlink_reload_actions_verify(devlink)) {
>> Move this check to the beginning. You don't need devlink instance for
>> the check, just ops.
>
>
>Right, will fix.
>
>> also, your devlink_reload_actions_verify() function returns
>> 0/-ESOMETHING. Treat it accordingly here.
>
>
>Well, yes, but I rather return NULL here since devlink_alloc() failed. If
>devlink_reload_actions_verify() fails it has WARN_ON which will lead the
>driver developer to his bug.

So let the verify() return bool.
My point is, if a function return 0/-ESOMETHING, you should not check
the return value directly but you should use int err/ret.

>
>> 
>> > +		kfree(devlink);
>> > +		return NULL;
>> > +	}

[...]
