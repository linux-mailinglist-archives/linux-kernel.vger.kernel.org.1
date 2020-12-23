Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 713242E1B13
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 11:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgLWKmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 05:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbgLWKmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 05:42:36 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9A2C0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 02:41:55 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 0147B588D24FF; Wed, 23 Dec 2020 11:41:51 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id F12DB60046354;
        Wed, 23 Dec 2020 11:41:51 +0100 (CET)
Date:   Wed, 23 Dec 2020 11:41:51 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Guenter Roeck <linux@roeck-us.net>
cc:     Gabriel C <nix.or.die@googlemail.com>, linux-hwmon@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Wei Huang <wei.huang2@amd.com>
Subject: Re: k10temp: ZEN3 readings are broken
In-Reply-To: <9d621d34-e5ce-301a-1b89-92c0791fe348@roeck-us.net>
Message-ID: <4483r6o2-245o-147-s71r-s64ss3nqr8ps@vanv.qr>
References: <CAEJqkgiiU7miC13iT6DufjFAsHkNZk6rBAw=KRRnHe47kTZDnw@mail.gmail.com> <9d621d34-e5ce-301a-1b89-92c0791fe348@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday 2020-12-22 04:58, Guenter Roeck wrote:
>On 12/21/20 5:45 PM, Gabriel C wrote:
>> Hello Guenter,
>> 
>> while trying to add ZEN3 support for zenpower out of tree modules, I find out
>> the in-kernel k10temp driver is broken with ZEN3 ( and partially ZEN2 even ).
>
>[...] since I do not have time to actively maintain
>the driver, since each chip variant seems to use different addresses and scales,
>and since the information about voltages and currents is unpublished by AMD,
>I'll remove support for voltage/current readings from the upstream driver.

I support that decision.

/proc/cpuinfo::AMD Ryzen 7 3700X 8-Core Processor, fam 23 model 113 step 0

A synthetic load (perl -e '1 while 1') x 16 shows:
Adapter: PCI adapter
Vcore:        +1.28 V
Vsoc:         +1.02 V
Tctl:         +94.8°C
Tdie:         +94.8°C
Tccd1:        +94.8°C
Icore:       +76.00 A
Isoc:         +6.75 A

A BOINC workload on average:
k10temp-pci-00c3
Adapter: PCI adapter
Vcore:        +1.17 V  
Vsoc:         +1.02 V  
Tctl:         +94.9°C  
Tdie:         +94.9°C  
Tccd1:        +95.0°C  
Icore:       +88.00 A  
Isoc:         +8.00 A  

The BOINC workload, when it momentarily spikes:
Adapter: PCI adapter
Vcore:        +1.32 V  
Vsoc:         +1.02 V  
Tctl:         +94.1°C  
Tdie:         +94.1°C  
Tccd1:        +96.0°C  
Icore:       +105.00 A  
Isoc:         +7.75 A  

For a processor sold as a 65 W part, observing reported sensors as 
88 A x 1.17 V + 8 A x 1.02 V = 111.12 W just can't be. We are off by a 
factor of about 2.
