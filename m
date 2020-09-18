Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81FBD26F9AD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIRJzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:55:09 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46163 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIRJzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:55:09 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M597q-1kI7Am0ZlM-001EGb; Fri, 18 Sep 2020 11:54:52 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-rpi-kernel@lists.infradead.org, nsaenzjulienne@suse.de
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, marcgonzalez@google.com,
        jamal.k.shareef@gmail.com, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, inf.braun@fau.de, hch@lst.de,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/5] staging: vchiq: stop using compat_alloc_user_space
Date:   Fri, 18 Sep 2020 11:54:36 +0200
Message-Id: <20200918095441.1446041-1-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RIMQCO9sg3s7Q8uUPOZE8Q3ZaERCR8FzdWbwg646liLFhy7ixQA
 2jT7XzbAVGuaTErny+Vn/YxqDlCJk+rupKSMEl3Wf2thyWaXOONIcRbLmrVXD0IzHZavQKu
 UOUJPU4NYOTyZLFwZHHMQYqfUudD8RWjvAKgXbUk+iWiRIqOJuor2tB0WGRMP5NWxF2lRcn
 l+LCNOW5M0kDOb4MYZSCw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0u4mE8JqKjw=:6Y0WvuNn4FoaFfGM/Jqg70
 Yb0XhB2dy3ufIBhZqj+aYi+QcfbtjOjAvvmu9htz615k9TWylT3xGtqk+SAlHtCYgXiyoq5Cm
 StEv/hF84Q57nt6rB36m0yLtnMjUnF+ey71eeAbWVRBYHRXgagevMIXn/696sHxzdlciv0gdr
 tt1wO26rP9JkfX/QhhxvQQPuBJIxuYdXk9vyGNeTukiwVCPAtQIMMxw6aDnxehTuc4mr2/m3v
 7qmgHxIc44kADlaEifJFS0fDbX1UivPBOTLVDfZ8g42+73Ut9m5XCDBLp7W2uOl1MtA1kmDaU
 6y4N6ih/ED9ZM6Wc7qcP6wwwPJOVLwO1vFgqhlqSCntFLDp9cR+H54Q3GVnRa825NDLRVnl5g
 8DnFUFEE5FHs7a9h3HXAPj8SXtg1cjqNd0OP/EkTnIf9TsP5vzw9yE9G+zZ4D564ZXbxBxNWh
 W36Go+I0Qmp1hjb4cZBxnPI1uqK9ZjrK9VaDUtQ+XXaZICqantajSs4oEfs3Y82iACCu008zp
 eKxOVgiFOwAXmzuifLeyyePq39Ja2wNBXPxteE+mht0mkjShFsOems1eEyZplhSE5ut4sGz/L
 SxxGIqzFJ33v6P2MPHs9PxQEyQG3ymLwdooIZf39lnM5UebR1Di4GH0OEIavaDAMLiDrlDoXT
 kVXXBfyUyMsDw374X3NBiutwHv7+mskcp5h8wTmBNBiIOGObx2YLd+TMXhh2CZoarlImR46zI
 IlL0/NwLpiyHLxXstgJ7PTfpUl0S9Z+ajChN6Cf3QUgmd9PDTy/87vqr29W96gOmudmBwR3ci
 CpOMk0lEHLlHzrJ3Az20i2Na2Ci11VdjSWMk1U5wHALh1eeuJaJFaKn8dEbOrLLFe90g1Yl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is one of only a few remaining files using
compat_alloc_user_space() and copy_in_user() to implement the compat_ioctl
handlers.

Change it to be more like the other drivers, calling the underlying
implementation directly, which is generally simpler and less
error-prone.

This is only build tested so far.

    Arnd

Arnd Bergmann (5):
  staging: vchiq: rework compat handling
  staging: vchiq: convert compat create_service
  staging: vchiq: convert compat dequeue_message
  staging: vchiq: convert compat bulk transfer
  staging: vchiq: convert compat await_completion

 .../interface/vchiq_arm/vchiq_arm.c           | 1194 ++++++++---------
 1 file changed, 551 insertions(+), 643 deletions(-)

-- 
2.27.0

