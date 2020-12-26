Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442832E2E2B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 13:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgLZMXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 07:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgLZMXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 07:23:20 -0500
X-Greylist: delayed 522 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 26 Dec 2020 04:22:40 PST
Received: from cc-smtpout3.netcologne.de (cc-smtpout3.netcologne.de [IPv6:2001:4dd0:100:1062:25:2:0:3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C0C2C061757
        for <linux-kernel@vger.kernel.org>; Sat, 26 Dec 2020 04:22:39 -0800 (PST)
Received: from cc-smtpin2.netcologne.de (cc-smtpin2.netcologne.de [89.1.8.202])
        by cc-smtpout3.netcologne.de (Postfix) with ESMTP id EA1BF1281E;
        Sat, 26 Dec 2020 13:13:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by cc-smtpin2.netcologne.de (Postfix) with ESMTP id C492F11E02;
        Sat, 26 Dec 2020 13:13:52 +0100 (CET)
Received: from [84.44.222.40] (helo=cc-smtpin2.netcologne.de)
        by localhost with ESMTP (eXpurgate 4.11.6)
        (envelope-from <kurt@garloff.de>)
        id 5fe72900-024d-7f0000012729-7f00000196cc-1
        for <multiple-recipients>; Sat, 26 Dec 2020 13:13:52 +0100
Received: from nas2.garloff.de (xdsl-84-44-222-40.nc.de [84.44.222.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by cc-smtpin2.netcologne.de (Postfix) with ESMTPSA;
        Sat, 26 Dec 2020 13:13:50 +0100 (CET)
Received: from [192.168.155.202] (ap4.garloff.de [192.168.155.15])
        by nas2.garloff.de (Postfix) with ESMTPSA id B2048B3B131B;
        Sat, 26 Dec 2020 13:13:49 +0100 (CET)
To:     Len Brown <len.brown@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Kurt Garloff <kurt@garloff.de>
Subject: turbostat: Fix Pkg Power on Zen
Message-ID: <1f1fb01e-0616-34ea-ede6-dc7dd679c3d4@garloff.de>
Date:   Sat, 26 Dec 2020 13:13:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------7B794C5CA64C1455EB0E089D"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7B794C5CA64C1455EB0E089D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Len,

find attached fix to avoid exiting with -13 on Zen. Patch is against turb=
ostat as included in Linux-5.10.2.
Please merge.

PS: This is probably material for -stable, as it used to work before on Z=
en (Zen2 aka Ryzen 3000 in my case).

--=20
Kurt Garloff <kurt@garloff.de>
Cologne, Germany


--------------7B794C5CA64C1455EB0E089D
Content-Type: text/x-patch; charset=UTF-8;
 name="turbostat-zen-pkgpower-510.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="turbostat-zen-pkgpower-510.diff"

commit b82f8e4cfcfd5d503226ed99b30a68aca25b7e18
Author: Kurt Garloff <kurt@garloff.de>
Date:   Sat Dec 26 13:00:15 2020 +0100

    turbostat: Fix Pkg Power tracking on Zen
   =20
    AMD Zen processors use a different MSR (MSR_PKG_ENERGY_STAT) than int=
el
    (MSR_PKG_ENERGY_STATUS) to track package power; however we want to re=
cord
    it at the same offset in our package_data.
    offset_to_idx() however only recognized the intel MSR, erroring
    out with -13 on Zen.
   =20
    With this fix, it will support the Zen MSR.
    Tested successfully on Ryzen 3000.
   =20
    Signed-off-by: Kurt Garloff <kurt@garloff.de>

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
index f3a1746f7f45..eb845421f492 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -325,6 +325,7 @@ int offset_to_idx(int offset)
 	int idx;
=20
 	switch (offset) {
+	case MSR_PKG_ENERGY_STAT:
 	case MSR_PKG_ENERGY_STATUS:
 		idx =3D IDX_PKG_ENERGY;
 		break;

--------------7B794C5CA64C1455EB0E089D--
