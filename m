Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7574263E06
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 09:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgIJHH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 03:07:29 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:37667 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730386AbgIJHFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:05:03 -0400
X-UUID: e0fcb27b161b4c75b82a42694f659e49-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=qQ3o5wuN2rg8uyEANSJYR8YzzG9Gaxvo1A2sTkhF+DE=;
        b=VjtBL01j/HoBXflC5GlI+QlUTjud9emFvNHY1ZJq5wY5TPnDX0DrA0dAMn2YeH8262sE/pt5GH2zcs6H+rEm2EvEbV51k3i4iQpuYfj+7BkX9ki3ztgQ+yYcMUxmWSSNBsGB64xkUXFky1+gs0UeZbamElxF76eiTWXFtuP9A4g=;
X-UUID: e0fcb27b161b4c75b82a42694f659e49-20200910
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1743303145; Thu, 10 Sep 2020 15:04:47 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Sep
 2020 15:04:46 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 15:04:44 +0800
Message-ID: <1599721372.7466.15.camel@mhfsdcap03>
Subject: Re: Aw: Re: [PATCH v4 0/4] Split PCIe node to comply with hardware
 design
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Frank Wunderlich <frank-w@public-files.de>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        <linux-kernel@vger.kernel.org>, <jianjun.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>, <yong.wu@mediatek.com>
Date:   Thu, 10 Sep 2020 15:02:52 +0800
In-Reply-To: <trinity-74abdbb2-2ddc-440a-85c8-97e80e9eb2ed-1599545604475@3c-app-gmx-bs38>
References: <20200721074915.14516-1-Chuanjia.Liu@mediatek.com>
         <1596440772.7361.35.camel@mhfsdcap03>
         <trinity-74abdbb2-2ddc-440a-85c8-97e80e9eb2ed-1599545604475@3c-app-gmx-bs38>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 7D884D44EC4ED2C18A83C4ECE5BF2DBC5AB661AF82EEBCB6FFD4697B9FB981372000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIwLTA5LTA4IGF0IDA4OjEzICswMjAwLCBGcmFuayBXdW5kZXJsaWNoIHdyb3Rl
Og0KPiBIaSwNCj4gDQo+IGkgZG9uJ3Qgc2VlIHRoaXMgUGF0Y2hzZXQgaW4gNS45LXJjNA0KPiAN
Cj4gaXMgYW55dGhpbmcgbWlzc2luZz8NCj4gDQo+IHJlZ2FyZHMgRnJhbmsNCg0KVGhhbmtzIGZv
ciBwaW5nIHRoaXMgbWFpbCwNCjx2Z2VyLmtlcm5lbC5vcmc+IG1hbGkgbGlzdCBjb25zaWRlciB0
aGlzIHBhdGNoc2V0IGlzIFNQQU0gDQpiZWNhdXNlIG9mIG15IGVudmlyb25tZW50YWwgcHJvYmxl
bXMuDQpJIGhhdmUgZml4ZWQgdGhpcyBwcm9ibGVtIGFuZCBzZW5kIHRoZSBWNSB2ZXJzaW9uLg0K
SXQgY2FuIGJlIHNlZW4gY29ycmVjdGx5IGluIGxpbnV4LXBjaSBtYWlsIGxpc3QuDQpOb3cgSSBn
dWVzcyB0aGUgbWFpbnRhaW5lciB3aWxsIGhlbHAgcmV2aWV3IGFuZCBhcHBseSB0aGlzLg0KDQpy
ZWdhcmRzIENodWFuamlhDQoNCg==

