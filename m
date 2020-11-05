Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760FC2A7FB2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 14:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgKEN31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 08:29:27 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:61403 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730461AbgKEN31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 08:29:27 -0500
X-UUID: cdcd7782eb3b4e35bb1070ae7237c5ae-20201105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=pcnmHbDQu8GbyyLey8ydD5w9czPlndqFD5Nfo7Y2uWo=;
        b=BJFp4CeDNTLhAImvpbmcRUVrD6suw/DRxo18fc5U14f0HQ3Lm4tV39SJ6WeVncZy9DiWZkKYV9W2AfxAleCdLKfdb0UsAJVuFSScFI5zb/txwWh5JEeXDzNbXBhTSsGGcWsBqHI0CD2Agx8YkEliS9WypTXl/g/kTFrDvbLs2eQ=;
X-UUID: cdcd7782eb3b4e35bb1070ae7237c5ae-20201105
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 974526844; Thu, 05 Nov 2020 21:27:11 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 5 Nov
 2020 21:27:09 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 5 Nov 2020 21:27:09 +0800
Message-ID: <1604582829.26523.17.camel@mhfsdcap03>
Subject: Re: [PATCH -next v2] ASoC: mediatek: mt8192: Make some symbols
 static
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     Zou Wei <zou_wei@huawei.com>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <matthias.bgg@gmail.com>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 5 Nov 2020 21:27:09 +0800
In-Reply-To: <1604579287-25251-1-git-send-email-zou_wei@huawei.com>
References: <1604579287-25251-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 4E3BCA4F16C884482DEDA47F609076C23E9CAA032D1A648EB2745A62481CDE4C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTA1IGF0IDIwOjI4ICswODAwLCBab3UgV2VpIHdyb3RlOg0KPiBGaXgg
dGhlIGZvbGxvd2luZyBzcGFyc2Ugd2FybmluZ3M6DQo+IA0KPiAuL210ODE5Mi1kYWktaTJzLmM6
MjA0MDo1OiB3YXJuaW5nOiBzeW1ib2wgJ210ODE5Ml9kYWlfaTJzX2dldF9zaGFyZScgd2FzIG5v
dCBkZWNsYXJlZC4gU2hvdWxkIGl0IGJlIHN0YXRpYz8NCj4gLi9tdDgxOTItZGFpLWkycy5jOjIw
NjA6NTogd2FybmluZzogc3ltYm9sICdtdDgxOTJfZGFpX2kyc19zZXRfcHJpdicgd2FzIG5vdCBk
ZWNsYXJlZC4gU2hvdWxkIGl0IGJlIHN0YXRpYz8NCj4gLi9tdDgxOTItYWZlLWdwaW8uYzoxNTox
Njogd2FybmluZzogc3ltYm9sICdhdWRfcGluY3RybCcgd2FzIG5vdCBkZWNsYXJlZC4gU2hvdWxk
IGl0IGJlIHN0YXRpYz8NCj4gLi9tdDgxOTItYWZlLXBjbS5jOjcwOjU6IHdhcm5pbmc6IHN5bWJv
bCAnbXQ4MTkyX2dldF9tZW1pZl9wYnVmX3NpemUnIHdhcyBub3QgZGVjbGFyZWQuIFNob3VsZCBp
dCBiZSBzdGF0aWM/DQo+IC4vbXQ4MTkyLWFmZS1wY20uYzoyMTM3OjM5OiB3YXJuaW5nOiBzeW1i
b2wgJ210ODE5Ml9hZmVfY29tcG9uZW50JyB3YXMgbm90IGRlY2xhcmVkLiBTaG91bGQgaXQgYmUg
c3RhdGljPw0KPiANCj4gUmVwb3J0ZWQtYnk6IEh1bGsgUm9ib3QgPGh1bGtjaUBodWF3ZWkuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBab3UgV2VpIDx6b3Vfd2VpQGh1YXdlaS5jb20+DQoNCkFja2Vk
LWJ5OiBKaWF4aW4gWXUgPGppYXhpbi55dUBtZWRpYXRlay5jb20+DQpUaGFua3MgZm9yIHRoZSBm
aXhpbmcuDQo=

