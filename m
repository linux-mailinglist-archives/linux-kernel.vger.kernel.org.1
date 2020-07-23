Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4FD22B02B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 15:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgGWNPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jul 2020 09:15:46 -0400
Received: from ms.lwn.net ([45.79.88.28]:40664 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgGWNPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:15:45 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 797D32CD;
        Thu, 23 Jul 2020 13:15:45 +0000 (UTC)
Date:   Thu, 23 Jul 2020 07:15:44 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 1/1] doc:it_IT: process: coding-style.rst: Correct
 __maybe_unused compiler label
Message-ID: <20200723071544.6ae66920@lwn.net>
In-Reply-To: <20200723103333.GO3533@dell>
References: <20200715122328.3882187-1-lee.jones@linaro.org>
        <4e50d1ee2ebd55f8f87fcd5c631e97f3@vaga.pv.it>
        <20200723103333.GO3533@dell>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 11:33:33 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> On Thu, 16 Jul 2020, Federico Vaga wrote:
> 
> > Of course, you are right! Thanks
> > 
> > On 2020-07-15 14:23, Lee Jones wrote:  
> > > Flag is __maybe_unused, not __maybe_used.
> > > 
> > > Cc: Federico Vaga <federico.vaga@vaga.pv.it>
> > > Cc: Jonathan Corbet <corbet@lwn.net>
> > > Cc: linux-doc@vger.kernel.org
> > > Cc: clang-built-linux@googlegroups.com
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>  
> 
> Any idea who will/should take this?

It's a docs patch, I'll apply it once I get back to the queue....

Thanks,

jon
