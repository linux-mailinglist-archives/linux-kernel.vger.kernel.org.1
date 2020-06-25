Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0274F209C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 12:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390819AbgFYKOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 06:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389773AbgFYKOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 06:14:52 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7431C061573;
        Thu, 25 Jun 2020 03:14:51 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0ed100f934f9e71bd17243.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d100:f934:f9e7:1bd1:7243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3CA8F1EC0105;
        Thu, 25 Jun 2020 12:14:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1593080088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wZEaiRB22xa7BcRCKe3HuRHsBBwhLUBTrmGUHGuXtCI=;
        b=cbJ49egfsTPDPA0eCEA0nvoKG0L2FvTzOqmQ1yrjTlmOhslozoqWySWPgieVp8Em0SEAof
        ME8e1WsY05VUCZC/NKer/BvgX1PHHN4HSUuk0GpRcJYtb0gnPDGBpCEOPcSkj4xyadZQoQ
        k+CoLRo9sqUZhyl2CvBE4p5nQUpYpxA=
Date:   Thu, 25 Jun 2020 12:14:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     x86@kernel.org, linux-sgx@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Serge Ayoun <serge.ayoun@intel.com>, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com,
        josh@joshtriplett.org, kai.huang@intel.com, kai.svahn@intel.com,
        kmoy@google.com, ludloff@google.com, luto@kernel.org,
        nhorman@redhat.com, npmccallum@redhat.com, puiterwijk@redhat.com,
        rientjes@google.com, tglx@linutronix.de, yaozhangx@google.com
Subject: Re: [PATCH v33 08/21] x86/sgx: Initialize metadata for Enclave Page
 Cache (EPC) sections
Message-ID: <20200625101441.GC20319@zn.tnic>
References: <20200617220844.57423-1-jarkko.sakkinen@linux.intel.com>
 <20200617220844.57423-9-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617220844.57423-9-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 01:08:30AM +0300, Jarkko Sakkinen wrote:
> +static inline struct sgx_epc_section *sgx_get_epc_section(
> +		struct sgx_epc_page *page)

Just let it stick out - breaking lines on arg opening brace are the
ugliest. Also:

  bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning")

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
