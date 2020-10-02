Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11FA281847
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388239AbgJBQr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:47:57 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:51588 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388184AbgJBQr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:47:57 -0400
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2020 12:47:57 EDT
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 73EDC4FA0D8;
        Fri,  2 Oct 2020 16:38:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sQkmeulFXgRN; Fri,  2 Oct 2020 16:38:46 +0000 (UTC)
Received: from mail.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id DBC654FA0D5;
        Fri,  2 Oct 2020 16:38:45 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 02 Oct 2020 09:38:45 -0700
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [mac80211_hwsim] 148fe295b7: hwsim.ap_long_preamble.fail
In-Reply-To: <20201002082945.GJ393@shao2-debian>
References: <20201002082945.GJ393@shao2-debian>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <ffe9deeeb714d233c47d693c899f9577@adapt-ip.com>
X-Sender: thomas@adapt-ip.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-02 01:29, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 148fe295b7d9d892b2b0f47070233ccdc70c83cd ("mac80211_hwsim:
> indicate support for S1G")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> 
> in testcase: hwsim
> version: hwsim-x86_64-6eb6cf0-1_20200619
> with following parameters:
> 
> 	group: hwsim-04
> 	ucode: 0x21
> 
> 
> 
> on test machine: 8 threads Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz
> with 16G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire
> log/backtrace):
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> 
> 2020-10-06 00:22:09 	./run-tests.py ap_long_preamble
> DEV: wlan0: 02:00:00:00:00:00
> DEV: wlan1: 02:00:00:00:01:00
> DEV: wlan2: 02:00:00:00:02:00
> APDEV: wlan3
> APDEV: wlan4
> START ap_long_preamble 1/1
> Test: AP with long preamble
> Starting AP wlan3
> Failed to enable hostapd interface wlan3
> Traceback (most recent call last):
>   File "./run-tests.py", line 533, in main
>     t(dev, apdev)
>   File "/lkp/benchmarks/hwsim/tests/hwsim/test_ap_params.py", line
> 821, in test_ap_long_preamble
>     hapd = hostapd.add_ap(apdev[0], params)
>   File "/lkp/benchmarks/hwsim/tests/hwsim/hostapd.py", line 581, in 
> add_ap
>     hapd.enable()
>   File "/lkp/benchmarks/hwsim/tests/hwsim/hostapd.py", line 248, in 
> enable
>     raise Exception("Failed to enable hostapd interface " + 
> self.ifname)
> Exception: Failed to enable hostapd interface wlan3
> FAIL ap_long_preamble 0.064398 2020-10-06 00:22:09.608978
> passed 0 test case(s)
> skipped 0 test case(s)
> failed tests: ap_long_preamble

This is actually a bug in hostap which was exposed by this commit (and 
fixed by 
https://patchwork.ozlabs.org/project/hostap/patch/20200827225940.18151-1-thomas@adapt-ip.com/).

-- 
thomas
