Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D7B26886C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 11:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgINJcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 05:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgINJch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 05:32:37 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBB4C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 02:32:36 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id z23so22201192ejr.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 02:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S12Ozp3Vsq8tS9g1DhUCy0Z/H/j+wxx4VSfsrHbFWrQ=;
        b=a4Zoosb5FMCUcX3ko7MzxtqQ5g229ysUK77EQ3rznkAU7ETZQeN15zHk8nOo+RupO/
         uWJEqSHNuvgjV3EETWW9l4VUIC3AefmOMGLR5a2r/CmuCH8NSocEKzWnzXu3W2ziXSk5
         EIbO/zel0odzIWMASvi+3MrQXncK3d7eC27vev3SYWcf6DOv8LxtHLFKPVdVcB2ezFmK
         b6kkDZ2HIj0yf65TqIuIwxDDrh47WUqIvwEg5gJ6ZHpuLliNbVIeGGGuLJf3seFmovJK
         jTB2lu30aOaTH8CDGjxTWU6j4jssjlCXqfvWL5H4Jmc02usJh3Pq7CpHqI3qVoHoP5ph
         XBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S12Ozp3Vsq8tS9g1DhUCy0Z/H/j+wxx4VSfsrHbFWrQ=;
        b=rV2g+c1qAC8xXfKoHxxaYe/sQ+wZzd+K5D/L48PPTXbbOv113o7mCH7rtKtmV3nU/8
         zFHEd1LJgc5gA2X10poaBLpamyR9buBQHyD2z5+tO+tT53sjLxgbhH4SvIPXmeN2OJnf
         fOTDOo0Z1duybeei5roZx1Hxrmiayg768DxhxpBnUDTGd2eMsW9pqGvonpp67YY+3aY9
         rLQu4PSPsDbZLte54BZns8fapisL5x4H4g5QXkySEazhkZdcUr/O9y4AUrVn9TYHoDyE
         mbO/PO+kPkZLMb9MF1mtXlgz3E3EHtXb8m0CIXmFAT2DOLSvS7tu4ZN2oSrDTJQDFy+O
         uNIg==
X-Gm-Message-State: AOAM532S/HM8M56ME5Kgaf9gUic9DOOFKPrbIIz60MKcdf25p1z2lEqh
        P3ATkP7cNCbXylIUckdshCfVlA==
X-Google-Smtp-Source: ABdhPJyBWT+4MuT1smyevpT5Ha/ugeFB0PYXRB0MRJ6FFg7yJ95A9z8gLMYrf983IDj+WcFuT4qUwQ==
X-Received: by 2002:a17:906:3ad0:: with SMTP id z16mr14355972ejd.193.1600075955616;
        Mon, 14 Sep 2020 02:32:35 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id p25sm8848649edm.60.2020.09.14.02.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 02:32:35 -0700 (PDT)
Date:   Mon, 14 Sep 2020 11:32:34 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Cc:     Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next RFC v4 01/15] devlink: Add reload action option
 to devlink reload command
Message-ID: <20200914093234.GB2236@nanopsycho.orion>
References: <1600063682-17313-1-git-send-email-moshe@mellanox.com>
 <1600063682-17313-2-git-send-email-moshe@mellanox.com>
 <CAACQVJochmfmUgKSvSTe4McFvG6=ffBbkfXsrOJjiCDwQVvaRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAACQVJochmfmUgKSvSTe4McFvG6=ffBbkfXsrOJjiCDwQVvaRw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Sep 14, 2020 at 09:08:58AM CEST, vasundhara-v.volam@broadcom.com wrote:
>On Mon, Sep 14, 2020 at 11:39 AM Moshe Shemesh <moshe@mellanox.com> wrote:

[...]


>> @@ -1126,15 +1126,24 @@ mlxsw_devlink_core_bus_device_reload_down(struct devlink *devlink,
>>  }
>>
>>  static int
>> -mlxsw_devlink_core_bus_device_reload_up(struct devlink *devlink,
>> -                                       struct netlink_ext_ack *extack)
>> +mlxsw_devlink_core_bus_device_reload_up(struct devlink *devlink, enum devlink_reload_action action,
>> +                                       struct netlink_ext_ack *extack,
>> +                                       unsigned long *actions_performed)
>Sorry for repeating again, for fw_activate action on our device, all
>the driver entities undergo reset asynchronously once user initiates
>"devlink dev reload action fw_activate" and reload_up does not have
>much to do except reporting actions that will be/being performed.
>
>Once reset is complete, the health reporter will be notified using

Hmm, how is the fw reset related to health reporter recovery? Recovery
happens after some error event. I don't believe it is wise to mix it.

Instead, why don't you block in reload_up() until the reset is complete?


>devlink_health_reporter_recovery_done(). Returning from reload_up does
>not guarantee successful activation of firmware. Status of reset will
>be notified to the health reporter via
>devlink_health_reporter_state_update().
>
>I am just repeating this, so I want to know if I am on the same page.
>
>Thanks.

[...]
