Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CAB2ADF30
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgKJTVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKJTVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:21:52 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07110C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Message-ID:From:CC:To:Subject:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:
        Date:Sender:Reply-To:Content-ID:Content-Description;
        bh=nh+MJe3DojicBPR9kWKJXmYTNm29JvO134GdJxVv1kU=; b=Lawk/xs5HDjVpv7AtqHlzuDk6A
        +rCKCdz3k5sgAAby8MRjDTqRvTVhUAbJ+PhYqc86PHVuwg6Vv9miV4jfb+JnONTEtCO6Zb4LzNB+Z
        bqUOs1su+MK8/c3VLf2jWFvPvVP2awxsSmNQZTsGMjOiiU6NORxGlfZiVBbkzN81JWro0+hv+lGrX
        YPCEsQxw+CFCoZ+wghMX6aHtuw5wJh+uyeWds2ONJf6Bh/1YVpvvLj0n96T6STnrLEguxrLoLsV4v
        Cr+xps4vH4xARYlV5GKv0pYOqYT2wLebQez9vbU7c6Oz+Kud1a1MooS7f76HFBZBxMB383AyHJe+x
        /4LdJkhw==;
Received: from [2001:8b0:10b:1:b16b:5d8a:941b:e15c]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcZD4-0007hj-FJ; Tue, 10 Nov 2020 19:21:42 +0000
Date:   Tue, 10 Nov 2020 19:21:38 +0000
User-Agent: K-9 Mail for Android
In-Reply-To: <874klxghwu.fsf@nanos.tec.linutronix.de>
References: <20201024213535.443185-20-dwmw2@infradead.org> <160397373817.397.3191135882528008704.tip-bot2@tip-bot2> <e2e06979-cbcf-8771-0b48-c46f2d034aa8@amd.com> <20201110061046.GA7290@nazgul.tnic> <87d00lgu13.fsf@nanos.tec.linutronix.de> <9a003c2f-f59a-43ab-bbd5-861b14436d29@amd.com> <87a6vpgqbt.fsf@nanos.tec.linutronix.de> <82d54a74-af90-39a4-e483-b3cd73e2ef03@amd.com> <78be575e10034e546cc349d65fac2fcfc6f486b2.camel@infradead.org> <877dqtgkzb.fsf@nanos.tec.linutronix.de> <874klxghwu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [EXTERNAL] [tip: x86/apic] x86/io_apic: Cleanup trigger/polarity helpers
To:     Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>
CC:     linux-kernel@vger.kernel.org, x86 <x86@kernel.org>,
        Qian Cai <cai@redhat.com>, Joerg Roedel <joro@8bytes.org>
From:   David Woodhouse <dwmw2@infradead.org>
Message-ID: <45B3C20C-3BBB-40F3-8A7B-EB20EDD0706F@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by merlin.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10 November 2020 18:56:17 GMT, Thomas Gleixner <tglx@linutronix=2Ede> w=
rote:
>On Tue, Nov 10 2020 at 18:50, Thomas Gleixner wrote:
>> On Tue, Nov 10 2020 at 16:33, David Woodhouse wrote:
>>> If I could get post-5=2E5 kernels to boot at all with the AMD IOMMU
>>> enabled, I'd have a go at throwing that together now=2E=2E=2E
>>
>> It can share the dmar domain code=2E Let me frob something=2E
>
>Not much to share there and I can't access my AMD machine at the
>moment=2E Something like the untested below should work=2E

Does it even need its own irqdomain? Can it not just allocate directly fro=
m the vector domain then program its own register directly based on the irq=
_cfg?


--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
