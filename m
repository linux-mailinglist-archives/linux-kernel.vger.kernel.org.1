Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38037269076
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgINPoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:44:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27822 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726131AbgINPij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:38:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600097917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OR1/eIYGZZvLMmu+vbBsRmOl+sNgRAjamn/gYhzlyVw=;
        b=WkafuasLFWnjaUyxH4dg3aOfIdJGuE38pmX7FaVfdw7mnZvPwyg5k7tFamH3BtbW0pZSX7
        WgivpklpA60dZJA6vDKERh2E7HHwHMvvB3RuNLYziYeO6B9fVQdq7mnnUMfvBzMaSanbIB
        +GtfRIcaC/EfNFgH82T/XGhSM0/temY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-7RRGZ5r0MjGx9LbAHOJTHA-1; Mon, 14 Sep 2020 11:38:30 -0400
X-MC-Unique: 7RRGZ5r0MjGx9LbAHOJTHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5AFF81CAF8;
        Mon, 14 Sep 2020 15:38:26 +0000 (UTC)
Received: from treble (ovpn-115-26.rdu2.redhat.com [10.10.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D4F8260C0F;
        Mon, 14 Sep 2020 15:38:14 +0000 (UTC)
Date:   Mon, 14 Sep 2020 10:38:12 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@alien8.de>,
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
Message-ID: <20200914153812.c6uh3spqmcy2ft3d@treble>
References: <20200911124019.42178-1-jarkko.sakkinen@linux.intel.com>
 <20200911124019.42178-3-jarkko.sakkinen@linux.intel.com>
 <20200914151816.u6camicid4bd5lgo@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200914151816.u6camicid4bd5lgo@treble>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 10:18:16AM -0500, Josh Poimboeuf wrote:
> Hi Jarko,
> 
> It looks like some of the patches weren't delivered to the lists.
> Patches 0, 1, 8, 9, and 17 seem to be missing.
> 
> Lore agrees with me:
> 
>   https://lore.kernel.org/linux-sgx/20200911124019.42178-1-jarkko.sakkinen@linux.intel.com/

And my first email to you bounced, similar to an email I tried sending
to Kristen a few weeks ago.  Something weird going on with Intel mail
servers?

-- 
Josh

