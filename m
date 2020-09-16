Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4121A26B7C3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbgIPA3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:29:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38354 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726546AbgIOOFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600178716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iWIPRlc8ySpXnZbb3ABJNrp/CQr1HLxNQWDbTLw9BhU=;
        b=jNMMNjpmtel+UfrVHb7G1mog8yAnGmDB52T3t7oEIa1cDlSgmXTZ7qINbQqAAbSAQCon/4
        nFnSC61yIpAJhVXhiZy/kx4wgEdnfG/V+lk0ZKK0FqP+bGcqq9G2iMUWjs1HE5GimZPMYt
        o2J5YSQXoVKSgqZ1Ha6lbJHB/lP/mHA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-C3Xi5FdHMEKiu4tVmFa7xg-1; Tue, 15 Sep 2020 10:03:08 -0400
X-MC-Unique: C3Xi5FdHMEKiu4tVmFa7xg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0629D10BBEE6;
        Tue, 15 Sep 2020 14:03:05 +0000 (UTC)
Received: from treble (ovpn-112-136.rdu2.redhat.com [10.10.112.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DBFE5DE47;
        Tue, 15 Sep 2020 14:02:51 +0000 (UTC)
Date:   Tue, 15 Sep 2020 09:02:50 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Darren Kenny <darren.kenny@oracle.com>,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        asapek@google.com, cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v37 02/24] x86/cpufeatures: x86/msr: Add Intel SGX Launch
 Control hardware bits
Message-ID: <20200915140250.kf2kgfbgzxfvmoiy@treble>
References: <20200911124019.42178-1-jarkko.sakkinen@linux.intel.com>
 <20200911124019.42178-3-jarkko.sakkinen@linux.intel.com>
 <20200914151816.u6camicid4bd5lgo@treble>
 <20200914153812.c6uh3spqmcy2ft3d@treble>
 <20200915095716.GI3612@linux.intel.com>
 <20200915132725.a2qbdio3jsu7rsqs@treble>
 <20200915133929.GI14436@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200915133929.GI14436@zn.tnic>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 03:39:29PM +0200, Borislav Petkov wrote:
> On Tue, Sep 15, 2020 at 08:27:25AM -0500, Josh Poimboeuf wrote:
> > I see the v37 missing patches now, but they're not threaded with the
> > original thread.
> 
> Probably because he bounced only the ones you didn't get, separately.
> 
> > v38 has some missing patches as well.
> 
> And I got them twice. Can we please stop the spamming?
> 
> And yeah, use another mail service - all those companies switching the
> o365 and mimecast, means time to move kernel development off of company
> mail because company mail simply can't handle it.

If you getting them (twice?) and vger's not, it sounds like vger is
dropping them for some reason.

-- 
Josh

