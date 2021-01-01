Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747942E85AF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 22:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbhAAVUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 16:20:10 -0500
Received: from mout.gmx.net ([212.227.15.19]:41165 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbhAAVUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 16:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609535908;
        bh=SEBirRQNsdff7T4jVtygRU8Hbx07IqHvJ56BFykpua8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Oo7RTtXBc5rWlVR6wJuYqbyuwwvq4GamzyiTDl4DskGgPByvM9JBwl4MwAgMgMq3D
         WY0RCWHR/QDxHy5y/XenKPnYsh2e1IZKEi3lK85iFmH+Fy60T+iz8vAuDK1hxx/yAi
         H6oumVuVBV6MSVuTuAkrtLfbbzx9zT6Oq/Gnl5X0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.57]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDXz-1k11FG3Xp7-00udbE; Fri, 01
 Jan 2021 22:18:27 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     dri-devel@lists.freedesktop.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mipi-dbi: Switch to new kerneldoc syntax for named variable macro argument
Date:   Fri,  1 Jan 2021 22:18:17 +0100
Message-Id: <20210101211818.1023919-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/jcMXDBSXErs310I68+O8MxCNGpK+ySrMql4+hvocEhdCZ4Ywi+
 PJDHDM5RJENBZ5yVRUQnUSCzywEb3+odIpnPJgr3r1PpYG5jtIWhFxv1SwAWd2zaAiMVRT2
 /525Z7UuWbLHgaFZwNNay1El/ykz4YLAIhzkeHR0j1OO2Jxqmz2mpIQ6H+B5+1pbFDgsIx1
 QbcsEaDV5vnlbWbdkm/Rg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5fVYP1534iA=:HCeJZ6esZ+U5WleLXzQP2o
 PMrTjornA64FZDJZYHBEFI0mHjQE9CoUEnIkNUA6EZL789ATeELQHLpnPyMoByZHl39yWaMD5
 0jOCr2tH1TqELLCsMRIntgAxZ0qo4bXNc7DNrseg9PwOjd4TTMHFQ2QNeaZQ+Hv6fA45NIGQu
 4Wx8wiJEFJbJFl9oPB24joQmRxUDEpL4cGlQb2BklKiAA/YlLD/C1JeGe53WDMjgPE6mr9Ww3
 LahxfWyHIdvpBbkAGsYIe/hsZCDpPgMDzfMs9HBahT+rWkluJIQAmbheGJGfAXts96JRa8SjE
 ++NcFvkjT6lBvy2cowSv67Pbmwy5mM7RJkoA8yai8kNZWDbkNZsAefG9/SSIDeoNm0Cj6NRkK
 hF41GsfXxR93y4KKE6kuzgEIyux2/G1CoXCwL62bOSRyAePp/RrnZbjti5LkAFB0l76omH7jk
 0QPBJkaimRgg99ylmzc/zRgkrllz5AR1jqVFC0geMdoCY93XMAEG8T80xIK9tTx6Fp1Nj4v7J
 fu8/BF7OENUiD+QHSz+tr+EByIcxKXaPOVA2HqVJiCW0zu+Y1Ta9cIhAJjoYpaFz+KTfOtxuJ
 a5LHySAWkHwyD9dCmtR0yWmCdHb+YzFTya3UyoeGxjaOid3R3B3VNpieWpG8jcKJ5WO22kHqK
 PiwbMbyDZso6UJoVpunMHGb37V+yMOsvB0QRMfuk+zBsF21NcFArF9l3S/282YCDr8HWjY+Jo
 OFl9GvM42f4AmW7QhojHG5WKVSJzvDlArfrxWGIcpanCny+izUuN+kWSMQtlHvEJL4NNw9Se3
 nvwQ5YfKe3BZ9B7Uw4PJRwQHW0Lc9HewBTHwY87GahFVdzzVjVWrj/7dFb26a83oX/0kD/Ibw
 796Goc/TXN8ZbDxjUlQA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The syntax without dots is available since commit 43756e347f21
("scripts/kernel-doc: Add support for named variable macro arguments").

The same HTML output is produced with and without this patch.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 include/drm/drm_mipi_dbi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_mipi_dbi.h b/include/drm/drm_mipi_dbi.h
index c2827ceaba0d2..f543d6e3e822c 100644
=2D-- a/include/drm/drm_mipi_dbi.h
+++ b/include/drm/drm_mipi_dbi.h
@@ -172,7 +172,7 @@ int mipi_dbi_buf_copy(void *dst, struct drm_framebuffe=
r *fb,
  * mipi_dbi_command - MIPI DCS command with optional parameter(s)
  * @dbi: MIPI DBI structure
  * @cmd: Command
- * @seq...: Optional parameter(s)
+ * @seq: Optional parameter(s)
  *
  * Send MIPI DCS command to the controller. Use mipi_dbi_command_read() f=
or
  * get/read.
=2D-
2.29.2

