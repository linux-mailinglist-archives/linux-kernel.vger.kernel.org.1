Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3023045EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393991AbhAZSF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:05:26 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:35438 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730561AbhAZJSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:18:04 -0500
X-UUID: a66961597fbf451e872fc27fc8b78bf7-20210126
X-UUID: a66961597fbf451e872fc27fc8b78bf7-20210126
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 158020583; Tue, 26 Jan 2021 17:17:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 26 Jan 2021 17:17:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 26 Jan 2021 17:17:18 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <lecopzer.chen@mediatek.com>
CC:     <akpm@linux-foundation.org>, <bigeasy@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux@armlinux.org.uk>,
        <marc.zyngier@arm.com>, <peterx@redhat.com>, <rppt@kernel.org>,
        <walken@google.com>, <yj.chiang@mediatek.com>
Subject: Re: [PATCH] ARM: mm: harden branch predictor before opening interrupts during fault
Date:   Tue, 26 Jan 2021 17:17:08 +0800
Message-ID: <20210126091708.3461-1-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201203092738.11866-1-lecopzer.chen@mediatek.com>
References: <20201203092738.11866-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I don't see any fix for this issue now(maybe I missed it..?),
could we fix this if there is better solution?
This issue exists almost two years.

Thanks!

BRs,
Lecopzer
