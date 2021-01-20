Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00C32FCFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389383AbhATMPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 07:15:22 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:61658 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388669AbhATLpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:45:25 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210120114441epoutp021b35cc7a680fa5b94a2fb7be7130ee4e~b7hi0tOUE0550805508epoutp02a
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 11:44:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210120114441epoutp021b35cc7a680fa5b94a2fb7be7130ee4e~b7hi0tOUE0550805508epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611143081;
        bh=8GGJA4qDpM99WxXaTKURZyu32KA4LL+v0ALBN1X/YL8=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=T4DjAwMeAzeqNFMDzybiExmvHksaYlsXD0WYnCrIJ/zGZdspTyHJ3tpbnBgQCzLwb
         W6LtN07kCZJk2dVmGrvc33ZrFsF26o3CUCyj/JntDkB+DCY9vz7410lZgJKf/Vj/yf
         H4fYd+gfyMODeVQYL407KizryZD8AlDyvIHRvP9I=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20210120114440epcas5p4456b0075b52ac5d590ed54b0fc610774~b7hiNew9B2343723437epcas5p48;
        Wed, 20 Jan 2021 11:44:40 +0000 (GMT)
X-AuditID: b6c32a49-8d5ff70000013d42-83-600817a8bc9e
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.EA.15682.8A718006; Wed, 20 Jan 2021 20:44:40 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 1/1] arm64/entry.S: check for stack overflow in el1 case
 only
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From:   Maninder Singh <maninder1.s@samsung.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "samitolvanen@google.com" <samitolvanen@google.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20210120110803.GB19241@willie-the-truck>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210120112259epcms5p5cfdc3e2172fdde8da6f3d35822483b07@epcms5p5>
Date:   Wed, 20 Jan 2021 16:52:59 +0530
X-CMS-MailID: 20210120112259epcms5p5cfdc3e2172fdde8da6f3d35822483b07
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTcRTH+W33Xq/LxXWzPGZWioJZTkel14ywslhR0cOiJ3Oty9J8rC17
        08NW0cheNJClJqS5pulazpa3QCYVVoKSVlbWKkdqiqmVWWqxXUf99+GcL99zvodD8kVl+BQy
        LWsvo8lSZIQRAqymfmZUtCmQTI29PBZDN7MMPfytD9GGDx0E3XfjHKKtn17g9PPaAoIufdnM
        o+8VNOB0qakXpx0NhYh+MDaM0bq385L8ZBVFFUhWbM2RWc1nCdmdkmOy89VmJBu0TltDbBEs
        2MlkpO1jNDELUwW7vj5swdRDfge6e8zEcXRdoEe+JFBz4UTjGUyPBKSIYhHY3uTx9YgkhZQ/
        jNrFbo2YWg8NLhPPzSIqFJryK5BbIqZi4Zct0l0mKAmYa+9jbg6glsHbwhYP86lcDB4bjnKj
        hJB/xoVxHAx3y2weG18qDgaaArnyJGgr7/Xxct+ja4jjADj1rpHPsT84h9nx+lQov5M3bnkS
        wdkSxp0EqCsI2G49wTXigbUUYVyqVfDstMcfoyKgy+Uc90yGGlMr4laeDnd7CzxH4FMzoao2
        hpOEgOFJJY+TTIS83x08byp7kZcjQNdmwb0JB/v7x1eTwfuq74g7cieCW2Ud+EU0w/jvzsb/
        Jhv/TS5GfDMKYtTaTBWjnaeWZjH7JVpFpjYnSyVRZmdakeeXopbbUbvzq8SBeCRyICD5YQHC
        3FEiVSTcqTh4iNFkyzU5GYzWgYJJLCxQaI91ykWUSrGX2c0wakbj7fJI3ynHeSfKVvuzIok0
        QRc9NxSHuJRmaqjRFbTD1W4PCUgoH3kVb5pVw1y+NBs/sFjcMzIgtXQ6iPB2+cekIJ3IJ+WC
        USVP2xQK28Lx1Sk/D9tK0kOTnJOdJxc9k1f/6BQv3SO/p1zHnN7qsICtKJadr0z9Ej5h8ejV
        5JGqL2p1Dzstevt2HZH09DHbMPl825+PWxNbFnS35k1qMbI+9fGvZy2ZIGmdY0hbYZwtiR68
        1mTM3xhZ8VS1co70c2Xku+QjlvaQ9NG11bIHY4dvprN/kHXq7ToBvn5zXYK6vqvZMTD/0VCi
        cPiGMrdymaG7M2SRsrGr2O9b17nEwCf6Qo3q+oa6MEy7SyGN4mu0ir+JlHTzugMAAA==
X-CMS-RootMailID: 20201211091546epcas5p24511325afff612d57306d733a3307648
References: <20210120110803.GB19241@willie-the-truck>
        <1607678131-20347-1-git-send-email-maninder1.s@samsung.com>
        <20210107112903.GB7523@C02TD0UTHF1T.local>
        <CGME20201211091546epcas5p24511325afff612d57306d733a3307648@epcms5p5>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Will

On Thu, Jan 07, 2021 at 11:29:03AM +0000, Mark Rutland wrote:
>> On Fri, Dec 11, 2020 at 02:45:31PM +0530, Maninder Singh wrote:
>> > current code checks for sp bit flip in all exceptions,
>> > but only el1 exceptions requires this. el0 can not enter
>> > into stack overflow case directly.
>> > 
>> > it will improve performance for el0 exceptions and interrupts.
>> > 
>> > Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
>> > Signed-off-by: Vaneet Narang <v.narang@samsung.com>
>> 
>> I did consider doing this at the time Ard and I wrote the overflow
>> detection, but there was no measureable impact on the workloads that I
>> tested, and it seemed worthwhile to have this as a sanity check in case
>> the SP was somehow corrupted (and to avoid any surprizing differences
>> between the EL0 and EL1 entry paths).
>> 
>
>> When you say "it will improve performance for el0 exceptions and
>> interrupts", do you have a workload where this has a measureable impact,
>> or was this found by inspection? Unless this is causing a real issue,
>> I'd prefer to leave it as-is for now.
>

We have not measured performance with any tool because as you said its not measurable,
but we think if we can remove some instructions then it will be better,
thats why suggested this change.
And in el0 there is no chance of overflow of sp so that 5 instructions can be avoided.

We tried this on our setup because we were changing some design for VMAP_STACK in our kernel
for some more enhancement, so that code was little much and we avoided that part
in our local kernel for el0.

Thanks,
Maninder Singh
 
