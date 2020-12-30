Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29912E7674
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 07:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgL3GXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 01:23:09 -0500
Received: from mail-m972.mail.163.com ([123.126.97.2]:42466 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgL3GXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 01:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=WFoKKNiR6ARwnUEcqW
        QAljrsCYsSC1HZ408ckQIIlzQ=; b=NgSNWWsojsIUjMHfAIOcAt7hDLIzNBj69P
        0e71FP/nrMchshmuNtAotX0eVHF9WepLY9PMDAGpvEPjHFYIRx94c7F+XiTKfKMv
        TPwhuU9Yg9UtV+JBzJ0JJB5fd7My8ie/fyRsnii4101tPOB0yMcFnQUOgmlfjmX3
        T1yb9WUwQ=
Received: from pek-pliu1-d1.wrs.com (unknown [60.247.85.82])
        by smtp2 (Coremail) with SMTP id GtxpCgD3h29pGOxf8oeWHA--.716S2;
        Wed, 30 Dec 2020 14:04:32 +0800 (CST)
From:   Liu Peibao <liupeibao@163.com>
To:     mhiramat@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: Review request 0/2: init/main.c: sink the kernel_init to the bottom
Date:   Wed, 30 Dec 2020 14:04:22 +0800
Message-Id: <20201230060424.29097-1-liupeibao@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GtxpCgD3h29pGOxf8oeWHA--.716S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUodgADUUUU
X-Originating-IP: [60.247.85.82]
X-CM-SenderInfo: xolx1vpled0qqrwthudrp/xtbBzRALbF0CO5i4WgAAsk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks better that sinking the kernel_init() to bottom. And such the
statement of kernel_init_freeable() is redundant. Also there is a
warning found by the checkpatch.pl.

