Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8928F22EDAD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 15:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgG0NkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 09:40:19 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:8922 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728109AbgG0NkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:40:18 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Mon, 27 Jul 2020 21:39:57
 +0800 (GMT+08:00)
X-Originating-IP: [210.32.144.186]
Date:   Mon, 27 Jul 2020 21:39:57 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Larry Finger" <Larry.Finger@lwfinger.net>
Cc:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, kjlu@umn.edu,
        "Shreeya Patel" <shreeya.patel23498@gmail.com>,
        "Julia Lawall" <julia.lawall@inria.fr>,
        "Michael Straube" <straube.linux@gmail.com>,
        "Stefano Brivio" <sbrivio@redhat.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] Staging: rtl8188eu: rtw_mlme: Fix uninitialized
 variable authmode
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <66d9502e-682f-6ccd-ef90-138feee0c2ae@lwfinger.net>
References: <20200724122957.30411-1-dinghao.liu@zju.edu.cn>
 <20200724132836.GC316746@kroah.com>
 <66d9502e-682f-6ccd-ef90-138feee0c2ae@lwfinger.net>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1721a94f.13572.173908057cb.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgBn6Pwt2R5fMeheAA--.11594W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAggHBlZdtPRcawAesp
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbGCS07vEb7Iv0x
        C_Ar1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlV2xY628EF7xvwVC2z280aVAFwI0_Gc
        CE3s1lV2xY628EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wCS07vEe2I262IYc4CY6c8I
        j28IcVAaY2xG8wCS07vE5I8CrVACY4xI64kE6c02F40Ex7xfMIAIbVAv7VC0I7IYx2IY67
        AKxVWUJVWUGwCS07vEYx0Ex4A2jsIE14v26r1j6r4UMIAIbVAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lV2xY6x02cVAKzwCS07vEc2xSY4AK67AK6ry8MIAIbVCY0x0Ix7I2Y4AK64vIr41lV2
        xY6xAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCS07vE4x8a6x804xWlV2xY6xC20s026xCa
        FVCjc4AY6r1j6r4UMIAIbVC20s026c02F40E14v26r1j6r18MIAIbVC20s026x8GjcxK67
        AKxVWUGVWUWwCS07vEx4CE17CEb7AF67AKxVWUtVW8ZwCS07vEIxAIcVC0I7IYx2IY67AK
        xVWUJVWUCwCS07vEIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIAIbVCI42IY6xAIw2
        0EY4v20xvaj40_WFyUJVCq3wCS07vEIxAIcVC2z280aVAFwI0_Jr0_Gr1lV2xY6IIF0xvE
        x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAKPiBZZXMsIGluIHRoaXMgcm91dGluZSwgaXQgd291bGQgYmUgcG9zc2libGUgZm9yIGF1dGht
b2RlIHRvIG5vdCBiZSBzZXQ7IGhvd2V2ZXIsIAo+IGxhdGVyIGNvZGUgb25seSBjb21wYXJlcyBp
dCB0byBlaXRoZXIgX1dQQV9JRV9JRF8gb3IgX1dQQTJfSUVfSURfLiBJdCBpcyBuZXZlciAKPiB1
c2VkIGluIGEgd2F5IHRoYXQgYW4gdW5zZXQgdmFsdWUgY291bGQgbWFrZSB0aGUgcHJvZ3JhbSBm
bG93IGJlIGRpZmZlcmVudCBieSAKPiBhcmJpdHJhcmlseSBzZXR0aW5nIHRoZSB2YWx1ZSB0byB6
ZXJvLiBUaHVzIHlvdXIgc3RhdGVtZW50ICJUaGVuIGF1dGhtb2RlIG1heSAKPiBjb250YWluIGEg
Z2FyYmFnZSB2YWx1ZSBhbmQgaW5mbHVlbmNlIHRoZSBleGVjdXRpb24gZmxvdyBvZiB0aGlzIGZ1
bmN0aW9uLiIgaXMgCj4gZmFsc2UuCj4gCgpJdCdzIGNsZWFyIHRvIG1lLiBUaGFuayB5b3UgZm9y
IHlvdXIgYWR2aWNlLgoKUmVnYXJkcywKRGluZ2hhbwo=
