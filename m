Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6148C2CFE5F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 20:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgLET1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 14:27:09 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:54164 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgLET1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 14:27:09 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id CF4C7804C8;
        Sat,  5 Dec 2020 20:26:21 +0100 (CET)
Date:   Sat, 5 Dec 2020 20:26:20 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm: panel: add flags to BOE NV110WTM-N61
Message-ID: <20201205192620.GE332836@ravnborg.org>
References: <20201201125554.v2.1.I8a7bfc0966e803ab91001c9e6d01a736950c4981@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201125554.v2.1.I8a7bfc0966e803ab91001c9e6d01a736950c4981@changeid>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=cm27Pg_UAAAA:8 a=7gkXJVJtAAAA:8 a=pGLkceISAAAA:8
        a=e5mUnYsNAAAA:8 a=k9QfZ0pYOBYzvvIi-LIA:9 a=CjuIK1q_8ugA:10
        a=xmb-EsYY8bH0VWELuYED:22 a=E9Po1WZjFZOl8hwRPBS3:22
        a=Vxmtnl_E_bksehYqCbjh:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

On Tue, Dec 01, 2020 at 12:56:11PM -0800, Douglas Anderson wrote:
> I forgot to add these when posting up the support for BOE
> NV110WTM-N61.  Add them now.
> 
> Fixes: a96ee0f6b58d ("drm: panel: simple: Add BOE NV110WTM-N61")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: dri-devel@lists.freedesktop.org

Thanks for noticing my fumbling and fixing this up in the correct way.
Applied to drm-misc-next.

	Sam
