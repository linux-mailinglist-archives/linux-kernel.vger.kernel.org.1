Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 229A420554F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 16:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732931AbgFWO7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 10:59:11 -0400
Received: from v6.sk ([167.172.42.174]:33784 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732738AbgFWO7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:59:10 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id E5EDC6130C;
        Tue, 23 Jun 2020 14:59:08 +0000 (UTC)
Date:   Tue, 23 Jun 2020 16:59:04 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] ARM: dts: mmp3: Add the GPU
Message-ID: <20200623145904.GA1378517@furthur.local>
References: <20200616182341.944473-1-lkundrak@v3.sk>
 <20200616182341.944473-13-lkundrak@v3.sk>
 <20200623133524.GB2783@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623133524.GB2783@bug>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 03:35:24PM +0200, Pavel Machek wrote:
> On Tue 2020-06-16 20:23:40, Lubomir Rintel wrote:
> > There's a GC2000 3D core accompanied by a GC300 2D core.
> 
> According to the next patch, it is GC200...

Good catch, thanks. The other patch is wrong, it actually is GC2000 --
will fix in next version.

Lubo

> 
> Best regards,
> 									Pavel
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
