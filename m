Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8542B1319
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgKMAQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:16:51 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:58353 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbgKMAQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:16:51 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4CXJtS4ZzMzBc;
        Fri, 13 Nov 2020 01:16:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1605226609; bh=PKfext26ZSEBjtW9babqh2FuB50HIUS6rN783BtOwmw=;
        h=Date:From:Subject:To:Cc:From;
        b=OzGIcMAPaeoSuHfucksUencTqUEkVpFhmYcQ4YWnOQ5JZsyTDrutw0fRD83RceBur
         MfEdvxAZPYyOtagakJOvG2f0Br3HU9U3bL0DtjV+3BsReYonIk2A32IAdGovLbJuMZ
         tr6QcyO+X3lCKTMkDAckkUF+2DXDXqp6VOvtP7utQNDLr6FtbGUe9LGldaPX+yZvpJ
         onggR8SEnalti5qI4DLok8h62SCkwBdB+ioknrIuge5ysueW5oFFYnxejP9ps65WbS
         fbOA+vyCyycijZRp09wOoJcJVo8cWa4fjQaG/8caUqXNU8G9bY6qOpBkISXYK6lU0P
         CnpNZubKyH64A==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Fri, 13 Nov 2020 01:16:46 +0100
Message-Id: <cover.1605225991.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/4] regulator: debugging and fixing supply deps
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that commit aea6cb99703e ("regulator: resolve supply
after creating regulator") exposed a number of issues in regulator
initialization and introduced a memory leak of its own. One uncovered
problem was already fixed by cf1ad559a20d ("regulator: defer probe when
trying to get voltage from unresolved supply"). This series fixes the
remaining ones and adds a two debugging aids to help in the future.

The final patch adds a workaround to preexisting problem occurring with
regulators that have the same name as its supply_name. This worked
before by accident, so might be worth backporting. The error message is
left on purpose so that these configurations can be detected and fixed.

(The first two patches are resends from Nov 5).

Michał Mirosław (4):
  regulator: fix memory leak with repeated set_machine_constraints()
  regulator: debug early supply resolving
  regulator: avoid resolve_supply() infinite recursion
  regulator: workaround self-referent regulators

 drivers/regulator/core.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

-- 
2.20.1

