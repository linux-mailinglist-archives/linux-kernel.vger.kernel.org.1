Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B11126BC33
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 08:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgIPGI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 02:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgIPGI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 02:08:58 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB2DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 23:08:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so5539051wrm.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 23:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6ltP0aOGQD+pWXD6AJUF98sdvcO7hY5wybesnqZaXUw=;
        b=Ux1DfmrceSWVJcjxg6rX12nRmouD06dTwTwqh7Kcyhgg4TgM3iB/16UnLsoRmsu+st
         4v6TkVr6sf2Ei73kzDFuDad+NgXokkTdeChhvnbFU8X8FhYA7W4+zSENytFEiiG2f4QA
         OW5NdYyiktAhLQmJ/tCpVQ60kPIqaGoveJOrm2xkCWUe5JKM6P3nypW6/Ma4gOLd0PVq
         XGI8690y/Wob6hZia8JoG5Q8k+LuiDjFEVG+08915OuzGuxgDOp1O9qvSeNh3CnF/OMD
         oPsPL8h0Ty4pcIJWMpHhfU9vJXBPI08o5aWnRvXSPIPnEEcz9xUMKDV/P1nwDaiHFkIV
         /EkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6ltP0aOGQD+pWXD6AJUF98sdvcO7hY5wybesnqZaXUw=;
        b=TMYoRhrsR7ZWC8EgjA4auQlAoYvH8USHsOv4prdouY5j2NxfPmVqH6CmRylRb2ebmz
         2Pax60HKBzeiypQfGMvuLRnkHNQULKqm7+1MzvaZlem83Osq/LuawaYfxXb8yygTjOGQ
         N+IHHFZpDaqhODQObJgL9jSh5AmCaNOayFyDHsV+yglGgMyCDAtZCVASfZat2ToI0CM7
         4RBq+sMHuiURbVdYfxmUrBUY8MCI0KhzOIdxOcLcmyQYajIhThbgeTFb0w7NtRPY/6/R
         GZd+QV5nmcvzZPJ5A8VQ5k4uvBkqe4NF1W4CLMy/IwRWBwblQdXuv7KZtcMd9iwWNunm
         qVpA==
X-Gm-Message-State: AOAM531tRSBL4uy6ueXGDN0r/80YDkZhF+LoLxD4+dpV8rQCCMbXDJPc
        vK95kJ6LdUcAtHgJ1mL0UWGGWQ==
X-Google-Smtp-Source: ABdhPJy1lHwl1CXyERuGj7W3u4wqt7kLrissmRGrhp5aC0BjolySXgBxonRNQGZjAdNklIJwvrVT1A==
X-Received: by 2002:a5d:5751:: with SMTP id q17mr1867192wrw.409.1600236536019;
        Tue, 15 Sep 2020 23:08:56 -0700 (PDT)
Received: from localhost ([85.163.43.78])
        by smtp.gmail.com with ESMTPSA id q18sm29992660wre.78.2020.09.15.23.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 23:08:55 -0700 (PDT)
Date:   Wed, 16 Sep 2020 08:08:54 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Moshe Shemesh <moshe@nvidia.com>
Cc:     Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RFC v4 10/15] net/mlx5: Add support for devlink
 reload action fw activate
Message-ID: <20200916060854.GB2278@nanopsycho>
References: <1600063682-17313-1-git-send-email-moshe@mellanox.com>
 <1600063682-17313-11-git-send-email-moshe@mellanox.com>
 <20200914135442.GJ2236@nanopsycho.orion>
 <565e63b3-2a01-4eba-42d3-f5abc6794ee8@nvidia.com>
 <20200915133705.GR2236@nanopsycho.orion>
 <5c5689d9-c2ba-7656-10f3-1d5f33fc6a2e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c5689d9-c2ba-7656-10f3-1d5f33fc6a2e@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Sep 15, 2020 at 10:28:44PM CEST, moshe@nvidia.com wrote:
>
>On 9/15/2020 4:37 PM, Jiri Pirko wrote:
>> Tue, Sep 15, 2020 at 02:44:02PM CEST, moshe@nvidia.com wrote:
>> > On 9/14/2020 4:54 PM, Jiri Pirko wrote:
>> > > Mon, Sep 14, 2020 at 08:07:57AM CEST, moshe@mellanox.com wrote:
>> > > 
>> > > [..]
>> > > 
>> > > > +static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev)
>> > > > +{
>> > > > +	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
>> > > > +
>> > > > +	/* if this is the driver that initiated the fw reset, devlink completed the reload */
>> > > > +	if (test_bit(MLX5_FW_RESET_FLAGS_PENDING_COMP, &fw_reset->reset_flags)) {
>> > > > +		complete(&fw_reset->done);
>> > > > +	} else {
>> > > > +		mlx5_load_one(dev, false);
>> > > > +		devlink_reload_implicit_actions_performed(priv_to_devlink(dev),
>> > > > +							  DEVLINK_RELOAD_ACTION_LIMIT_LEVEL_NONE,
>> > > > +							  BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
>> > > > +							  BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE));
>> > > Hmm, who originated the reset? Devlink_reload of the same devlink
>> > > instance?
>> > 
>> > Not the same devlink instance for sure. I defer it by the flag above
>> > MLX5_FW_RESET_FLAG_PENDING_COMP. If the flag set, I set complete to the
>> > reload_down() waiting for it.
>> Hmm, thinking about the stats, as
>> devlink_reload_implicit_actions_performed() is called only in case
>> another instance does the reload, shouldn't it be a separate set of
>> stats? I think that the user would like to distinguish local and remote
>> reload, don't you think?
>> 
>
>Possible, it will double the counters, but it will give more info.
>
>So actually, if devlink_reload is not supported by driver, I should hold and
>show only the remote stats or all stats always ?

It would make sense to show just remote stats.

>
>How such remote counter should look like ? something like remote_fw_activate 
>while the local is just fw_activate ?

Sounds good.


>
>> > 
>> > > [..]
