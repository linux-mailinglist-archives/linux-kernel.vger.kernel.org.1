Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53149223EE2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 16:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgGQO45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 10:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgGQO45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:56:57 -0400
X-Greylist: delayed 365 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Jul 2020 07:56:56 PDT
Received: from forward101j.mail.yandex.net (forward101j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F0EC0619D2;
        Fri, 17 Jul 2020 07:56:56 -0700 (PDT)
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id 698A71BE0377;
        Fri, 17 Jul 2020 17:50:45 +0300 (MSK)
Received: from mxback4q.mail.yandex.net (mxback4q.mail.yandex.net [IPv6:2a02:6b8:c0e:6d:0:640:ed15:d2bd])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id 62C53CF40004;
        Fri, 17 Jul 2020 17:50:45 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback4q.mail.yandex.net (mxback/Yandex) with ESMTP id QqLLPKvti9-oiGKjpS7;
        Fri, 17 Jul 2020 17:50:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1594997444;
        bh=dYUGYiu6pNonVdQuyFFI2i91J0LSxcgntC14SiS/iGI=;
        h=Date:Message-Id:Cc:Subject:To:From;
        b=xDEHEDyPZI8MvB+DlXNAgdcOF21axirrmgPOmMrX+7sCmNOUkXaQlFG6eKpJJuzJt
         uhSluJNH/qc5RzsXMd2VwCZlg+AOdKuaV8GDxwOtRhJRhsJ+ddQIqe4S4ijkDRJGtz
         qcq2tN6IHZvuqmPMylWaURJ0Db6KhstKEL+3HFSY=
Authentication-Results: mxback4q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla5-b4d100574cfc.qloud-c.yandex.net with HTTP;
        Fri, 17 Jul 2020 17:50:44 +0300
From:   Evgeny Novikov <novikov@ispras.ru>
Envelope-From: eugenenovikov@yandex.ru
To:     Jean Delvare <jdelvare@suse.com>
Cc:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ldv-project-org <ldv-project@linuxtesting.org>
Subject: hwmon: (xgene) missing iounmap() and memunmap()
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 17 Jul 2020 17:50:44 +0300
Message-Id: <687151594996519@mail.yandex.ru>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xgene_hwmon_probe() invokes ioremap() and memremap() under
certain assumptions, but the driver does not invoke iounmap() and
memunmap() either on probe error handling paths or in
xgene_hwmon_remove().

I assume a patch would be non-trivial while I have not a capability
to test it well.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
