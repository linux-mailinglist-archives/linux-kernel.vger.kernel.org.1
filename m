Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA852AD1C3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgKJIug convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Nov 2020 03:50:36 -0500
Received: from aposti.net ([89.234.176.197]:34636 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgKJIug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:50:36 -0500
Date:   Tue, 10 Nov 2020 08:50:22 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] drm/ingenic: ipu: Search for scaling coefs up to 102%
 =?UTF-8?Q?of=0D=0A?= the screen
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Message-Id: <YJOKJQ.8KD9M5MU0NTP2@crapouillou.net>
In-Reply-To: <20201107193311.GB1039949@ravnborg.org>
References: <20201105083905.8780-1-paul@crapouillou.net>
        <20201107193311.GB1039949@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le sam. 7 nov. 2020 à 20:33, Sam Ravnborg <sam@ravnborg.org> a écrit :
> Hi Paul.
> 
> On Thu, Nov 05, 2020 at 08:39:05AM +0000, Paul Cercueil wrote:
>>  Increase the scaled image's theorical width/height until we find a
>>  configuration that has valid scaling coefficients, up to 102% of the
>>  screen's resolution. This makes sure that we can scale from almost
>>  every resolution possible at the cost of a very small distorsion.
>>  The CRTC_W / CRTC_H are not modified.
>> 
>>  This algorithm was already in place but would not try to go above 
>> the
>>  screen's resolution, and as a result would only work if the CRTC_W /
>>  CRTC_H were smaller than the screen resolution. It will now try 
>> until it
>>  reaches 102% of the screen's resolution.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> 
> Looks like the patch does what the descriptions says.
> So in other words - look OK to me. I am not confident enogh for a r-b
> but my code reading is enough to warrant an a-b:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>

Note that this algorithm exists mostly as a band-aid for a missing 
functionality: it is not possible for userspace to request the closest 
mode that would encapsulate the provided one, because the GEM buffer is 
created beforehand. If there was a way to let the kernel tweak the 
mode, I could write a better algorithm that would result in a better 
looking picture.

Cheers,
-Paul


