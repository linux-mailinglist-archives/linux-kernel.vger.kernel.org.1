Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BF0272138
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgIUKdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgIUKdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:33:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FE1C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:33:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e17so11601268wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kjxw4km93AnFxrs9BHkSiQ7WIwZ/JBZnTalW8nKwc6M=;
        b=wB8n8aKCne/xXh8ZcRI25eb7QDQ9dmygXDzNbdHRZRZOxblgUGkC7zIcpk8um1U/6b
         et6Uo0KgtcECJ9YYbmvCLQsL8P9hyJSBrWqF02RGzwmpf0OQDxYp55VTpqWS6qtzQFoR
         O76kqrdDfo/XeET1njsxCKaFgf2mDucqtbSHiTKgbSWnbzpgHvr7bc3otsPvYAkOIs1z
         8a2Hd0cuZxOX9RpT9n2OQDphuWPy/IZGWk/UzKOWURJazGy3wN6twgcHFMPXadPuE7HZ
         W0wPXawsW6Wiw3GxGN/2JhY59+PWFKI1FOSR//80NLjiqTH7CTyJsGMoXLpez9gV6b/o
         f68Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kjxw4km93AnFxrs9BHkSiQ7WIwZ/JBZnTalW8nKwc6M=;
        b=ik3uI3ERulWWSDCDOZv3rvQ/3dn/effYENfY5Cq+Sb0kYl/cIJhOmhsNy9aPVB2ljw
         HMX2p9DsOkLzybVZ4COWXrvk4zVHNmrfZZmTydHGmu55wD0PzocvOKTMCkuOwhXRRNk7
         rXuCAQJlLwNP1VMhlY0yJn3j8H9nzdk5eWq/UTiFx/vBAazI8PrZz4J9Zh/6ccKY+A8q
         5g2DLafHi49VxY8ShjzdbC7aoh3cl5kDxudmStx9BIZXNKlsmV6oAMzye3RdJ1J3ichm
         pmphbU/f5qVQZERTtKCn/fIphjG0b/efVz8Bb1T6/CUGRENOjR+5mP5qKCjfeY0PdX16
         SeGA==
X-Gm-Message-State: AOAM531rQ6fLtJBe7/3duOEt+qYNStFf5gC8qibCNsC66ndz3nMDJQc4
        ao01c8I6tcAK8ti/p+3uhebe9Q==
X-Google-Smtp-Source: ABdhPJyBhlImM0gM7xMgkbACh9Rethu8/rF/kbdt83J3OCB6keNBr6euoSva3wSDTqHdNMC0CK+cVA==
X-Received: by 2002:a1c:5a86:: with SMTP id o128mr28331649wmb.129.1600684421300;
        Mon, 21 Sep 2020 03:33:41 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id 91sm21494851wrq.9.2020.09.21.03.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:33:40 -0700 (PDT)
Date:   Mon, 21 Sep 2020 12:33:39 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Moshe Shemesh <moshe@nvidia.com>
Cc:     Ido Schimmel <idosch@idosch.org>,
        Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RFC v4 04/15] devlink: Add reload actions stats
 to dev get
Message-ID: <20200921103339.GC2323@nanopsycho.orion>
References: <1600063682-17313-1-git-send-email-moshe@mellanox.com>
 <1600063682-17313-5-git-send-email-moshe@mellanox.com>
 <20200914134500.GH2236@nanopsycho.orion>
 <20200915064519.GA5390@shredder>
 <20200915074402.GM2236@nanopsycho.orion>
 <0d6cb0da-761b-b122-f5b1-b82320cfd5c4@nvidia.com>
 <20200915133406.GQ2236@nanopsycho.orion>
 <bcd28773-0027-11f5-1fd9-0a793f0a3c3a@nvidia.com>
 <bd55e716-7659-c3c4-ded5-c0abbb3d37f3@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd55e716-7659-c3c4-ded5-c0abbb3d37f3@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Sep 18, 2020 at 06:13:59PM CEST, moshe@nvidia.com wrote:
>
>On 9/15/2020 11:33 PM, Moshe Shemesh wrote:
>> External email: Use caution opening links or attachments
>> 
>> 
>> On 9/15/2020 4:34 PM, Jiri Pirko wrote:
>> > Tue, Sep 15, 2020 at 02:31:38PM CEST, moshe@nvidia.com wrote:
>> > > On 9/15/2020 10:44 AM, Jiri Pirko wrote:
>> > > > Tue, Sep 15, 2020 at 08:45:19AM CEST, idosch@idosch.org wrote:
>> > > > > On Mon, Sep 14, 2020 at 03:45:00PM +0200, Jiri Pirko wrote:
>> > > > > > Mon, Sep 14, 2020 at 08:07:51AM CEST, moshe@mellanox.com wrote:
>> > > > > > > Expose devlink reload actions stats to the user through devlink dev
>> > > > > > > get command.
>> > > > > > > 
>> > > > > > > Examples:
>> > > > > > > $ devlink dev show
>> > > > > > > pci/0000:82:00.0:
>> > > > > > >    reload_action_stats:
>> > > > > > >      driver_reinit 2
>> > > > > > >      fw_activate 1
>> > > > > > >      driver_reinit_no_reset 0
>> > > > > > >      fw_activate_no_reset 0
>> > > > > > > pci/0000:82:00.1:
>> > > > > > >    reload_action_stats:
>> > > > > > >      driver_reinit 1
>> > > > > > >      fw_activate 1
>> > > > > > >      driver_reinit_no_reset 0
>> > > > > > >      fw_activate_no_reset 0
>> > > > > > I would rather have something like:
>> > > > > >      stats:
>> > > > > >        reload_action:
>> > > > > >          driver_reinit 1
>> > > > > >          fw_activate 1
>> > > > > >          driver_reinit_no_reset 0
>> > > > > >          fw_activate_no_reset 0
>> > > > > > 
>> > > > > > Then we can easily extend and add other stats in the tree.
>> > > 
>> > > Sure, I will add it.
>> > Could you please checkout the metrics patchset and figure out how to
>> > merge that with your usecase?
>> > 
>> 
>> I will check, I will discuss with Ido how it will fit.
>> 
>
>I have discussed it with Ido, it doesn't fit to merge with metrics:
>
>1. These counters are maintained by devlink unlike metrics which are read by
>the driver from HW.

Okay.

>
>2. The metrics counters push string name, while here I use enum.
>
>However, I did add another level as you suggested here for option to future
>stats that may fit.
>
>> > > > > > Also, I wonder if these stats could be somehow merged
>> > > > > > with Ido's metrics
>> > > > > > work:
>> > > > > > https://github.com/idosch/linux/commits/submit/devlink_metric_rfc_v1
>> > > > > > 
>> > > > > > Ido, would it make sense?
>> > > > > I guess. My original idea for devlink-metric was to expose
>> > > > > design-specific metrics to user space where the entity
>> > > > > registering the
>> > > > > metrics is the device driver. In this case the entity
>> > > > > would be devlink
>> > > > > itself and it would be auto-registered for each device.
>> > > > Yeah, the usecase is different, but it is still stats, right.
>> > > > 
>> > > > 
>> > > > > > > $ devlink dev show -jp
>> > > > > > > {
>> > > > > > >      "dev": {
>> > > > > > >          "pci/0000:82:00.0": {
>> > > > > > >              "reload_action_stats": [ {
>> > > > > > >                      "driver_reinit": 2
>> > > > > > >                  },{
>> > > > > > >                      "fw_activate": 1
>> > > > > > >                  },{
>> > > > > > >                      "driver_reinit_no_reset": 0
>> > > > > > >                  },{
>> > > > > > >                      "fw_activate_no_reset": 0
>> > > > > > >                  } ]
>> > > > > > >          },
>> > > > > > >          "pci/0000:82:00.1": {
>> > > > > > >              "reload_action_stats": [ {
>> > > > > > >                      "driver_reinit": 1
>> > > > > > >                  },{
>> > > > > > >                      "fw_activate": 1
>> > > > > > >                  },{
>> > > > > > >                      "driver_reinit_no_reset": 0
>> > > > > > >                  },{
>> > > > > > >                      "fw_activate_no_reset": 0
>> > > > > > >                  } ]
>> > > > > > >          }
>> > > > > > >      }
>> > > > > > > }
>> > > > > > > 
>> > > > > > [..]
