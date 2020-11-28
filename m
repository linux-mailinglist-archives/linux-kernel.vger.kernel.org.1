Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3252C7159
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391536AbgK1VzS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 28 Nov 2020 16:55:18 -0500
Received: from aposti.net ([89.234.176.197]:60314 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387641AbgK1UEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 15:04:33 -0500
Date:   Sat, 28 Nov 2020 20:03:40 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] drm/ingenic: Add basic PM support
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Message-Id: <4QVIKQ.W7K2XGO9R8N22@crapouillou.net>
In-Reply-To: <20201128185820.GA1001988@ravnborg.org>
References: <20201128171606.132830-1-paul@crapouillou.net>
        <20201128185820.GA1001988@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le sam. 28 nov. 2020 à 19:58, Sam Ravnborg <sam@ravnborg.org> a écrit 
:
> Hi Paul.
> 
> On Sat, Nov 28, 2020 at 05:16:06PM +0000, Paul Cercueil wrote:
>>  Call drm_mode_config_helper_suspend() and
>>  drm_mode_config_helper_resume() on suspend and resume, respectively.
>> 
>>  This makes sure that the display stack is properly disabled when the
>>  hardware is put to sleep.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> 
> As discussed on irc, with resume fixed to return the result of the
> drm_mode_config_helper_resume() call.
> 
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Applied with the fix, thanks.

Cheers,
-Paul


