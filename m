Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AE81E9D3B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 07:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgFAFVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 01:21:42 -0400
Received: from spam.zju.edu.cn ([61.164.42.155]:17738 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725847AbgFAFVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 01:21:41 -0400
Received: by ajax-webmail-mail-app4 (Coremail) ; Mon, 1 Jun 2020 13:21:27
 +0800 (GMT+08:00)
X-Originating-IP: [222.205.72.4]
Date:   Mon, 1 Jun 2020 13:21:27 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   dinghao.liu@zju.edu.cn
To:     "Ben Skeggs" <skeggsb@gmail.com>
Cc:     kjlu@umn.edu, "David Airlie" <airlied@linux.ie>,
        "ML nouveau" <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "ML dri-devel" <dri-devel@lists.freedesktop.org>,
        "Ben Skeggs" <bskeggs@redhat.com>, Markus.Elfring@web.de
Subject: Re: Re: Re: [PATCH] drm/nouveau/clk/gm20b: Fix memory leak in
 gm20b_clk_new
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190906(84e8bf8f)
 Copyright (c) 2002-2020 www.mailtech.cn zju.edu.cn
In-Reply-To: <CACAvsv5t2gWDae_8b0-fH9e8fzgmxfiUtZTPeFuhmKXDFAmvGw@mail.gmail.com>
References: <20200529080042.6082-1-dinghao.liu@zju.edu.cn>
 <CACAvsv73wZK_pKk4TDHaTeBUqxYHvK0KhLQBgPC8Be_VviY2jg@mail.gmail.com>
 <6a65a5b1.dd4b7.1726deaea0a.Coremail.dinghao.liu@zju.edu.cn>
 <CACAvsv5kcUC_kOfMPxqY-irSAexmhm=WKO8Vk=wTZWdsbaartw@mail.gmail.com>
 <CACAvsv5t2gWDae_8b0-fH9e8fzgmxfiUtZTPeFuhmKXDFAmvGw@mail.gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <b3db4d2.ddd1e.1726e53d54b.Coremail.dinghao.liu@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cS_KCgCHIARXkNRe+6VsAA--.10702W
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAgUSBlZdtOZozQABsu
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJTRUUUbX0S07vEb7Iv0x
        C_Cr1lV2xY67kC6x804xWlV2xY67CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DMIAI
        bVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4ylV2xY628lY4IE4IxF12IF4w
        CS07vE84x0c7CEj48ve4kI8wCS07vE84ACjcxK6xIIjxv20xvE14v26w1j6s0DMIAIbVA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWlV2xY628EF7xvwVC2z280aVAFwI0_Gc
        CE3s1lV2xY628EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wCS07vEe2I262IYc4CY6c8I
        j28IcVAaY2xG8wCS07vE5I8CrVACY4xI64kE6c02F40Ex7xfMIAIbVAv7VC0I7IYx2IY67
        AKxVWUJVWUGwCS07vEYx0Ex4A2jsIE14v26r1j6r4UMIAIbVAm72CE4IkC6x0Yz7v_Jr0_
        Gr1lV2xY6x02cVAKzwCS07vEc2xSY4AK67AK6r4rMIAIbVCY0x0Ix7I2Y4AK64vIr41lV2
        xY6xAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCS07vE4x8a6x804xWlV2xY6xC20s026xCa
        FVCjc4AY6r1j6r4UMIAIbVC20s026c02F40E14v26r1j6r18MIAIbVC20s026x8GjcxK67
        AKxVWUGVWUWwCS07vEx4CE17CEb7AF67AKxVWUtVW8ZwCS07vEIxAIcVC0I7IYx2IY67AK
        xVWUJVWUCwCS07vEIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIAIbVCI42IY6xAIw2
        0EY4v20xvaj40_WFyUJVCq3wCS07vEIxAIcVC2z280aVAFwI0_Jr0_Gr1lV2xY6IIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IElmIHRoZXJlJ3MgKmFueSogZXJyb3IsIGl0J2xsIGNoZWNrIHRoZSBwb2ludGVyLCBpZiBp
dCdzIG5vbi1OVUxMLAo+ID4gaXQnbGwgY2FsbCB0aGUgZGVzdHJ1Y3Rvci4gIElmIGt6YWxsb2Mo
KSBmYWlscywgdGhlIHBvaW50ZXIgd2lsbCBiZQo+ID4gTlVMTCwgdGhlcmUncyBubyBkb3VibGUt
ZnJlZSBidWcuICAqZXZlcnkqIHN1YmRldiBpcyB3cml0dGVuIHRoaXMgd2F5Cj4gPiB0byBhdm9p
ZCBkdXBsaWNhdGluZyBjbGVhbnVwIGxvZ2ljLgo+IEFjdHVhbGx5LCBnbTIwYl9jbGtfbmV3X3Nw
ZWVkbzAoKSBtYXkgaGF2ZSBhIGJ1ZyBoZXJlIGlmIGt6YWxsb2MoKQo+IGZhaWxzIGFzIGl0IGRv
ZXNuJ3Qgb3ZlcndyaXRlIHRoZSBwcmV2aW91cyBwb2ludGVyIGZyb20KPiBnbTIwYl9jbGtfbmV3
KCkuICBUaGF0IHdob2xlIGN0b3IoKSBzZXF1ZW5jZSBpcyB3cml0dGVuIGEgbGl0dGxlCj4gc3Ry
YW5nZWx5Lgo+IAoKSXQncyBjbGVhciB0byBtZSwgdGhhbmsgeW91ciBmb3IgeW91ciBleHBsYW5h
dGlvbiEgQXMgZm9yIApnbTIwYl9jbGtfbmV3X3NwZWVkbzAoKSwgSSB0aGluayBpdHMgYnVnIHBh
dHRlcm4gaXMgbm90IHZlcnkgCmNsZWFyLiBNYXliZSB3ZSBzaG91bGQga2VlcCBpdCB1bnRpbCB3
ZSBmaW5kIGFuIHVzZSBjaGFpbiB0aGF0CmNvdWxkIGxlYWQgdG8gYSBidWcuCgpSZWdhcmRzLApE
aW5naGFvCg==
