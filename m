Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1DBA19CC85
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 23:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389034AbgDBVpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 17:45:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39068 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388008AbgDBVpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 17:45:13 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jK7e2-0003jo-Ii; Thu, 02 Apr 2020 23:45:02 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B3201100D52; Thu,  2 Apr 2020 23:45:01 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Singh\, Balbir" <sblbir@amazon.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tony.luck\@intel.com" <tony.luck@intel.com>,
        "keescook\@chromium.org" <keescook@chromium.org>,
        "benh\@kernel.crashing.org" <benh@kernel.crashing.org>,
        "x86\@kernel.org" <x86@kernel.org>,
        "dave.hansen\@intel.com" <dave.hansen@intel.com>
Subject: Re: [PATCH 0/3] arch/x86: Optionally flush L1D on context switch
In-Reply-To: <20200402204749.33ulub5jx66dktxg@treble>
References: <20200402062401.29856-1-sblbir@amazon.com> <20200402201328.zqnxwaetpk4ubg56@treble> <31c9720eff18ce167378e9a0017dcd73e0552164.camel@amazon.com> <20200402204749.33ulub5jx66dktxg@treble>
Date:   Thu, 02 Apr 2020 23:45:01 +0200
Message-ID: <875zehmujm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Poimboeuf <jpoimboe@redhat.com> writes:
> On Thu, Apr 02, 2020 at 08:35:46PM +0000, Singh, Balbir wrote:
>> Yes, that CVE the motivation, the mitigation for CVE-2020-0550 does suggest
>> flushing the cache on context switch. But in general, as we begin to find more
>> ways of evicting data or snopping data, a generic mechanism is more useful and
>> that is why I am making it an opt-in.
>
> Ok.  I think it would be a good idea to expand on that justification
> more precisely in the commit message.  That would help both reviewers of
> the code and users of the new option understand what level of paranoia
> they're opting in to :-)

The commit message is mostly useful for reviewers and people who have to
do code archeaology. 

Documentation/admin-guide/hw-vuln/ has plenty of space to host a
document with explanations. paranoia.rst comes to my mind. :)

Thanks,

        tglx
 
