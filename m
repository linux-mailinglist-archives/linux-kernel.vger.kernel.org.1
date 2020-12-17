Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC542DD2B2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 15:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgLQOOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 09:14:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLQOOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 09:14:01 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D90BFC061794
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 06:13:20 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id g24so7721438qtq.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 06:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1W7HWkK0e8ZwL+3YOI6wvH3/gtZCie/A8YszznlKKqQ=;
        b=ThogHRWEKye4fpcRYf7dv7q3xZ6EAM94Zcc5QuGiHJWgqemM+Y7xURVQBt1jHHkbMb
         HIWqg1pUj46gRuRmH9XLS1B30igGzL2MhLthey+MDDoGTMpFyhgnO41qegGFd96snQxq
         x+QuUmhLytuqfXQj5EZdQ405g5JjstytIRa1hFLvPfhNJMdbmFIvrMtL/MR/KZtakBrP
         5dDeBSKN/PzW1zP40CHlSjZ3d9eMDimVGJeuIRUjOxX6VJLk4IZGcpysSrvLh/RsMGBO
         OHA+30jGTYWV/z+1RKDXXXgY2vp6ZNPd3hXm2QrnicOC4ib25SOI3PehaIUipEIHTqif
         0jZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1W7HWkK0e8ZwL+3YOI6wvH3/gtZCie/A8YszznlKKqQ=;
        b=VmkA86PMySZGUcs3U3KEDqfvsvSZHIMcUWs5WFNVBhaYmlwp5ivZdjLMSQ+lAPNMJd
         s60xQnvEmzKizv5CJQuD1AzVsUaeziA0TNy3BWZ+o8ij7og9sxuHW9zk0wAfB4SEthQZ
         LpcjOQ75afo3ql4993DC4q0TS+Q+V7kccserdWNxXncUUT375p5X8U8vy5skoBHAFboO
         TYH0+i5ZArJsQ9lpQjJ0ZiqK8fY9rmJIXGuhwUzsRq2Z7sOhlPnfpPIFFjx4OzZhOXyX
         FmDUgEQT6aKBVgoS/g+yT6kkyl+4XWotpru5Bq2QFAqGPGS1K5Oi6eOxiGRK7Yj+qzz8
         iLOQ==
X-Gm-Message-State: AOAM5328KvfgJJMGd8HCo8x0CoPQ1SV6zpQww5ZNuvrFpG9teMwoZlB+
        g6jYncouI2zZUcIwFK9gjTZXFDhjDExIx/mtnNz6qw==
X-Google-Smtp-Source: ABdhPJzlz11Oo4fcMwwilYwBQt9h0JX7y3PNSUMcfeLQ6XrWem8z95fVo4AFrEF6LRYZ5wDKA+5iVyasLJTDkCP1uus=
X-Received: by 2002:ac8:6f4f:: with SMTP id n15mr43951803qtv.216.1608214400055;
 Thu, 17 Dec 2020 06:13:20 -0800 (PST)
MIME-Version: 1.0
References: <1608198007-10143-1-git-send-email-stefanc@marvell.com>
 <1608198007-10143-2-git-send-email-stefanc@marvell.com> <CAPv3WKcwT9F3w=Ua-ktE=eorp0a-HPvoF2U-CwsHVtFw6GKOzQ@mail.gmail.com>
 <20201217140927.GA2981994@lunn.ch>
In-Reply-To: <20201217140927.GA2981994@lunn.ch>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 17 Dec 2020 15:13:08 +0100
Message-ID: <CAPv3WKdFWgjun8uZ2=g5Mhg0tY1QXoDAqKApL5O5WALsfv3Pcw@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] net: mvpp2: disable force link UP during port
 init procedure
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Stefan Chulski <stefanc@marvell.com>,
        netdev <netdev@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>, nadavh@marvell.com,
        Yan Markman <ymarkman@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Russell King <rmk+kernel@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 17 gru 2020 o 15:09 Andrew Lunn <andrew@lunn.ch> napisa=C5=82(a):
>
> > Do you think it's a fix that should be backported to stable branches?
> > If yes, please add 'Fixes: <commit ID> ("commit title")' and it may be
> > good to add 'Cc: stable@vger.kernel.org' adjacent to the Signed-off-by
> > tag.
>
> netdev patches should not be Cc: stable@vger.kernel.org. David and
> Jakub handle stable patches directly.
>

Thanks for clarification.

Marcin
