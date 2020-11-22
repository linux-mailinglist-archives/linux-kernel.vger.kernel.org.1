Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 785F22BC727
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 17:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgKVQfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 11:35:44 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:16481 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbgKVQfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 11:35:43 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4CfG9k1Hfzz89;
        Sun, 22 Nov 2020 17:35:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1606062941; bh=NkwA7IEkGbLWPY9ngv+0aF8xmSduQoFAvE1LTf/cnSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lqr5qRNgJZgG7Q0l+OZaTA6lYextmfayzR3eDA5fjIQR+/N8HCXIhxTb1kigrcqQv
         dxUan9qszkmXk50qEqI/DpNYVHNlEbApy5t7V5mcqF6qIYSUW7xVF8gYKXTS8Vc4ta
         q5wgaw5OFBn3I0cn8ztDpLl/rc/cCL2YDo77CYRLvDZ/JlaGs154Xdm5fBDmSnYOl6
         MHHYbclXVjR17gIOinCsdpotJIB2S6Bw5VAhNr6tHFqvy/02PsL5peC/PGPuyOI8it
         q/PK1s0+VinLiRkxkN/Xd7NplSKwHf9JcfTJ5rfRn1Z8xXbRMoEr8qYrat+blSjQEI
         CsrO15DmVnlTg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sun, 22 Nov 2020 17:35:34 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        broonie@kernel.org
Subject: Re: About regression caused by commit aea6cb99703e ("regulator:
 resolve supply after creating regulator")
Message-ID: <20201122163534.GA16669@qmqm.qmqm.pl>
References: <c13f1683-97c9-40b4-f740-73eaceb7c98f@suse.com>
 <20201108171811.GB10914@qmqm.qmqm.pl>
 <858790f6-8b22-4fe7-bb74-56904ad203bd@suse.com>
 <cea48473-eeb1-db60-cc0d-ebf9a26aaf0c@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cea48473-eeb1-db60-cc0d-ebf9a26aaf0c@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 03:43:33PM +0100, Jan Kiszka wrote:
> On 09.11.20 00:28, Qu Wenruo wrote:
> > On 2020/11/9 上午1:18, Michał Mirosław wrote:
> >> On Sun, Nov 08, 2020 at 03:35:33PM +0800, Qu Wenruo wrote:
[...]
> >>> It turns out that, commit aea6cb99703e ("regulator: resolve supply after
> >>> creating regulator") seems to be the cause.
[...]
> We are still missing some magic fix for stable trees: On the STM32MP15x,
> things are broken since 5.4.73 now. And 5.9.y is not booting as well on
> that board. Reverting the original commit make it boot again.
> 
> Linus master is fine, though, but I'm tired of bisecting. Any
> suggestions? Or is there something queued up already?

You might want to look at `git log --grep=aea6cb99703e` if you can't
wait for a stable backport.

Best Regards
Michał Mirosław
