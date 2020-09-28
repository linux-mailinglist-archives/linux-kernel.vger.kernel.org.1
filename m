Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B3027B4A9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 20:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgI1SkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 14:40:16 -0400
Received: from mail-41103.protonmail.ch ([185.70.41.103]:43448 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgI1SkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 14:40:16 -0400
Received: from mail-03.mail-europe.com (mail-03.mail-europe.com [91.134.188.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 6D8362008B0E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 18:40:14 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="i2rR73AP"
Date:   Mon, 28 Sep 2020 18:39:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1601318411; bh=zi67LLnIHCXlIwN+LZwsHRacBhJfkJPNpMrdB5zosfc=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=i2rR73APDgZAHBaq7GCMZHrtTLYvB+lxdid55FwK6nnV8S0VI+3R2xNBAYJ8SboN3
         6oe6R5dfTO0Tz3FmaV3YCa75HDKMIObhy0fojDceluNrJo28u0WjH76253e9ASyqtr
         I09kavC8KJ4j46hGU6A1tLRUYv7y2TYtEd/waHq9w7dmsElx592L76VqZLC1O9rFdm
         SE0ZI6I3SWzUun3o0BqF0tNWusCc3bfjVVeRhujO+zKGizJ5aDnjRDlNmPxe+zRRsK
         CBnjlAiovA/MMNnnthcLv+QVqXincDRTEdGUhdpFz1ZF5/EI1ZOIp+/HEaM1tApc2k
         c8nZiBwbGC8+w==
To:     Jonathan Corbet <corbet@lwn.net>
From:   Mark Starovoytov <mstarovo@pm.me>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, Mark Starovoytov <mstarovo@pm.me>
Reply-To: Mark Starovoytov <mstarovo@pm.me>
Subject: [PATCH] mailmap: add entry for <mstarovoitov@marvell.com>
Message-ID: <20200928183948.589-1-mstarovo@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,TVD_PH_BODY_ACCOUNTS_PRE
        shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map the address to my private mail, because my Marvell account has been sus=
pended.

Signed-off-by: Mark Starovoytov <mstarovo@pm.me>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index a780211468e4..f7bd4ee8c4b9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -195,6 +195,7 @@ Maciej W. Rozycki <macro@mips.com> <macro@imgtec.com>
 Marcin Nowakowski <marcin.nowakowski@mips.com> <marcin.nowakowski@imgtec.c=
om>
 Marc Zyngier <maz@kernel.org> <marc.zyngier@arm.com>
 Mark Brown <broonie@sirena.org.uk>
+Mark Starovoytov <mstarovo@pm.me> <mstarovoitov@marvell.com>
 Mark Yao <markyao0591@gmail.com> <mark.yao@rock-chips.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@ginzinger.com>
 Martin Kepplinger <martink@posteo.de> <martin.kepplinger@puri.sm>
--=20
2.17.1


