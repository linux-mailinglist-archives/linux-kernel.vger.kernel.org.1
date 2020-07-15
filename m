Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BF122044A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 07:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgGOFRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 01:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgGOFRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:17:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273ACC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:17:21 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:17:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594790238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cXO320q4GkCe2Aew1c5mHBAyO5/6Jbm89pFoFIxkOzg=;
        b=z3TTaGR9bOxU0IKAGu9agWb3Meux3/9l7MXcoUa2cGWEJXKh80jSDebH6bP/5baMtbw3ff
        cE9MfRMr+UjowGJzkVhEHdIcS/cqRQDb0Rync2fH1sY29xKvrNu1lCyjIoJn0zu3EEgA1H
        mKZookoqJg8cTKaTofRENIx7y2/wuKGbNG97sIRsS9zYTg2Xn02Af2Bd/zTci5F4mwbpsd
        eTM09SQeXHj5uoQUX0f1076ePt5RLfS/gnh4JYfAwkf9Ch1O+4RmXrCsKxRkUFxpee5IFr
        Jn9Jc51Eyr5k1KHwI64l8t5IYfZiTY9RYBcR/U1CaeaCVkiinguQ8x8z1l5yow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594790238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cXO320q4GkCe2Aew1c5mHBAyO5/6Jbm89pFoFIxkOzg=;
        b=kax19Snu70YSwZBcaslmFFZOKqpSEJz7lZrP8RbhShtnQk1GB4yfegnarzyW2mn0zIsaKj
        0QIsuz8TJCHXi8Bg==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] arm64: perf: Proper cap_user_time* support
Message-ID: <20200715051715.GA225020@debian-buster-darwi.lab.linutronix.de>
References: <20200715020512.20991-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715020512.20991-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 10:05:06AM +0800, Leo Yan wrote:
...
>
> In this version, there have two changes comparing to Peter's original
> patch set [1]:
>
...
>
> [1] https://lkml.org/lkml/2020/5/12/481
>

Nitpick: please avoid using https://lkml.org:

  1) It's a non-official external service
  2) The opaque URLs it uses drop the most important info for uniquely
     identifying e-mails: the Message-Id.

Thus if the site one day goes down, and at times it did, the reference
is almost gone forever.

Use "https://lkml.kernel.org/r/<message-id>". The link becomes:

  https://lkml.kernel.org/r/20200512124058.833263033@infradead.org

thanks,

--
Ahmed S. Darwish
Linutronix GmbH
