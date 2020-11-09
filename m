Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870F92AC2C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbgKIRpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:45:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:44312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730115AbgKIRpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:45:08 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 052E120639;
        Mon,  9 Nov 2020 17:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604943906;
        bh=pFovQDkBetMXt5TJD5tInvTeE/kZOpZNdk59x2W8Bjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q2jVLdxBYXLUzBZoY+TFQGGKvRcomWylJy0DRHVWJuvS4FZ0Dzki13tScmNSfyiWa
         K2dQ0k7ox8mR8DskVYc0VV/5nlbRwlN1bG2sbYIdX2GcLV6V0RM7yJqnmIlHgHQjCP
         jhW5jhARyL7wt6mBIuuqz6jvkIOa/iZOnRgTE0ks=
Date:   Mon, 9 Nov 2020 18:46:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Frankie Chang <Frankie.Chang@mediatek.com>
Cc:     Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>
Subject: Re: binder: add transaction latency tracer
Message-ID: <20201109174605.GA2426739@kroah.com>
References: <1602781377-4278-1-git-send-email-Frankie.Chang@mediatek.com>
 <1603987737-2763-1-git-send-email-Frankie.Chang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603987737-2763-1-git-send-email-Frankie.Chang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 12:08:54AM +0800, Frankie Chang wrote:
> Change from v11:
>   - rebase.

This whole patch set is sent with DOS line-ends, which makes git really
unhappy when it tries to apply it, as rightfully, it doesn't know how to
convert things.

Please resend this patch series as a plain-text patch series.  Perhaps
using git send-email?  Something is converting these patches to an odd
encoding which makes them not able to be applied.

Try sending them to yourself first, and seeing if you can apply them
from the messages directly, and if so, then resend them.

thanks,

greg k-h
