Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC842FF54B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 21:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbhAUUBo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Jan 2021 15:01:44 -0500
Received: from mailoutvs41.siol.net ([185.57.226.232]:52768 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726848AbhAUTzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 14:55:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id A146F520BDA;
        Thu, 21 Jan 2021 20:54:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id B90abY8oWMUe; Thu, 21 Jan 2021 20:54:09 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 5D80B5235B6;
        Thu, 21 Jan 2021 20:54:09 +0100 (CET)
Received: from kista.localnet (cpe-86-58-58-53.static.triera.net [86.58.58.53])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id EC71B520BDA;
        Thu, 21 Jan 2021 20:54:07 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     linux-arm-kernel@lists.infradead.org,
        Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Cc:     mripard@kernel.org, wens@csie.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: sun7i: a20: bananapro: Fix ethernet node
Date:   Thu, 21 Jan 2021 20:54:07 +0100
Message-ID: <2438641.b0YrFlWa0f@kista>
In-Reply-To: <20210121170836.GA4948@lemon.iwr.uni-heidelberg.de>
References: <20210121170836.GA4948@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne četrtek, 21. januar 2021 ob 18:08:36 CET je Hermann Lauer napisal(a):
> BPi Pro needs TX and RX delay for Gbit to work reliable and avoid high
> packet loss rates. The realtek phy driver overrides the settings of the
> pull ups for the delays, so fix this for Banana Pro.
> 
> Signed-off-by: Hermann Lauer <Hermann.Lauer@uni-heidelberg.de>

Much better. Now the only thing missing is "Fixes" tag, which references 
commit which introduced the issue. Probably this will be the commit which 
added ethernet node. This tag is important for deciding which commits should 
be backported to stable releases. Take a look in v1 for M2U fixes tag.

Btw, each version should have changelog under "---" line, so maintainers and 
reviewers know what changed.

Best regards,
Jernej


