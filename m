Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93D32D27C4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgLHJfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:35:01 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:55307 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgLHJe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:34:59 -0500
Received: from orion.localdomain ([95.117.39.192]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M8hlZ-1kqiDJ1wwb-004mb7; Tue, 08 Dec 2020 10:32:08 +0100
From:   "Enrico Weigelt, metux IT consult" <info@metux.net>
To:     linux-kernel@vger.kernel.org
Cc:     duncan.sands@free.fr, accessrunner-general@lists.sourceforge.net,
        linux-usb@vger.kernel.org
Subject: [PATCH 1/3] drivers: usb: atm: reduce noise
Date:   Tue,  8 Dec 2020 10:32:04 +0100
Message-Id: <20201208093206.24780-1-info@metux.net>
X-Mailer: git-send-email 2.11.0
X-Provags-ID: V03:K1:iSgMJMzCNUTd221b4ZZkoUHSLM4f7iwwAPT7Elb1vOnULyrJnNr
 3bazwtfUVGsfuSO0cSygFbaTm6cajstD8lMNd/JmBPt4DpC9uf/WMtWEZd4MNguqkn6vGh9
 kLZ9t1Xn4gkACfSKgCar+//SOGDOClxV7SY8rzG/SZzltKnAawbYMUt3svgcvV4QsNpPvL5
 O9VcNumL/0tpNQSeBbCrw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7XLfjbf7OQ0=:7zc+8I1V8VTU6ktfQyvqu7
 5lcISjwfr+iumYsKiR/YsehQseA7WtANLNQrLIUjXpIYM9Cg9MSRE8rj8flsrG6esdAC0zi+4
 UR5CWGUvv4qghaG4dL6ecMAMsaiHJMz8Rv9iNhGv/MWUVgxUFCzThqPVyyrLm7B+HXfnCAjY3
 QPk2GhVw6Q27BFbUC9EyqsQUu00Xttu16Q0uJmSO+YTu/IDPkuM4FIhwakKnTuYUfCUj2fn6C
 EDihV2S/Ry0+8XSWScr2PUA98o0Ps+r9j8QuXfofjIWa6aKhrUaFUOi3BsudC1aSUazN/Tfuw
 z6nDdhSeCpSV/dhQGMmQaqBMczBxqtKonxmuuu1VYYQOm7gvRdcc4FQOwJlzkS1PSRLFxHHp5
 DiiKowD5KpTFyBrdkzHtiB04B6oi0NcJwb8sEi5A8RMX+VwffUleMUOqpUMlL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If drivers work correctly, they should remain silent.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 drivers/usb/atm/cxacru.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/usb/atm/cxacru.c b/drivers/usb/atm/cxacru.c
index e62a770a5d3b..0114cc54e622 100644
--- a/drivers/usb/atm/cxacru.c
+++ b/drivers/usb/atm/cxacru.c
@@ -810,9 +810,6 @@ static int cxacru_atm_start(struct usbatm_data *usbatm_instance,
 	mutex_unlock(&instance->poll_state_serialize);
 	mutex_unlock(&instance->adsl_state_serialize);
 
-	printk(KERN_INFO "%s%d: %s %pM\n", atm_dev->type, atm_dev->number,
-			usbatm_instance->description, atm_dev->esi);
-
 	if (start_polling)
 		cxacru_poll_status(&instance->poll_work.work);
 	return 0;
-- 
2.11.0

