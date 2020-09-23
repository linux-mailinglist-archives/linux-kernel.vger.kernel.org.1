Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61795275E0B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 18:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgIWQ51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 12:57:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:60002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbgIWQ51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 12:57:27 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A69220BED;
        Wed, 23 Sep 2020 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600880246;
        bh=hIdSVVLt2zl1VTm4xEiFNczxwYeQMbtR2OaGzJVMESg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=frkDKHFkw1LNkAk9Hk3XL4hZDLPoU7jUkLN8nuMM/AI1vuMKuzNC7Da4YfuapGy2O
         YHbtU7iCnrKFKaOzIysY3MfXEa4SD7bpvWbFjFHMCCr0WNUH5JvTWFvBprbc60YTF9
         il8QBspfZvtbkFHbFCnfLuAnmXo4hcGQEtrDiY1E=
Date:   Wed, 23 Sep 2020 18:57:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Subject: Re: [RFC PATCH 1/9] misc: Add Surface Aggregator subsystem
Message-ID: <20200923165745.GA3732240@kroah.com>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-2-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923151511.3842150-2-luzmaximilian@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 05:15:03PM +0200, Maximilian Luz wrote:
> +/* -- Safe counters. -------------------------------------------------------- */
> +
> +/**
> + * ssh_seq_reset() - Reset/initialize sequence ID counter.
> + * @c: The counter to reset.
> + */
> +static void ssh_seq_reset(struct ssh_seq_counter *c)
> +{
> +	WRITE_ONCE(c->value, 0);
> +}

These "counters" are odd, what exactly are they?

They seem like a simple atomic counter, but not quite, so you have
rolled your own pseudo-atomic variable.  Are you sure that it works
properly?  If so, how?

What about just using an ida/idr structure instead?  Or just a simple
atomic counter that avoids the values you can't touch, or better yet, a
simple number with a correct lock protecting it :)

thanks,

greg k-h
