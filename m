Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2334426A00E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 09:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgIOHpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 03:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgIOHoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 03:44:05 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE564C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 00:44:04 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id nw23so3621975ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 00:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bVk5ziYF94Toafe35ecOS7d2MqTzFsDTBdEA3MQSQJU=;
        b=SYtgTycQtyXYM41h5Hp5WxBfd6nX4yMCaFMLKp9fX6L9pfNRCbL4nl/LUHtmnzWe/K
         ZK9LRiCJb4hR4W+jQDcGrdEXej45PsPx+cWvmLv9AElLjWqfuqOuNho9JYMSyDS+tb2x
         dxGcXw9DsyMm0GLWrAsOw0wnIG0Dej64WgE2IMK8e1I0G43LRRWvslqaSNX+8eVSggdV
         hCbJH0WEB1cg70Piv5y4Zm8lBK31VKL/ulx2ISzad1nw8XZxWZTTI4PH2r+abE8cdo2W
         1Qaj6B109Y2lL0aXATRnSzUmouzYnlKnfCy3ie/2/NmLii5I2LkEK16upRjdAPu1F9hC
         sZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bVk5ziYF94Toafe35ecOS7d2MqTzFsDTBdEA3MQSQJU=;
        b=ZoZsuZoK7gwG2vUePnX3VjIr1i/kHCM6sSgbNYksaKIV+4VC9Q3kGuXOWiU5UZuEuM
         PUkqtZAsUlBejSxDvLEj371y3PpW7Ekms8Km2I4QRoA2s7i79FSMBMoN8dXCNT3PAZ14
         DDYHdrHMEr4HcnNcOS0O41qDte5KvC98ZUIOlYgxzmoMfTIun6rPSXcAldlhvbqFfeyo
         zt2OgfoVL2p2kxWYVAi/+KrJ36uJ2iP6DnFVlMPQmktxkTw1AUSGFijsNUGagdopB1h6
         RrF0dUniZ/4U6GKaNfE4VUkWTMuPyJWFnf9bn2RGX7lE144JbuskBsKIIalBg2XOBX4r
         I7Vg==
X-Gm-Message-State: AOAM530HgQWGxULhToOk8c/yt0tCL3Bvq++70vbWJ0qzrFjKGpyNcv1V
        +VqZrUD8gQDlYY8/vED+lVBJUw==
X-Google-Smtp-Source: ABdhPJwSNpRt4PF7QqyfvTp3IHkDf7OiKPmP4SM79becnDyGX2tGNHYASYk/CD/0JvbGNRgAY/uLpQ==
X-Received: by 2002:a17:906:cec9:: with SMTP id si9mr18210890ejb.351.1600155843496;
        Tue, 15 Sep 2020 00:44:03 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id mb16sm9519149ejb.45.2020.09.15.00.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 00:44:02 -0700 (PDT)
Date:   Tue, 15 Sep 2020 09:44:02 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Ido Schimmel <idosch@idosch.org>
Cc:     Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RFC v4 04/15] devlink: Add reload actions stats
 to dev get
Message-ID: <20200915074402.GM2236@nanopsycho.orion>
References: <1600063682-17313-1-git-send-email-moshe@mellanox.com>
 <1600063682-17313-5-git-send-email-moshe@mellanox.com>
 <20200914134500.GH2236@nanopsycho.orion>
 <20200915064519.GA5390@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915064519.GA5390@shredder>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Sep 15, 2020 at 08:45:19AM CEST, idosch@idosch.org wrote:
>On Mon, Sep 14, 2020 at 03:45:00PM +0200, Jiri Pirko wrote:
>> Mon, Sep 14, 2020 at 08:07:51AM CEST, moshe@mellanox.com wrote:
>> >Expose devlink reload actions stats to the user through devlink dev
>> >get command.
>> >
>> >Examples:
>> >$ devlink dev show
>> >pci/0000:82:00.0:
>> >  reload_action_stats:
>> >    driver_reinit 2
>> >    fw_activate 1
>> >    driver_reinit_no_reset 0
>> >    fw_activate_no_reset 0
>> >pci/0000:82:00.1:
>> >  reload_action_stats:
>> >    driver_reinit 1
>> >    fw_activate 1
>> >    driver_reinit_no_reset 0
>> >    fw_activate_no_reset 0
>> 
>> I would rather have something like:
>>    stats:
>>      reload_action:
>>        driver_reinit 1
>>        fw_activate 1
>>        driver_reinit_no_reset 0
>>        fw_activate_no_reset 0
>> 
>> Then we can easily extend and add other stats in the tree.
>> 
>> 
>> Also, I wonder if these stats could be somehow merged with Ido's metrics
>> work:
>> https://github.com/idosch/linux/commits/submit/devlink_metric_rfc_v1
>> 
>> Ido, would it make sense?
>
>I guess. My original idea for devlink-metric was to expose
>design-specific metrics to user space where the entity registering the
>metrics is the device driver. In this case the entity would be devlink
>itself and it would be auto-registered for each device.

Yeah, the usecase is different, but it is still stats, right.


>
>> 
>> 
>> >
>> >$ devlink dev show -jp
>> >{
>> >    "dev": {
>> >        "pci/0000:82:00.0": {
>> >            "reload_action_stats": [ {
>> >                    "driver_reinit": 2
>> >                },{
>> >                    "fw_activate": 1
>> >                },{
>> >                    "driver_reinit_no_reset": 0
>> >                },{
>> >                    "fw_activate_no_reset": 0
>> >                } ]
>> >        },
>> >        "pci/0000:82:00.1": {
>> >            "reload_action_stats": [ {
>> >                    "driver_reinit": 1
>> >                },{
>> >                    "fw_activate": 1
>> >                },{
>> >                    "driver_reinit_no_reset": 0
>> >                },{
>> >                    "fw_activate_no_reset": 0
>> >                } ]
>> >        }
>> >    }
>> >}
>> >
>> 
>> [..]
