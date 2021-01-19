Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB40C2FBD3E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbhASRNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:13:02 -0500
Received: from mickerik.phytec.de ([195.145.39.210]:59974 "EHLO
        mickerik.phytec.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390524AbhASRLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:11:30 -0500
X-Greylist: delayed 829 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jan 2021 12:11:30 EST
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a1; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1611076239; x=1613668239;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eoordXUw6KUWMAixMtC80v8Vu9Qg/xm8FcYRY6dgC2E=;
        b=B7uhBaTcPwT0kcwDmd9C6Sjx19sd/LkFqPCa1Cv186VmJXY5Pa0SAm8PI1ZU8mvv
        Lg08XQ3gYuveB+oqzDjA0aVeKZSNrQP8NKqWQuZVv47VFZDHHg5Wg2rD62qMeRJs
        6u3+grQKLMWhA0nyHu61xBxVBkOmBbiZlx1Ayxzj70g=;
X-AuditID: c39127d2-0d3b770000001c86-9f-6007128f5d18
Received: from Florix.phytec.de (florix.phytec.de [172.16.0.118])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 95.B0.07302.F8217006; Tue, 19 Jan 2021 18:10:39 +0100 (CET)
Received: from [172.16.21.73] (172.16.0.116) by Florix.phytec.de
 (172.16.0.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 19 Jan
 2021 18:10:39 +0100
Subject: Re: Splicing to/from a tty
From:   Robert Karszniewicz <r.karszniewicz@phytec.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Christoph Hellwig <hch@lst.de>, Oliver Giles <ohw.giles@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jiri Slaby <jirislaby@kernel.org>
References: <C8KER7U60WXE.25UFD8RE6QZQK@oguc> <20210118081615.GA1397@lst.de>
 <CAHk-=wgoWjqMoEZ9A7N+MF+urrw2Vyk+PP_FW4BQLAeY9PWARQ@mail.gmail.com>
 <CAHk-=wg1n2B2dJAzohVdFN4OQCFnnpE7Zbm2gRa8hfGXrReFQg@mail.gmail.com>
 <CAHk-=wga4M_VLcfkBL0mK-1_mJHYKDzPA48jEOCBgME=nE4O6Q@mail.gmail.com>
 <CAHk-=whsaDmEch8KR3Qr-KkcxoOhTX5RaEJ529cB2c97fu+=Ag@mail.gmail.com>
 <CAHk-=wg-1gntaB4xTAsQhvxumOeB_36sFdpVCWgZGLnCUQGUvw@mail.gmail.com>
 <CAHk-=wjgufiORSuAb270XpGn45jexRjP9SCmcc7AAAZsVrAaPw@mail.gmail.com>
 <CAHk-=whW7t=3B=iCwYkJ3W-FH08wZNCFO7EJ5qQSqD9Z_tBxrQ@mail.gmail.com>
 <YAbIVgGt1Qz8ItMh@kroah.com> <9d3baff9-5d4a-4308-9556-8dd037c2fe4b@phytec.de>
Message-ID: <4c96301e-f2a1-3343-8927-c2567ad179eb@phytec.de>
Date:   Tue, 19 Jan 2021 18:10:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9d3baff9-5d4a-4308-9556-8dd037c2fe4b@phytec.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.16.0.116]
X-ClientProxiedBy: Florix.phytec.de (172.16.0.118) To Florix.phytec.de
 (172.16.0.118)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42JZI8BQptsvxJ5gsPeNrkXz4vVsFitXH2Wy
        eDdXxuLyrjlsFr2rNrJaPOp7y25x/u9xVgd2j52z7rJ7bFrVyeZxYsZvFo/9c9ewe+y+2cDm
        8XmTnMemJ2+ZAtijuGxSUnMyy1KL9O0SuDL6j29mLpjJVPHqwVz2Bsb7jF2MnBwSAiYSt3fe
        YOti5OIQEljGJLFu2zoWCOc+o8S62zuYQKqEBZQlJnbPYwGx2YA6djffYu5i5OAQEUiV2L+z
        GqSeWeAUo8T9pjnMIDVCAr2sEotuaIHYvAI2EvtXrGMHsVkEVCWuP3kDNlNUIEKita+TGaJG
        UOLkzCdg8zkFbCV2zP3KDjKfWUBTYv0ufZAws4C4xK0n85kgbHmJ7W9hVqlKnG57zQTxjILE
        3N8TmSHscIl5v2exT2AUnoVkwyyEqbOQTJ2FZOoCRpZVjEK5mcnZqUWZ2XoFGZUlqcl6Kamb
        GIHxdHii+qUdjH1zPA4xMnEwHmKU4GBWEuFt+suWIMSbklhZlVqUH19UmpNafIhRmoNFSZx3
        A29JmJBAemJJanZqakFqEUyWiYNTqoFR/lTK8ScBr7bHL1p03WUS7/otSv8dmZmklqw5xcO0
        eHaaTsTdeslL5hMezBDcV7+IbV+HTsWlu4Hn/RXOyEdFLPNhfNLVHmYt87HYpCNNRnD9Kb5p
        P+Xyp3q/1wn37480XqebXmB8QsJ5yl611p3tJWmHZ+oarJjJaWgtEP7+bU1vo6fcyiYlluKM
        REMt5qLiRACQ4KT9lQIAAA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/21 5:56 PM, Robert Karszniewicz wrote:
> Another case I've also noticed is writing to a serial connection:
> kernel write not supported for file /ttymxc0 (pid: 252 comm: cat)

Which is actually a TTY and I just failed to see the forest for all the trees...

Cheers.
