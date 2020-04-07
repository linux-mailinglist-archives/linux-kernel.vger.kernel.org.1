Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB891A1164
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 18:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgDGQbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 12:31:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:44755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727829AbgDGQbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586277060;
        bh=mGcNn/hciDAa1MtlzL+yKAo9BVtXHK66bYlr9Vx0ozY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ClIVEwm8T5Aa6VcCJQASK9GNmTiUt+aynyqNP6ZIf6TmCASZnR9d6SbWM4IKwXToa
         uDSaYF8YhZf7vRVraaXIW0ZEyzNelb3YOG308tHYAYxA6JtvRIZ+MrvngK+GJFa7vl
         uqD6AKqDz/szviFV+2smJlBnTz8UcQdkDFI7Iz78=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.196]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MMobO-1jcQZU17Xo-00IjSr; Tue, 07 Apr 2020 18:31:00 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Oscar Carter <oscar.carter@gmx.com>,
        Malcolm Priestley <tvboxspy@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Quentin Deslandes <quentin.deslandes@itdev.co.uk>,
        Amir Mahdi Ghorbanian <indigoomega021@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] staging: vt6656: Remove unnecessary local variable initialization
Date:   Tue,  7 Apr 2020 18:29:59 +0200
Message-Id: <20200407162959.7318-3-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200407162959.7318-1-oscar.carter@gmx.com>
References: <20200407162959.7318-1-oscar.carter@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UaY/NzihUNA7noUE4WYo5a2HMtl4iCD2xIPTYOXp8Y36W5So9s9
 SU6FGSAaXWqjiMZ+i4KJ+VgUy1o+JX72oXb9tGYSU58Q3IE3l7lUNmJPAvdGFCh48Kza7zj
 7q6va4Abvh8S41q4PvJ+72V6UcyBlL5Qt5XqjKFU3uR9tqibS5MqVDox6PBNVo36I7SHFWt
 /W6duAPkz/YzcdTJBKIGw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ssw9doPq2OE=:oj/WuGNg3mz2KQVXrTZJeP
 fqAuIHxpbaf8nQtNhm5rog717riSqPIP9MJVR/TfCLgQ+fmJ/hE74+AWu/MS3pqQl35et2TMn
 qqbvBObj6sYgYPBJlIbbymW76ahkZ/UOA34FTmLKesPEWt19QOCFKHKOBn9+/1g+oZJQ2qYN6
 PTHCVFNSUfKPlTHrogTTk4iTJALA4ZI6gq9ppXx4vO8ZICEfLB/I7u+pPdpmPmg6IbVLparz8
 9iq+Uc6FSBJ+QFzgvpHFIOJe3Mb/mBGtIswp8SWtbUc5iLrSF+8iBizALt2XJlhu5gDPaCORv
 lG/hnCDCLGhZac+TBcRkz6utSTNrHlV2qS6+f2f42d2pomdirIMNPkyxUlipbuUyY1u/7ITVV
 Mj6G+WVyaKmxToKy7z95rRLvd1ekCz9sljzF6iATGiIEkMt4MnqIwNfbxZ/J1rJEXLCSXwZXt
 R2MSpUhVsCoZe27VGOlhzqnz1OQ3T7V9gvP0VTMXKFobkhKpvbdseop5DGUMvczxEe0E8GkEo
 hT2G2eNis6gD1zDZROpep64c3e6n0adUNuq3pNCQz9ZUAHHbUjm+7fxKUqwz2Vcoc2Q/T3Ykm
 nMH9t/nyYBgHNa732VtdBlPeo8NN/tCkrbyS59jhoUvopE61fHouTfIaItTk6O2tWztposGa4
 lsoifrY/ybmGmHoNJ9cxitVrgJkaYIa0HrSgmU6UmpSbrE2hpqqaR3BWRJbtD0lClHDMrOnJX
 rAavBiWwk7HLMZsXDWm8PlDAYHpwS+BNabVl00Y1zGRMc/v4L9zuXzQ2G8Yb+sGVHQtWcPZJE
 yOBy7lpV3YvKZ/02C2cn50B1jBY2ygbv2H0zFhgOrV2CsfC980RQRs1opxOAqCQt3GI5EkAi4
 rhKE0w86Jtp6LeQLsnNGHYhW8GueyyDghIcx/kYRJw2rNiPvLXgyupEmHQ5axpuyeMvWzk/Q/
 z1gY0N5Rx1+YCXsIcvxAyx7JaIktqkHwqi7+Fa0S1KCR4/4WwrG7XTH3FBPGpY9A/EZWBH53o
 eeExstw5rCO5Z06p2LS+p4Gp1DR7Optf4xIIf/wd6viST0hM1bE7AcCsplcEp0B19N921KLDT
 CTwChosCov30WcasUYwCvNMCIsvt46NW6kLhfwVq7XkJlgwG7uqMEwBx71N6z0L/TYXQF5nQF
 CH21trLuLwMydyHMfR22ptE1QIBsYG6KfL7nuyI+AEezOtNDP8uQjCOjINwN1Lnjswcmm+d5q
 xDpKp27KcK33HmY/g
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't initialize the rate variable as it is set a few lines later.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
 drivers/staging/vt6656/baseband.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vt6656/baseband.c b/drivers/staging/vt6656/ba=
seband.c
index 092e56668a09..5d9bc97916a5 100644
=2D-- a/drivers/staging/vt6656/baseband.c
+++ b/drivers/staging/vt6656/baseband.c
@@ -135,7 +135,7 @@ unsigned int vnt_get_frame_time(u8 preamble_type, u8 p=
kt_type,
 {
 	unsigned int frame_time;
 	unsigned int preamble;
-	unsigned int rate =3D 0;
+	unsigned int rate;

 	if (tx_rate > RATE_54M)
 		return 0;
=2D-
2.20.1

