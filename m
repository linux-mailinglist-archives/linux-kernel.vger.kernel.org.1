Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DA12B132C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 01:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgKMAU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 19:20:29 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:52944 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgKMAU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 19:20:28 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4CXJyf6T7ZzBc;
        Fri, 13 Nov 2020 01:20:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1605226827; bh=5AvHMwmdXrUqDje3yNByZNR9Li4JpuwLy9j5ruyPFms=;
        h=Date:From:Subject:To:Cc:From;
        b=B8gRlfkN0eVaYPJbKkEJHXXFuzXs8VBvfcwJmLbG2pFhTuzlQH2wOkv9fcaliqDO+
         JKqFpcwKlZwAqMN2rlUn2ooWFa9BnaTbvFjsqop0gJH8tRphvdqggUznOoM9uPMHl6
         uzJPcssISA9uuIP3VfBrQ8HjwsSXsBD3RcUTYoB0JrN3SfkGJk67Nn34H6wQCp0FKL
         DqCz1bfcgUBNQ2uL+InGINGA7h88I70ec99XC9mq3yphdRN00eEQ33tHwkQPY0JsS9
         CieFHEGjOG+xaXvFFBVVhRliLnIZTSXUGMdt+g6wATnKvIwf9MWfb9XnzshBVrB5qm
         sMEHT1e6GFHaA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Fri, 13 Nov 2020 01:20:26 +0100
Message-Id: <cover.1605226675.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [PATCH RESEND 0/4] regulator: debugging and fixing supply deps
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

(Series resent because of wrong arm-kernel ML address.)

Michał Mirosław (4):
  regulator: fix memory leak with repeated set_machine_constraints()
  regulator: debug early supply resolving
  regulator: avoid resolve_supply() infinite recursion
  regulator: workaround self-referent regulators

 drivers/regulator/core.c | 40 ++++++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 16 deletions(-)

-- 
2.20.1

