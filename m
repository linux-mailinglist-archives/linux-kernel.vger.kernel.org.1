Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA73622110F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 17:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgGOPcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 11:32:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgGOPcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:32:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41C2D206D5;
        Wed, 15 Jul 2020 15:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594827140;
        bh=oJ4h/SmpkONnzXL2WSeND1WZd7clSyOkeMbEe5Ho76g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ozO9wnglZvOOTjDuQJJp2X8xeSqaczMd/tIGeCdNmA0YHS6ORamWoMJRObtEdJ6nG
         daHMBIMnYUz4WLJmEyx6s432CNuHXYG1NjN0PeLMQT/uB8q01G7Hfu19BCbIxQIMci
         3P26AwYOHjzT2e5G5vYSpGTEwHlNnwXZXzo5Tcvg=
Date:   Wed, 15 Jul 2020 17:32:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Garrit Franke <garritfranke@gmail.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kobject: remove unused KOBJ_MAX action
Message-ID: <20200715153216.GB749262@kroah.com>
References: <20200714063517.GB662760@kroah.com>
 <20200715151116.6098-1-garritfranke@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715151116.6098-1-garritfranke@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 05:11:16PM +0200, Garrit Franke wrote:
> The loop in lib/kobject_uevent.c that checked for KOBJ_MAX is no longer present, we do
> a much more sane ARRAY_SIZE() check instead (see 5c5daf657cb5).

Odd line wrapping :(

When you specify a git commit, use the format as documented in the
submitting patches file:
	5c5daf657cb5 ("Driver core: exclude kobject_uevent.c for !CONFIG_HOTPLUG")

> Therefore, the KOBJ_MAX is not used anymore.

That sentence does not make much sense :(

thanks,

greg k-h
