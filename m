Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65381D3656
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 18:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgENQU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 12:20:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:41558 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgENQU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:20:59 -0400
Received: from zn.tnic (p200300ec2f0bbd007cf66d800b61f914.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:bd00:7cf6:6d80:b61:f914])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A05901EC0375;
        Thu, 14 May 2020 18:20:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589473257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1gKq6/txv4/dgqBSdy7caqtzhIA39mnyFKl7npStMa0=;
        b=fUJLbZBgov/laPrkl2Yl9XCMoB+nZYSK+2NrvD3hRSrTsOQ9DpXfw+AAK6OYoOI8klNJkH
        wIe9zDYTXg9X3myCOnN7aKChTK3c2I29Ip3jE64JIIixjfMIkrJvWoK6vjCrwMxsWO+E6f
        EdbPMxs96XMONwYa+h3OocaBzKBwno4=
Date:   Thu, 14 May 2020 18:20:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     "Dr. Greg" <greg@enjellic.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-sgx@vger.kernel.org,
        akpm@linux-foundation.org, dave.hansen@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com, haitao.huang@intel.com,
        andriy.shevchenko@linux.intel.com, kai.svahn@intel.com,
        josh@joshtriplett.org, luto@kernel.org, kai.huang@intel.com,
        rientjes@google.com, cedric.xing@intel.com, puiterwijk@redhat.com
Subject: Re: [PATCH v29 00/20] Intel SGX foundations
Message-ID: <20200514162054.GE9266@zn.tnic>
References: <20200421215316.56503-1-jarkko.sakkinen@linux.intel.com>
 <20200426165753.GA11046@wind.enjellic.com>
 <87d07gk24l.fsf@nanos.tec.linutronix.de>
 <20200508190226.GA31465@wind.enjellic.com>
 <20200508195635.GR27052@linux.intel.com>
 <20200514091637.GA25156@wind.enjellic.com>
 <20200514161559.GA15603@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200514161559.GA15603@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 09:15:59AM -0700, Sean Christopherson wrote:
> I'm not opposed to adding a kernel param to disable SGX.  At one point
> there was a proposal to extend clearcpuid to allow disabling multiple
> feature bits, but it looks like that went the way of the dodo.
> 
> Note, such a param would disable SGX entirely, e.g. clear the feature bit
> in /proc/cpuinfo and prevent any in-kernel SGX code from running.

It is a usual practice for big features like SGX to add a
"nosgx" cmdline param to disable it in case something goes
south. We do this for all features - see all "no*" switches in
Documentation/admin-guide/kernel-parameters.txt

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
