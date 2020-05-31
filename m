Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C32C51E963B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 10:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgEaIXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 04:23:23 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:5634 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725898AbgEaIXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 04:23:22 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Sun, 31 May 2020 16:23:10
 +0800 (GMT+08:00)
X-Originating-IP: [10.192.85.18]
Date:   Sun, 31 May 2020 16:23:10 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Markus Elfring" <Markus.Elfring@web.de>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ben Skeggs" <bskeggs@redhat.com>,
        "David Airlie" <airlied@linux.ie>, "Kangjie Lu" <kjlu@umn.edu>
Subject: Re: Re: [PATCH] drm/nouveau/clk/gm20b: Fix memory leak in
 gm20b_clk_new()
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <dd729c13-fbc8-22e7-7d8e-e3e126f66943@web.de>
References: <dd729c13-fbc8-22e7-7d8e-e3e126f66943@web.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <40d8fb01.db721.17269d3d620.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgCXQQVuadNec1ljAA--.9601W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgcRBlZdtOY5bwABsc
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUblCS07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlV2xY628EF7xvwVC2z280aVAFwI0_Gc
        CE3s1lV2xY628EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wCS07vEe2I262IYc4CY6c8I
        j28IcVAaY2xG8wCS07vE5I8CrVACY4xI64kE6c02F40Ex7xfMIAIbVAv7VC0I7IYx2IY67
        AKxVWUJVWUGwCS07vEYx0Ex4A2jsIE14v26r1j6r4UMIAIbVAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lV2xY6x02cVAKzwCS07vEc2IjII80xcxEwVAKI48JMIAIbVCF04k20xvE74AGY7Cv6c
        x26r4fKr1UJr1lV2xY6xCjnVCjjxCrMIAIbVCFx2IqxVCFs4IE7xkEbVWUJVW8JwCS07vE
        x2IqxVAqx4xG67AKxVWUJVWUGwCS07vEx2IqxVCjr7xvwVAFwI0_JrI_JrWlV2xY6I8E67
        AF67kF1VAFwI0_Jw0_GFylV2xY6IIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lV2xY6IIF0xvE
        2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCS07vEIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s
        1lV2xY6IIF0xvEx4A2jsIE14v26r1j6r4UMIAIbVCI42IY6I8E87Iv6xkF7I0E14v26r4j
        6r4UJbIYCTnIWIevJa73U
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAKPiA+IEl0J3MgdGhlIHNhbWUgd2hlbiBnbTIwYl9jbGtfbmV3KCkgcmV0dXJucyBmcm9tIGVs
c2V3aGVyZSBmb2xsb3dpbmcgdGhpcyBjYWxsLgo+IAo+IEkgc3VnZ2VzdCB0byByZWNvbnNpZGVy
IHRoZSBpbnRlcnByZXRhdGlvbiBvZiB0aGUgc29mdHdhcmUgc2l0dWF0aW9uIG9uY2UgbW9yZS4K
PiBDYW4gaXQgYmUgdGhhdCB0aGUgYWxsb2NhdGVkIGNsb2NrIG9iamVjdCBzaG91bGQgYmUga2Vw
dCB1c2FibGUgZXZlbiBhZnRlcgo+IGEgc3VjY2Vzc2Z1bCByZXR1cm4gZnJvbSB0aGlzIGZ1bmN0
aW9uPwo+IAoKSXQncyBwb3NzaWJsZSB0aGF0IHdlIGV4cGVjdCBhbiB1c2FibGUgY2xrIHBvaW50
ZXIsIHRob3VnaCBJIGNvdWxkIG5vdCBmaW5kCnRoZSBleGFjdCB1c2FnZSB5ZXQuIEZvciBzZWN1
cml0eSwgSSB3aWxsIHJlbGVhc2UgdGhpcyBwb2ludGVyIG9ubHkgb24gZXJyb3IgCnBhdGhzIGlu
IHRoaXMgZnVuY3Rpb24uCgo+IAo+IFdvdWxkIHlvdSBsaWtlIHRvIGFkZCB0aGUgdGFnIOKAnEZp
eGVz4oCdIHRvIHRoZSBjb21taXQgbWVzc2FnZT8KPiAKClRoYW5rIHlvdSBmb3IgeW91ciBhZHZp
Y2UhIEkgd2lsbCBhZGQgdGhpcyB0YWcgaW4gdGhlIG5leHQgdmVyc2lvbiBvZiBwYXRjaC4KClJl
Z2FyZHMsCkRpbmdoYW8=
