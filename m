Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E29269E55
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 08:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgIOGSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 02:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgIOGSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 02:18:48 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FFFC061788
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 23:18:47 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i1so1865255edv.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 23:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9am9YLQ12i+k6cN6RIp9GxfKB8+xvQlyP4sg2rnKSZw=;
        b=qhCa3eWd5M9dMGkBFiu7uOJh6zgpigFNEIHSG99UMkqd6ZWKMJqHHfeSu/J7uZZZWq
         jlAZ21H+lr0ZhcU5zxu21KF5FIo4uhlq89KNwg1Yh415hPW9beuXs5KZomv52rqi/ixj
         yhbBzE8A4EnzlnY49LEb8qZwCNDSohbZs/P6Oyz2ZLtF9yAVjds0CsnzdhDSNXSjmk/H
         JVNssND4QaP7utjwKFmL2MNhJDrO5ujEzi+F/8k2UHlw+zqcb8dG+mxpvOYPaNWrndCO
         rooG5jVJodO0iKcV0Mp1DoPesfFkgJTxpVevPLGMkwXc1NXe2nZzmF7wajdewxjtWq2o
         7u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9am9YLQ12i+k6cN6RIp9GxfKB8+xvQlyP4sg2rnKSZw=;
        b=DYIqkSepLVLslmvLgVwjCb0uHuf9Lmv7AD7IBawJErmmumqSmxiOejyMaL5EF5EFOE
         tRYCGbDFD1U7wpgorrohtNKlTqqeoEnJuSpMjkHFxio5YdBYulfNVB6G5lzwBx24CBXS
         AVZMd5TH/NBmFx5V0H5OyxfMicglb+UMmPC2yF5ic4kd+eV1tOe/MW84cqlAVLhkBS8n
         Fg2GGhfyDa4Z+tPW0Wkj6gGvNjtTth1+F6zvQ1TaIxJI66WPrD2LOWXa69BsS+it1vU3
         fLnvJXx/7JpnKjt8s9lbHlT+hpPtxziJt/o8Up+YPnYaxCfKYp0DYzqv6OHqts7tYabA
         1krg==
X-Gm-Message-State: AOAM533TCkfRaLipOtspPeJEFYJ/3jV2o+9myyQAYR1mZVdE9D/UQDiz
        OM68uMhEai3LdfhYGx019wwedw==
X-Google-Smtp-Source: ABdhPJwBttQPHuQ44HQDxVWlox/ktiSn5DU2y5o5i6WoVEmGzW4k5TF900avkpIDiox1QTZwF6S92w==
X-Received: by 2002:a50:d942:: with SMTP id u2mr21466383edj.0.1600150725984;
        Mon, 14 Sep 2020 23:18:45 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id u23sm9300369ejc.108.2020.09.14.23.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 23:18:45 -0700 (PDT)
Date:   Tue, 15 Sep 2020 08:18:44 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michael Chan <michael.chan@broadcom.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Netdev <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next RFC v4 01/15] devlink: Add reload action option
 to devlink reload command
Message-ID: <20200915061844.GL2236@nanopsycho.orion>
References: <1600063682-17313-1-git-send-email-moshe@mellanox.com>
 <1600063682-17313-2-git-send-email-moshe@mellanox.com>
 <CAACQVJochmfmUgKSvSTe4McFvG6=ffBbkfXsrOJjiCDwQVvaRw@mail.gmail.com>
 <20200914093234.GB2236@nanopsycho.orion>
 <CAACQVJqVV_YLfV002wxU2s1WJUa3_AvqwMMVr8KLAtTa0d9iOw@mail.gmail.com>
 <20200914112829.GC2236@nanopsycho.orion>
 <20200914143100.06a4641d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CACKFLinODtbqezEeYdiEwcgkTdCa66D3D5_Xx+OjT23qsLi4Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACKFLinODtbqezEeYdiEwcgkTdCa66D3D5_Xx+OjT23qsLi4Og@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Sep 15, 2020 at 12:06:19AM CEST, michael.chan@broadcom.com wrote:
>On Mon, Sep 14, 2020 at 2:31 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>
>> On Mon, 14 Sep 2020 13:28:29 +0200 Jiri Pirko wrote:
>> > >> Instead, why don't you block in reload_up() until the reset is complete?
>> > >
>> > >Though user initiate "devlink dev reload" event on a single interface,
>> > >all driver entities undergo reset and all entities recover
>> > >independently. I don't think we can block the reload_up() on the
>> > >interface(that user initiated the command), until whole reset is
>> > >complete.
>> >
>> > Why not? mlxsw reset takes up to like 10 seconds for example.
>>
>> +1, why?
>
>Yes, we should be able to block until the reset sequence is complete.
>I don't see any problem.  I will work with Vasundhara on this.

Could you please also remove fw_reset as it is apparently misuse of
devlink health mechanism?

Thanks!
