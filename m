Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2ACD2E85B8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 22:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbhAAV1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 16:27:00 -0500
Received: from mout.gmx.net ([212.227.17.22]:36295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbhAAV07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 16:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609536327;
        bh=n5VZorDxJ4E3jMomn5t3g5gHnoDeyVEV26lJvjdJRRI=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=XJS2kfa3tBOQlzAkuIP6EQric8alxi11stwmyZ+QKxR0BGf2i2jFB4kKb/39BH9Kr
         E2IlEyfZaji7s4cWV5WEy84HSIcAb9XgofN+u46UfoTCqqR9C1HPE48e7LEzMRg7ln
         4+T1+mj+keBOCOokq1QQoUY6yq0yZSY/H2DmYBIg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([37.201.215.57]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MK3Vu-1ka51N2CTe-00LWHp; Fri, 01
 Jan 2021 22:25:27 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH] scripts/jobserver-exec: Fix a typo ("envirnoment")
Date:   Fri,  1 Jan 2021 22:25:17 +0100
Message-Id: <20210101212519.1028884-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+oTew9IYDGEntlhthJG9SQZD+t1NOZtiN0WGumEIWe+K2KvtjE3
 d69WxHUcatnF3d2Z9XfDX+D+/I6vsGmxea3SvTjdWRwFJdGg6jURKI4qKC5ad96TjQdxNd8
 0ct3oeU7JFMv8TpPv6Vw0Qlm/KpXCJw4T6YnJrYNf94Je09jfkLByERXpkS7fZcTOdBPbqM
 UMR/rgf5SwZFtqbGNjnLA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ji1GKPCNcNQ=:gXmNYKb/40HcFGk6IsAZ1m
 9z8SWaObQulc3LmSfHPhy7plHmfUwYW1u0P8sYzPfdte959u33qwUJxzDXubXVc5I9S6txEFq
 KCBv7qeTuHB5fK1mrbKSZKy7GJ/LCLvc/ImmA8+LbEJJukOWNCoCqHicjlx2so9mXry4h+1IR
 H30wR1oMj6DL/lxukO2f8oleYWOg/okVUJ1o5rogljgrbjenBHCe3gTSdbv1PvA3GgDHz0uOd
 2GItogoNFaih245wquzeE3zSyw9le3IInADj9v7CCofSKA6UztThrG+UgngJuqFudRjAVwSwF
 D5yTZdp9EoA0eLmjEB7bO705yQ7lywOMzAMB32qi5jTg4tD6efzWvB6YOmkTBYEBca4RZ9V5X
 AG+V48wjP2B5NwBaH5Hto9/ylMZFysFVMVSozM51ZIcd0kDLOGFbYukRxMkSCfVM1V/RsN0ZA
 IbyZRbOxbYHZA9XnIvH4w46zoDj7e35CjIBI8LPLjp/HctC8aw1VkRPO5mSD/PUrA2Zaqf9Ws
 5Hj3v4QelDVrfHZ91TdchnBYZ0MsK8aieQ376fh1/DoARhxwhZTlad5+gd9BbGqsphLQEjVuf
 f+yH93lWpVyQCyhj+FlCzmQvNeDLll27aCKse8cnZ7dNxTWy8S5vjTEVrP8YqvES887swNyXM
 qUxucQbYCu/sAj/O/toK+Fx4WXOtGUXkNoTXDWLMJgm+MKzkW67QIbI9ouvAGilw66hP2HV8E
 9HR1D/bYQX3CWW4StTUrO5ADs3+lV+tUI0OBeC2RpM4Ce9qKqljJL4ym56jg7qFkTQrltzTTB
 Ufpxgvix0c0FosfS+hKXFQFO/Q8U8t7pzte0Uzh8fAW3pPe83LujwLE4ef15XSp7UzK0K3giD
 ixYp/bH9Mo25dS7QXSLA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 scripts/jobserver-exec | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/jobserver-exec b/scripts/jobserver-exec
index 0fdb31a790a81..1c779cd1ccb48 100755
=2D-- a/scripts/jobserver-exec
+++ b/scripts/jobserver-exec
@@ -10,7 +10,7 @@ from __future__ import print_function
 import os, sys, errno
 import subprocess

-# Extract and prepare jobserver file descriptors from envirnoment.
+# Extract and prepare jobserver file descriptors from environment.
 claim =3D 0
 jobs =3D b""
 try:
=2D-
2.29.2

