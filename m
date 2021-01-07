Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16CC2EC82C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 03:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbhAGCld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 21:41:33 -0500
Received: from smtpcmd11116.aruba.it ([62.149.156.116]:56164 "EHLO
        smtpcmd11116.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbhAGCld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 21:41:33 -0500
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jan 2021 21:41:33 EST
Received: from ubuntu.localdomain ([146.241.198.163])
        by Aruba Outgoing Smtp  with ESMTPSA
        id xL4LkiX9OkRIKxL4LkeM1F; Thu, 07 Jan 2021 03:30:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1609986636; bh=T/3tAYcIse29GPq8KBZmxeUEKL6kngCkz57iuh6Rt+o=;
        h=From:To:Subject:Date:MIME-Version;
        b=MG+6iTvo09xggYooV0jpXiH2mlaWupc0iAB0H2msqheEcK7VEVDALOqqlR1177XsN
         6fRrj8WRe+5Ud7MxY3uT1eiIUqEZu9KGNvsYQbC/ZWvNqbMMAiEU4kOs1O1o/wCDUc
         DlbN3avo0bgumYRoXxHjvUODJICOugKGt2k1U8HWmdadzhMtpb4N/0+9B6zhjbIslm
         FWGKOydb7pK5DASHsSeC4vvlxJZmuZC8hV4NKvH7O+2Z+UTF49zYUQVK9qH+NuHM1J
         8OmWgDuD7XxTohcZmIldABHgD6fWsLjdjFpe7YkT9JX56CFLdeZ6FZOkKOqwRZejtJ
         qh6fZIYBw9dwg==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Marjan Pascolo <marjan.pascolo@trexom.it>, wens@csie.org,
        daniel@ffwll.ch, airlied@linux.ie, treding@nvidia.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Giulio Benetti <giulio.benetti@micronovasrl.com>
Subject: [PATCH v2 0/2] drm/sun4i: fix DCLK and improve its handling
Date:   Thu,  7 Jan 2021 03:30:30 +0100
Message-Id: <20210107023032.560182-1-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <3685133.SLcexNTYsu@kista>
References: <3685133.SLcexNTYsu@kista>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfDPwNH/FgacnF1sUUyqDtIHhJPzsiAY1wJSQ4dQfBax5aRm4Zi6mwJSLaQbhE5CmjOpGqBGUngrQgHGJt0GdkgiakP6SHa4P3QKO4/VWFMK+FjxxhrCv
 +TXHBPT8FJkM9S9Mfigu6+teKRKk8UOV853vWLWc2fEVeV6moKSNRJUSB0mX0r20rqAmtMIpNY4xiug2H0HEmTnODCUPC41h2wb5FquH1gPAkwYBl7fYWht3
 rQQRUUuw+s1g0pfIvALKMbCzbwJTjtWWu+xbgcLQBvQ3kspe5mXfe1EGGIOch4y5DbFPjPeWxqscUc+giXhqlRBdv9zrhEpYOE6mY49x1Xm9fDnBeUTlWNmP
 Fnn9FbMQEu5cNSmjs43Y9CvD2WqNef8KcOUh9NikYV+7n3+fKjiTMTUYL1QOikDAtB0vpJpqk8DCN14j66gd4+b1mstREjDgfI57bns/zCkA299KW6BsZJpr
 UmNtk2nAzw8xQ2oeawoite2lq3Y1D6FJ2vlIfS+syyK4k0pQFYlZIITHVylsDH2R97VQ78XNbvv5+21NRTLtoFj90KbJgP6H4HEgHQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

First patch is a tested by me fix, while the second need testing to
understand if it works correctly with any sunxi SoC with DE peripheral.
Already tested SoCs are:
- A20
- A33

Need testing:
- A10
- A10s
- A13

Giulio Benetti (2):
  drm/sun4i: tcon: fix inverted DCLK polarity
  drm/sun4i: tcon: improve DCLK polarity handling

 drivers/gpu/drm/sun4i/sun4i_tcon.c | 20 +-------------------
 drivers/gpu/drm/sun4i/sun4i_tcon.h |  1 +
 2 files changed, 2 insertions(+), 19 deletions(-)

-- 
2.25.1

