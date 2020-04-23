Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE17C1B5A01
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 13:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgDWLGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 07:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726805AbgDWLGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:06:23 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50712C035494
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 04:06:23 -0700 (PDT)
Received: from [10.56.9.120] (x59cc8a78.dyn.telefonica.de [89.204.138.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C91501EC0D7E;
        Thu, 23 Apr 2020 13:06:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587639982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o33zzbSEWrNleUhq11NCh6BFH/qH868Q9IHQ+H7NKhg=;
        b=dSnLl3r55NsFsiAmcA10u/EW3tOt6FRslf3HQBY2mfGXRRSM4moVLXWdY97QtsQc2QhPZH
        20lWrhihUrsM+ZBIfhZO49eDiCzgrj61TkLDpi6JuY4T2hrbUEefieAT0CEI7bnhW7WvTV
        10IUN8mMRMQ2NgoaD69tHjQHT2iDFm8=
Date:   Thu, 23 Apr 2020 13:06:19 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <838855E1-35B4-4235-B164-4C3ED127CCF4@lca.pw>
References: <20200423060825.GA9824@lst.de> <838855E1-35B4-4235-B164-4C3ED127CCF4@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: AMD boot woe due to "x86/mm: Cleanup pgprot_4k_2_large() and pgprot_large_2_4k()"
To:     Qian Cai <cai@lca.pw>, Christoph Hellwig <hch@lst.de>
CC:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
From:   Boris Petkov <bp@alien8.de>
Message-ID: <72CCEEC2-FF21-437C-873C-4C31640B2913@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 23, 2020 12:47:15 PM GMT+02:00, Qian Cai <cai@lca=2Epw> wrote:
>
>
>> On Apr 23, 2020, at 2:08 AM, Christoph Hellwig <hch@lst=2Ede> wrote:
>>=20
>> I can send one, but given that Qian found it and fixed it I'd have
>> to attribute it to him anyway :)
>>=20
>> This assumes you don't want a complete resend of the series, of
>course=2E
>
>How about you send a single patch to include this and the the other
>pgprotval_t fix you mentioned early as well? Feel free to add my
>reported-by while all I care is to close out those bugs=2E

No need, I've rebased and testing=2E Stay tuned=2E


--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
