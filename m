Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A6126B471
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 01:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgIOXYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 19:24:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41752 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbgIOOiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:38:01 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200915132115euoutp021c7cd4ecf23393b9afd19cb642badc0e~096mPCBoj0422904229euoutp02U
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 13:21:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200915132115euoutp021c7cd4ecf23393b9afd19cb642badc0e~096mPCBoj0422904229euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600176075;
        bh=oYjVmJZSlUBjaVFPcJsHxcnXZt+nZprwRiCDpebwd0E=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=CwUZA//bWZCFHEtRlvObcZO22XLuucR6TCWA6mU8k4fxrm004RqjoffcVLjEHqYrU
         v8lJI22ewkWtOucsqUM01GcaveyHKJ6vOuvuekbfxXWJ0vmaFBUbDFPAz95xV65b4O
         ER+NrXNr+RQR5j0bP7y3F8KRq2/RL5/SpiwtZ2PE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200915132114eucas1p1e80f0c8f12a98eebafbd31c311ceb418~096l9Y_rm1375113751eucas1p1Q;
        Tue, 15 Sep 2020 13:21:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id AA.E3.06456.ACFB06F5; Tue, 15
        Sep 2020 14:21:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200915132114eucas1p13a20e046ccc5006e0dcb49131fc59eab~096lmu9qs1375513755eucas1p1M;
        Tue, 15 Sep 2020 13:21:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200915132114eusmtrp2231d8512124355c4bd5a25b549b425d8~096ll169T1231912319eusmtrp2Q;
        Tue, 15 Sep 2020 13:21:14 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-2e-5f60bfca4a41
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E2.1E.06314.ACFB06F5; Tue, 15
        Sep 2020 14:21:14 +0100 (BST)
Received: from [106.210.123.115] (unknown [106.210.123.115]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200915132113eusmtip142209c1b8e59cda6f5388c840060254f~096kRzyN11813018130eusmtip1Y;
        Tue, 15 Sep 2020 13:21:13 +0000 (GMT)
Subject: Re: [PATCH 3/3] clk: samsung: Use cached clk_hws instead of
 __clk_lookup() calls
To:     linux-clk@vger.kernel.org
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
Message-ID: <6ce620a0-429d-af4a-dd97-6ce5a8fb8aa7@samsung.com>
Date:   Tue, 15 Sep 2020 15:21:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826171529.23618-3-s.nawrocki@samsung.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm2zln5zicHWfhi5rRKKxQU5M4lVlG4SqijKDQcs52UHFT2fHa
        jzJES1OLfmSt8FbUXKx0idcuKGuSoqaFyVIDNcwsdKk/rKnteIz893zP5Xvf5+OjMFkf4UUl
        paSzuhSVRi6W4A3Whd6AzjdxyqChmRCm7u5zgvk0N0EwFZYegrk5NoUxvb21JGMeGyAYe/EI
        wXxoeSBm7va+FjEmyzDJ9HUeYfJfWUhmaaAOZ4wtDnTQTTE9mE8qmvXDpMJsLBQrXjy6oiit
        NyLFrNn3lDhaEqZmNUmZrG5neJwkcf7hEpb2Ccs2F1UTuSgPK0IuFNCh8LTEQhQhCSWjDQhs
        eXYxL8joOQRfroEgzCJwjP0W/0u0Tt0nBeGJM7FoW43bEdxZHnXeS1EedAwYTCf4wHp6I9is
        C2Leg9FWDIZrqkS8IKaDoeRtKeKxlA4HS+63lZ1weisYpmpX+A10LFg7R3HB4w7v7o2vYBc6
        DApmTCSPMdoTbOMVIgFvgsafDzB+GNDzJJQvDq0WPQzT1tJV7AHfO+pJAfvAcjMf5gN5CIpb
        P5PC4ZbzAToqkeDaB0M9/ANQzhHb4XnLToGOgPL8NpyngXaDwZ/uwhJucLuhDBNoKVwvkAnu
        LfDHWCYSsBfcGF/GbyG5fk01/Zo6+jV19P/nViLciDzZDE6bwHLBKWxWIKfSchkpCYEXU7Vm
        5PxoXUsdv5rQfH98O6IpJHeVxmUplTJClcnlaNsRUJh8vfRQd1esTKpW5VxidalKXYaG5dqR
        N4XLPaW7qicvyOgEVTqbzLJprO6fKqJcvHJRfkjyRERoUkD0+Sj1Oiq+0L/JdU/V5a7JA4eK
        CUNd+9ljVf5BH9veO7ZoOYfpZuM7i+w4OtM/s405ObeXyI4abRb5eDyeDpN+LYzojzytzgs/
        t7970SE5qn55rC0m7cfI7mebJzSvY2btBZHeblhNUqS95LufyY8pu9pD+Y7id+Q4l6gK3oHp
        ONVfEorxvGQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsVy+t/xu7qn9ifEG+zdpmCxccZ6VovrX56z
        Wsw/co7Vov/xa2aL8+c3sFtsenyN1eJjzz1Wi8u75rBZzDi/j8li7ZG77BYXT7latO49wm7x
        79pGFotVu/4wOvB5vL/Ryu6xc9Zddo9NqzrZPDYvqffo27KK0ePzJrkAtig9m6L80pJUhYz8
        4hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9uwS9jK+L/zEXXGeu2NS1iLWB
        sZm5i5GTQ0LARGL369nsXYxcHEICSxklviy+y9bFyAGUkJKY36IEUSMs8edaFxtEzXtGiUlX
        7jCD1AgLREusWOsLUiMiICtx69hPsBpmgWPMEjunnGKBaDjIKPH61FomkCo2AUOJ3qN9jCA2
        r4CdxJGGF2BXsAioSqx4vQEsLioQJ3Gm5wUbRI2gxMmZT1hAbE4BG4m2D2vZQWxmAXWJP/Mu
        MUPY4hK3nsxngrDlJba/ncM8gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GJDveLE3OLS
        vHS95PzcTYzACN527OfmHYyXNgYfYhTgYFTi4U0oj48XYk0sK67MPcQowcGsJMLrdPZ0nBBv
        SmJlVWpRfnxRaU5q8SFGU6DnJjJLiSbnA5NLXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTE
        ktTs1NSC1CKYPiYOTqkGRksF3lb++U9r1h7lWG+ZOk/Qqb/829mjnhpnX7Z+u7UxbcY237b5
        l7Y6rjrDGrRj96sCG7OlXVu+9nWYT3uzl0eAd4bS1BP97yPiH9Ve+LZ5ZyzH5v3zlTtYr83/
        2xLv+2PSnoDb3c80Wm1efyjZ8OX89Dd5J5VFCn/O717RyPUta8KEGysi3rApsRRnJBpqMRcV
        JwIAXmBABPYCAAA=
X-CMS-MailID: 20200915132114eucas1p13a20e046ccc5006e0dcb49131fc59eab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200826171557eucas1p13c960ad6abc814cf53bc125f5c4d9b39
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200826171557eucas1p13c960ad6abc814cf53bc125f5c4d9b39
References: <20200826171529.23618-1-s.nawrocki@samsung.com>
        <CGME20200826171557eucas1p13c960ad6abc814cf53bc125f5c4d9b39@eucas1p1.samsung.com>
        <20200826171529.23618-3-s.nawrocki@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.08.2020 19:15, Sylwester Nawrocki wrote:
> For the CPU clock registration two parent clocks are required, these
> are now being passed as struct clk_hw pointers, rather than by the
> global scope names. That allows us to avoid  __clk_lookup() calls
> and simplifies a bit the CPU clock registration function.
> While at it drop unneeded extern keyword in the function declaration.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Applied.
