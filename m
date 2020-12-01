Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D48742C9969
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 09:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgLAIYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 03:24:36 -0500
Received: from mail.v3.sk ([167.172.186.51]:58616 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726120AbgLAIYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 03:24:35 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 6AE02E0715;
        Tue,  1 Dec 2020 08:20:58 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vYVICJXNuaDB; Tue,  1 Dec 2020 08:20:58 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id F3043E06F5;
        Tue,  1 Dec 2020 08:20:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OGd873nddM_r; Tue,  1 Dec 2020 08:20:57 +0000 (UTC)
Received: from localhost (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id A7D21DF9A4;
        Tue,  1 Dec 2020 08:20:57 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/4] Platform: OLPC: Register regulators for all power lines to DCON
Date:   Tue,  1 Dec 2020 09:23:44 +0100
Message-Id: <20201201082348.1723631-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm wondering if I could ask for help hooking up the OLPC display
controller driver to the power regulator framework. The DCON chip uses
four different power supplies (3.3V, 2.5V and two 1.8V) and the EC is in
charge of switching the regulators.

I'm not sure how does this plug into the regulator framework. Is it okay
if I make the EC driver expose the regulators and enforce that they all
enable at the same time? The patch set below aims to implement something
like that:

The first three patches are just loosely related to the problem; they
just prepare the field for the last patch:

  [PATCH RFC 1/4] Platform: OLPC: Specify the enable time for DCON power
  [PATCH RFC 2/4] Platform: OLPC: Fix handling of regulator registration
  [PATCH RFC 3/4] Platform: OLPC: Remove regulator_dev from the priv stru=
ct

This exposes three regulators all controlling the same EC power interface=
:

  [PATCH RFC 4/4] Platform: OLPC: Register regulators for all power lines

Thank you
Lubo

