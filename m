Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 653CF205391
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 15:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732719AbgFWNfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 09:35:33 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59562 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732616AbgFWNf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:35:27 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 75CF31C0C0E; Tue, 23 Jun 2020 15:35:25 +0200 (CEST)
Date:   Tue, 23 Jun 2020 15:35:24 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/13] ARM: dts: mmp3: Add the GPU
Message-ID: <20200623133524.GB2783@bug>
References: <20200616182341.944473-1-lkundrak@v3.sk>
 <20200616182341.944473-13-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616182341.944473-13-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-06-16 20:23:40, Lubomir Rintel wrote:
> There's a GC2000 3D core accompanied by a GC300 2D core.

According to the next patch, it is GC200...

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
