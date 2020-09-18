Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221B426F9EC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgIRKIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:08:50 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:57043 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgIRKIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:08:50 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MNbtD-1k98Bu3muZ-00P8yi; Fri, 18 Sep 2020 12:08:34 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-fbdev@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, hch@lst.de,
        linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/3] fbdev: stop using compat_alloc_user_space
Date:   Fri, 18 Sep 2020 12:08:10 +0200
Message-Id: <20200918100812.1447443-1-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HqcSX/i6GHoFmyY01bRB6CKtbn8MaB27UT0Ol1JC5D61FuBVEpu
 UPtbHHIjZAKhvhQIb6QZpWTk7Cvz8P5eKYlnmDMJqr7FJvy1X67irWQrLyhQzU6E69ytquW
 ZfAToXAayZQo4NyFOk8sxVZoPPCvYtC28GytZbVhFJdZO9GwqVdM8lxXViaenpLZT7/zWSE
 0tFo8ku0w0LaTGLKnXUzQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UrDYAkK+Umc=:a8nXlg0sB7/GhQzgWi+SsZ
 lUXCGAR/C4+Rc2dXCEk+vaOsRWhG/8SIvdeULI4waJyV6JpwNBRYWhqi0Z/Lybz+NfALjbM/R
 ho4Nut4YdSvqVaRb8piiiFGKLex2y4CBM0dHk9UFSgQ83stdJrUtOHCZyedrAJobxLntYAkiP
 4a0nWVh8AKiuFIxWR94vmvsFx7wVEmTK4sSMHp01Sf5S4g89HGK1Cy/O9CpXGf0Y1y6B7TNa3
 F1JMSVbftE+XOD77JMPtIK71qd5A51I7jTepdSCimQpmCcHWNKV27vavkd955E6zAynJkY5xC
 N19IQhykPAUvUzBaeOv+iSp0z3QLBnAdVMD/THQ41mXwQp4eHKwUK6Hr0igt72WTJTxTBXpqX
 x9XlpodOvv3fUPa2/n25x5Q5EgQTxTeG98AS9WfZzrA/OhprUesO9HNqnhUIpCNWULsDErLks
 KXKc4UlSfxXymJDvptP82+KjZaCoQVWeXFMWTO/a2QI/87Eqz1CAicQVkKrbmP4TfJ+Aafp/l
 cdZQFBmk4is/W/5d7Wyyxlvqx2NWvhMeNS3CbL1Pvr9eKIVd8upoco07WtDcznT0h/MM4cmR1
 9tm9ZlbszPUHsbEkUZIpJy9HuS4NA8kQVfn7JIgsv14MBt/j4m6NByHExJqO8RNoHBKikMCdO
 X7Fpe3gduQ8h77quEA9flECZSaY1c0HMToCL0ya/elolj6a/CTwSbEoYzClC1GtDwe1ntmdUt
 nRyE6wROL/9ODIncDUHmuAoLfTrE6tUGVEdzkGxyK+Y7z/kc4mhbSQeRZ6xjs2U2BJvqYamQk
 z4aGgt1JMLwtriYPKcYrjBRxzjjUFGlh0mPlbuL+UpnzGgAAxAQn6w7NpOLKvs8Lf/Mjxk6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fbdev code uses compat_alloc_user_space in a few of its
compat_ioctl handlers, which tends to be a bit more complicated
and error-prone than calling the underlying handlers directly,
so I would like to remove it completely.

This modifies two such functions in fbdev, and removes another
one that is completely unused.

    Arnd

Arnd Bergmann (3):
  fbdev: simplify fb_getput_cmap()
  fbdev: sbuslib: remove unused FBIOSCURSOR32 helper
  fbdev: sbuslib: remove compat_alloc_user_space usage

 drivers/video/fbdev/core/fbmem.c |  44 +++++------
 drivers/video/fbdev/sbuslib.c    | 124 ++++++++++++++++++-------------
 2 files changed, 90 insertions(+), 78 deletions(-)

-- 
2.27.0

