Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32ADF2AE723
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 04:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgKKDj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 22:39:59 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:42330 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgKKDj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 22:39:57 -0500
Received: from srv.home ([10.8.0.1] ident=heh29180)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <brad@fnarfbargle.com>)
        id 1kcgxC-000434-49; Wed, 11 Nov 2020 11:37:50 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject; bh=QbZ4v8/BuXQPYFybt+rEG4mvWF5ncSIq5z8b8FxAZlg=;
        b=UYcfKDyIkFUSJNX2kR1JPmJ+Aex7sWXj2lbliMAXwQ7WCiXPJnK48tCq6ZmhLuLay5pGKp69EKnEg3zvBaByhimn3FDSUtLnzJBdcVpFL2jX65a6p09QMv21tt/tZ2+K0Podbq2UNMis6AgUVbfFxAY7syelegEE1qBPBzeU2r4=;
Subject: [PATCH v4 0/1] applesmc: Re-work SMC comms
From:   Brad Campbell <brad@fnarfbargle.com>
To:     Henrik Rydberg <rydberg@bitmath.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-hwmon@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hns@goldelico.com, Guenter Roeck <linux@roeck-us.net>,
        Andreas Kemnade <andreas@kemnade.info>,
        Jean Delvare <jdelvare@suse.com>
References: <20200930105442.3f642f6c@aktux> <20201002002251.28462e64@aktux>
 <7543ef85-727d-96c3-947e-5b18e9e6c44d@roeck-us.net>
 <20201006090226.4275c824@kemnade.info>
 <db042e9b-be41-11b1-7059-3881b1da5c8b@fnarfbargle.com>
 <68467f1b-cea1-47ea-a4d4-8319214b072a@fnarfbargle.com>
 <20201104142057.62493c12@aktux>
 <2436afef-99c6-c352-936d-567bf553388c@fnarfbargle.com>
 <7a085650-2399-08c0-3c4d-6cd1fa28a365@roeck-us.net>
 <fc36d066-c432-e7d2-312f-a0a592446fe2@fnarfbargle.com>
 <10027199-5d31-93e7-9bd8-7baaebff8b71@roeck-us.net>
 <70331f82-35a1-50bd-685d-0b06061dd213@fnarfbargle.com>
 <3c72ccc3-4de1-b5d0-423d-7b8c80991254@fnarfbargle.com>
 <6d071547-10ee-ca92-ec8b-4b5069d04501@bitmath.org>
 <8e117844-d62a-bcb1-398d-c59cc0d4b878@fnarfbargle.com>
 <e5a856b1-fb1a-db5d-0fde-c86d0bcca1df@bitmath.org>
 <aa60f673-427a-1a47-7593-54d1404c3c92@bitmath.org>
 <9109d059-d9cb-7464-edba-3f42aa78ce92@bitmath.org>
 <5310c0ab-0f80-1f9e-8807-066223edae13@bitmath.org>
 <57057d07-d3a0-8713-8365-7b12ca222bae@fnarfbargle.com>
Message-ID: <e5c6242a-5207-0f9a-5803-2dc164425b5b@fnarfbargle.com>
Date:   Wed, 11 Nov 2020 14:37:49 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <57057d07-d3a0-8713-8365-7b12ca222bae@fnarfbargle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

G'day All,

Versions 1-3 of this patch were various attempts to try and simplify/clarify the communication to the SMC in order to remove the timing sensitivity which was exposed by Commit fff2d0f701e6 ("hwmon: (applesmc) avoid overlong udelay()"). As with the original author(s), we were limited in not having any documentation and relying on a "poke it and see what happens".

Whilst version 3 ticked all the boxes from a performance and reliability standpoint it still wasn't clear why it worked and why retries were required when sending a command to the SMC. I dug into the OSX driver to try and seek some clarity around that and found a very simple "state corrector" for want of a better word, whereby any interaction with the SMC was preceded by a simple 3 step process (found in smc_sane()) which ensured the SMC was in the right state to accept a transaction (or ultimately reported as broken). My testing has shown this routine is generally only required once on driver load to sync up the state machine, however it's purpose is to pull the SMC back into line if its internal state machine gets out of sync. This was likely happening with the command retry loop in the earlier versions, however due to the way the status bits were being checked it was unclear.

The other thing that was clear is outside of the "state corrector", all checking of SMC status bits happened before a read/write, not after. By re-working the comms to follow this protocol I believe we've simplified the code, made the actual operation clearer and removed *all* timing dependencies. This has also allowed a simplification of the timing in wait_status and a reduction in the waits incurred.

Henrik further simplified wait_status by leaving the minimum wait in usleep_range as 8uS. Testing on multiple machines has borne this out resulting in less loops/sleeps and no apparent impact in the performance of the driver (and in fact an increase on my iMac12,2 with a _very_ slow SMC). It also allowed for the removal of the jiffy based timeout as worst case it's going to sleep for a couple of seconds. The OSX driver puts a 10s timeout on every wait.

So, after much testing I'll submit v4 for comment and further testing.

Regards,
Brad
