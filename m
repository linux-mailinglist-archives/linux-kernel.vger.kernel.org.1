Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9FF2773B7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbgIXOPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:15:20 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48799 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727974AbgIXOPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:15:20 -0400
X-UUID: 12b20e8b6cab426cb41af521a91cbaf0-20200924
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3gDT2fSDKlN+/xLxFu5tIv5oC9wVXrVAOCd+NyaKVj0=;
        b=E17bSWndZCM03aK+gvO72kKz8/wL/wftTH7/l+wx0vh7Q7PUylP62BoJaq2zwoT4JeCEOj7EbtHks0QYNs19pnM9E+1qeHP9RityhyjjuLcjRisuwTJSH6BdHWDQqf+FnApCIwOUoIFkkGTzCFWbOQMtJvZA8pbrfLUI19OTOXE=;
X-UUID: 12b20e8b6cab426cb41af521a91cbaf0-20200924
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <phil.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 246545244; Thu, 24 Sep 2020 22:15:15 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Sep 2020 22:15:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Sep 2020 22:15:11 +0800
From:   Phil Chang <phil.chang@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        Phil Chang <phil.chang@mediatek.com>,
        YJ Chiang <yj.chiang@mediatek.com>,
        Alix Wu <alix.wu@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: Re: [PATCH] [PATCH] ARM64: Setup DMA32 zone size by bootargs
Date:   Thu, 24 Sep 2020 22:15:14 +0800
Message-ID: <20200924141514.23930-1-phil.chang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200916133324.6280-1-phil.chang@mediatek.com>
References: <20200916133324.6280-1-phil.chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QWN0dWFsbHksIEluIGEgZW1iZWRkZWQgc3lzdGVtIHdpdGggM0dCIG1lbW9yeSwgdGhlIG1lbW9y
eSBidXMgd2lkdGggaXMgbm90IHRoZSBzYW1lIGFtb25nIHRoZSAzR0IuDQooVGhlIGZpcnN0IDJH
QiBpcyA0OC1iaXQgd2lkZSwgYW5kIHRoZSBsYXR0ZXIgMUdCIGlzIDE2LWJpdCB3aWRlLikNCkZv
ciBtZW1vcnkgdGhyb3VnaHB1dCByZWFzb24gb2YgaGFyZHdhcmUgSVBzLCB3ZSBuZWVkIGFsbG9j
YXRlIG1lbW9yeSBmcm9tIHRoZSBmaXJzdCAyR0IgZm9yDQp0aGUgaGFyZHdhcmUgSVBzLiBBbmQg
dGhhdCBpcyB3aHkgd2Ugc2V0dXAgdGhlIGZpcnN0IDJHQiBhcyBETUFfWk9ORSwgYW5kIHVzZSBH
RlBfRE1BIHRvIGFsbG9jYXRlDQptZW1vcnkgZnJvbSB0aGUgcmFuZ2UuDQo=

