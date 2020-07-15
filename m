Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06ED2214ED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 21:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGOTPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 15:15:20 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:32871 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbgGOTPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 15:15:14 -0400
Date:   Wed, 15 Jul 2020 19:15:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1594840502;
        bh=P/gvWR474i9qth5RZzFqPpPCdgTMcXM/XgN0ab28lYU=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=DnRkV5IYwD5QKQyrENU9/lmSOdE+IYr40nYm/Xxk5cMbG9vjjLZQutg//ASCWXLVa
         FwlxGzPgXvC1sUooE6vCAeYKCmYH3ioqS1Kqq45lIGwiBDxMYH4KRACRddky1VAtS5
         YvusbL9yXwrS7E+O6IYSqw2JRURgquOz8Ac+SCyE=
To:     lgirdwood@gmail.com
From:   Colton Lewis <colton.w.lewis@protonmail.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        Colton Lewis <colton.w.lewis@protonmail.com>
Reply-To: Colton Lewis <colton.w.lewis@protonmail.com>
Subject: [PATCH] regulator: Correct kernel-doc inconsistency
Message-ID: <20200715191438.29312-1-colton.w.lewis@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on mail.protonmail.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Silence documentation build warning by correcting kernel-doc comments.

./include/linux/regulator/machine.h:196: warning: Function parameter or mem=
ber 'max_uV_step' not described in 'regulation_constraints'
./include/linux/regulator/driver.h:206: warning: Function parameter or memb=
er 'resume' not described in 'regulator_ops'

Signed-off-by: Colton Lewis <colton.w.lewis@protonmail.com>
---
 include/linux/regulator/driver.h  | 2 +-
 include/linux/regulator/machine.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/dri=
ver.h
index 7eb9fea8e482..7258e678d809 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -117,7 +117,7 @@ enum regulator_status {
  *                       suspended.
  * @set_suspend_mode: Set the operating mode for the regulator when the
  *                    system is suspended.
- *
+ * @resume: Resume operation of suspended regulator.
  * @set_pull_down: Configure the regulator to pull down when the regulator
  *=09=09   is disabled.
  *
diff --git a/include/linux/regulator/machine.h b/include/linux/regulator/ma=
chine.h
index a84cc8879c3e..8a56f033b6cd 100644
--- a/include/linux/regulator/machine.h
+++ b/include/linux/regulator/machine.h
@@ -101,6 +101,7 @@ struct regulator_state {
  * @system_load: Load that isn't captured by any consumer requests.
  *
  * @max_spread: Max possible spread between coupled regulators
+ * @max_uV_step: Max possible step change in voltage
  * @valid_modes_mask: Mask of modes which may be configured by consumers.
  * @valid_ops_mask: Operations which may be performed by consumers.
  *
--=20
2.26.2


