Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1FF1F1298
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 07:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgFHF7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 01:59:31 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:10459 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728053AbgFHF7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 01:59:31 -0400
X-IronPort-AV: E=Sophos;i="5.73,487,1583190000"; 
   d="scan'208";a="453434732"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 07:59:29 +0200
Date:   Mon, 8 Jun 2020 07:59:29 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Al Viro <viro@zeniv.linux.org.uk>
cc:     "Rodolfo C. Villordo" <rodolfovillordo@gmail.com>,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Forest Bond <forest@alittletooquiet.net>,Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,devel@driverdev.osuosl.org,linux-kernel@vger.kernel.org
In-Reply-To: <20200608054614.GO23230@ZenIV.linux.org.uk>
Message-ID: <alpine.DEB.2.21.2006080758510.2430@hadrien>
References: <20200607224156.GA24090@ip-172-31-24-31.ec2.internal> <20200608054614.GO23230@ZenIV.linux.org.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Jun 2020, Al Viro wrote:

> On Sun, Jun 07, 2020 at 10:41:56PM +0000, Rodolfo C. Villordo wrote:
> > Multiple line over 80 characters fixes by splitting in multiple lines.
> > Warning found by checkpatch.pl
>
> I doubt that checkpatch.pl can catch the real problems there:
>
> * Hungarian Notation Sucks.  Really.
> * so does CamelCase, especially for wonders like s_uGetRTSCTSRsvTime

Rodolfo,

If you work hard with Coccinelle and python scripting, it can help with
the first two problems.

julia


> * local variables are useful
> * if a long expression keeps cropping up all over the place, you
> probably are missing an inline helper.
>
> PS: this
> > -			buf->time_stamp_off_a = vnt_time_stamp_off(pDevice, wCurrentRate);
> > -			buf->time_stamp_off_b = vnt_time_stamp_off(pDevice, pDevice->byTopCCKBasicRate);
> > +			buf->time_stamp_off_a =
> > +				vnt_time_stamp_off(pDevice, wCurrentRate);
> > +			buf->time_stamp_off_b =
> > +				vnt_time_stamp_off(pDevice,
> > +						   pDevice->byTopCCKBasicRate);
> is no improvement.
>
