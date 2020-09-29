Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AD027CE2A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 14:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgI2Mze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 08:55:34 -0400
Received: from mx4.wp.pl ([212.77.101.12]:40568 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728185AbgI2Mzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 08:55:31 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Sep 2020 08:55:28 EDT
Received: (wp-smtpd smtp.wp.pl 30980 invoked from network); 29 Sep 2020 14:48:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1601383727; bh=riBCsGSrvVs1MmPzP8zZ7cZlVtj1L6yxJ2egJQq+XXQ=;
          h=To:From:Subject;
          b=r4L3Qo5qReuksrySav5rVJkaLySKsawa1+7pp2JhtOGwetj2XS8YzVZyzpqTsO4Yb
           9DwId/1dgck+2+mGfiz946kxU2DBrXYRLzSwkqLJVXNlwiKeJLIRevHrbGym8b2Lmd
           0kJGNT8CGy+zSEDfQUAQZ8O/HCr3J164cb5q4ltM=
Received: from citpc010.gsi.de (HELO [140.181.101.163]) (scriptkiddie@wp.pl@[140.181.101.163])
          (envelope-sender <scriptkiddie@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <linux-kernel@vger.kernel.org>; 29 Sep 2020 14:48:47 +0200
To:     linux-kernel@vger.kernel.org
From:   Marek Szuba <scriptkiddie@wp.pl>
Subject: pps-gpio: Allow enabling the option 'capture_clear' from the device
 tree
Autocrypt: addr=scriptkiddie@wp.pl; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5495aa2a-7f37-e6c8-9f6b-db1547be6db2@wp.pl>
Date:   Tue, 29 Sep 2020 14:48:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-WP-MailID: b6f833ea61eda7d2089fbedc861e4091
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000002 [QYFt]                               
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It has been possible to switch asserts from the rising to the falling
edge via the DT for quite a while so it would be nice to be able to do
the same with generating clear events - it is useful for improving
timing precision under some circumstances. Any chance we could have this
feature added to mainline kernels some time soon? It is a pretty trivial
change, see e.g.

https://github.com/raspberrypi/linux/commit/486a3a1dfa5e7892522d18b62aa33219a1b1ad31

and in addition to the Raspberry Pi, this seems to work fine on my
Allwinner A20-based SBC with (patched and self-built, of course) kernel 5.8.

What do you think?

Cheers,
-- 
MS
