Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3364D1D3D83
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 21:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgENTav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 15:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725965AbgENTav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:30:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2CDC061A0C;
        Thu, 14 May 2020 12:30:50 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZJZ4-0007W6-Lh; Thu, 14 May 2020 21:30:42 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 283061004CE; Thu, 14 May 2020 21:30:42 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nathaniel McCallum <npmccallum@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com,
        "Christopherson\, Sean J" <sean.j.christopherson@intel.com>,
        Neil Horman <nhorman@redhat.com>,
        "Huang\, Haitao" <haitao.huang@intel.com>,
        andriy.shevchenko@linux.intel.com,
        "Svahn\, Kai" <kai.svahn@intel.com>, bp@alien8.de,
        Josh Triplett <josh@joshtriplett.org>, luto@kernel.org,
        kai.huang@intel.com, David Rientjes <rientjes@google.com>,
        "Xing\, Cedric" <cedric.xing@intel.com>,
        Patrick Uiterwijk <puiterwijk@redhat.com>
Subject: Re: [PATCH v29 00/20] Intel SGX foundations
In-Reply-To: <0d485f780ac9809229290762931cd591e6f8156a.camel@linux.intel.com>
References: <20200421215316.56503-1-jarkko.sakkinen@linux.intel.com> <CAOASepPFe_ucuwe7JW_-+VBQ4=+sHqyGXOdA9kUbcYA_9=v0sA@mail.gmail.com> <0d485f780ac9809229290762931cd591e6f8156a.camel@linux.intel.com>
Date:   Thu, 14 May 2020 21:30:42 +0200
Message-ID: <87mu6axqjh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com> writes:
>
> General question: maybe it would be easiest that I issue a pull request
> once everyone feels that the series is ready to be pulled and stop sending
> new versions of the series?

Might be the easiest for you, but I prefer a final series in email.

Thanks,

        tglx
