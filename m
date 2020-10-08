Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F39286ECF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 08:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgJHGmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 02:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgJHGmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 02:42:43 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38567C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 23:42:43 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQPdP-001Rfm-6L; Thu, 08 Oct 2020 08:42:39 +0200
Message-ID: <1545e7c77675c9a0574a7582ee5f0c969c01419e.camel@sipsolutions.net>
Subject: Re: [PATCH v2 04/11] drivers/base/devcoredump: convert devcd_count
 to counter_atomic32
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, gregkh@linuxfoundation.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 08 Oct 2020 08:42:22 +0200
In-Reply-To: <202010071334.8298F3FA7@keescook> (sfid-20201007_224326_651899_546CB035)
References: <cover.1602011710.git.skhan@linuxfoundation.org>
         <462fd514dfe2afbb8faa1dea4cdb4b0e75d8e8da.1602011710.git.skhan@linuxfoundation.org>
         <202010071114.EE9A2A47C@keescook>
         <cb86761a-5531-cbb2-3987-0897771949b8@linuxfoundation.org>
         <f27149d6b9b781ccf9c2fa041082c134abccd925.camel@sipsolutions.net>
         <202010071334.8298F3FA7@keescook> (sfid-20201007_224326_651899_546CB035)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-07 at 13:43 -0700, Kees Cook wrote:
> > > > I actually wonder if this should use refcount_t just because it is
> > > > designed to be an alway-unique value. It is hard to imagine ever causing
> > > > this to overflow, but why not let it be protected?
> > > > 
> > > 
> > > This is one of the cases where devcd_count doesn't guard lifetimes,
> > > however if it ever overflows, refcount_t is a better choice.
> > > 
> > > If we decide refcount_t is a better choice, I can drop this patch
> > > and send refcount_t conversion patch instead.
> > > 
> > > Greg! Any thoughts on refcount_t for this being a better choice?
> > 
> > I'm not Greg, but ... there's a 5 minute timeout. So in order to cause a
> > clash you'd have to manage to overflow the counter within a 5 minute
> > interval, otherwise you can actually reuse the numbers starting again
> > from 0 without any ill effect.
> 
> That's not true as far as I can see: there's no reset in here. It's a
> global heap variable with function-level visibility (note the "static"),
> so it is only ever initialized once:

Yes, obviously it is a static variable. You'll note that I also never
claimed anything regarding reset.

What I said was two things (perhaps with too many words :-) ):
 1) each value that we derive from this ever-incrementing (modulo 2^32)
    variable only get used for a limited amount of time (max. 5 minutes)
 2) if you manage to overflow within 5 minutes, then the following
    device_add() will just fail and nothing else/bad will happen

Therefore, there's no problem with wrapping, and IMHO it'd be *better*
than saturating because (1) means that the wrapping almost certainly
doesn't matter, and (2) means that even if you do manage to wrap and
cause a "clash" (what I wrote in the text you quoted) this is entirely
harmless.

OTOH, if you saturate, then - again under the premise of actually
getting there, however unlikely it may be - you are afterwards *always*
hitting (2), regardless of (1), which seems counter-productive given
that (1) means that (2) almost certainly won't happen.

IOW, I disagree with you, and think that counter_atomic_32 is more
appropriate here than refcount_t.

johannes

