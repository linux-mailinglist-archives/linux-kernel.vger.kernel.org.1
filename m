Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4554C260325
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 19:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbgIGRpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 13:45:01 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:50098 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731493AbgIGRom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:44:42 -0400
Date:   Mon, 7 Sep 2020 13:44:37 -0400
From:   Rich Felker <dalias@libc.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-sh@vger.kernel.org,
        Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
        linux-kernel@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH] sh: fix syscall tracing
Message-ID: <20200907174436.GK3265@brightrain.aerifal.cx>
References: <20200903054803.GX3265@brightrain.aerifal.cx>
 <e456a455-62cd-4f76-a69a-84d1e5b4d153@physik.fu-berlin.de>
 <20200903161639.GE3265@brightrain.aerifal.cx>
 <1a3f0f7e-f6e6-db4e-06ad-9c7d560a6265@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a3f0f7e-f6e6-db4e-06ad-9c7d560a6265@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 11:52:20AM +0200, John Paul Adrian Glaubitz wrote:
> Hi Rich!
> 
> On 9/3/20 6:16 PM, Rich Felker wrote:
> >> I can confirm that this patch fixes both strace for me and does not break libseccomp,
> >> I have run the libseccomp testsuite with my patch for SuperH support applied on top
> >> of a rebased libseccomp with the 32-bit fixes. Attaching the testsuite log.
> >>
> >> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > 
> > Great! Thanks!
> 
> Can we still get this merged as a hotfix for 5.9?

Yes, fixes for regressions in the same release cycle are in-scope (the
whole point of having -rc's). I have at least one other fix that needs
to go in too and was just giving it a little time to make sure
everything's ok now and that there are no more.

Rich
