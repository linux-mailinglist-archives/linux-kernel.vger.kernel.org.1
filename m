Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC43A2EC999
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 05:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbhAGErg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 23:47:36 -0500
Received: from relay4.mymailcheap.com ([137.74.80.156]:52964 "EHLO
        relay4.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbhAGErf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 23:47:35 -0500
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id C55E33F1D0;
        Thu,  7 Jan 2021 05:46:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 93F492A7E5;
        Thu,  7 Jan 2021 05:46:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1609994761;
        bh=8unyk0aOxyvIXZOJPusmERGg+i43rMAKH28AqjQ7mUY=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=tWG5DTHu16/GMSadEHWNO/lgoT9fzvzO4cYUEXp5Tvv4aTy9tVDas9RESuCa3EgyI
         g+EtosfDBEG8Nm3Z4/xZrYw7+Vk82TVV7SdOJ+gbDMA0WLpj9RClDJVTkHv9mFKQMq
         74tltlvR96q9kIsGXVkVBHUET9RxtGDBgWeXkXOY=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 075XNDlJ-52U; Thu,  7 Jan 2021 05:46:00 +0100 (CET)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Thu,  7 Jan 2021 05:46:00 +0100 (CET)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 934AD4228E;
        Thu,  7 Jan 2021 04:45:59 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="HdmdzN6t";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [192.168.1.235] (unknown [59.41.161.221])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 231964228E;
        Thu,  7 Jan 2021 04:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1609994755; bh=8unyk0aOxyvIXZOJPusmERGg+i43rMAKH28AqjQ7mUY=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=HdmdzN6tQ8OtkUpQeXMIGEF1zUavlVlWiiL1vh+Nh/HP5Yr+NlGVvEWwOMLiA1Pf0
         h4X4EAACCeCOyW0fafpJqRj4JpypRauSVDoNn90Ssl3y2UKPWLwgnpfb6hRTBYA50G
         W/6NnxPy5O2Zhl70TRDATe3EEmawivqOjiPlC5Kk=
Date:   Thu, 07 Jan 2021 12:00:21 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMty3ZCkEb9g5t6Hs5DN5yHXYvDhymriYqqV+6DZiC+Qb645ww@mail.gmail.com>
References: <20201128125257.1626588-1-icenowy@aosc.io> <CAMty3ZCkEb9g5t6Hs5DN5yHXYvDhymriYqqV+6DZiC+Qb645ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] drm/panel: feiyang-fy07024di26a30d: cleanup if panel attaching failed
To:     Jagan Teki <jagan@amarulasolutions.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <C1F366E9-0EDB-4679-BB93-92223F5B8C4A@aosc.io>
X-Rspamd-Server: mail20.mymailcheap.com
X-Spamd-Result: default: False [1.40 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1];
         ML_SERVERS(-3.10)[148.251.23.173];
         TO_DN_ALL(0.00)[];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[7];
         RECEIVED_SPAMHAUS_PBL(0.00)[59.41.161.221:received];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         FREEMAIL_CC(0.00)[gmail.com,ravnborg.org,linux.ie,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
         SUSPICIOUS_RECIPS(1.50)[];
         RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Queue-Id: 934AD4228E
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2021=E5=B9=B41=E6=9C=886=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=885:=
47:20, Jagan Teki <jagan@amarulasolutions=2Ecom> =E5=86=99=E5=88=B0:
>On Sat, Nov 28, 2020 at 6:23 PM Icenowy Zheng <icenowy@aosc=2Eio> wrote:
>>
>> Attaching the panel can fail, so cleanup work is necessary, otherwise
>> a pointer to freed struct drm_panel* will remain in drm_panel code=2E
>>
>> Do the cleanup if panel attaching failed=2E
>>
>> Fixes: 69dc678abc2b ("drm/panel: Add Feiyang FY07024DI26A30-D
>MIPI-DSI LCD panel")
>
>The fact that this has failed to probe due to recent changes in
>sun6i_mipi_dsi=2Ec I don't know how to put that into the commit message=
=2E

It's not related, we shouldn't assume this panel driver will always
be used with sunxi SoCs=2E

It's a panel driver bug that cannot deal with -EPROBE_DEFER well=2E

>> Signed-off-by: Icenowy Zheng <icenowy@aosc=2Eio>
>> ---
>
>Reviewed-by: Jagan Teki <jagan@amarulasolutions=2Ecom>
