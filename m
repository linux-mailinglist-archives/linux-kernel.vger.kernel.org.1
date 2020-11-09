Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344B42AB233
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 09:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgKIIJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 03:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727679AbgKIIJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 03:09:41 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311F3C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 00:09:40 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id i6so11152108lfd.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 00:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=axyGt1wqKAYfmWoWOLaDDpJAktMqWVgCi5lIj5UDrAs=;
        b=NM5AiWrn9Kvpwnbqi1yYTrJkkomsu0S8pl7Vg80ZkloeUv+01BQE5Lnrc1JD2yKrTY
         jxQFbbq1r3SFY+4sOPDEf4UJnnzSu20oIJoIEXyAI0irUXAZ2z73bPQ3mIw8NZTveZBW
         tqtoXpMRTQPrsjn3uyds8I3vUijGnf04zK0cU/Gdby7+n+8SKD1gEYPVC2QydRRuX64Z
         IXhjhAZLtuqjtArNOCcc6mz6FDGHGT2Gadmzp3NM8N8Pr5gZ8COJWKgf1C2MTNYl2bUT
         4W9c66JNcv1du6GR5LqSMdlSXZ/XbC0k6JiFMelDapWz0ClcLB3lDS6IxV45NY+pxH4F
         PAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=axyGt1wqKAYfmWoWOLaDDpJAktMqWVgCi5lIj5UDrAs=;
        b=icrQaMk4D/K0BVqd7GUlFDME1jKZ//veSGPfhWjkPUhbus9fZ/R6CHrC+SBIG3nH1k
         4sNl/Yly98narVDv06HsHeETm3rWH5w1OSeWQilCr5uVrk1gXbs88cBuXCfmybX8CJbl
         Op4a1dPDYkIQdHHDNcFo7ifUYLkoG32doDaBHU/c7ZnyM2k4gPmgPkEVVeFUvtDifgqw
         qvZHV6cTVCjI51ev3hBpMufpd7UhnRDOGU07Bijsh1URZSL1LBWiYQp1dQhaxfGbZqLN
         MzCukcCl0xwfa64tLA+PBgTddc/xxUXgMJE99IdCW3vHWGpbonorpXiDnGz7HmmWoFIR
         z5rw==
X-Gm-Message-State: AOAM533U35gLQCoMGNcC9jiuVMSlsGjdR+jUxbcecVUr+WPnhnUDMd1R
        UeUgaLUzAUtDMl1WmAlpJULcBQ==
X-Google-Smtp-Source: ABdhPJx3LZPSji/ECBg7RPCyQMIcGlS6xJLzOqAsT1lOV6TEsbYx1zLPL/2vY9O8jAI1pl1tC/KgfQ==
X-Received: by 2002:ac2:52b3:: with SMTP id r19mr877256lfm.140.1604909378618;
        Mon, 09 Nov 2020 00:09:38 -0800 (PST)
Received: from wkz-x280 (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id i4sm1691370lfd.190.2020.11.09.00.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 00:09:38 -0800 (PST)
From:   Tobias Waldekranz <tobias@waldekranz.com>
To:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc:     DENG Qingfang <dqfext@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
        Marek Behun <marek.behun@nic.cz>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Subject: Re: [RFC PATCH net-next 3/3] net: dsa: listen for SWITCHDEV_{FDB,DEL}_ADD_TO_DEVICE on foreign bridge neighbors
In-Reply-To: <20201109003028.melbgstk4pilxksl@skbuf>
References: <20201108131953.2462644-1-olteanv@gmail.com> <20201108131953.2462644-4-olteanv@gmail.com> <CALW65jb+Njb3WkY-TUhsHh1YWEzfMcXoRAXshnT8ke02wc10Uw@mail.gmail.com> <20201108172355.5nwsw3ek5qg6z7yx@skbuf> <20201108235939.GC1417181@lunn.ch> <20201109003028.melbgstk4pilxksl@skbuf>
Date:   Mon, 09 Nov 2020 09:09:37 +0100
Message-ID: <87y2jbt0hq.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 02:30, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Mon, Nov 09, 2020 at 12:59:39AM +0100, Andrew Lunn wrote:
>> We also need to make sure the static entries get removed correctly
>> when a host moves. The mv88e6xxx will not replace a static entry with
>> a dynamically learned one. It will probably rise an ATU violation
>> interrupt that frames have come in the wrong port.
>
> This is a good one. Currently every implementer of .port_fdb_add assumes
> a static entry is what we want, but that is not the case here. We want
> an entry that can expire or the switch can move it to a different port
> when there is evidence that it's wrong. Should we add more arguments to
> the API?

I don't think that would help. You would essentially be trading one
situation where station moves causes loss of traffic for another
one. But now you have also increased the background load of an already
choked resource, the MDIO bus.

At least on mv88e6xxx, your only option to allow the hardware to move
the station to another port autonomously is to add the entry as a
dynamically learnt one. However, since the switch does not perform any
SA learning on the CPU port in this world, the entry would have to be
refreshed by software, otherwise it would just age out.

Then you run in to this situation:

A and B are communicating.

       br0
  .----'|'----.
  |     |     |
swp0  swp1  wlan0
  |           |
  A           B

The switch's FDB:
A: swp0
B: cpu0 (due to this patchset)

Now B roams to an AP somewhere behind swp1 and continues to communicate
with A.

       br0
  .----'|'----.
  |     |     |
swp0  swp1  wlan0
  |     |
  A     B

The switch's FDB:
A: swp0
B: swp1

But br0 sees none of this, so at whatever interval we choose we will
refresh the FDB, moving the station back to the cpu:

A: swp0
B: cpu0

So now you have traded the issue of having to wait for the hardware to
age out its entry, to the issue of having to wait for br0 to age out its
entry. Right?
