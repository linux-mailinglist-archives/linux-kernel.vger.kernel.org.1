Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF1F275068
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 07:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgIWFoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 01:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:57208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgIWFoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 01:44:22 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13C9C21D91;
        Wed, 23 Sep 2020 05:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600839861;
        bh=PNVSGZ/IrHXOOxQ05RfPzXNQcUDkA7tZrXhQqZ54p+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hrMrcdGWIv/lLOd/1R9KnmbvSryjwks5+bZOkxbcvfQUhWPVId4unyS6AkYskHMPa
         OLm2HGJX7vEN+N+/XDWPMBdA7MeZ+PJ2n9qFxAXxFIygSIO5cGHMD+OW9W2Fb7mVhb
         qQaoU5HKuj0ZOVUAaaVCtnpU4UAJ8LpUbG8bNQvo=
Date:   Wed, 23 Sep 2020 07:44:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devel@driverdev.osuosl.org,
        Marcelo Diop-Gonzalez <marcgonzalez@google.com>,
        linux-kernel@vger.kernel.org,
        Nachammai Karuppiah <nachukannan@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Jamal Shareef <jamal.k.shareef@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] staging: vchiq: fix __user annotations
Message-ID: <20200923054440.GA2619878@kroah.com>
References: <20200922202208.1861595-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200922202208.1861595-1-arnd@arndb.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 10:21:43PM +0200, Arnd Bergmann wrote:
> My earlier patches caused some new sparse warnings, but it turns out
> that a number of those are actual bugs, or at least suspicous code.
> 
> Adding __user annotations to the data structures that are defined in
> uapi headers helps avoid the new warnings, but that causes a different
> set of warnings to show up, as some of these structures are used both
> inside of the kernel and at the user interface but storing pointers to
> different things there.
> 
> Duplicating the vchiq_service_params and vchiq_completion_data structures
> in turn takes care of most of those, and then it turns out that there
> is a 'data' pointer that can be any of a __user address, a dmd_addr_t
> and a kernel pointer in vmalloc space at times.
> 
> I'm trying to annotate these as best I can without changing behavior,
> but there still seems to be a serious bug when user space passes
> a valid vmalloc space address instead of a user pointer. Adding
> comments in the code there, and leaving the warnings in place that
> seem to correspond to actual bugs.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  .../include/linux/raspberrypi/vchiq.h         | 11 ++-
>  .../interface/vchiq_arm/vchiq_2835_arm.c      |  2 +-
>  .../interface/vchiq_arm/vchiq_arm.c           | 95 ++++++++++++-------
>  .../interface/vchiq_arm/vchiq_core.c          | 19 ++--
>  .../interface/vchiq_arm/vchiq_core.h          | 10 +-
>  .../interface/vchiq_arm/vchiq_ioctl.h         | 29 ++++--
>  6 files changed, 106 insertions(+), 60 deletions(-)

This patch series breaks the build for me:

drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c: In function ‘vc_vchi_audio_init’:
drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c:125:9: error: variable ‘param
’ has initializer but incomplete type
  125 |  struct vchiq_service_params params = {
      |         ^~~~~~~~~~~~~~~~~~~~
drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c:126:4: error: ‘struct vchiq_service_params’ has no member named ‘version’
  126 |   .version  = VC_AUDIOSERV_VER,
      |    ^~~~~~~
In file included from drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c:8:
drivers/staging/vc04_services/bcm2835-audio/vc_vchi_audioserv_defs.h:8:26: warning: excess elements in struct initializer
    8 | #define VC_AUDIOSERV_VER 2
      |                          ^
drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c:126:15: note: in expansion of macro ‘VC_AUDIOSERV_VER’
  126 |   .version  = VC_AUDIOSERV_VER,
      |               ^~~~~~~~~~~~~~~~


and so on...

Care to try a v2?

thanks,

greg k-h
