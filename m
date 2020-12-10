Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DF62D5F87
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391840AbgLJPWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:22:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:41804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgLJPWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 10:22:38 -0500
Date:   Thu, 10 Dec 2020 16:23:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607613717;
        bh=ajOZXmURrx5BgRHqod5FB6tlCTkuY0yk/pB1C2pU9Yw=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3eSicyoKTo5Ae1Xce7tzqnWWG9IC/BRqytPrPV+tQBG2RVPIZOZsHoYfGWwtLNNx
         PELu+ioEJssPpRuPqpgJMaQBnpeJ89ayg4bMlmOin1121xv3bBCx4CxdsC2a5GLoJH
         K+lY4n1M4wGy+vUpHu7G/jh9nhwkpiOOXnxZ3lkA=
From:   Greg KH <gregkh@linuxfoundation.org>
To:     samuel.thibault@ens-lyon.org
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [patch 1/3] speakup: Add synth parameter to io functions
Message-ID: <X9I9Xwh+Q3tHXh88@kroah.com>
References: <20201209205829.693745475@ens-lyon.org>
 <20201209205838.531299374@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201209205838.531299374@ens-lyon.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 09:58:30PM +0100, samuel.thibault@ens-lyon.org wrote:
> This merely adds the missing synth parameter to all io functions.
> 
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 

The build still breaks when this patch is applied:

  CC [M]  drivers/accessibility/speakup/spk_ttyio.o
In file included from drivers/accessibility/speakup/spk_ttyio.c:9:
drivers/accessibility/speakup/spk_ttyio.c: In function ‘spk_ttyio_in’:
drivers/accessibility/speakup/spk_priv.h:31:27: warning: passing argument 1 of ‘ttyio_in’ makes pointer from integer without a cast [-Wint-conversion]
   31 | #define SPK_SYNTH_TIMEOUT 100000 /* in micro-seconds */
      |                           ^~~~~~
      |                           |
      |                           int
drivers/accessibility/speakup/spk_ttyio.c:344:18: note: in expansion of macro ‘SPK_SYNTH_TIMEOUT’
  344 |  return ttyio_in(SPK_SYNTH_TIMEOUT);
      |                  ^~~~~~~~~~~~~~~~~
drivers/accessibility/speakup/spk_ttyio.c:315:49: note: expected ‘struct spk_synth *’ but argument is of type ‘int’
  315 | static unsigned char ttyio_in(struct spk_synth *in_synth, int timeout)
      |                               ~~~~~~~~~~~~~~~~~~^~~~~~~~
drivers/accessibility/speakup/spk_ttyio.c:344:9: error: too few arguments to function ‘ttyio_in’
  344 |  return ttyio_in(SPK_SYNTH_TIMEOUT);
      |         ^~~~~~~~
drivers/accessibility/speakup/spk_ttyio.c:315:22: note: declared here
  315 | static unsigned char ttyio_in(struct spk_synth *in_synth, int timeout)
      |                      ^~~~~~~~
drivers/accessibility/speakup/spk_ttyio.c: In function ‘spk_ttyio_in_nowait’:
drivers/accessibility/speakup/spk_ttyio.c:349:10: error: too few arguments to function ‘ttyio_in’
  349 |  u8 rv = ttyio_in(0);
      |          ^~~~~~~~
drivers/accessibility/speakup/spk_ttyio.c:315:22: note: declared here
  315 | static unsigned char ttyio_in(struct spk_synth *in_synth, int timeout)
      |                      ^~~~~~~~
drivers/accessibility/speakup/spk_ttyio.c: In function ‘spk_ttyio_in’:
drivers/accessibility/speakup/spk_ttyio.c:345:1: error: control reaches end of non-void function [-Werror=return-type]
  345 | }
      | ^
cc1: some warnings being treated as errors
make[3]: *** [scripts/Makefile.build:279: drivers/accessibility/speakup/spk_ttyio.o] Error 1
make[2]: *** [scripts/Makefile.build:496: drivers/accessibility/speakup] Error 2
make[1]: *** [scripts/Makefile.build:496: drivers/accessibility] Error 2
make: *** [Makefile:1805: drivers] Error 2


You can't break the build on any patches in a series :(

thanks,

greg k-h
