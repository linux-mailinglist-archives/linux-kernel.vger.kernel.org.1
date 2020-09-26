Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0E1279C43
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 21:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgIZTwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 15:52:46 -0400
Received: from crapouillou.net ([89.234.176.41]:53664 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgIZTwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 15:52:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1601149964; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bbvZ4S5ZsNKQOCsIjc6o3syVQHMaJOxJwAZvYkhk8XU=;
        b=uPuoqs/mPao1mGuotGA/RYR4hP30E8X739I2hgihzUNJqhGqBpGaai+KPrycPEb2E+Ha+L
        9pXCAoXGwYBAd0AU7Z6ivUTvLFKTdEmqGzesSOKlfhtfI8OeHl9Is8Z95M2BR7AcRw7VzM
        WqyJqXfEgRXNJgEVaG1vE9MKRYAe6hQ=
Date:   Sat, 26 Sep 2020 21:52:33 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v2 0/7] Ingenic-drm improvements + new pixel formats
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-Id: <L77AHQ.S2E32L5HRQOA1@crapouillou.net>
In-Reply-To: <20200926182548.GB91317@ravnborg.org>
References: <20200926170501.1109197-1-paul@crapouillou.net>
        <20200926182548.GB91317@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le sam. 26 sept. 2020 =E0 20:25, Sam Ravnborg <sam@ravnborg.org> a=20
=E9crit :
> Hi Paul.
>=20
> On Sat, Sep 26, 2020 at 07:04:54PM +0200, Paul Cercueil wrote:
>>  Hi,
>>=20
>>  This is a V2 of my small patchset "Small improvements to=20
>> ingenic-drm"
>>  that I sent about two weeks ago. In that time, I worked on new
>>  improvements, so I thought I'd just add them to the patchset, since
>>  I needed a V2 anyway.
>>=20
>>  Sam: the patches you acked have been all slightly modified, I kept=20
>> your
>>  acked-by on them, please tell me if that's OK.
>=20
> All patches except "Add support for paletted 8bpp" are:
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Alright, I'll push the other ones, and keep the 8bpp one for a V3.

-Paul

>=20
>=20
>=20
> 	sam
>>=20
>>  Cheers,
>>  -Paul
>>=20
>>  Paul Cercueil (7):
>>    drm/ingenic: Reset pixclock rate when parent clock rate changes
>>    drm/ingenic: Add support for reserved memory
>>    drm/ingenic: Alloc F0 and F1 DMA descriptors at once
>>    drm/ingenic: Support handling different pixel formats in F0/F1=20
>> planes
>>    drm/ingenic: Add support for paletted 8bpp
>>    drm/ingenic: Add support for 30-bit modes
>>    drm/ingenic: Add support for 24-bit modes
>>=20
>>   drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 262=20
>> +++++++++++++++++++---
>>   drivers/gpu/drm/ingenic/ingenic-drm.h     |   3 +
>>   2 files changed, 228 insertions(+), 37 deletions(-)
>>=20
>>  --
>>  2.28.0


