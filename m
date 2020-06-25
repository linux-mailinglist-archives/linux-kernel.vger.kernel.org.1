Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C87209FC4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 15:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405042AbgFYNYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 09:24:52 -0400
Received: from ms.lwn.net ([45.79.88.28]:58870 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405046AbgFYNYv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 09:24:51 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id EC8762AE;
        Thu, 25 Jun 2020 13:24:50 +0000 (UTC)
Date:   Thu, 25 Jun 2020 07:24:49 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 01/10] mfd: wm8350-core: Supply description
 wm8350_reg_{un}lock args
Message-ID: <20200625072449.4d3e3fca@lwn.net>
In-Reply-To: <20200625071313.GM954398@dell>
References: <20200625064619.2775707-1-lee.jones@linaro.org>
        <20200625064619.2775707-2-lee.jones@linaro.org>
        <20200625065608.GB2789306@kroah.com>
        <20200625071313.GM954398@dell>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jun 2020 08:13:13 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> > Why are all of these documentation fixes for stable?  
> 
> Because they fix compiler warnings.
> 
> Not correct?

I am overjoyed to see people fixing docs build warnings, it is work that
is desperately needed.  That said, these warning fixes are probably not
stable material; the problem is bigger and longer-term than that.

Thanks,

jon
