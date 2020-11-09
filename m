Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECD42ABDA3
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 14:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729761AbgKIM4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 07:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKIMzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:55:53 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AA7C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 04:55:52 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id o24so3450732ljj.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 04:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:cc:subject:from:to:date:message-id
         :in-reply-to;
        bh=ulXD30Aq+PcBA8C2atq4hmVoKNoOqmPsqqKu5TG3MEc=;
        b=sa0RB8rjIfzw92kAdTJeBmLStrDAedV0wkRSTULl3xOnLsRFc1tGb6t3w+4ONn+opB
         TJBA43U7tqDNA0No9OKcvv148leZR7qt0zWM752HhhzZoqZBmn8PM5sX9RxV/YkDUmS/
         f+79TR3gCsdw75f5GBkCn6xHlHh9drdBOSoPQukx/VB42w0sr/X9lf323XKd1p7VkOdq
         bTnMkiXXmjP8VrJ8+w14zWR/XXGyqPe7RMLJCr36JevqTCaI9l2XftL8mRxDLl+9FBcO
         62XOgyICwUgkiVLNmkLStV+92zLzhJGanwPdGql9i6688TCNe3LjYfz6/cfabIu7SXVH
         8Nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:cc:subject:from:to
         :date:message-id:in-reply-to;
        bh=ulXD30Aq+PcBA8C2atq4hmVoKNoOqmPsqqKu5TG3MEc=;
        b=uL3Ac74NrCDrlTjwxY9AgPVrdLq+PpoQHL/QqfVu1O0IU6gnXEoeiaKDsLNt9bs8Ka
         lUUPItZ1tjqqi2T4/0W6DaY5q3enLEN6kQms/3p/iDXrVjGYiUy1dzr1q/lcPeirMXGF
         9I710wbCgUI8DoyHfqw6StOKeu6rau9itbXIpJCe3coOD0A9GrMA43LmjyqmgVh9M61y
         avbmMtiR/dZ/6yPH4TwgedbCzB4blcZ1IhDUdH1vxVHCyKJGtapQfit5T2jBN/e8zt3o
         yz5HeWAPKnxR3TOxtzEOY9j4kw6rYF+/n2jPwJkIpmAlVWOgKaCa0Yi5dZAMGj/q8JbB
         NYSg==
X-Gm-Message-State: AOAM531tJ86mJp99aoQIlDNuEXedtgGD/Ztoj1I23jO5BPq+vhf6iA5T
        5ddCxFFlGGS2UaKQNrpkkp0K8w==
X-Google-Smtp-Source: ABdhPJxdfDTVTRjJT1U+XecRCKBuvP1jjAyucclSPbqCyw5eHhSNAYIVEookDXNF9kVxO1ee0QmofQ==
X-Received: by 2002:a2e:9189:: with SMTP id f9mr5759459ljg.295.1604926551157;
        Mon, 09 Nov 2020 04:55:51 -0800 (PST)
Received: from localhost (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id q191sm1620435ljb.139.2020.11.09.04.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 04:55:50 -0800 (PST)
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     "Andrew Lunn" <andrew@lunn.ch>, "DENG Qingfang" <dqfext@gmail.com>,
        "Vivien Didelot" <vivien.didelot@gmail.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "netdev" <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Marek Behun" <marek.behun@nic.cz>,
        "Russell King - ARM Linux admin" <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH net-next 3/3] net: dsa: listen for
 SWITCHDEV_{FDB,DEL}_ADD_TO_DEVICE on foreign bridge neighbors
From:   "Tobias Waldekranz" <tobias@waldekranz.com>
To:     "Vladimir Oltean" <olteanv@gmail.com>
Date:   Mon, 09 Nov 2020 13:54:08 +0100
Message-Id: <C6YQXZUI5RGL.2QLVGE7F8QC5I@wkz-x280>
In-Reply-To: <20201109123813.kjzvel7pszhcmcgw@skbuf>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 9, 2020 at 3:38 PM CET, Vladimir Oltean wrote:
> On Mon, Nov 09, 2020 at 02:31:11PM +0200, Vladimir Oltean wrote:
> > I need to sit on this for a while. How many DSA drivers do we have that
> > don't do SA learning in hardware for CPU-injected packets? ocelot/felix
> > and mv88e6xxx? Who else? Because if there aren't that many (or any at
> > all except for these two), then I could try to spend some time and see
> > how Felix behaves when I send FORWARD frames to it. Then we could go on
> > full blast with the other alternative, to force-enable address learning
> > from the CPU port, and declare this one as too complicated and not wort=
h
> > the effort.
>
> In fact I'm not sure that I should be expecting an answer to this
> question. We can evaluate the other alternative in parallel. Would you
> be so kind to send some sort of RFC for your TX-side offload_fwd_mark so
> that I could test with the hardware I have, and get a better
> understanding
> of the limitations there?

That is the plan. I have some stuff I need to get done before
though. The current implementation is on a 4.19 kernel, so it's going
to take some time to rebase it.
