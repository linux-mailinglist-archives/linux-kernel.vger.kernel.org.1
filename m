Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5A92AACB1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 18:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgKHR7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 12:59:50 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:45508 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgKHR7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 12:59:50 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 39F3B80538;
        Sun,  8 Nov 2020 18:59:47 +0100 (CET)
Date:   Sun, 8 Nov 2020 18:59:45 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     trix@redhat.com
Cc:     tzimmermann@suse.de, airlied@linux.ie,
        nouveau@lists.freedesktop.org, gustavoars@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kraxel@redhat.com, spice-devel@lists.freedesktop.org,
        airlied@redhat.com, virtualization@lists.linux-foundation.org,
        bskeggs@redhat.com
Subject: Re: [PATCH] drm: remove unneeded break
Message-ID: <20201108175945.GA1508644@ravnborg.org>
References: <20201019163115.25814-1-trix@redhat.com>
 <20201019170641.GA963808@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019170641.GA963808@ravnborg.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=20KFwNOVAAAA:8 a=7gkXJVJtAAAA:8
        a=fi46lLvuFyj7XQ7yi5sA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom
On Mon, Oct 19, 2020 at 07:06:41PM +0200, Sam Ravnborg wrote:
> Hi Tom
> On Mon, Oct 19, 2020 at 09:31:15AM -0700, trix@redhat.com wrote:
> > From: Tom Rix <trix@redhat.com>
> > 
> > A break is not needed if it is preceded by a return or break
> > 
> > Signed-off-by: Tom Rix <trix@redhat.com>
> 
> Looks good and builds with no warnings.
> 
> One of the diffs made me - "oh this looks wrong". But after I looked again
> it was right and the resulting code is more readable - so good.
> 
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Was tempted to just apply to drm-misc-next but will give others the
> opportunity to chime in.

Thanks.
Now applied to drm-misc-next - will show up in -next in a week or so.

	Sam
