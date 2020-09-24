Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F685277732
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgIXQvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:51:04 -0400
Received: from ms.lwn.net ([45.79.88.28]:59288 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgIXQvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:51:03 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4A60B750;
        Thu, 24 Sep 2020 16:51:01 +0000 (UTC)
Date:   Thu, 24 Sep 2020 10:50:57 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin Mares <mj@ucw.cz>, linux-video@atrey.karlin.mff.cuni.cz,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/2] Documentation/admin-guide: remove use of
 "rdev"
Message-ID: <20200924105057.00fa0cf8@lwn.net>
In-Reply-To: <20200918015640.8439-1-rdunlap@infradead.org>
References: <20200918015640.8439-1-rdunlap@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Sep 2020 18:56:38 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Remove mention of using "rdev" to set boot device, video mode,
> or ramdisk information for the booting kernel.
> 
> 
> Cc: Karel Zak <kzak@redhat.com>
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Martin Mares <mj@ucw.cz>
> Cc: linux-video@atrey.karlin.mff.cuni.cz
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> 
> 
>  [RFC PATCH 1/2] Documentation/admin-guide: README & svga: remove use of "rdev"
>  [RFC PATCH 2/2] Documentation/admin-guide: blockdev/ramdisk: remove use of "rdev"

Applied, thanks.

jon
