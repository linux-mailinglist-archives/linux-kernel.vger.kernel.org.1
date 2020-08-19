Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC7A22496D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 09:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgHSHMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 03:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgHSHLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:11:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F15C061389;
        Wed, 19 Aug 2020 00:11:41 -0700 (PDT)
Date:   Wed, 19 Aug 2020 09:11:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597821099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9LpC0XaRf4DGoIdiCEBe93B/70c29C6ZKL34lno4gEY=;
        b=UXqfqdhf3Nhc9cOurrtA2TRVB6hnQsJeLc4jDdGaJls1pj/UsfWp+nGO/gwk5XDW0Iu8tO
        RVoOH4Vga+sEvnrLZmAUHMdrlpBkWRGmXH+5hh34iT48YYmNGeoDQ8rxwQtUh1A8CA1tYD
        NP4DEWE6NsL1zok6BvhOiKnhJHAL/hCvc1UT933OjtS0wC6yfYLifyi51vj5ChOhhNd8hj
        L4ZxGPfb2gzWAf842Pua2ljeoqxvjjZp5JYU/rXA2zKpMOAfocuEW6To/qWTc429MnOrgM
        MUl7DATUcska8ZGULDPv58gkPUBtYWYQGYnFsp5zAj3xEwDuuLkrMpMmwSacEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597821099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9LpC0XaRf4DGoIdiCEBe93B/70c29C6ZKL34lno4gEY=;
        b=mGmT0S3ySWU3Bb20vrlRlEUdsOchhjk/u4nsbuHBDIZ1O9b0/EizMooUkP9DSV0AITT7um
        XzuYUqq/jYVDGkCQ==
From:   'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>
To:     Thomas Graziadei <thomas.graziadei@omicronenergy.com>
Cc:     Mark Marshall <markmarshall14@gmail.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mark Marshall <mark.marshall@omicronenergy.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: Kernel crash due to memory corruption with v5.4.26-rt17 and
 PowerPC e500
Message-ID: <20200819071138.bypg3slqhw7r577r@linutronix.de>
References: <CAD4b4WK9W+dNZZ_WPt-9ZNpSHvyxdwPW86Rtq4AKOONuvyR37A@mail.gmail.com>
 <20200529131452.pgj7mx7xaz7n4kz3@linutronix.de>
 <CAD4b4WLS36JKepz31m98Z3Ve05d63GnfBGsuuWRXpjXZqPoBrA@mail.gmail.com>
 <20200529161518.svpxhkeljafbtdz2@linutronix.de>
 <20200529163722.mdxzrj4n3lyzjtfu@linutronix.de>
 <20200706165004.7m57fvspmwnjcjxh@linutronix.de>
 <eeeae7d9-c028-47f0-ab5b-7983e32f36cb@EXC03-ATKLA.omicron.at>
 <c1ef757b-4cd6-410e-a647-a3303cef4b1b@EXC03-ATKLA.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c1ef757b-4cd6-410e-a647-a3303cef4b1b@EXC03-ATKLA.omicron.at>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-12 14:45:22 [+0200], Thomas Graziadei wrote:
> Hi Sebastian,
Hi Thomas,

> any progress on your side?

due to lack of time none. But I am on it=E2=80=A6

> Do you think the patch could be applied for the next versions?

So I had a theory why it happens but then you said no so now I need
to figure out why it happens so I can write it in the changelog.

I believe you made it happen in qemu and you sent a .config and
everything so I will stare into it as soon as I can.

> Regards,
> Thomas

Sebastian
