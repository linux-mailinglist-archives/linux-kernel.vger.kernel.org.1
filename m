Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A165C1DC611
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 06:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgEUETG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 00:19:06 -0400
Received: from mail4.tencent.com ([183.57.53.109]:34018 "EHLO
        mail4.tencent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgEUETG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 00:19:06 -0400
X-Greylist: delayed 550 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 May 2020 00:19:03 EDT
Received: from EX-SZ018.tencent.com (unknown [10.28.6.39])
        by mail4.tencent.com (Postfix) with ESMTP id 62AC3722D9;
        Thu, 21 May 2020 12:09:51 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tencent.com;
        s=s202002; t=1590034191;
        bh=0J/Iyor6JI7kRj1E77ZmS5fAyQEZe9jJ3ekKIr2jbXE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=T1r/i0PzgUJ5D5/W/TEnUAd9CFz+RI7PKOjiIvW7trPFyeqjvCrianLh5Z2edQOM9
         26iOF8GPEygYRhvMtQC1wYkZElc7rtI0oajiMu0uGpyUeuYEYyCuCyVNEXbkpiWMYc
         bdOFn6Bfiv4GKY//cF6GL3oCWSIrwUGUwUEmldzs=
Received: from EX-SZ006.tencent.com (10.28.6.30) by EX-SZ018.tencent.com
 (10.28.6.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 21 May
 2020 12:09:51 +0800
Received: from EX-SZ012.tencent.com (10.28.6.36) by EX-SZ006.tencent.com
 (10.28.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3; Thu, 21 May
 2020 12:09:51 +0800
Received: from EX-SZ012.tencent.com ([fe80::704d:4b2e:562c:22c]) by
 EX-SZ012.tencent.com ([fe80::704d:4b2e:562c:22c%3]) with mapi id
 15.01.1847.007; Thu, 21 May 2020 12:09:51 +0800
From:   =?iso-2022-jp?B?YmVuYmppYW5nKBskQj5VSTcbKEIp?= 
        <benbjiang@tencent.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
CC:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Tim Chen" <tim.c.chen@linux.intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "pjt@google.com" <pjt@google.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        vpillai <vpillai@digitalocean.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "kerrnel@google.com" <kerrnel@google.com>,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "aubrey.li@linux.intel.com" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH RFC] sched: Add a per-thread core scheduling
 interface(Internet mail)
Thread-Topic: [PATCH RFC] sched: Add a per-thread core scheduling
 interface(Internet mail)
Thread-Index: AQHWLvXKFOwpUhEtgUmeB0cRYW4c1KixZ1AA
Date:   Thu, 21 May 2020 04:09:50 +0000
Message-ID: <71B72E96-CD6E-43C3-B22B-ADE0EC78C550@tencent.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200520222642.70679-1-joel@joelfernandes.org>
In-Reply-To: <20200520222642.70679-1-joel@joelfernandes.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.28.2.16]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <C4E62B49377D9046850931CE6C01E8F1@tencent.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 21, 2020, at 6:26 AM, Joel Fernandes (Google) <joel@joelfernandes.=
org> wrote:
>=20
> Add a per-thread core scheduling interface which allows a thread to tag
> itself and enable core scheduling. Based on discussion at OSPM with
> maintainers, we propose a prctl(2) interface accepting values of 0 or 1.
> 1 - enable core scheduling for the task.
> 0 - disable core scheduling for the task.
>=20
> Special cases:
> (1)
> The core-scheduling patchset contains a CGroup interface as well. In
> order for us to respect users of that interface, we avoid overriding the
> tag if a task was CGroup-tagged because the task becomes inconsistent
> with the CGroup tag. Instead return -EBUSY.
>=20
> (2)
> If a task is prctl-tagged, allow the CGroup interface to override
> the task's tag.
>=20
> ChromeOS will use core-scheduling to securely enable hyperthreading.
> This cuts down the keypress latency in Google docs from 150ms to 50ms
> while improving the camera streaming frame rate by ~3%.
Hi,
Are the performance improvements compared to the hyperthreading disabled sc=
enario or not?
Could you help to explain how the keypress latency improvement comes with c=
ore-scheduling?

Thanks a lot.

Regards,
Jiang

