Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEF62911A5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 13:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437591AbgJQL2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 07:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437383AbgJQL2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 07:28:06 -0400
X-Greylist: delayed 2141 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 17 Oct 2020 04:28:05 PDT
Received: from torres.zugschlus.de (torres.zugschlus.de [IPv6:2a01:238:42bc:a101::2:100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6909C061755
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 04:28:05 -0700 (PDT)
Received: from mh by torres.zugschlus.de with local (Exim 4.92.2)
        (envelope-from <mh+linux-kernel@zugschlus.de>)
        id 1kTjor-0007mB-39; Sat, 17 Oct 2020 12:52:13 +0200
Date:   Sat, 17 Oct 2020 12:52:13 +0200
From:   Marc Haber <mh+linux-kernel@zugschlus.de>
To:     willy.liu@realtek.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
Subject: 42d8c91e for drivers/net/phy/realtek.c causing loss on Banana Pi
Message-ID: <20201017105213.GT32306@torres.zugschlus.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

in kernel 5.9, my Banana Pi test systems suffers from catastrophic
packet loss on the Ethernet that makes the machine nearly unusable.
Reverting bbc4d71d63549bcd003a430de18a72a742d8c91e fixes the issue for
me.

Please investigate the breakage caused by this commit. I am prepared to
help with testing and would appreciate a fix even in Greg's stable
releases.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421
