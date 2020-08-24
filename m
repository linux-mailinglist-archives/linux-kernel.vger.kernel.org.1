Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E286224FC75
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 13:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgHXLXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 07:23:21 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:41410 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgHXLXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:23:12 -0400
Date:   Mon, 24 Aug 2020 11:22:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1598268179; bh=yrg1J0Lts+eTmxcxiXjhYz4fa26vjELxzM3mrkKWEmk=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=I66bgMI2BwYC4u2e1VH9nPsG9POat19/wdhH6Q3lI35jf/FZDf1PDyJibi2K5L/NS
         BqRNobb+x5W+fDu6mPMuXjGCM2RJI29Q3Gfc3+1A2Yxpgg5IM+lQRgIbYOih4zKyDA
         hg2ZOpl549Qq5lnH4YUAoFhOqIkTBd9/fRaziMTGt7PGF4awLtCEacpKssnoXpADbR
         8BQ+GWPFj0/1ky/K245c6CsHPVQqKcCnC4E8nCTwRBowqczs/17Qh2hZ0FY5nFR1l+
         SSOS99140ki+DbRpSqiESYkDfL2+QQWjWQDvUbcNXFIcHxER6eYLw5ZWw+yRkujg3/
         EgVVqznnpHZkQ==
To:     linux-kernel@vger.kernel.org
From:   Mark Starovoytov <mstarovo@pm.me>
Cc:     Mark Starovoytov <mstarovo@pm.me>
Reply-To: Mark Starovoytov <mstarovo@pm.me>
Subject: [PATCH] mailmap: add entry for <mstarovoitov@marvell.com>
Message-ID: <20200824112221.19182-1-mstarovo@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,TVD_PH_BODY_ACCOUNTS_PRE
        shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
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
index 332c7833057f..4cf029cff065 100644
--- a/.mailmap
+++ b/.mailmap
@@ -191,6 +191,7 @@ Maciej W. Rozycki <macro@mips.com> <macro@imgtec.com>
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


