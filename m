Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6F0928686D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 21:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgJGTi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 15:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgJGTi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 15:38:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE6EC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 12:38:56 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQFGy-0019jE-FY; Wed, 07 Oct 2020 21:38:48 +0200
Message-ID: <f27149d6b9b781ccf9c2fa041082c134abccd925.camel@sipsolutions.net>
Subject: Re: [PATCH v2 04/11] drivers/base/devcoredump: convert devcd_count
 to counter_atomic32
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 07 Oct 2020 21:38:47 +0200
In-Reply-To: <cb86761a-5531-cbb2-3987-0897771949b8@linuxfoundation.org> (sfid-20201007_213346_492518_9DEB611E)
References: <cover.1602011710.git.skhan@linuxfoundation.org>
         <462fd514dfe2afbb8faa1dea4cdb4b0e75d8e8da.1602011710.git.skhan@linuxfoundation.org>
         <202010071114.EE9A2A47C@keescook>
         <cb86761a-5531-cbb2-3987-0897771949b8@linuxfoundation.org>
         (sfid-20201007_213346_492518_9DEB611E)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-07 at 13:33 -0600, Shuah Khan wrote:
> On 10/7/20 12:15 PM, Kees Cook wrote:
> > On Tue, Oct 06, 2020 at 02:44:35PM -0600, Shuah Khan wrote:
> > > counter_atomic* is introduced to be used when a variable is used as
> > > a simple counter and doesn't guard object lifetimes. This clearly
> > > differentiates atomic_t usages that guard object lifetimes.
> > > 
> > > counter_atomic* variables will wrap around to 0 when it overflows and
> > > should not be used to guard resource lifetimes, device usage and
> > > open counts that control state changes, and pm states.
> > > 
> > > devcd_count is used to track dev_coredumpm device count and used in
> > > device name string. It doesn't guard object lifetimes, device usage
> > > counts, device open counts, and pm states. There is very little chance
> > > of this counter overflowing. Convert it to use counter_atomic32.
> > > 
> > > This conversion doesn't change the overflow wrap around behavior.
> > > 
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> > 
> > I actually wonder if this should use refcount_t just because it is
> > designed to be an alway-unique value. It is hard to imagine ever causing
> > this to overflow, but why not let it be protected?
> > 
> 
> This is one of the cases where devcd_count doesn't guard lifetimes,
> however if it ever overflows, refcount_t is a better choice.
> 
> If we decide refcount_t is a better choice, I can drop this patch
> and send refcount_t conversion patch instead.
> 
> Greg! Any thoughts on refcount_t for this being a better choice?

I'm not Greg, but ... there's a 5 minute timeout. So in order to cause a
clash you'd have to manage to overflow the counter within a 5 minute
interval, otherwise you can actually reuse the numbers starting again
from 0 without any ill effect.

And even if you *do* manage to overflow it quickly enough it'll just
fail device_add() and error out, and nothing happens.

So I think it's fairly much pointless to think about protecting against
some kind of overflows. It's just trying to get a "temporarily unique
ID" here, could be doing anything else instead, but most other things
would require bigger data structures and/or (higher level) locking.

OTOH, if you *do* somehow create that many core dumps (huge uptimes and
extremely frequent crashes?) it seems like refcount_t would be a bad
choice because it saturates, and then you can only do one more dump per
5 minutes? Or maybe that's a good thing in these ill cases ...

I don't think it'll really happen either way :)

johannes

