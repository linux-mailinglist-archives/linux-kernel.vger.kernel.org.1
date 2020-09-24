Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72B227758C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 17:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgIXPhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 11:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbgIXPhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 11:37:00 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C221622208;
        Thu, 24 Sep 2020 15:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600961820;
        bh=/cGqNUHp0D6orsIJY1ALWDj9FM1YLGdTBkqKwjo4014=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yYeD9mddBetQ/EVaHClCOdTJDgj2r57fhsPcJbBKWlwoLYWn0iwsYROhtfFBOBhrw
         +Om5sZMPJkm3mKC7+Sivo3gxvaOLNKc3uZmXlmvK6Zhu7552brXh0VrBk+3jPUCbyo
         eWXEbOg8wFjfZel6YWESiHwP0vuzt/ZQCn3jjZn4=
Date:   Thu, 24 Sep 2020 17:37:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Srinivasan Raju <srini.raju@purelifi.com>
Cc:     mostafa.afgani@purelifi.com, pureLiFi Ltd <info@purelifi.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>
Subject: Re: [PATCH] staging: Initial driver submission for pureLiFi devices
Message-ID: <20200924153716.GB1171035@kroah.com>
References: <20200924151910.21693-1-srini.raju@purelifi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924151910.21693-1-srini.raju@purelifi.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 08:48:51PM +0530, Srinivasan Raju wrote:
> +++ b/drivers/staging/purelifi/chip.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GNU General Public License v2.0 or later

That's not a valid SPDX identifier :)



> +/* Copyright (c) 2015-2020 pureLiFi Ltd
> + * All rights reserved.
> + *
> + * Copyright (C) 2015-2020 pureLiFi <info@purelifi.com>
> + * Copyright (C) 2006-2007 Daniel Drake <dsd@gentoo.org>
> + * Copyright (C) 2005-2007 Ulrich Kunitz <kune@deine-taler.de>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

These paragraphs are not needed with a SPDX line above.

thanks,

greg k-h
