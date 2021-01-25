Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF63303658
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729486AbhAZGPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:15:02 -0500
Received: from de-deferred2.bosch-org.com ([139.15.180.217]:35288 "EHLO
        de-deferred2.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728613AbhAYNIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 08:08:55 -0500
Received: from de-out1.bosch-org.com (snat-lb41g3-dmz-psi-sl1-maildeferred.fe.ssn.bosch.com [139.15.180.215])
        by fe0vms0193.rbdmz01.com (Postfix) with ESMTPS id 4DPVHp0XTXzD3l;
        Mon, 25 Jan 2021 13:56:54 +0100 (CET)
Received: from si0vm1948.rbesz01.com (lb41g3-ha-dmz-psi-sl1-mailout.fe.ssn.bosch.com [139.15.230.188])
        by si0vms0217.rbdmz01.com (Postfix) with ESMTPS id 4DPVFv1rWnz4f3lwd;
        Mon, 25 Jan 2021 13:55:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=de.bosch.com;
        s=key2-intmail; t=1611579315;
        bh=euRhdnUaVRB7WYYx1jBcEN1vRJOnUijtneH+xYtWGIM=; l=10;
        h=From:Subject:From:Reply-To:Sender;
        b=aWvsA1xDQjmcACqwmv7+MW8kD2Al0yZfwPDlbuZwGZqkmAkX93RAycf10d+Jpocpp
         NaiT4Ncd5Rh8JThS8E5JKlGRowdaXsbuzQm1MhB2K3hRMl46OTNj5/9z9z/4LCYjGC
         l0XzSbbOeKXF28dJ553vHJkMMWXmxv5lZRLIflzw=
Received: from fe0vm02900.rbesz01.com (unknown [10.58.172.176])
        by si0vm1948.rbesz01.com (Postfix) with ESMTPS id 4DPVFv1VhMz5PF;
        Mon, 25 Jan 2021 13:55:15 +0100 (CET)
X-AuditID: 0a3aad0c-f13ff700000020da-ec-600ebfb39f36
Received: from fe0vm1652.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm02900.rbesz01.com (SMG Outbound) with SMTP id 83.80.08410.3BFBE006; Mon, 25 Jan 2021 13:55:15 +0100 (CET)
Received: from SI-HUB2000.de.bosch.com (si-hub2000.de.bosch.com [10.4.103.108])
        by fe0vm1652.rbesz01.com (Postfix) with ESMTPS id 4DPVFv00zyzV15;
        Mon, 25 Jan 2021 13:55:15 +0100 (CET)
Received: from luchador.grb-fir.grb.de.bosch.com (10.19.187.97) by
 SI-HUB2000.de.bosch.com (10.4.103.108) with Microsoft SMTP Server id
 15.1.2106.2; Mon, 25 Jan 2021 13:55:14 +0100
From:   Mark Jonas <mark.jonas@de.bosch.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Adam.Thomson.Opensource@diasemi.com>,
        <stwiss.opensource@diasemi.com>, <marek.vasut@gmail.com>,
        <tingquan.ruan@cn.bosch.com>, <hubert.streidl@de.bosch.com>,
        Mark Jonas <mark.jonas@de.bosch.com>
Subject: [PATCH 0/1] mfd: da9063: Support SMBus and I2C mode
Date:   Mon, 25 Jan 2021 13:54:57 +0100
Message-ID: <20210125125458.1302525-1-mark.jonas@de.bosch.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNLMWRmVeSWpSXmKPExsXCZbVWVnfzfr4EgylNLBZL3y9ltph/5Byr
        xf2vRxktLu+aw2ZxdM89ZovWvUfYLa7+Xs9isbf1IrMDh8eKT/oeO2fdZffYtKqTzePOtT1s
        Hp83yQWwRnHZpKTmZJalFunbJXBlTHjHU/CEq6LzemID40KOLkZODgkBE4kr+4+zdDFycQgJ
        zGCSWLXmDBOEs5tR4kn3dChnB6PElm0v2EFa2AS0JG6e2MEMYosI1Eqs27oBrIhZoItJ4u3k
        z6xdjBwcwgI2EjMXxIDUsAioSvQ+vQJWzytgJ/Hv5GkWiNXyEjMvfWeHiAtKnJz5BCzODBRv
        3jqbGcKWkDj44gXzBEa+WUjKZiEpm4WkbAEj8ypGsbRUg7JcAyNLAwO9oqTU4ioDQ73k/NxN
        jJDw5dnBeKrng94hRiYOxkOMEhzMSiK8u/V4EoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzqvBs
        jBMSSE8sSc1OTS1ILYLJMnFwSjUwtc1weMVT13KobzvTs5PxM56eP9ASvjgs2PDjjmuFFWz7
        1IoKvm0urxXsaDtode9D3ZYvU5XmWC8Q/hqQc+LX20+/Ziuvk65lkGk4/eSgSWtniqu27uIA
        +fMXUjYe5p5XveR/LtMPNoEFU+7L+AVfWMT9siFiOntR+e9ZpUe8bz93a2AoXOHhtWd7kfkN
        TaVUJjPWZanthTrOyZWVvheKlwRufuZXPeXYFPvK5R2Xvqt4mc9cHtQZMyXGhOX+ft5JKdc5
        7hg73lNI2bpQpHHdhsdRiSdYd/06VCf00OHWqjPL/zf9m8pzcL+Gk/FF6VXv9yz6MFXn/aYv
        umFKpn3tJT2mDGkNcZMlbjeo9U+NVWIpzkg01GIuKk4EAJUbB9/OAgAA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On an NXP i.MX6 Solo processor we are running an application which makes
use of real-time threads (SCHED_RR). In combination with a DA9063 we
experienced (rare) random shut-downs and reboots. We found that the
issue was caused by a combination of the (default) DA9063 SMBus mode
and non-atomic I2C transactions of the i.MX6 I2C driver. Because a
transaction could be idle for longer than the SMBus clock time-out due
to a real-time thread the DA9063 would time-out and receive the second
half of the transaction as an unintended message.

The solution we are giving to review in this patch is to allow using the
I2C mode of the DA9063. We kindly ask for feedback and eventually hope
for an integration to the mainline.

Because we are on a vendor kernel we were not able to test this patch
on the current mainline kernel. Though, we tested a (very similar) patch
on our (close to mainline) Linux 4.14 and 5.4 vendor kernels.

Hubert Streidl (1):
  mfd: da9063: Support SMBus and I2C mode

 Documentation/devicetree/bindings/mfd/da9063.txt |  7 +++++++
 drivers/mfd/da9063-core.c                        |  9 +++++++++
 drivers/mfd/da9063-i2c.c                         | 13 +++++++++++++
 include/linux/mfd/da9063/core.h                  |  1 +
 include/linux/mfd/da9063/registers.h             |  3 +++
 5 files changed, 33 insertions(+)

-- 
2.25.1

